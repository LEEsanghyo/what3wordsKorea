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
			for i=0 to UBOUND(ID) step 1
				'해당 전역변수의 세션에 채팅 플래그 1로 설정
				if cstr(ID(i)) = cstr(result) then
					Chat(i) = 1
					Application.lock
					Application("Clients_Chat") = Chat
					Application("Req_ID") = Session("member_no")
					Application("Req_Name") = Request.Cookies("member_name")
					Application.unlock
					response.write "채팅신청을 보냈습니다. 상대가 수락 시 채팅이 시작됩니다."
					exit for
				end if
			next
		end if
	elseif Accept = 0 then
		for i=0 to UBOUND(ID) step 1
			'내 세션에 새 채팅 신청이 있는지 확인
			if cstr(ID(i)) = cstr(Session("member_no")) then
				if Chat(i) = 1 then
					Chat(i) = 0
					req_id = Application("Req_ID")
					Req_name = Application("Req_Name")
					ReqInfo = "새 채팅," + Req_name + "," + CStr(req_id)
					response.write reqInfo
					clearVar()
				elseif Chat(i) = 2 then
					Chat(i) = 0
					iid = Application("individual_id")
					response.write "채팅 시작," + cstr(Session("member_no")) + "," + cstr(iid)
					clearVar()
				elseif Chat(i) = 3 then
					Chat(i) = 0
					response.write "상대방이 채팅을 거절했습니다."
					clearVar()
				end if
				exit for
			end if
		next
	else
		for i=0 to UBOUND(ID) step 1
			if cstr(ID(i)) = cstr(req_id) then
				if Accept = 1 then
					Chat(i) = 2
					Application.lock
					Application("individual_id") = Session("member_no")
					Application.unlock
					response.write "수락," + Cstr(Session("member_no")) + "," + Cstr(req_id)
				elseif Accept = 2 then
					Chat(i) = 3
					response.write "거절"
				end if
				Application.lock
				Application("Clients_Chat") = Chat
				Application.unlock
				exit for
			end if
		next
	end if

	function clearVar()
		Application.lock
		Application("Clients_Chat") = Chat
		Application("Req_ID") = 0
		Application("Req_Name") = ""
		Application("individual_id") = ""
		Application.unlock
	End function
%>
<!-- #include virtual="/_include/connect_close.inc" -->