﻿<!-- #include virtual="/_include/connect.inc" -->
<% 
	'로그인 확인
	if Session("member_no") = "" or Session("member_no") < 1 then
		response.redirect "/"
	else
		talk_member_email = Request.Cookies("talk_member_email")
		talk_member_pwd = Request.Cookies("talk_member_pwd")
		member_uid = Request.Cookies("member_uid")
		strSQL = "p_login_auto_check '" & talk_member_email & "','" & _
		talk_member_pwd & "','" & member_uid & "'"
		Set userData = Server.CreateObject("ADODB.RecordSet")
		userData.Open strSQL, DbConn
		if userData("p_count") > "0" then
			Session("member_no") = userData("member_no")
			Session("member_name") = userData("member_name")
			Session("member_email") = userData("member_email")
			Session("admin_flag") = userData("admin_flag")
			Session("authority_level") = userData("authority_level")
		set userData = nothing
		end if
	end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->