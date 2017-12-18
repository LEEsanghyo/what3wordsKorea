

<!DOCTYPE html>
<head>
<title>Áö±¸ÃÌ ÇÑ±ÛÁÂÇ¥</title>
        <style>
       #map {
        height: 400px;
        width: 100%;
       }
    </style>

</head>

	<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

  <body>

    <h3></h3>
    <div id="map"></div>
    <script>
      function initMap() {
        var uluru = {lat: <%=request("lat_value") %>, lng: <%=request("lon_value") %> };
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 17,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap">
    </script>

</body>

</html>




