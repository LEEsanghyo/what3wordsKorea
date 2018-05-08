<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_tsh_post_delete '" &  request("post_no") & "'"

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   Set rs = nothing

   response.write "삭제되었습니다."
   'response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

