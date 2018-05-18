<%
    id = Session("member_no")
    name = Request.Cookies("member_name")
    img = Request.Cookies("profile_url")
    other = request("otherid")

    if img = "" then
        img = "/images/my.png"
    end if
%>
<!Doctype html>
<html>
    <meta charset="UTF-8">
    <head>
        <title>W3W Chatting</title>
        <link rel="stylesheet" href="/_css/chat.css" type="text/css">
        <script type="text/javascript">
            var id = new Array();
            id[0] = <%=id%>;
            id[1] = <%=other%>;
            var nick = <%=name%>;
            var imgsrc = "<img id='img' src='<%=img%>' onclick='getRoute(<%=id%>)'/>";
        </script>
    </head>
    <body>
        <p align="left">위치조회 허용<input type="checkbox" onclick="setMyLocation()"></p>
        <ul id="one"></ul>
        <div>
        <input id="o" onkeypress="if(event.keyCode==13){sendOne()}" autocomplete="off" /><button onclick="sendOne()">Send</button>
        </div>
        <script type="text/javascript" src="http://tour.abcyo.kr:1337/socket.io/socket.io.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.js"></script>
        <script type="text/javascript" src="/_script/chatting.js" onload="sendSession()"></script>
    </body>
</html>