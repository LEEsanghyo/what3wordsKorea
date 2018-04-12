<!-- #include virtual="/_include/connect.inc" -->
<%   

    profile_desc = request("profile_desc")

    strSQL = "p_gim_member_profile_desc_set '" & Session("member_no") & "','" & _
                                                 request("member_name") & "','" & _
                                                 profile_desc & "'"
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbConn   
    
    set rsData = nothing
    
    response.Write "변경되었습니다."
%>
<!-- #include virtual="/_include/connect_close.inc" -->