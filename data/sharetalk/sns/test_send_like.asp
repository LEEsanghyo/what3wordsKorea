<!-- #include virtual="/_include/connect.inc" -->
<%
      Response.CharSet = "utf-8" 

      strSQL = "p_gsns_user_like_insert '" & request("box_number") & "','" & _ 
                                                            request("like_number") & "'"

      'response.Write "step2: " & strSQL
      'response.end
    
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbConn, 1, 1

      result_msg = rsData("result_msg")

      set rsData = nothing
     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
