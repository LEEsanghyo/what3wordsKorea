

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
          zoom: 12,
          center: uluru
        });

        var contentString = '<div style="text-align:center;color:#3388cc;"><%=request("pos_words") %></div>';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker = new google.maps.Marker({
          position: uluru,
          map: map,
          title: 'Uluru (Ayers Rock)'
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });

        var bounds = {
        north: <%=request("lat2") %>,
        south: <%=request("lat1") %>,
        east: <%=request("lon2") %>,
        west: <%=request("lon1") %>
        };

  
        // Define a rectangle and set its editable property to true.
        var rectangle = new google.maps.Rectangle({
          bounds: bounds,
          editable: false
        });
        rectangle.setMap(map);

      }


    </script>

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap">
    </script>

</body>

</html>




