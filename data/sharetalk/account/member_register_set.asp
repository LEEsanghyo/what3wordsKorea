<!-- #include virtual="/_include/connect.inc" -->
<%   
    subscribe_flag = 0

    member_uniqid = request("member_uniqid")

    if member_uniqid = "undefined" then
    	member_uniqid = null
    end if 

    strSQL = "p_gim_member_set '" & request("member_name") & "','" & request("member_email") & "','" & request("member_age") & "','" & request("member_interest") & "','" & request("member_phone") & "','" & request("member_pwd") & "','" & subscribe_flag & "','" &  request("org_flag") & "','" & member_uniqid & "'"

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, Dbconn

    message = rsData("message")

    response.Write message
    'response.Write "1," & strSQL

    set rsData = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->