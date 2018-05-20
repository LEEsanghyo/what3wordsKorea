<!-- #include virtual="/_include/connect.inc" -->
<%
	response.charset = "UTF-8"

    profile_desc = request("profile_desc")
    member_interest = request("member_interest")
    profile_url = request("profile_url")

    strSQL = "p_gim_member_profile_desc_set '" & Session("member_no") & "','" & request("member_name") & "','" & member_interest & "','" & profile_desc & "','" & profile_url & "'"
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbConn

    message = rsData("message")

    if message <> "" then
    	response.write message
    else
    	response.write "변경되었습니다."
    end if 
    
    set rsData = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->