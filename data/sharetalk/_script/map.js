var lat, lng;
var marker;
var marker_flag=0;
var xhr;
var map;
var center_marker;
var test3word;
var my_position;
var count = 0;
var markersArray_restaurant = [];
var markersArray_lodging = [];
var detail_url;

function original_search(){
	var original_address= document.getElementById("original_address").value;
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({'address':original_address},
		function(results, status){
			if(results!=""){
				var location=results[0].geometry.location;
				lat=location.lat();
				lng=location.lng();
				var strsql = "/map/range_find_ajax.asp?x_center=" + lat + "&y_center=" + lng;
				xhr = new XMLHttpRequest();
				xhr.onreadystatechange = return_original_search;
				xhr.open("Get", strsql);
				xhr.send(null);
			}
		}
	)
}

function return_original_search(){
	if (xhr.readyState == 4) {
		var data = xhr.responseText;
		if(data != ''){
			if(marker_flag != 0) marker.setMap(null);
			marker_flag++;
			move_camera(lat, lng);
			marker = new google.maps.Marker({
				position: {
					lat: lat,
					lng: lng
				},
				map: map
			});
			var test3word = document.getElementById("test3word");
			test3word.value = data;
		}
	}
}

function move_camera(lat, lng){
	map.panTo(new google.maps.LatLng(lat, lng));
	map.setZoom(15);
}

function initMap() {
	getLocation();
	map = new google.maps.Map(document.getElementById('map'), {
		center : uluru,
		//center : { lat : 37.946976, lng: 127.670702 },
		zoom : zoom_level
	});
	google.maps.event.addDomListener(window, "resize", function() {
		var center = map.getCenter();
		google.maps.event.trigger(map, "resize");
		map.setCenter(center);
	});
	map.addListener('center_changed', function(){  // center 바뀔 때, event 등록
		if(map.getZoom() == 15){
			test3word = document.getElementById('test3word');
			var bounds = map.getBounds();
			x_southwest = map.getBounds().getSouthWest().lat();
			y_southwest = map.getBounds().getSouthWest().lng();
			x_northeast = map.getBounds().getNorthEast().lat();
			y_northeast = map.getBounds().getNorthEast().lng();
			var x_center = (x_southwest + x_northeast)/2;
			var y_center = (y_southwest + y_northeast)/2;
			if(count!=0) center_marker.setMap(null);
			center_marker = new google.maps.Marker({
				position: {
					lat: x_center,
					lng: y_center
				},
				map: map
			});
			count++;
			var strsql = "/map/range_find_ajax.asp?x_center=" + x_center + "&y_center=" + y_center;
			xhr = new XMLHttpRequest();
			xhr.onreadystatechange = setMarker;
			xhr.open("Get", strsql);
			xhr.send(null);
		}
	});
	// Define a rectangle and set its editable property to true.
	var rectangle = new google.maps.Rectangle({
		bounds: bounds,
		editable: false
	});
	rectangle.setMap(map);
}

function setMarker(){
	if (xhr.readyState == 4) {
		var data = xhr.responseText;
		if(data != '')	test3word.value = data;
	}
}

function getLocation(){	   // 내 위치
	if (navigator.geolocation) { // GPS를 지원하면
		navigator.geolocation.getCurrentPosition(function(position) {
			var strsql = "/map/range_find_ajax.asp?x_center=" + position.coords.latitude + "&y_center=" + position.coords.longitude;
			move_camera(position.coords.latitude, position.coords.longitude);
			marker = new google.maps.Marker({
				position: {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				},
				map: map
			});
			xhr = new XMLHttpRequest();
			xhr.onreadystatechange = my_position;
			xhr.open("Get", strsql);
			xhr.send(null);
			}, function(error) {
				console.error(error);
			}, {
			enableHighAccuracy: false,
			maximumAge: 0,
			timeout: Infinity
		});
	} else {
		alert('GPS를 지원하지 않습니다');
	}
}

