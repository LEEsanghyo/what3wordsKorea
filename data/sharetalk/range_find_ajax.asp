<!-- #include virtual="/_include/connect.inc" -->
<%
    response.Charset = "utf-8"
  
    strSQL = "p_range_find '" & request("x_center") &"','" & _
                                request("y_center") & "'"

      Set ys = Server.CreateObject("ADODB.RecordSet")
      ys.Open strSQL, DbConn, 1, 1

      data_value = ys("word_grid")
      set ys = nothing

      Response.write data_value
%>
<!-- #include virtual="/_include/connect_close.inc" -->
