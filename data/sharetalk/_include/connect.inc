<%@Language="VBScript" CODEPAGE="65001" %>
<% Response.CharSet="utf-8"
	Session.codepage="65001"
	Response.codepage="65001"
	Response.ContentType="text/html;charset=utf-8"
%>
<%
  Set Dbconn = Server.CreateObject("ADODB.Connection")
  Dbconn.Open "dsn=tourdb;uid=talkuser;pwd=talk1234!"
  'Set Dbconn = Server.CreateObject("ADODB.Connection")
  'DbConn.Open "dsn=glocationdb;uid=griduser;pwd=jay1234~;"
%>
