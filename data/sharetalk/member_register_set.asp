<!-- #include virtual="/_include/connect.inc" -->
<%   
    member_no = 0
    subscribe_flag = "0"
    org_name = "What3Words"

    strSQL = "p_gim_member_set '" & member_no & "','" & request("member_name") & "','" & request("member_alias") & "','" & request("member_email") & "','" & request("member_pwd") & "','" & subscribe_flag & "','" & request("member_phone") & "','" & org_name & "'"

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, Dbconn

    message = rsData("message")
	
    response.Write message
    'response.Write "1," & strSQL

    set rsData = nothing
%>
<!-- #include virtual="/_include/connect_close.inc" -->