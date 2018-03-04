<!-- #include virtual="/_include/connect.inc" -->
<%
	Dim strSQL
	response.charset = "utf-8"

	strSQL = "p_zb_poi_insert '" & request("p_poi_name") & "','" &_
								request("p_gcat_name_en") & "','" &_
								request("p_lat_value") & "','" &_
								request("p_lon_value") & "','" &_
	Set ys = Server.CreateObject("ADODB.RecordSet")
	ys.Open strSQL, DbConn, 1, 1
  
	'response.write strSQL
	'response.end
%>
<!-- #include virtual="/_include/connect_close.inc" -->