<%
	Server.ScriptTimeout=3600
	'서버 session time = 1시간
	
	'경/위도 좌표와 단어 불러오기
	if request("search_lat") <> "" then
		search_lat = request("search_lat")
	else
		search_lat = 42163
	end if
	if request("search_lon") <> "" then
		search_lon = request("search_lon")
	else
		search_lon = 111670
	end if
	if request("search_word") <> "" then
		search_word = request("search_word")
	else
		search_word = "null"
	end if
	if request("lat_value") <> "" then
		lat_value = request("lat_value")
	else
		lat_value = 37.946976
	end if
	if request("lon_value") <> "" then
		lon_value = request("lon_value")
	else
		lon_value = 127.670702
	end if
	if request("lat1") <> "" then
		lat1 = request("lat1")
	else
		lat1 = 32.910549
	end if
	if request("lon1") <> "" then
		lon1 = request("lon1")
	else
		lon1 = 123.715624
	end if
	if request("lat2") <> "" then
		lat2 = request("lat2")
	else
		lat2 = 42.983403
	end if
	if request("lon2") <> "" then
		lon2 = request("lon2")
	else
		lon2 = 131.625780
	end if
	if request("pos_words") <> "" then
		pos_words = request("pos_words")
	else
		pos_words = "'Korea'"
	end if
	if request("zoom_level") <> "" then
		zoom_level = request("zoom_level")
	else
		zoom_level = 13
	end if
	
	
	'좌표 단어 읽어오기
	'strSQL = "p_gmap_wordgrid_read_lat_new	'" & search_lat & "','" & search_lon & "'"
	
	'Set rsGrid = Server.CreateObject("ADODB.RecordSet")
	'rsGrid.Open strSQL, DbConn, 1, 1
	'if rsGrid.EOF or rsGrid.BOF then
	'	NoDataGrid = True
	'Else
	'	NoDataGrid = False
	'end if
	
	'좌표단어 리스트 읽어오기
	'strSQL = "p_gmap_wordgrid_list	'" & search_word & "'"
	'Set rsGridList = Server.CreateObject("ADODB.RecordSet")
	'rsGridList.Open strSQL, DbConn
	'if rsGridList.EOF or rsGridList.BOF then
	'	NoDataGridList = True
	'Else
	'	NoDataGridList = False
	'end if
	
	'카테고리 읽어오기
	strSQL = "p_tb_category_read '" & Session("admin_flag") & "'"
	Set rsCategory = Server.CreateObject("ADODB.RecordSet")
	rsCategory.Open strSQL, DbConn
%>