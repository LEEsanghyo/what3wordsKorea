<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   post_title = request("post_title") 
   post_contents = request("post_contents") 

   post_title = Replace(post_title,"<BR>",chr(13) & chr(10))
   post_title = Replace(post_title,"<amp>",chr(38))
   post_title = Replace(post_title,"<comma>",chr(44))
   post_title = Replace(post_title,"<apostrophe>",chr(39)&chr(39))
   post_title = Replace(post_title,"<quote>",chr(34))

   'post_contents = Replace(post_contents,"<BR>",chr(13) & chr(10))
   post_contents = Replace(post_contents,"<amp>",chr(38))
   post_contents = Replace(post_contents,"<comma>",chr(44))
   post_contents = Replace(post_contents,"<apostrophe>",chr(39)&chr(39))
   post_contents = Replace(post_contents,"<quote>",chr(34))
    

   strSQL = "p_tsh_post_update '" &  request("post_no")  & "','" & _
                                     post_title & "','" & _
                                     post_contents & "'"

   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, DbCon, 1, 1      

   Set rs = nothing

   response.write "저장되었습니다."
   'response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

