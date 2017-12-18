

<html>
<head>
<title>지구촌 한글좌표</title>
</head>

	<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

	<script>
		function initialize() {


			//var Y_point			= 37.5297876;		// Y 좌표
			//var X_point			= 126.9257818;		// X 좌표
			var Y_point			= <%=request("lat_value") %>;		// Y 좌표
			var X_point			= <%=request("lon_value") %>;		// X 좌표

			var zoomLevel		= 17;						// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼

			var markerTitle		= "test";				// 현재 위치 마커에 마우스를 오버을때 나타나는 정보
			//var markerTitle		= "<%=request("pos_words") %>";				// 현재 위치 마커에 마우스를 오버을때 나타나는 정보
			var markerMaxWidth	= 300;						// 마커를 클릭했을때 나타나는 말풍선의 최대 크기

			// 말풍선 내용
			var contentString	= '<div>' +
			'<h2>지구촌 한글 그리드</h2>' +
	        '<p>지구촌 한글 그리드<br>하나된 지구를 만들어 갑니다.</p>' +
			'</div>';

			var myLatlng = new google.maps.LatLng(Y_point, X_point);
			var mapOptions = {
								zoom: zoomLevel,
								center: myLatlng,
								mapTypeId: google.maps.MapTypeId.ROADMAP
			}
        
			var map = new google.maps.Map(document.getElementById('map_view'), mapOptions);

			var marker = new google.maps.Marker({
													position: myLatlng,
													map: map,
													title: markerTitle
			});

			var infowindow = new google.maps.InfoWindow(
														{
															content: contentString,
															maxWidth: markerMaxWidth
														}
			);

			google.maps.event.addListener(marker, 'click', function() {
        
			infowindow.open(map, marker);
			});
		}
	</script>
<body onload="initialize()" >

    <div id="map_view" style="width:700px; height:500px;"></div>
</body>

</html>