function my_position(){
	if(xhr.readyState ==4){
		var data=xhr.responseText;
		if(data!=''){
			my_position = document.getElementById("my_position");
			my_position.value =data;
		}
		navigator.geolocation.watchPosition(getLocation, location_error ,{maximumAge:2000})
	}
}

function location_error(){
	switch(error.code) {
		case error.UNKNOWN_ERROR:
			alert("unknown error");
			break;
		case error.PERMISSION_DENIED:
			alert("Permission to use Geolocation was denied");
			break;
		case error.POSITION_UNAVAILABLE:
			alert("unavailable");
			break;
		case error.TIMEOUT:
			alert("timeout error");
			break;
	}
}

function information(target){
	if(document.getElementById(target).checked){
		var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + map.getCenter().lat() +"," + map.getCenter().lng() + "&radius=1500&type=";
		detail_url="https://maps.googleapis.com/maps/api/place/details/json?placeid=";
		switch(target){
			case "음식점":
				url += "restaurant&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
				search_nearby(url,1);
				//search_nearby_sql(1);
				break;
			case "호텔":
				//url += "lodging&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
				//search_nearby(url,2);
				search_nearby_sql(2);
				break;
			case "관광지":
				//url += "amusement_park&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
				//search_nearby(url,3);
				search_nearby_sql(3);
				break;
			case "추천": alert("ㅁ");break;
			case "북마크": alert("ㅁ");break;
		}
	}
	else{
		switch(target){
			case "음식점":
				for(var i=0; i<markersArray_restaurant.length;i++){
					markersArray_restaurant[i].setMap(null);
				}
				break;
			case "호텔":
				for(var i=0; i<markersArray_lodging.length;i++){
					markersArray_lodging[i].setMap(null);
				}
				break;
			case "관광지":
				break;
			case "추천": break;
			case "북마크": break;
		}
	}
}

function search_nearby_sql(no){
	var bounds = map.getBounds();
	var min_lat = map.getBounds().getSouthWest().lat();
	var min_lng = map.getBounds().getSouthWest().lng();
	var max_lat = map.getBounds().getNorthEast().lat();
	var max_lng = map.getBounds().getNorthEast().lng();
	var strsql = "/map/search_nearby_sql_ajax.asp?min_lat="+ min_lat+"&max_lat="+max_lat +"&min_lng="+min_lng  +"&max_lng="+max_lng;
	console.log(strsql);
	xhr=new XMLHttpRequest();
	xhr.onreadystatechange=return_search_nearby_sql;
	xhr.open("Get",strsql);
	xhr.send(null);
}

function return_search_nearby_sql(){
	if(xhr.readyState==4){
		var data = xhr.responseText;
		if(data != '') {
			var data_arr = data.split("/");
			for(var i = 0; i<data_arr.length/7;i++){
				switch(parseInt(data_arr[5+(7*i)])){
					case 1:
					markersArray_restaurant[i] =  new google.maps.Marker({
						position: {
							lat: parseFloat(data_arr[4+(7*i)]),
							lng: parseFloat(data_arr[3+(7*i)])
						},
						map: map,
						title:data_arr[6+(7*i)],
						icon:"http://maps.google.com/mapfiles/kml/pal2/icon32.png"
					});
					break;
					case 2: break;	 // lodging
				} //switch
			} //for
			into_marker(data_arr);
		}  // if
	}
}

function into_marker(data_arr){
	for(var i=0; i<data_arr.length/7; i++){
		a(i, data_arr);
	}
}

function a(i, data_arr){
	markersArray_restaurant[i].addListener('click',function(){
		document.getElementById("name").innerHTML = data_arr[6+(7*i)];
		document.getElementById("weekday_text").innerHTML = data_arr[2+(7*i)];
		document.getElementById("tel_no").innerHTML = data_arr[1+(7*i)];
	});
}

