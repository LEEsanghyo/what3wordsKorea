var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var clients = [];

app.get('/ichat', function(req,res){
});

http.listen(1337,function(){
    console.log('Server Start at *:1337');
});

io.on('connection', function(socket){
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
				return false;
			}
		}
		io.to(socket.id).emit('end', null);
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
				console.log(clients[i].uid + ' disconnected');
				clients.splice(i, 1);
				break;
			}
		}
	});
});