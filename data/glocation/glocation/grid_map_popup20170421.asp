

<html>
<head>
<title>������ �ѱ���ǥ</title>
</head>

	<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

	<script>
		function initialize() {


			//var Y_point			= 37.5297876;		// Y ��ǥ
			//var X_point			= 126.9257818;		// X ��ǥ
			var Y_point			= <%=request("lat_value") %>;		// Y ��ǥ
			var X_point			= <%=request("lon_value") %>;		// X ��ǥ

			var zoomLevel		= 17;						// ������ Ȯ�� ���� : ���ڰ� Ŭ���� Ȯ�������� ŭ

			var markerTitle		= "test";				// ���� ��ġ ��Ŀ�� ���콺�� �������� ��Ÿ���� ����
			//var markerTitle		= "<%=request("pos_words") %>";				// ���� ��ġ ��Ŀ�� ���콺�� �������� ��Ÿ���� ����
			var markerMaxWidth	= 300;						// ��Ŀ�� Ŭ�������� ��Ÿ���� ��ǳ���� �ִ� ũ��

			// ��ǳ�� ����
			var contentString	= '<div>' +
			'<h2>������ �ѱ� �׸���</h2>' +
	        '<p>������ �ѱ� �׸���<br>�ϳ��� ������ ����� ���ϴ�.</p>' +
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




