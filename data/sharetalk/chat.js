var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var clients = [];

/* 파일 읽기 / 업로드 */
// 파일 읽기
var fs = require('fs');

// 파일 업로드
var multer = require('multer');
const path = require('path');
const upload = multer({
	storage : multer.diskStorage({
		destination: function(req, file, cb){
			cb(null, 'uploads/');
		},
		filename: function(req, file, cb){
			var filepath = new Date().valueOf() + path.extname(file.originalname);
			cb(null, filepath);
		}
	}),
	limits: { filesize: 10*1024*1024 }
});

function resFile(req, res, next){
	console.log(req.body.img_url);
	var url = './' + req.body.img_url;
	if (url != './images/my.png'){
		fs.unlink(url, function(err){
			if (err) console.log('No File');
		});
	}
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.send('/' + req.file.path.replace("\\", "/"));
}

app.post('/uploadprof', upload.single('profupload'), resFile);
app.post('/uploadback', upload.single('backupload'), resFile);
app.post('/uploadsns', upload.single('snsupload'), resFile);

http.listen(1337,function(){
    console.log('Server Start at *:1337');
});


/* 채팅 */
io.on('connection', function(socket){
	console.log('socket detected');
	// 1대1 채팅을 위해 세션 정보 저장
	socket.on('session', function(id){
		console.log(socket.id + ' Session connected');
		var Client = new Object();
		Client.uid = id;
		Client.sid = socket.id;
		clients.push(Client);
	});

	// 1 대 1 채팅
	socket.on('individual', function(data){
		console.log('Chat Sent to ' + data[0]);
		for (var i=0; i<clients.length; i++){
			if (clients[i].uid == data[0]){
				io.to(clients[i].sid).emit('individual', data);
				return false;
			}
		}
		io.to(socket.id).emit('end', null);
	});

	// 지역 별 채팅방 접속
	socket.on('joinRoom', function(data){
		socket.join(data);
	});

	// 지역 별 채팅방 메세지 전송
	socket.on('statechat', function(data){
		socket.broadcast.to(data[0]).emit('statechat', data);
	});

	// 대화 끝낼 시 해당 세션의 소켓 ID로 클라이언트 배열에서 삭제
	socket.on('disconnect', function(){
		for (var i=0; i<clients.length; i++){
			if (clients[i].sid = socket.id){
				console.log(clients[i].uid + ' disconnected');
				clients.splice(i, 1);
				break;
			}
		}
	});
});