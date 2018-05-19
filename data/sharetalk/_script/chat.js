var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var clients = [];

/* 파일 읽기 / 업로드 */
// 파일 읽기
var fs = require('fs');

// 파일 업로드
var multer = require('multer');
var storage = multer.diskStorage({
	destination: function(req, file, cb){
		cb(null, 'uploads/');
	},
	filename: function(req, file, cb){
		fs.exist(req.path, function(exists){
			exists ? fs.rename(req.path, file.fieldname )
			: null;
			cb(null, file.fieldname + '-' + Date.now());
		})
	}
});

const upload = multer({ 
	dest: 'uploads/',
	storage : storage,
	limits : {fileSize : 5*(1024^2) }
});

app.post('/uploadprof', upload.single('image'), function(req, res, next){
	console.log(req.file);
})


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
		console.log('지역 방에 접속하셨습니다');
		socket.join(data);
	});

	// 지역 별 채팅방 메세지 전송
	socket.on('statechat', function(data){
		console.log('대화 보냈습니다.');
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