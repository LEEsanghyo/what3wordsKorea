var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var clients = [];

app.get('/', function(req,res){
    res.sendFile(__dirname + '/chat.html');
});

http.listen(1337,function(){
    console.log('Server Start at *:1337');
});

io.on('connection', function(socket){
	socket.on('login', function(data){
		var client = new Object();
		client.id = data.id;
		client.sid = socket.id;
		clients.push(client);
	});
	socket.on('chat message', function(id, msg){
		var sockid;
		for (var i=0; i<clients[i].length; i++){
			if (clients[i] == id)	sockid = clients[i].sid;
		}
		io.to(sockid).emit('chat message', msg);
	});
	socket.on('disconnect', function(){
		for (i=0; i<clients.length; i++){
			if (clients[i].sid = socket.id)	console.log(clients[i].id + ' 로그아웃');
		}
	});
});