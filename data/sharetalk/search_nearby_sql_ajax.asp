<!-- #include virtual="/_include/connect.inc" -->
<%
    response.charset = "utf-8"

    strSQL = "p_tc_poi_read2 '" & request("min_lat") & "','" &_
                                request("max_lat") & "','" &_
                                request("min_lng") & "','" &_
                                request("max_lng") & "'"

    Set ys = Server.CreateObject("ADODB.RecordSet")
    ys.Open strSQL, DbConn, 1, 1

    'data_value = ys("cat_no")&","&ys("poi_name") &","&ys("lat_value")&","&ys("lon_value")& "," & ys("contact_info") & "," &ys("poi_desc")

    data_value = ys("data_value")
    response.write data_value
    response.end

%>
<!-- #include virtual="/_include/connect_close.inc" -->
