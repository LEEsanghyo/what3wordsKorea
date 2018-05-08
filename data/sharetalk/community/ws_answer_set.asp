<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   if request("answer_desc")  <> "" then

      answer_desc = request("answer_desc") 

      answer_desc = Replace(answer_desc,"<BR>",chr(13) & chr(10))
      answer_desc = Replace(answer_desc,"<amp>",chr(38))
      answer_desc = Replace(answer_desc,"<comma>",chr(44))
      answer_desc = Replace(answer_desc,"<apostrophe>",chr(39)&chr(39))
      answer_desc = Replace(answer_desc,"<quote>",chr(34))

    else

      answer_desc = ""

    end if

    strSQL = "p_tsh_post_answer_set '" & request("post_no")  & "','" & _
                                         Session("member_no") & "','" & _
                                         answer_desc & "'"

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1      

    'result_desc = rs("result_desc")

    Set rs = nothing

    response.write "댓글 저장되었습니다."
    'response.write  strSQL

%>
<!-- #include virtual="/_include/connect_close.inc" -->

