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
		member_no = rsGi("member_no")
		Response.Cookies("member_email") = member_email
		Response.Cookies("member_name") = rsGi("member_name")
		Session("admin_flag") = rsgi("admin_flag")
		Session("member_uid") = member_uid
		Session("member_no") = member_no
		Session("chat_flag") = 0

		'세션 아이디넘버를 전역변수에 저장
		Application.lock
		Clients_ID = Application("Clients_ID")
		Clients_ID(UBOUND(Clients_ID)) = member_no
		Redim Preserve Clients_ID(UBOUND(Clients_ID)+1)
		Application("Clients_ID") = Clients_ID
		Clients_Chat = Application("Clients_Chat")
		Clients_Chat(UBOUND(Clients_Chat)) = 0
		Redim Preserve Clients_Chat(UBOUND(Clients_Chat)+1)
		Application("Clients_Chat") = Clients_Chat
		Application.unlock

	elseif rsgi("l_message") <> "" then
		response.write "0"
	else
		response.write "로그인 오류입니다."
	end if
	set rsGi = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->