<!-- #include virtual="/_include/connect.inc" -->
<% 
	'로그인 확인
	if Session("member_no") < 1 and Session("member_uid") = "" then
		response.redirect "/"
	end if
%>
<!-- #include virtual="/_include/connect_close.inc" -->