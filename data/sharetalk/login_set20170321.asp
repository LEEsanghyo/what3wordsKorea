<!-- #include virtual="/_include/connectgi.inc" -->
<%   
    strSQL = "p_gim_login_check '" & request("member_email") & "','" & _
                                     request("member_pwd") & "',''"
    
    response.Write strSQL
    response.end
    
       
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, giDbCon, 1, 1
    
    if rsData("count") > "0" then
    
      Session("member_no") = rsData("member_no")
      member_name = rsData("member_name")
      member_alias = rsData("member_alias")
      member_phone = rsData("member_phone")
      org_name = rsData("org_name")

    else
      'Response.redirect "login.asp?message=이메일회원이나 비밀번호를 확인하세요."
    end if

    set rsData = nothing

%>
<!-- #include virtual="/_include/connectgi_close.inc" -->

<!-- #include virtual="/_include/connect.inc" -->
<%  
    strSQL = "p_login_check '" & Session("member_no") & "','" & _
                                 member_name & "','" & _
                                 member_alias & "','" & _
                                 request("member_email") & "','" & _
                                 request("member_phone") & "','" & _
                                 request("org_name") & "','" & _
                                 request("member_pwd") & "'"

    'response.Write "step2: " & strSQL
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1      

    p_count = rsData("p_count")
    Session("member_name") = rsData("member_name")
    Session("member_email") = rsData("member_email")
    Session("work_flag") = rsData("work_flag")
    Session("admin_flag") = rsData("admin_flag")
    
    set rsData = nothing
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->
