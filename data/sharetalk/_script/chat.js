var app = require('express')();
var cors = require('cors');
var http = require('http').Server(app);
var io = require('socket.io')(http);
var url = require('url');
var querystring = require('querystring');
var clients = [];

app.get('/ichat', function(req,res){
	//console.log(req);
	var parsedUrl = url.parse(req.url);
	var parsedQuery = querystring.parse(parsedUrl.query, '&', '=');
	var my = parsedQuery.my;
	var other = parsedQuery.other;
	res.statusCode = 302;
	res.setHeader('Location', 'http://localhost:8090/ichat.asp?myid=' + my + '&otherid=' + other);
	res.end();
	//console.log(req.socket.id);
});

app.use(cors());

http.listen(1337,function(){
    console.log('Server Start at *:1337');
});

io.on('connection', function(socket){
	//console.log(socket);
	// 1대1 채팅을 위해 세션 정보 저장
	socket.on('session', function(id){
		console.log(socket.id + ' Session connected');
		var Client = new Object();
		Client.uid = id;
		Client.sid = socket.id;
		clients.push(Client);
	});

	// 1대1 채팅 ()
	socket.on('individual', function(data){
		console.log('Chat Sent to ' + data[0]);
		for (var i=0; i<clients.length; i++){
			if (clients[i].uid == data[0]){
				io.to(clients[i].sid).emit('individual', data[1]);
				break;
			}
		}
	});

	// 지역 별 채팅방
	socket.on('key', function(data){
		console.log('접속');
		socket.join(data);
	});

	// 대화 끝낼 시 해당 세션의 소켓 ID로 클라이언트 배열에서 삭제
	socket.on('disconnect', function(){
		for (var i=0; i<clients.length; i++){
			if (clients[i].sid = socket.id){
				console.log(clients[i].id + ' disconnected');
				clients.splice(i, 1);
				break;
			}
		}

	});
});