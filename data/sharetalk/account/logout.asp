<%
	member_no = Session("member_no")
	Application.lock
	ID = Application("Clients_ID")
	Chat = Application("Clients_Chat")
	response.write UBOUND(ID)
	for i=0 to UBOUND(ID)-1
		if ID(i) = member_no then
			Chat(i) = 0
			ID(i) = 0
			exit for
		end if
	next
	Application("Clients_ID") = ID
	Application("Clients_Chat") = Chat
	Application.unlock
	Response.Cookies("member_email") = ""
	Response.Cookies("member_name") = ""
	Session("admin_flag") = ""
	Session("member_uid") = ""
	Session("member_no") = ""
	Session.abandon
	response.redirect "/"
%>