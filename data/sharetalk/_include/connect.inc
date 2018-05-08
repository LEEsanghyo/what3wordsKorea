<%
	Set Dbconn = Server.CreateObject("ADODB.Connection")
	Dbconn.Open "dsn=tourdb;uid=talkuser;pwd=talk1234@"  
	'Dbconn.Open "dsn=tourdb;uid=talkuser;pwd=talk1234!"
%>