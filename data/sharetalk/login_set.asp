<!-- #include virtual="/_include/connect.inc" -->
<%  
	member_uid = request("member_uniqid")
	if member_uid = "undefined" then
		member_uid = ""
	end if
	member_email = request("member_email")
    member_pwd = request("member_pwd")

    strSQL = "p_login_check '" & member_email & "','" & member_pwd & "','" & member_uid & "'"

    Set rsGi = Server.CreateObject("ADODB.RecordSet")
    rsGi.Open strSQL, DbConn
	if rsGi("p_count") = 1 Then
		Session("member_no") = rsGi("member_no")
		Session("member_name") = rsgi("member_name")
		Session("member_email") = rsgi("member_email")
		Session("authority_level") = rsgi("authority_level")
		Session("admin_flag") = rsgi("admin_flag")

		Response.Cookies("talk_member_email") = member_email
		Response.Cookies("talk_member_pwd") = member_pwd		
		Response.Cookies("member_uid") = member_uid

		response.write rsgi("admin_flag")
		response.write rsgi("l_message")
	elseif rsgi("l_message") <> "" then
		response.write "0"
	else
		response.write "로그인 오류입니다."
	end if
	set rsGi = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->