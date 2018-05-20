<!-- #include virtual="/_include/connect.inc" -->
<%
	location = request("location")
	flag = request("flag")
	member_no = request("member_no")

	if location = "undefined" then
		response.write "위치를 찾을 수 없습니다."
		response.end
	else
		strurl = "p_gim_member_location '" & flag & "','" & member_no & "','" & location & "'"
		Set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open strurl, DbConn
		if flag = 1 then
			response.charset = "UTF-8"
			response.write rs("member_location")
		end if
	end if
	Set rs = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->