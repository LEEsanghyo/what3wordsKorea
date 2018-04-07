<!-- #include virtual="/_include/connect.inc" -->
<%
	Dim strSQL

	strSQL = "p_zb_poi_insert '" & request("p_poi_name") & "','" &_
								request("p_gcat_name_en") & "','" &_
								request("p_lat_value") & "','" &_
								request("p_lon_value") & "','" &_
								request("p_contact_info") & "','" &_
								request("p_poi_desc") & "','" &_
								request("p_google_id") & "'"
	Set ys = Server.CreateObject("ADODB.RecordSet")
	ys.Open strSQL, DbConn
  
	'response.write strSQL
	'response.end
%>
<!-- #include virtual="/_include/connect_close.inc" -->