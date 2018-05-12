<%
    id = Session("member_no")
    name = Request.Cookies("member_name")
    roomid = request("roomid")
%>
<!Doctype html>
<html>
    <meta charset="UTF-8">
    <head>
        <title>W3W Chatting</title>
         <style>
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body { font: 13px Helvetica, Arial; }
            div { background: #000; padding: 3px; position: fixed; bottom: 0; width: 100%; }
            div input { border: 0; padding: 10px; width: 90%; margin-right: .5%; }
            div button { width: 9%; background: rgb(130, 224, 255); border: none; padding: 10px; }
            #messages { list-style-type: none; margin: 0; padding: 0; }
            #messages li { padding: 5px 10px; }
            #messages li:nth-child(odd) { background: #eee; }
        </style>
    </head>
    <body>
        <ul id="messages"></ul>
        <div>
        <input id="m" onkeypress="if(event.keyCode==13){sendMessage()}" autocomplete="off" /><button onclick="sendMessage()">Send</button>
        </div>
        <script src="http://tour.abcyo.kr:1337/socket.io/socket.io.js"></script>
        <script async src="https://code.jquery.com/jquery-1.11.1.js"></script>
        <script>
            // 나와 상대방의 세션 ID 불러오고, 채팅 서버에 내 ID 저장
            var xhr;
            var socket = io.connect('http://tour.abcyo.kr:1337');
            var id = <%=roomid%>

            // 채팅 서버에 내 세션 설정
            function joinRoom(){
                socket.emit('joinRoom', id);
            }
            joinRoom();

            function sendMessage(){
                var nick = "<%=name%>";
                // 상대방에게 채팅 매세지 보내기
                var data = new Array();
                data[0] = id;
                data[1] = nick + " : " + $('#m').val();
                socket.emit('statechat', data);
                $('#m').val('');
                return false;
            }

            // 채팅 매세지 받기
            socket.on('statechat', function(msg){
                $('#messages').append($('<li>').text(msg));
            });
        </script>
    </body>
</html>