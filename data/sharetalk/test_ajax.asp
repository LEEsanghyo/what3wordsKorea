<!-- #include virtual="/_include/connect.inc" -->
<%
    response.charset = "utf-8"



    strSQL = "p_zb_poi_insert '" & request("p_poi_name") & "','" &_
                                request("p_gcat_name_en") & "','" &_
                                request("p_lat_value") & "','" &_
                                request("p_lon_value") & "','" &_
                                request("p_poi_name") & "','" &_
                                request("p_poi_name") & "','" &_
                                request("p_poi_name") &"'"
  'response.write strSQL
  'response.end


  Set ys = Server.CreateObject("ADODB.RecordSet")
  ys.Open strSQL, DbConn, 1, 1

  



%>
<!-- #include virtual="/_include/connect_close.inc" -->
