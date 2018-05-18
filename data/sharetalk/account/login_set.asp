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
    rsGi.Open strSQL, DbConn, 1, 1
	if rsGi("p_count") = 1 Then
		member_no = rsGi("member_no")
		Clients_ID = Application("Clients_ID")

		for i=0 to UBOUND(Clients_ID) step 1
			if member_no = Clients_ID(i) then
				response.write "이미 로그인된 사용자입니다."
				response.end
			end if

		next

		Session("admin_flag") = rsgi("admin_flag")
		Response.Cookies("profile_url") = rsGi("profile_url")
		Response.Cookies("member_name") = rsGi("member_name")
		Session("member_uid") = member_uid
		Session("member_no") = member_no

		'세션 아이디넘버를 전역변수에 저장
		Application.lock
		Clients_ID = Application("Clients_ID")
		Clients_ID(Application("count")) = member_no
		Redim Preserve Clients_ID(Application("count")+1)
		Application("Clients_ID") = Clients_ID
		Clients_Chat = Application("Clients_Chat")
		Clients_Chat(Application("count")) = 0
		Redim Preserve Clients_Chat(Application("count")+1)
		Application("Clients_Chat") = Clients_Chat
		Application("count") = Application("count") + 1
		Application.unlock

	elseif rsgi("l_message") <> "로그인 오류입니다." then
		response.write "0"
	else
		response.write rsgi("l_message")
	end if
	set rsGi = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->