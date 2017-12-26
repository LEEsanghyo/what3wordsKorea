<!-- #include virtual="/_include/connect.inc" -->
<%
    response.charset = "euc-kr"

     strSQL = "p_range_find_2 '" &      request("x_southwest") & "','" & _
                                      request("x_northeast") & "','" & _
                                      request("y_southwest") & "','" & _
                                      request("y_northeast")  & "'"

      'response.write strSQL
      'response.End

      Set ys = Server.CreateObject("ADODB.RecordSet")
      ys.Open strSQL, DbCon, 1, 1


      'Do While Not ys.EOF

      lat_value = ys("lat_value")

      'Loop




      set ys = nothing

      Response.write lat_value
      'Response.write "success"

%>
<!-- #include virtual="/_include/connect_close.inc" -->
