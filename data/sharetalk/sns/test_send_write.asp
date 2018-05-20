<!-- #include virtual="/_include/connect.inc" -->
<%
      Response.CharSet = "utf-8" 

      strSQL = "p_gsns_user_write_insert '" & request("from_place") & "','" & _ 
                                           request("file_upload_area_real") & "','" & _ 
                                           request("content_input_area") & "','" & _ 
                                           request("latitude") & "','" & _ 
                                           request("longitude") & "','" & _ 
                                           request("address") & "','" & _ 
                                           request.Cookies("member_email") & "'" 
      'response.Write "step2: " & strSQL
      'response.end
    
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbConn, 1, 1

      result_msg = rsData("result_msg")

      set rsData = nothing
     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
