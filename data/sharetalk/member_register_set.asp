<!-- #include virtual="/_include/connectgi.inc" -->
<%   
    member_no = "0"
    subscribe_flag = "0"
    org_name = "TALKSHARE"

    strSQL = "p_gim_member_mobile_set '1','" & _
                                    member_no & "','" & _
                                    request("member_name") & "','" & _
                                    request("member_alias") & "','" & _
                                    request("member_email") & "','" & _
                                    request("member_pwd") & "','" & _
                                    subscribe_flag & "','" & _
                                    request("member_phone") & "','" & _
                                    org_name & "'"
        
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, giDbCon, 1, 1     
     
    result_no = rsData("result_no")
    message = rsData("message")

    set rsData = nothing
    
    response.Write result_no & "," & message
    'response.Write "1," & strSQL
    
%>
<!-- #include virtual="/_include/connectgi_close.inc" -->