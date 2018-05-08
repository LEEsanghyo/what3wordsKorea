<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_tsh_post_engage_set '" & request("post_no")  & "','" & _
                                        Session("member_no") & "','" & _
                                        request("engage_code") & "'"

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   result_desc = rs("result_desc")

   Set rs = nothing

   response.write request("post_no") & "," & result_desc
   'response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

