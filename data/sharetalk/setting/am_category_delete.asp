<!-- #include virtual="/_include/login_check.asp" -->
<%
   strSQL = "p_tsm_category_delete '" & request("cat_no") & "'"
    
   'response.write  strSQL
   'response.end

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbConn, 1, 1      

   Set rs = nothing

   response.write "삭제 되었습니다"
   
%>

