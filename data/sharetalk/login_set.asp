<!-- #include virtual="/_include/connect.inc" -->
<%  
    member_email = request("member_email")
    member_pwd = request("member_pwd")

    strSQL = "p_login_check '" & member_email & "','" & member_pwd & "'"

    Set rsGi = Server.CreateObject("ADODB.RecordSet")
    rsGi.Open strSQL, DbConn
	if (rsGi("p_count")=1) Then
		Session("member_no") = rsGi("member_no")
		member_name = rsGi("member_name")
		member_alias = rsGi("member_alias")
		org_name = rsGi("org_name")

		p_count = rsgi("p_count")
		Session("member_name") = rsgi("member_name")
		Session("member_email") = rsgi("member_email")
		Session("admin_flag") = rsgi("admin_flag")
		Session("authority_level") = rsgi("authority_level")

		Response.Cookies("talk_member_email") = member_email
		Response.Cookies("talk_member_pwd") = member_pwd

		response.write "로그인 되었습니다."
		
	else
		response.write "로그인 오류입니다."
	END IF
	set rsGi = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->
