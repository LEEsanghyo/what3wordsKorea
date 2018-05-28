<%
  Set Dbconn = Server.CreateObject("ADODB.Connection")
  Dbconn.Open "dsn=tourdb;uid=talkuser;pwd=talk1234#"  
'Dbconn.Open "dsn=tourdb;uid=talkuser;pwd=talk1234!"
  'Set Dbconn = Server.CreateObject("ADODB.Connection")
  'DbConn.Open "dsn=glocationdb;uid=griduser;pwd=jay1234~;"
%>
