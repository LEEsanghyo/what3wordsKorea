<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_gim_member_admin_set '" & request("member_no") & "'"

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   'result_desc = rs("result_desc")

   Set rs = nothing

   'response.write "변경되었습니다"
   response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

