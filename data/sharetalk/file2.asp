<!-- #include virtual="/_include/connect.inc" -->
<%
  Server.ScriptTimeout=3600
  '서버 session time = 1시간

  if request("search_lat") <> "" then
    search_lat = request("search_lat")
  else
    search_lat = "42163"
  end if

  if request("search_lon") <> "" then
    search_lon = request("search_lon")
  else
    search_lon = "111670"
  end if

  search_word = request("search_word")

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
    lat1 = "32.910549"
  end if

  if request("lon1") <> "" then
    lon1 = request("lon1")
  else
    lon1 = "123.715624"
  end if

  if request("lat2") <> "" then
    lat2 = request("lat2")
  else
    lat2 = "42.983403"
  end if

  if request("lon2") <> "" then
    lon2 = request("lon2")
  else
    lon2 = "131.625780"
  end if

  if request("pos_words") <> "" then
    pos_words = request("pos_words")
  else
    pos_words = "Korea"
  end if

  if request("zoom_level") <> "" then
    zoom_level = request("zoom_level")
  else
    zoom_level = 6
  end if

  strSQL = "p_gmap_wordgrid_read_lat_new  '" & search_lat & "','" & search_lon & "'"

  Set rsGrid = Server.CreateObject("ADODB.RecordSet")
  rsGrid.Open strSQL, DbConn, 1, 1

  if rsGrid.EOF or rsGrid.BOF then
    NoDataGrid = True
  Else
  NoDataGrid = False
  end if

  strSQL = "p_gmap_wordgrid_list  '" & search_word & "'"

  'response.write  strSQL
  'response.End

  Set rsGridList = Server.CreateObject("ADODB.RecordSet")
  rsGridList.Open strSQL, DbConn, 1, 1

  if rsGridList.EOF or rsGridList.BOF then
    NoDataGridList = True
  Else
  NoDataGridList = False
  end if

    MENU = "HOME"
    keyword = request("keyword")

    talk_member_email = Request.Cookies("talk_member_email")
    talk_member_pwd = Request.Cookies("talk_member_pwd")

    strSQL = "p_login_auto_check '" & talk_member_email & "','" & _
                                      talk_member_pwd & "'"

    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1

    'response.write "3"
    'response.end

    if rsData("p_count") > "0" then
      Session("member_no") = rsData("member_no")
      Session("member_name") = rsData("member_name")
      Session("member_email") = rsData("member_email")
      Session("admin_flag") = rsData("admin_flag")
      Session("authority_level") = rsData("authority_level")
    end if

    set rsData = nothing

    strSQL = "p_tsh_post_read '" & keyword & "','" & request("cat_no") & "'"

    'response.Write strSQL
    'response.end

    set rsPost = Server.CreateObject("ADODB.Recordset")
    rsPost.CursorLocation = 3
    rsPost.Open strSQL, DbCon

    if rsPost.EOF or rsPost.BOF then
	  NoDataPost = True
    Else
	   NoDataPost = False
    end if

    '페이징처리관련
    page =request("page")

    If NoDataPost = False then
  	  Cus_pageSize = 20
	  rsPost.PageSize = Cus_pageSize

	  pagecount=rsPost.pagecount
  	  totalRecord = rsPost.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If
	  rsPost.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsPost.PageSize) + 1)

      if page > lastpg then
	  	page = lastpg
      end If

    end if
    '페이징처리관련 끝

    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbCon, 1, 1

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if
%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>글공유 HOME</title>
<style type="text/css">
* { padding: 0; margin: 0; }

