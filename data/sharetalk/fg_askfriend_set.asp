<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   strSQL = "p_gim_member_askfriend_set '" & Session("member_no") & "','" & _
                                             request("friend_no") & "'"

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   result_desc = rs("result_desc")

   Set rs = nothing

   response.write result_desc
   'response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

