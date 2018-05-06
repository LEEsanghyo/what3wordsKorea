<!-- #include virtual="/_include/connect.inc" -->
<%
	article_number = 0
	article_number = CInt(request("article_number"))
	code = CInt(request("code"))
	ID = Application("Clients_ID")
	Chat = Application("Clients_Chat")
	Accept = 0
	Accept = request("Accept")
	req_id = request("id")
	reqInfo = ""

	'채팅 신청 시
	if article_number <> 0 then
		strSQL = "p_insta_writer_read '" & article_number & "','" & code & "'"

		Set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open strSQL, DbConn

		result = rs("userid")

		if result = 0 then
			response.write "오류가 발생했습니다."
		else
			for i=0 to UBOUND(ID)-1 step 1
				if ID(i) = result then
					Chat(i) = 1
					Application.lock
					Application("Clients_Chat") = Chat
					Application("Req_ID") = CStr(Session("member_no"))
					Application("Req_Name") = Request.Cookies("member_name")
					Application.unlock
					exit for
				end if
			next
		end if
	elseif Accept = 0 then
		for i=0 to UBOUND(ID)-1 step 1
			'내 세션에 새 채팅 신청이 있는지 확인
			if ID(i) = Session("member_no")then
				if Chat(i) = 1 then
					req_id = Application("Req_ID")
					Req_name = Application("Req_Name")
					ReqInfo = "새 채팅," + Req_name + "," + CStr(req_id)
					response.write reqInfo
					Chat(i) = 0
				elseif Chat(i) = 2 then
					chat_id = Application("Req_ID")
					chat_name = Application("Req_Name")
					ChatInfo = "채팅 시작," + chat_name + "," + CStr(chat_id)
					response.write ChatInfo
					Chat(i) = 0
				elseif Chat(i) = 3 then
					response.write "상대방이 채팅을 거절했습니다."
					Chat(i) = 0
				end if
				Application.lock
				Application("Clients_Chat") = Chat
				Application("Req_ID") = 0
				Application("Req_Name") = ""
				Application.unlock
				exit for
			end if
		next
	else
		if Accept = 1 then
			Chat(req_id) = 2
			response.write "수락"
		elseif Accept = 2 then
			Chat(req_id) = 3
			response.write "거절"
		end if
			Application.lock
			Application("Clients_Chat") = Chat
			Application.unlock
	end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->