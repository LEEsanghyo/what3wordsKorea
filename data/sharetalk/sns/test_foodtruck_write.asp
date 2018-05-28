<!-- #include virtual="/_include/connect.inc" -->
<%
    input_user = Request.Cookies("member_name")
    input_userid = Session("member_no")
%>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>What3Words Home</title>
		<link rel="stylesheet" href="/_css/style.css" type="text/css">		
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <style>
            #under_the_nav{
                width:100%;
                height:100%;
                display:flex;
                flex-flow: row nowrap;
                justify-content: space-between;
                margin-top:70px;
            }
            #write_box{
                width:100%;
                height:100%;
                margin-left:10%;
                margin-right:10%;
                margin-bottom:50%;
                padding:2%;
                border:1px red solid;
            }
            .title_box{
                text-align:center;
            }
            .title_zone{

            }
            .title_input{
            }
            .content_box{
                text-align:center;
            }
            .content_zone{

            }
            .content_input{

            }
            #content_input_area{
                width:100%;
                min-height:200px;
            }
            .file_upload_box{
                text-align:center;
            }
            .file_zone{

            }
            .file_upload{

            }
            #file_upload_area{
                width:100%;
            }
            .location_box{
                text-align:center;
            }
            .location_zone{

            }
            .lat_input{
                width:100%;
            }
            .log_input{
                width:100%;
            }
            #latitude{
                width:100%;
            }
            #logitude{
                width:100%;
            }
            .button_box{
                text-align:center;
            }
        </style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.0.js"></script>
		<script type="text/javascript">
		    var lat_r ="";
            var log_r = "";
            function geoFind() {
                //Geolocation API에 액세스할 수 있는지를 확인
                alert("System start finding your location... Please wait for completion");
                if (navigator.geolocation) {
                    //위치 정보를 얻기
                        navigator.geolocation.getCurrentPosition(function (pos) {
                            lat_r = pos.coords.latitude;
                            log_r = pos.coords.longitude;
                            $('#latitude').html(pos.coords.latitude);       // 위도
                            $('#longitude').html(pos.coords.longitude);  // 경도
                            alert(lat_r);
                        });
                } else {
                    alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
                }
            }

            function write_upload() {
                var title_input = document.getElementById("input_title").value;
		        var content_input_area = document.getElementById("content_input_area").value;
		        var file_path = document.getElementById("file_upload_area").value;
		        var file_upload_area = file_path.split("\\");
		        var file_upload_area_real = "images/" + file_upload_area[2];
		        var latitude = lat_r;
		        var longitude = log_r;
                var foodtruck_code = 2;

		        if (latitude.length < 2) {
		            alert("please wait for location");
		            return false;
		        }

                if (title_input == "") {
                    alert("title is empty");
                    return false;
                }
		        else if (content_input_area == "") {
		            alert("content is empty");
		            return false;
		        }
		        else if (file_upload_area_real == "") {
		            alert("upload is empty");
		            return false;
		        }
		        else if (latitude == "") {
		            alert("lat is empty");
		            return false;
		        }
		        else if (longitude == "") {
		            alert("lat is empty");
		            return false;
		        }
		        else {
                    var content = content_input_area.replace(/\n/g, '<br/>');
                    var user = '<%=input_user%>';
                    var userid = <%=input_userid%>;
		            var strurl = "test_send_write_daily.asp?file_upload_area_real=" + file_upload_area_real + "&title_input=" + title_input + "&content_input_area=" + content + "&latitude=" + latitude + "&longitude=" + longitude + "&code=" + foodtruck_code + "&input_user=" + user + "&input_userid=" + userid;

		            xhr = new XMLHttpRequest();
		            xhr.onreadystatechange = SendContent;
		            xhr.open("Get", strurl);
		            alert(strurl);
		            xhr.send(null);
		            location.href = "test_page_insta.asp";
		            return true;
		            
		        }
		    }

		    function SendContent() {
		        if (xhr.readyState == 4) {
		            var data = xhr.responseText;
		            document.getElementById("result_msg").innerHTML = data;
		        }
		    }
		    function BacktoDefault() {
		        location.href = "test_page_insta.asp";
            }
            function geoCode() {
                var latitude_x = document.getElementById("latitude");
                var longitude_y = document.getElementById("longitude");
                var faddr = document.getElementById("address").value;
                var geocoder;
           
                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ "address": faddr }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var faddr_lat = results[0].geometry.location.lat();
                        var faddr_lng = results[0].geometry.location.lng();
                    } else {
                        alert("here!!");
                        var faddr_lat = "";
                        var faddr_lng = "";
                    }

                    alert("주소 : " + faddr + "\n\n위도: " + faddr_lat + "\n\n경도: " + faddr_lng);

		            $('#latitude').html(faddr_lat);       // 위도
                    $('#longitude').html(faddr_lng);   // 경도
                    lat_r = faddr_lat;
                    log_r = faddr_lng;
                    return;
                });
                

            }
		</script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap"></script>
	</head>

	<body>
		<% top_menu = "HOME" %>
		
		<!-- #include virtual="/_include/top_menu.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
        <div id="under_the_nav">
            <div id="write_box">
                <div class="row" style="font-size:30pt; text-align:center;">
                    FOODTRUCK WRITE UPLOAD
                </div>
                <hr />
                <div class="title_box row">
                    <div class="title_zone col-sm-2 col-lg-2">
                        TITLE
                    </div>
                    <div class="title_input col-sm-10 col-lg-10">
                        <input type="text" style="width:100%;" id="input_title" />
                    </div>
                </div>
                <hr />
                <div class="content_box row">
                    <div class="content_zone col-sm-2 col-lg-2">
                        CONTENT
                    </div>
                    <div class="content_input col-sm-10 col-lg-10">
                        <textarea id="content_input_area"></textarea>
                    </div>
                </div>
                <hr />
                <div class="file_upload_box row">
                    <div class="file_zone col-sm-2 col-lg-2">
                        FILE UPLOAD
                    </div>
                    <div class="file_upload col-sm-10 col-lg-10">
                        <input type="file" id="file_upload_area"/>
                    </div>
                </div>
                <hr />
                <div class="location_box row">
                    <div class="change_address_box row">
                        <div class="location_zone col-sm-2 col-lg-2">
                            LOCATION
                        </div>
                        <div class="address_input_box col-sm-8 col-lg-8">
                            <input id="address" style="width:98%;" type="text" value="본인이 원하는 위치를 작성해주세요." />
                        </div>
                        <div class="address_change_button1 col-sm-1 col-lg-1">
                            <button type="button" onclick="geoCode();" style="width:100%;">주소 변환</button>
                        </div>
                        <div class="address_change_button2 col-sm-1 col-lg-1">
                            <button type="button" onclick="geoFind();" style="width:100%;">위치 찾기</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="lat_input col-sm-5 col-lg-5">
                            <ul>
                                <li>사용자 위도 : <span id="latitude"></span></li>
                            </ul>
                        </div>
                        <div class="log_input col-sm-5 col-lg-5">
                            <ul>
                                <li>사용자 경도 :<span id="longitude"></span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="button_box row">
                    <input type="submit" value="확인" onclick="write_upload()"/>
                    <input type="button" value="취소" onclick="BacktoDefault()" />
                </div>
            </div>
        </div>
        <div id="result_msg">

        </div>
	</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->