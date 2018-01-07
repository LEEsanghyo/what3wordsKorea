<!-- #include virtual="/_include/connectgi.inc" -->
<%  
    member_email = request("member_email")
    member_pwd = request("member_pwd")

    strSQL = "p_gim_login_check '" & member_email & "','" & _
                                     member_pwd & "',''"

    Set rsGi = Server.CreateObject("ADODB.RecordSet")
    rsGi.Open strSQL, giDbCon, 1, 1
    
    gicount = rsGi("count")

    if gicount > "0" then
    
      Session("member_no") = rsGi("member_no")
      member_name = rsGi("member_name")
      member_alias = rsGi("member_alias")
      member_phone = rsGi("member_phone")
      org_name = rsGi("org_name")
%>
<!-- #include virtual="/_include/connect.inc" -->
<%

      strSQL = "p_login_check '" & Session("member_no") & "','" & _
                                 member_name & "','" & _
                                 member_alias & "','" & _
                                 member_email & "','" & _
                                 member_phone & "','" & _
                                 org_name & "','" & _
                                 member_pwd & "'"

      'response.Write "step2: " & strSQL
    
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbCon, 1, 1      

      p_count = rsData("p_count")
      Session("member_name") = rsData("member_name")
      Session("member_email") = rsData("member_email")
      Session("admin_flag") = rsData("admin_flag")
      Session("authority_level") = rsData("authority_level")
    
      set rsData = nothing

      Response.Cookies("talk_member_email") = member_email
      Response.Cookies("talk_member_pwd") = member_pwd

      response.write "0,로그인 되었습니다."

%>
<!-- #include virtual="/_include/connect_close.inc" -->
<%
    else

      response.write "1,로그인 오류입니다."

    end if

    set rsGi = nothing
%>
<!-- #include virtual="/_include/connectgi_close.inc" -->