html, body {
    max-width: 100%;
    overflow-x: hidden;
    font-family: Arial, 맑은 고딕, 돋움; background:#FFFFFF;
    padding:0px;margin:0px;
}
a { text-decoration: none; color: #000000; }
li { list-style-type: none; }
header {
    width: 100%;
	height: 70px;
	margin: 0px;
    background:#5A6CB4;
    padding: 0px;
    position:fixed;
    z-index:4
}
#brand {
    width: 80%;
	float: left;
	height: 40px;
    padding:0px;
	color: #FFFFFF;
}
nav { width: 100%; text-align: center; top:70px;}
nav a {
	display: block;
	padding: 15px 0;
	border-bottom: 1px solid #0076A3;
	color: #00A5CC;
}
nav a:hover { background: #6DCFF6; color: #FFF; }
nav li:last-child a { border-bottom: none; }
/*-----------------------------------------*/
.menu {
  z-index:5;
	width: 240px;
	height: 100%;
	position: absolute;
	background: #EEEEEE;
	left: -240px;
	transition: all .3s ease-in-out;
	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;

}
.menu-icon {
	padding: 10px 10px;
    margin:0px 5px 0px 0px;
	background: #EEEEEE;
    float:right;
	color: #0cc738;
	cursor: pointer;
	margin-top: 4px;
	border-radius: 5px;
    position:absolute;
    top:5px;
    right:5px;
}
#menuToggle { display: none; }
#menuToggle:checked ~ header { position: absolute; left: 0; }
#menuToggle:checked ~ .menu { position: absolute; left: 0; }
#menuToggle:checked ~ .login { position: absolute; left: 60px; top:50px; }
#menuToggle:checked ~ .title { position: absolute; left: 260px; top:50px; }
#menuToggle:checked ~ .content { position: absolute; left: 260px; top:10px; }
#menuToggle:checked ~ .bottom { position:absolute; left: 260px; }


.title {
    text-align:center;
    font-size:25px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    height:30px;
    margin:2px;
    padding:5px;
    color:#0cc738;
//    background: #0cc738;
    border-radius: 2px;
}

.login {
    margin:0px;
    padding:0px;
    display:flex;
    justify-content:center;
    height:60px;
}

.content {
	width: 100%;
	margin: 0px;
    font-size:16px;
    font-family:Arial, 맑은 고딕, 돋움;
    /* font-weight:bold; */
    background:#FFFFFF;
    padding:0px;
	transition: all .3s ease-in-out;
	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;
}

.bottom {
    font-size:14px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    padding:20px;
    margin:2px;
}

/* 게시판 디자인 */
.main_table {
    width:100%;
    border:0px;
    font-family:Arial, 맑은 고딕, 돋움;
}

.bbcTitle {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 1.2em;
    font-weight:bold;
    color:#000000;
    margin: 5px 5px 5px 5px;
    padding:5px 5px 5px 5px;
}

.bbcContent {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.98em;
    color:#000000;
    margin:5px 5px 5px 20px;
    padding:5px 5px 5px 5px;
}
.bbcDate {
    height:20px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.8em;
    color:#000000;
    margin:5px 5px 5px 20px;
    padding:5px 5px 5px 5px;
}

span td a {
    font-family:Arial, 맑은 고딕, 돋움;
}

/* 게시판 디자인 */

/* 팝업 메뉴 start */
            #popupBoxLogin{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
			}

			.popupBoxWrapper{
				width: 300px; margin: 0px; text-align: left;position:absolute;top:100px;left:20px;right:50;border-radius:0px;
			}
			.popupBoxContent{
				background-color: #FFF; padding: 0px;border-radius:2px;
			}

