<%
  Set Dbcon = Server.CreateObject("ADODB.Connection")
  Dbcon.Open "Provider=SQLOLEDB;Data Source=.\SQLEXPRESS;Initial Catalog=talkdb;User ID=talkuser;Password=1q2w3e4r5%;"
  Set Dbconn = Server.CreateObject("ADODB.Connection")
  DbConn.Open "dsn=glocationdb;uid=griduser;pwd=jay1234~;"
%>
