<!-- #include virtual="/_include/words.asp" -->
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>좌표 관리</title>
		<link rel="stylesheet" href="/_include/style.css" type="text/css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	</head>
	
	<body>
		<% top_menu = "글공유" %>
		<!-- #include virtual="/_include/top_menu.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
		<div style="margin-top:100px" class="container-fluid">
			<div class="row">
				<div class="col-xs-3"></div>
				<div class="col-xs-6">
					<input type="text" id="original_address" class="form-control" placeholder="검색할 주소를 입력하세요">
				</div>
				<div class="col-xs-3">
					<button type="button" class="btn btn-primary" onclick="original_search()">검색</button>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-xs-2"></div>
				<div class ="col-xs-1" id="panel">
					<div class="has-error checkbox">
						<label>
							<input type="checkbox" id="음식점" onchange="information(this.value)" value="음식점">
							음식점
						</label>
						<hr>
						<label>
							<input type="checkbox" id="호텔"	onchange="information(this.value)" value="호텔">
							호텔
						</label>
						<hr>
						<label>
							<input type="checkbox" id="관광지"	 onchange="information(this.value)" value="관광지">
							관광지
						</label>
						<hr>
						<label>
							<input type="checkbox" id="추천"	onchange="information(this.value)" value="추천">
							추천
						</label>
						<hr>
						<label>
							<input type="checkbox" id="북마크" onchange="information(this.value)" value="북마크">
							북마크
						</label>
						<hr>
					</div>
				</div>
				<div class="col-md-8 col-sm-6" id="map"></div>	
				<div class="col-xs-1"></div>
				<form style="margin:center;text-align:center;" action="test_ajax.asp" method=post>
					<br>
					<input style="text-align:center;" type="text" class="form-control" id="test3word" disabled><br>
					이름 : <input type=text name=p_poi_name value="<%=name%>">&nbsp
					세부업종 : <input type="text" name=intro value="<%=intro%>"><br>
					카테고리 : <select name=category>
						<% Do While not rsCategory.EOF %>
						<option value=<%=rsCategory("cat_no")%>><%=rsCategory("cat_name")%></option>
						<%
							rsCategory.MoveNext
							Loop
							set rsCategory = Nothing
						%>
					</select>&nbsp
					전화번호 : <input type="text" name=phone value="<%=phone%>"><br>						
					상세 정보<br><textarea name=info cols=50 rows=4 value="<%=poi_desc%>"></textarea><br>
					사진 올리기<input type=file name=pic accept="image/*" multiple><br>
					<input type=submit value="저장">&nbsp&nbsp&nbsp&nbsp<input type="button" id="save" value="취소" onclick='history.back(-1)'>
				</form>
			</div>
		</div>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<script src="/_script/map.js"></script>
		<script>
			var map;
			var bounds;
			var uluru;
			var zoom_level = <%= zoom_level %>
			bounds = {
				north: <%= lon2 %>,
				south: <%= lon1 %>,
				east: <%= lat2 %>,
				west: <%= lat1 %>
			};
			
			uluru = {lat: <%= lat_value %>, lng: <%= lon_value %>};
		</script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap"></script>
	</body>
</html>