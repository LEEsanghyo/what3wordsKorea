<!-- #include virtual="/_include/connect.inc" -->
<% if Session("member_no") < 1 and Session("member_uid") = "" then %>
<script type="text/javascript">
	alert("로그인을 하셔야 이용할 수 있습니다.");
	location.replace("/");
</script>
<% end if %>
<!-- #include virtual="/_include/connect_close.inc" -->