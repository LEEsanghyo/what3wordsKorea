<%
	Clients_ID = Application("Clients_ID")
	Clients_Chat = Application("Clients_Chat")
	Sessions_ID = Application("Session_ID")
	for i=0 to UBOUND(Sessions_ID) step 1
		if Sessions_ID(i) = Session.SessionID then
			Clients_ID(i) = 0
			Clients_Chat(i) = 0
			Sessions_ID(i) = ""
			exit for
		end if
	next
	Application("Clients_ID") = Clients_ID
	Application("Clients_Chat") = Clients_Chat
	Application("Session_ID") = Sessions_ID
	Response.Cookies("member_email") = ""
	Response.Cookies("member_name") = ""
	Session.abandon
	response.redirect "/"
%>