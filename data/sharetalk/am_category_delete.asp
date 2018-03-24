<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_tsm_category_delete '" & request("cat_no") & "'"
    
   'response.write  strSQL
   'response.end

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   Set rs = nothing

   response.write "삭제 되었습니다"
   
%>
<!-- #include virtual="/_include/connect_close.inc" -->

