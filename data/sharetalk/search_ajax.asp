<!-- #include virtual="/_include/connect.inc" -->
<%
    response.charset = "utf-8"


    strSQL = "p_word_find '" & request("word") & "'"


      'response.write strSQL
      'response.End

      Set ys = Server.CreateObject("ADODB.RecordSet")
      ys.Open strSQL, DbConn, 1, 1


      data_value = ys("out_data")
      set ys = nothing

      Response.write data_value

%>
<!-- #include virtual="/_include/connect_close.inc" -->