/* 팝업 메뉴 end */

			/* navigation start */
			ul.category {
				list-style-type:none;
				margin:0;
				padding:0;
				/* position:absolute; */
			}
			li.category {
				display: inline-block;
				float:left;
				margin-right: 1px;
			}
			li.category a {
				display:block;
				min-width:60px;
				height: 40px;
				text-align:center;
				line-height:40px;
				font-size:14px;
				font-family:Arial,맑은 고딕,돋움;
				font-weight:bold;
				color:#000000;
				background: #FFFFFF;
				text-decoration: none;
			}
			/*Hover state for top level links */

			li.category:hover a {
				color: #19C589;
			}
			/* navigation end */

      #map {
       height: 600px;
      }

      #panel{
      background-color:#e5e5e5;
      position: absolute;
      left: 65%;
      z-index: 3;
      border: 1px solid #999

      }
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<SCRIPT LANGUAGE=javascript>

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




    function PostEngage(elem) {
        //alert("1");
        var pno = elem.getAttribute("pno");
        var code = elem.getAttribute("code");
        var myNodelist = document.getElementsByName("engage" + pno);
        var i;
        for (i = 0; i < myNodelist.length; i++) {
            myNodelist[i].style.color = "#000000";
        }
        //alert("2");
        elem.style.color = "#3388cc";
        //alert(rprocess);
        var strurl = "ws_engage_set.asp?post_no=" + pno + "&engage_code=" + code;
        //alert(strurl);
        //return false;
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = PostEngageSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }
    function PostEngageSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');
            //alert(data);
            //alert(slipdata[2]);
            document.getElementById("engage_" + slipdata[0]).innerHTML = "공감 " + slipdata[1];
            if (slipdata[2] == "") {
                document.getElementById("trbox_" + slipdata[0]).style.display = "none";
            }
            else {
                document.getElementById("trbox_" + slipdata[0]).style.display = "block";
                document.getElementById("engagebox_" + slipdata[0]).innerHTML = slipdata[2];
            }
            //alert(slipdata[2]);
        }
    }
    function VisitRegister() {
        var siteurl = "member_register.asp";
        //alert(siteurl);
        window.location.href = siteurl;
    }
    function LoginPopup() {
        var email = document.getElementById("member_email").value;
        var n = email.search(/@/i);
        //alert(n);
        if (email == "") {
            //alert("이메일을 입력하세요.");
            document.getElementById("member_email").placeholder = "이메일을 입력하세요.";
            document.getElementById("member_email").focus();
            return false;
        }
        toggle_visibility('popupBoxLogin');
        document.getElementById("member_pwd").focus();
    }
    function LoginConfirm() {
        var email = document.getElementById("member_email").value;
        var pwd = document.getElementById("member_pwd").value;
        if (pwd == "") {
            alert("비밀번호를 입력하세요.");
            document.getElementById("member_pwd").focus();
            return false;
        }
        var strurl = "login_set.asp?member_email=" + email + "&member_pwd=" + pwd;
        //alert(strurl);
        //return false;
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = LoginConfirmSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }
    function LoginConfirmSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //var slipdata = data.split(',');
            var siteurl = "default.asp";
            window.location.href = siteurl;
        }
    }
    function PostSearch() {
        var keyword = document.getElementById("keyword").value;
        var siteurl = "default.asp?keyword=" + keyword;
        window.location.href = siteurl;
        //alert(keyword);
    }
    function toggle_visibility(id) {
        var e = document.getElementById(id);
        if (e.style.display == 'block')
            e.style.display = 'none';
        else
            e.style.display = 'block';
    }

    function original_search(){

      var original_address= document.getElementById("original_address").value;

      var geocoder = new google.maps.Geocoder();
      geocoder.geocode({'address':original_address},

    		function(results, status){

    			if(results!=""){

    				var location=results[0].geometry.location;

    				lat=location.lat();
    				lng=location.lng();

            var strsql = "range_find_ajax.asp?x_center=" + lat + "&y_center=" + lng;

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
         var uluru = {lat: <%=lat_value %>, lng: <%=lon_value %>};
         map = new google.maps.Map(document.getElementById('map'), {
           zoom: <%=zoom_level %>,
           center: uluru
         });

         getLocation();
         google.maps.event.addDomListener(window, "resize", function() {
           var center = map.getCenter();
           google.maps.event.trigger(map, "resize");
           map.setCenter(center);
         });

         var bounds = {
      north: <%=lon2 %>,
      south: <%=lon1 %>,
      east: <%=lat2 %>,
      west: <%=lat1 %>
      };

      map.addListener('center_changed', function(){  // center 바뀔 때, event 등록
        if(map.getZoom() == 15){
          test3word=document.getElementById("test3word");
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
          var strsql = "range_find_ajax.asp?x_center=" + x_center + "&y_center=" + y_center;
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
                    if(data != '')
                    test3word.value = data;
                    }
                }

    function getLocation() {       // 내 위치
                  if (navigator.geolocation) { // GPS를 지원하면
                    navigator.geolocation.getCurrentPosition(function(position) {

                      var strsql = "range_find_ajax.asp?x_center=" + position.coords.latitude + "&y_center=" + position.coords.longitude;
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

        break;

        case "호텔":
        for(var i=0; i<markersArray_lodging.length;i++){
          markersArray_lodging[i].setMap(null);
        }
        break;

        case "관광지":



        break;

        case "추천": alert("ㅁ");break;

        case "북마크": alert("ㅁ");break;

      }


      }
    }
    function search_nearby_sql(no){

      var bounds = map.getBounds();
      var min_lat = map.getBounds().getSouthWest().lat();
      var min_lng = map.getBounds().getSouthWest().lng();
      var max_lat = map.getBounds().getNorthEast().lat();
      var max_lng = map.getBounds().getNorthEast().lng();

      var strsql = "search_nearby_sql_ajax.asp?min_lat="+ min_lat+"&max_lat="+max_lat +"&min_lng="+min_lng  +"&max_lng="+max_lng;

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


                case 2: break;   // lodging




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
                            /*   markersArray_restaurant[i].addListener('click', function(){
                                  (function(place_id, place_name){
                                    alert(place_name);
                                   detail_url += place_id + "&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
                                   show_detail(detail_url, place_name);

                                  })(place_id, json["results"][i].name);

                                }) */

                              //  markersArray_restaurant[i].addListener('click', function(result, place_id,place_name){
                              //  alert(place_name);
                              //  detail_url += place_id + "&key=AIzaSyAMrRsdusECHHPD-La4B6FUocXp6XcyxeQ";
                              //      show_detail(detail_url);
                             //    });

                             strsql = "test_ajax.asp?p_poi_name=" + json["results"][i].name + "&p_gcat_name_en=restaurant&p_lat_value="+json["results"][i].geometry.location.lat + "&p_lon_value="+json["results"][i].geometry.location.lng;
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


</SCRIPT>


</head>
<body>
<% top_menu = "글공유" %>
 <!-- #include virtual="/_include/top_menu.asp" -->
 <!-- #include virtual="/_include/top_menulist.asp" -->

<div style="margin-top:100px" class="container-fluid">
    <div class="row">
      <div class="col-xs-1 col-sm-3"></div>
      <div class="col-xs-7 col-sm-6">
        <input type="text" id="original_address" class="form-control" placeholder="검색할 주소를 입력하세요">
      </div>
      <div class="col-xs-3 col-sm-3">
        <button type="button" class="btn btn-primary" onclick="original_search()">검색</button>
      </div>
    </div>
    <br><hr>

    <div class="row">

      <div class ="col-xs-1 col-md-2"></div>
      <div class="col-xs-10 col-md-8" id="map">
      <script>
          initMap();
      </script>

      </div>

      <div class ="col-xs-4 col-md-2" id="panel">
      <div class="has-error checkbox">
      <label>
        <input type="checkbox" id="음식점" onchange="information(this.value)" value="음식점">
        음식점
      </label>
      <hr>
      <label>
        <input type="checkbox" id="호텔"  onchange="information(this.value)" value="호텔">
        호텔
      </label>
      <hr>
      <label>
        <input type="checkbox" id="관광지"  onchange="information(this.value)" value="관광지">
        관광지
      </label>
      <hr>
      <label>
        <input type="checkbox" id="추천"  onchange="information(this.value)" value="추천">
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
    </div>

    <br><br><hr>
    <div>
      <div class="row">
        <div class="col-xs-0 col-sm-1">  </div>
        <div class="col-xs-4 col-sm-5" style="text-align:center" >내 위치</div>
        <div class="col-xs-8 col-sm-5">
        <input type="text" id="my_position" class="form-control" disabled>
        </div>
        <div class="col-xs-0 col-sm-1">  </div>
      </div>
      <br>
      <div class="row">
          <div class="col-xs-0 col-sm-1">  </div>
          <div class="col-xs-4 col-sm-5" style="text-align:center">갈 곳 </div>
          <div class="col-xs-8 col-sm-5">
          <input type="text" class="form-control" id="test3word" disabled>
          </div>
          <div class="col-xs-0 col-sm-1">  </div>

  </div>

</div>

<hr>
<div class="row">
  <div class ="col-xs-12 col-sm-12">
    <textarea class="form-control" style="overflow-y: hidden;overflow-x:hidden" disabled></textarea>
  </div>
</div>
<hr>
<div>
  <div class="row">
    <div class="col-xs-12 col-sm-12" id="photo"><div>

    <div class="col-xs-12 col-sm-6" id="name"></div> <div class="col-xs-12 col-sm-6" id="tel_no"></div>
    <div class="col-xs-12 col-sm-12" id="address"></div>
    <div class="col-xs-12 col-sm-6" id="open_time"></div> <div class="col-xs-12 col-sm-6" id="current_open"></div>
    <div class="col-xs-12 col-sm-12" id="weekday_text"></div>
    <div class="col-xs-12 col-sm-12" id="rating"></div>
    <div class="col-xs-12 col-sm-12" id="reviews"></div>
    <div class="col-xs-12 col-sm-12" id="website"></div>

  </div>
  <br>
  <div class="row">
      <div class="col-xs-1 col-sm-1" style="background-Color:brown">q  </div>
      <div class="col-xs-5 col-sm-5" style="background-Color:black">w  </div>
      <div class="col-xs-5 col-sm-5" style="background-Color:red">e  </div>
      <div class="col-xs-1 col-sm-1" style="background-Color:brown">r  </div>
  </div>
</div>

</div>


    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap">
    </script>

     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    <!-- #include virtual="/_include/connect_close.inc" -->
    </body>
  </html>
