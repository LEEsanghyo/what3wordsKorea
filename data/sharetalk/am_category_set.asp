<!-- #include virtual="/_include/login_check.asp" -->
<%
   strSQL = "p_tsm_category_quick_set '" & request("cat_no") & "','" & _
                                           request("cat_name") & "'"
    
   'response.write  strSQL
   'response.end

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbConn, 1, 1

   data_desc = rs("data_desc")

   Set rs = nothing

   'response.write "변경되었습니다"
   response.write  data_desc

%>

