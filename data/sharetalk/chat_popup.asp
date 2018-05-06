<%
	nick = request("member_nickname")
	my_id = Session("member_no")
	other_id = request("member_no")
%>
<!doctype html>
<html>
<meta charset="utf-8">
<body>
	<p style="text-align: center;"><%=nick%>님으로부터 채팅 신청이 도착했습니다. 수락하시겠습니까?</p>
	<p style="text-align:center"><button onclick="resChat(1, <%=my_id %>)">네</button>&nbsp;<button onclick="resChat(2,<%=other_id %>);">아니오</button>
	<script type="text/javascript" src="/_script/community.js"></script>
</body>
</html>