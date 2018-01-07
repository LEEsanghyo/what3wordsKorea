<!-- #include virtual="/_include/connectgi.inc" -->
<%
    'response.Write "작업중"
    'response.end


    email = Request("find_email")
    frommail = "글로벌정보 <songpnet@naver.com>"

    strSQL = "p_gim_member_read_byemail '" & email & "'"
    'response.Write strSQL
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, giDbCon, 1, 1  

    if rs.EOF or rs.BOF then
      member_no = ""
	  member_name = ""
	  member_alias = ""
	  member_pwd = ""
    Else
	  member_no = rs("member_no")
	  member_name = rs("member_name")
	  member_alias = rs("member_alias")
	  member_pwd = rs("member_pwd")
    end if   
    set rs = nothing
  
  mail_body = "<!DOCTYPE HTML> " & _
              "<html> " & _
              "<head> " & _
              "<title>글공유 비밀번호 확인</title> " & _ 
              "</head> " & _ 
              "<body> " & _ 
              "<table border=0 cellpadding=0 cellspacing=0 border=0  width=900> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff align=center> " & _
              "글공유 비밀번호 전송메일입니다. " & _
              "</td> " & _
              "</tr> " & _
              "<tr height=25><td></td></tr> " & _
              "</table> " & _
              "<table border=0 cellpadding=0 cellspacing=0 border=0  width=900> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>성명</td> " & _
              "<td bgcolor=#ffffff width=200> " & member_name & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>별칭</td> " & _
              "<td bgcolor=#ffffff width=200> " & member_alias & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>메일</td> " & _
              "<td bgcolor=#ffffff width=200> " & email & "</td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td bgcolor=#ffffff width=100 align=center>비번</td> " & _
              "<td bgcolor=#ffffff width=200><font style=font-weight:bold;> " & member_pwd & "</font></td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=35> " & _
              "<td bgcolor=#ffffff width=100></td> " & _
              "<td colspan=2 align=center><a href=http://dev2.booksnack.net/><font style=font-weight:bold;> [ 글공유 바로가기 ] </font></a></td> " & _
              "<td bgcolor=#ffffff width=500></td> " & _
              "</tr> " & _
              "<tr height=25><td></td></tr> " & _
              "</table> " & _
              "<table border=0 cellspacing=0 cellpadding=0 width=900 bgcolor=#ffffff> " & _
              "<tr height=30><td width=900 valign=middle> " & _
              "</td></tr> " & _
              "</table> " & _
              "</body> " & _
              "</html> "
  
  'asp mail site reference
  'http://monkeychoi.blog.me/60118971734

  Set objConfig = Server.CreateObject("CDO.Configuration")

  With objConfig.Fields
        .item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
        .item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\inetpub\mailroot\pickup"
        .item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
        .item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
        .update
  End With

  Set objMessage = Server.CreateObject("CDO.Message")

  With objMessage
  Set .Configuration = objConfig
        .To = email
		.From = frommail
		.Subject = "글공유 비밀번호 전송메일입니다."
		.HTMLBody = mail_body
		.Send
  End With

  Set objMessage			= Nothing
  Set objConfig				= Nothing

  strSQL = "p_giz_mailing_log '" & member_no & "','" & _
								   model_no & "','" & _
								   "songpanet@naver.com','" & _
								   email & "','" & _
								   mail_body & "','FINDPWD_TALK'"

  'response.Write strSQL		
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, giDbCon, 1, 1

  set rs = nothing 
%>
<!-- #include virtual="/_include/connectgi_close.inc" -->
<% 
  
  message = "비밀번호가 이메일로 전송되었습니다. <br>메일 수신이 안되면 songpanet@naver.com으로 요청하세요."
 
  Response.Redirect "member_register.asp?message=" & message
	
%>