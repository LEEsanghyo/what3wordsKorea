<!-- #include virtual="/_include/connect.inc" -->
<%
    response.charset = "euc-kr"





    strSQL = "p_range_find_2 '41175', '114105'"


      'response.write strSQL
      'response.End

      Set ys = Server.CreateObject("ADODB.RecordSet")
      ys.Open strSQL, DbCon, 1, 1


      data_value = ys("data_value")

      set ys = nothing

      Response.write data_value

%>
<!-- #include virtual="/_include/connect_close.inc" -->
