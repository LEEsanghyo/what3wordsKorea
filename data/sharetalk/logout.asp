<%
    Session.Abandon 	
    
    Response.Cookies("talk_member_email") = ""
    Response.Cookies("talk_member_pwd") = ""
%>
<script>
        var siteurl = "default.asp"
        self.location.href = siteurl;
</script>