<!-- #include virtual="/_include/connect.inc" -->
<%
      'Response.CharSet = "utf-8" 

      strSQL = "p_gsns_user_write_daily_insert '" & request("file_upload_area_real") & "','" & _ 
                                           request("title_input") & "','" & _ 
                                           request("content_input_area") & "','" & _ 
                                           request("latitude") & "','" & _ 
                                           request("longitude") & "','" & _ 
                                           request("code") & "','" & _ 
                                           request("input_user") & "','" & request("input_userid") & "'" 
    
      'response.Write "step2: " & strSQL
      'response.end
    
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbConn, 3, 3

      'result_msg = rsData("result_msg")

      set rsData = nothing
     
%>
<!-- #include virtual="/_include/connect_close.inc" -->