function search_nearby(url, no){
	$.ajax({
		type:"GET",
		url: url,
		success:function(json){
			console.log(url);
			//alert(json["results"][0].name);
			var length = json["results"].length;
			//alert(length);
			for(var i=0; i<length; i++){
				if(no ==1){
					markersArray_restaurant[i] =  new google.maps.Marker({
						position: {
							lat: json["results"][i].geometry.location.lat,
							lng: json["results"][i].geometry.location.lng
						},
						map: map,
						title:json["results"][i].name,
						icon:"http://maps.google.com/mapfiles/kml/pal2/icon32.png"
					});
					var place_id = json["results"][i].place_id;
					//alert(json["results"][i].name);
					/*	 markersArray_restaurant[i].addListener('click', function(){
					(function(place_id, place_name){
					alert(place_name);
					detail_url += place_id + "&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
					show_detail(detail_url, place_name);
					})(place_id, json["results"][i].name);
					}) */
					//	markersArray_restaurant[i].addListener('click', function(result, place_id,place_name){
					//	alert(place_name);
					//	detail_url += place_id + "&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
					//		show_detail(detail_url);
					//	  });
					strsql = "/map/test_ajax.asp?p_poi_name=" + json["results"][i].name + "&p_gcat_name_en=restaurant&p_lat_value="+json["results"][i].geometry.location.lat + "&p_lon_value="+json["results"][i].geometry.location.lng;
					console.log(strsql);
					test_ajax(strsql);
				}
				else if(no==2){
					markersArray_lodging[i] =  new google.maps.Marker({
						position: {
							lat: json["results"][i].geometry.location.lat,
							lng: json["results"][i].geometry.location.lng
						},
						map: map,
						title:json["results"][i].name,
						icon:"http://maps.google.com/mapfiles/kml/pal2/icon10.png"
					});
				}
				else if(no==3){
				}
				else if(no==4){
				}
				else if(no==5){
				}
				//console.log(json["results"][i].name);
			} // for
			add_marker_event(json);
		} //success
	}) //ajax
}

function test_ajax(strsql){
	var xhr2 = new XMLHttpRequest();
	xhr2.onreadystatechange=function(){
		if(xhr2.readyState==4){
			var data = xhr2.responseText;
		}
	}
	xhr2.open("POST",strsql);
	xhr2.send(null);
}

function return_test(){
	if(xhr2.readyState==4){
		var data = xhr3.responseText;
	}
}

function add_marker_event(json){
}

function show_detail(detail_url, place_name){
	$.ajax({
		type:"GET",
		url: detail_url,
		success:function(json){
			document.getElementById("name").innerHTML = place_name;
			console.log("formatted_phone_number" in json["result"]);
			a= "formatted_phone_number" in json["result"];
			alert(a);
			if(a)
				document.getElementById("tel_no").innerHTML = json["result"].formatted_phone_number;
				a = "formatted_address" in json["result"]
			if( a == true)
				document.getElementById("address").innerHTML = json["result"].formatted_address;
			if("opening_hours" in json["result"] == true){
				if("weekday_text" in json["result"].opening_hours == true){
					for(var i=0 ;i< json["result"].opening_hours.weekday_text.length;i++)
						document.getElementById("current_open").innerHTML += json["result"].opening_hours.weekday_text[i];
					}
				}
				if("rating" in json["result"] == true)
					document.getElementById("rating").innerHTML = json["result"].rating;
				if("reviews" in json["result"] == true){
				for(var i=0; i< json["result"].reviews.length;i++){
					document.getElementById("reviews").innerHTML += "작성자: " + json["result"].reviews[i].author_name + "\n" +
					"평점: " + json["result"].reviews[i].rating + "\n" +
					"작성 날짜: " + json["result"].reviews[i].relative_time_description + "\n" +
					"내용: " + json["result"].reviews[i].text + "\n\n" ;
					}
				}
			if("website" in json["result"] == true)
			document.getElementById("website").innerHTML = json["result"].website;
		} // success
	}) //ajax
}