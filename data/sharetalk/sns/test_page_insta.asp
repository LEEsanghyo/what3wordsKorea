<!-- #include virtual="/_include/words.asp" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
	    '================== [  카테고리 리스트 불러오기  ] ===================
	'카테고리 리스트 불러오기
    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbConn, 1, 1

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if
    
    '================== [  sns 정보 불러오기  ] ===================

    strSQL = "p_sns_contents_read"

    Set rsSns = Server.CreateObject("ADODB.RecordSet")
    rsSns.Open strSQL, DbConn, 1, 1

    if rsSns.EOF or rsSns.BOF then
        NoDataSns = True
    Else
        NoDataSns = False
    end if

    '================== [  Busking 정보 불러오기  ] ===================

    strSQL = "p_sns_busking_contents_read"

    Set rsSns_busking = Server.CreateObject("ADODB.RecordSet")
    rsSns_busking.Open strSQL, DbConn, 1, 1

    if rsSns_busking.EOF or rsSns_busking.BOF then
        NoDataBusking = True
    Else
        NoDataBusking = False
    end if

    '================== [  FoodTruck 정보 불러오기  ] ===================

    strSQL = "p_sns_foodtruck_contents_read"

    Set rsSns_foodtruck = Server.CreateObject("ADODB.RecordSet")
    rsSns_foodtruck.Open strSQL, DbConn, 1, 1

    if rsSns_foodtruck.EOF or rsSns_foodtruck.BOF then
        NoDataFoodtruck = True
    Else
        NoDataFoodtruck = False
    end if

    '================== [  Volunteer 정보 불러오기  ] ===================

    strSQL = "p_sns_volunteer_contents_read"

    Set rsSns_volunteer = Server.CreateObject("ADODB.RecordSet")
    rsSns_volunteer.Open strSQL, DbConn, 1, 1

    if rsSns_volunteer.EOF or rsSns_volunteer.BOF then
        NoDataVolunteer = True
    Else
        NoDataVolunteer = False
    end if

    Dim num, num2, num3, num4
    num =0
    num2 = 0
    num3 = 0
    num4 = 0
%>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>What3Words Home</title>
		<link rel="stylesheet" href="/_include/style.css" type="text/css">		
        <style>
            #buttons_box{
                margin-top:70px;
            }
            #under_the_nav{
                display:flex;
                flex-flow: row nowrap;
                justify-content: space-between;
                margin-top:10px;
                padding:5%;
            }
            #map_box{
                font-size:20px;
                text-align:center;
                float:left;
                width:68%;
                height:90%;
                display:inline-block;
            }
            #insta_box{
                border-left:5px solid #648250;
                float:right;
                width:32%;
                height:100%;
                overflow-x:hidden;
                overflow-y:scroll;
            }
            #board_box{
                margin-right:20px;
                padding:5px;
            }
            #personal_box{
                margin-top:5px;
                padding:5px;
                background:#648250;
            }
            #from_box1{
                margin:5px;
                background:#ffffff;
                height:3%;
                margin-right:10px;
                text-align:left;
            }
           #from_box2{
                margin:5px;
                background:#ffffff;
                height:3%;
                margin-right:10px;
                text-align:left;
            }
            #tag_box{
                margin:5px;
                padding:5px;
                background:#ffffff;
                height:3%;
                margin-right:10px;
            }
            #content_box{
                margin:5px;
                height:10%;
                padding:5px;
                background:#ffffff;
                margin-right:10px;
            }
            #image_box{
                margin:5px;
                padding:5px;
                height:30%;
                background:#ffffff;
                margin-right:10px;
            }
            #go_to_box{
                background:#ffffff;
                text-align:center;
                margin:5px;
                height:3%;
                margin-right:10px;
                cursor:pointer;
            }
            #user_img{
                width:100%;
                height:100%;   
                object-fit:contain;
            }
            #from_img1 {
                width: 100%;
                height: 100%;
                object-fit: contain;
                cursor:pointer;
            }
            #from_img2{
                width:100%;
                height:100%;
                object-fit:contain;
                cursor:pointer;
            }
            #from_img3{
                width:100%;
                height:100%;
                object-fit:contain;
                cursor:pointer;
            }
            #map{
                height:100%;
                width:100%;
            }
            #popupAlertPosition{
			    
		    }
            .popup_content_viewer{
                font-size:20px;
                text-align:center;
                color:#00ff00;
            }
        </style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="http://localhost:1337/socket.io/socket.io.js"></script>
		<script src="/_script/chat.js"></script>
		<script type="text/javascript" src="/_script/map.js"></script>
		<script>
			var map;
			var bounds = {
				north: <%= lon2 %>,
				south: <%= lon1 %>,
				east: <%= lat2 %>,
				west: <%= lat1 %>
			};
			var uluru = {lat: <%= lat_value %>, lng: <%= lon_value %> };
			var zoom_level = <%= zoom_level %>;
		</script>		
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap"></script>
        
        <script type="text/javascript">

            var latitude_array = [];
            var longitude_array = [];
            var icon_image_array = [];
            var content_array = [];
            var like_array = [];
            var heart_amount_array = [];

            var d_user_id_busking = [];
            var d_user_profile_busking = [];
            var d_title_busking = [];
            var d_content_busking = [];
            var d_image_location_busking = [];
            var d_write_date_busking = [];
            var d_lat_busking = [];
            var d_long_busking = [];

            var d_user_id_foodtruck = [];
            var d_user_profile_foodtruck = [];
            var d_title_foodtruck = [];
            var d_content_foodtruck = [];
            var d_image_location_foodtruck = [];
            var d_write_date_foodtruck = [];
            var d_lat_foodtruck = [];
            var d_long_foodtruck = [];

            var d_user_id_volunteer = [];
            var d_user_profile_volunteer = [];
            var d_title_volunteer = [];
            var d_content_volunteer = [];
            var d_image_location_volunteer = [];
            var d_write_date_volunteer = [];
            var d_lat_volunteer = [];
            var d_long_volunteer = [];

            var image_number = 0;
            var last_number = 0;
            var markers = [];
            var b_markers = [];
            var f_markers = [];
            var v_markers = [];
            var define_done = 0;
            var define_done_daily = 0;
            var open_window; //어차피 팝업 윈도우는 하나뿐이 뜰 수밖에 없습니다.
            var open_window_busking;
            var open_window_foodtruck;
            var open_window_volunteer;

            var busking_image = "images/busking.jpg";
            var foodtruck_image = "images/foodtruck.jpg";
            var volunteer_image = "images/volunteer.jpg";

            function img_click1(elem) {
                image_number = 1;
                img_change(elem);
            }

            function img_click2(elem) {
                image_number = 2;
                img_change(elem);
            }

            function img_click3(elem) {
                image_number = 3;
                img_change(elem);
            }

            function img_click4(elem) {
                image_number = 4;
                img_change(elem);
            }

            function img_click5(elem) {
                image_number = 5;
                img_change(elem);
            }

            function img_change(elem) {

                var strurl = "";
                var sno = elem.getAttribute("sno");
                var image1 = document.getElementById('heart_img1_' + sno);
                var image2 = document.getElementById('heart_img2_' + sno);
                var image3 = document.getElementById('heart_img3_' + sno);
                var image4 = document.getElementById('heart_img4_' + sno);
                var image5 = document.getElementById('heart_img5_' + sno);
                var sno_new = parseInt(sno) + 1;
                if (image_number == 1) {
                    image1.src = "images/heart_full.png";
                    image2.src = "images/heart_empty.png";
                    image3.src = "images/heart_empty.png";
                    image4.src = "images/heart_empty.png";
                    image5.src = "images/heart_empty.png";
                    strurl = "test_send_like.asp?box_number=" + sno_new + "&like_number=" + 1;
                    send_like(strurl);
                }
                else if (image_number == 2) {
                    image1.src = "images/heart_full.png";
                    image2.src = "images/heart_full.png";
                    image3.src = "images/heart_empty.png";
                    image4.src = "images/heart_empty.png";
                    image5.src = "images/heart_empty.png";
                    strurl = "test_send_like.asp?box_number=" + sno_new + "&like_number=" + 2;
                    send_like(strurl);
                }
                else if (image_number == 3) {
                    image1.src = "images/heart_full.png";
                    image2.src = "images/heart_full.png";
                    image3.src = "images/heart_full.png";
                    image4.src = "images/heart_empty.png";
                    image5.src = "images/heart_empty.png";
                    strurl = "test_send_like.asp?box_number=" + sno_new + "&like_number=" + 3;
                    send_like(strurl);
                }
                else if (image_number == 4) {
                    image1.src = "images/heart_full.png";
                    image2.src = "images/heart_full.png";
                    image3.src = "images/heart_full.png";
                    image4.src = "images/heart_full.png";
                    image5.src = "images/heart_empty.png";        
                    strurl = "test_send_like.asp?box_number=" + sno_new + "&like_number=" + 4;
                    send_like(strurl);
                }
                else {
                    image1.src = "images/heart_full.png";
                    image2.src = "images/heart_full.png";
                    image3.src = "images/heart_full.png";
                    image4.src = "images/heart_full.png";
                    image5.src = "images/heart_full.png";
                    strurl = "test_send_like.asp?box_number=" + sno_new + "&like_number=" + 5;
                    send_like(strurl);
                }
            }

            function send_like(strurl) {

                xhr = new XMLHttpRequest();
                xhr.onreadystatechange = SendContent;
                xhr.open("Get", strurl);
                xhr.send(null);
                window.location.reload();
                return true;
            }

            function SendContent() {
                if (xhr.readyState == 4) {
                    var data = xhr.responseText;
                    //document.getElementById("result_msg").innerHTML = data;
                }
            }

            function get_all_data() {
                var num2 = 0;
                var long1;
                var long2;
                var long3;
                var long4;
                var image_link;
                
                if (define_done == 0) {
                        <%
                        Do While NOT rsSns.EOF
                        %>
                        latitude_array[num2] = <%=rsSns("sns_latitude") %>;
                        long1 =  <%=rsSns("sns_longitude") %>;
                        long1 = long1.toString();
                        long2 = long1.split(".");
                        long3 = long2[1].substring(0, 6);

                        longitude_array[num2] = long2[0] + "." + long3;
                        image_link = "<%=rsSns("sns_file_upload_area_real") %>";
                        icon_image_array[num2] = image_link;
                        like_array[num2] = <%=rsSns("sns_like_number") %>;
                        heart_amount_array[num2] = <%=rsSns("sns_like_average") %>;
                        content_array[num2] = "<%=rsSns("sns_content_input_area") %>";
                        num2 = num2 + 1;
                        <%
                        rsSns.MoveNext
                        Loop
                        rsSns.MoveFirst
                        %>

                        define_done = 1;
                }
                start_place_all();
            }

            function get_all_data_sub() {
                var num2 = 0;
                var long1;
                var long2;
                var long3;
                var long4;
                var image_link;
                
                if (define_done == 0) {
                    <%
                    Do While NOT rsSns.EOF
                    %>
                    latitude_array[num2] = <%=rsSns("sns_latitude") %>;
                    long1 =  <%=rsSns("sns_longitude") %>;
                    long1 = long1.toString();
                    long2 = long1.split(".");
                    long3 = long2[1].substring(0, 6);

                    longitude_array[num2] = long2[0] + "." + long3;
                    image_link = "<%=rsSns("sns_file_upload_area_real") %>";
                    icon_image_array[num2] = image_link;
                    like_array[num2] = <%=rsSns("sns_like_number") %>;
                    heart_amount_array[num2] = <%=rsSns("sns_like_average") %>;
                    content_array[num2] = "<%=rsSns("sns_content_input_area") %>";
                    num2 = num2 + 1;
                    <%
                    rsSns.MoveNext
                    Loop
                    rsSns.MoveFirst
                    %>

                    define_done = 1;
                }
            }

            function get_all_busking_data() {
                var num3 = 0;

                <%
                Do While NOT rsSns_busking.EOF
                %>
                    d_user_profile_busking[num3] = "<%=rsSns_busking("input_user") %>";
                    d_title_busking[num3] = "<%=rsSns_busking("title_input") %>";
                    d_content_busking[num3] = "<%=rsSns_busking("content_input") %>";
                    d_lat_busking[num3] = <%=rsSns_busking("latitude") %>;
                    d_long_busking[num3] = <%=rsSns_busking("longitude") %>;
                    d_image_location_busking[num3] = "<%=rsSns_busking("image_place") %>";
                    d_write_date_busking[num3] = "<%=rsSns_busking("write_date") %>";
                    num3 = num3 + 1;
                <%
                rsSns_busking.MoveNext
                Loop
                rsSns_busking.MoveFirst
                %>
                   start_place_all_daily(1);
            }

            function get_all_foodtruck_data() {
                var num3 = 0;

                <%
                Do While NOT rsSns_foodtruck.EOF
                %>
                    d_user_profile_foodtruck[num3] = "<%=rsSns_foodtruck("input_user") %>";
                    d_title_foodtruck[num3] = "<%=rsSns_foodtruck("title_input") %>";
                    d_content_foodtruck[num3] = "<%=rsSns_foodtruck("content_input") %>";
                    d_lat_foodtruck[num3] = <%=rsSns_foodtruck("latitude") %>;
                    d_long_foodtruck[num3] = <%=rsSns_foodtruck("longitude") %>;
                    d_image_location_foodtruck[num3] = "<%=rsSns_foodtruck("image_place") %>";
                    d_write_date_foodtruck[num3] = "<%=rsSns_foodtruck("write_date") %>";
                    num3 = num3 + 1;
                <%
                rsSns_foodtruck.MoveNext
                Loop
                rsSns_foodtruck.MoveFirst
                %>
                    start_place_all_daily(2);
            }

            function get_all_volunteer_data() {
                var num3 = 0;

                <%
                Do While NOT rsSns_volunteer.EOF
                %>
                    d_user_profile_volunteer[num3] = "<%=rsSns_volunteer("input_user") %>";
                    d_title_volunteer[num3] = "<%=rsSns_volunteer("title_input") %>";
                    d_content_volunteer[num3] = "<%=rsSns_volunteer("content_input") %>";
                    d_lat_volunteer[num3] = <%=rsSns_volunteer("latitude") %>;
                    d_long_volunteer[num3] = <%=rsSns_volunteer("longitude") %>;
                    d_image_location_volunteer[num3] = "<%=rsSns_volunteer("image_place") %>";
                    d_write_date_volunteer[num3] = "<%=rsSns_volunteer("write_date") %>";
                    num3 = num3 + 1;
                <%
                rsSns_volunteer.MoveNext
                Loop
                rsSns_volunteer.MoveFirst
                %>
                    start_place_all_daily(3);
            }

            function start_place_all_daily(elem) {
                var marker_for_add;
                var myIcon;
                var mapOptions_place;

                if (elem == 1) {
                    mapOptions_place = {
                        zoom: 15,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                        center: new google.maps.LatLng(parseFloat(d_lat_busking[0]), parseFloat(d_long_busking[0]))
                    }
                    map = new google.maps.Map(document.getElementById('map'), mapOptions_place);

                    for (var i = 0; i < return_number_of_busking(); i++) {
                        addMarker_daily(i, 1);
                    }
                }
                else if (elem == 2) {
                    mapOptions_place = {
                        zoom: 15,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                        center: new google.maps.LatLng(parseFloat(d_lat_foodtruck[0]), parseFloat(d_long_foodtruck[0]))
                    }
                    map = new google.maps.Map(document.getElementById('map'), mapOptions_place);

                    for (var i = 0; i < return_number_of_foodtruck(); i++) {
                        addMarker_daily(i, 2);
                    }
                }
                else {
                    mapOptions_place = {
                        zoom: 15,
                        mapTypeId: google.maps.MapTypeId.ROADMAP,
                        center: new google.maps.LatLng(parseFloat(d_lat_volunteer[0]), parseFloat(d_long_volunteer[0]))
                    }
                    map = new google.maps.Map(document.getElementById('map'), mapOptions_place);

                    for (var i = 0; i < return_number_of_volunteer(); i++) {
                        addMarker_daily(i, 3);
                    }
                }

                define_done_daily = 1;
            }

            function start_place_all(){
             
                var marker_for_add;
                var myIcon;
                var mapOptions_place = {
                    zoom: 15,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(parseFloat(latitude_array[0]), parseFloat(longitude_array[0]))
                }

                map = new google.maps.Map(document.getElementById('map'), mapOptions_place);
                
                for (var i = 0; i < return_number_of_write(); i++) {
                    addMarker(i);
                }
            }

            function addMarker(num_iter) {

                myIcon = new google.maps.MarkerImage(icon_image_array[num_iter], null, null, null, new google.maps.Size(45, 45));

                var marker_piece = new google.maps.Marker({
                    position: { lat: parseFloat(latitude_array[num_iter]), lng: parseFloat(longitude_array[num_iter]) },
                    map: map,
                    icon: myIcon,
                    animation: google.maps.Animation.BOUNCE,
                    title:"What3Words"
                });

                marker_piece.addListener('click', function () {
                    SetContent(num_iter+1);
                });

                markers.push(marker_piece);
            }

            function addMarker_daily(elem, code) {

                if (code == 1) {
                    myIcon = new google.maps.MarkerImage(busking_image, null, null, null, new google.maps.Size(45, 45));

                    var marker_piece1 = new google.maps.Marker({
                        position: { lat: parseFloat(d_lat_busking[elem]), lng: parseFloat(d_long_busking[elem]) },
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title:"busking_marker"
                    });
                    marker_piece1.addListener('click', function () {
                        SetContent_busking(elem + 1);
                    });
                    b_markers.push(marker_piece1);
                }
                else if (code == 2) {
                    myIcon = new google.maps.MarkerImage(foodtruck_image, null, null, null, new google.maps.Size(45, 45));

                    var marker_piece2 = new google.maps.Marker({
                        position: { lat: parseFloat(d_lat_foodtruck[elem]), lng: parseFloat(d_long_foodtruck[elem]) },
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title:"foodtruck_marker"
                    });
                    marker_piece2.addListener('click', function () {
                        SetContent_foodtruck(elem + 1);
                    });
                    f_markers.push(marker_piece2);
                }
                else {
                    myIcon = new google.maps.MarkerImage(volunteer_image, null, null, null, new google.maps.Size(45, 45));

                    var marker_piece3 = new google.maps.Marker({
                        position: { lat: parseFloat(d_lat_volunteer[elem]), lng: parseFloat(d_long_volunteer[elem]) },
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title:"volunteer_marker"
                    });
                    marker_piece3.addListener('click', function () {
                        SetContent_volunteer(elem + 1);
                    });
                    v_markers.push(marker_piece3);
                }
            }

            function place_all_write() {

                var number_of_write = return_number_of_write();

            }

            function go_to_write(lat, long) {

                location.href = "test_page_insta_write.asp";

            }

            function go_to_place(num) {

                if (define_done == 0) {
                    get_all_data_sub();
                }

                var lat_new = num.getAttribute("latno");
                var long_new = num.getAttribute("lonno");
                var upload_image_link = num.getAttribute("sno_image");
                var long_new_head = long_new.split(".");
                var long_new_tail = long_new_head[1].substring(0, 6);
                var long_new_real = long_new_head[0] + "." + long_new_tail;
                var sno_click_num = num.getAttribute("sno_click_num");


                var marker_selected = { lat: parseFloat(lat_new), lng: parseFloat(long_new_real) };
                map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 17,
                    center: marker_selected
                });

                var myIcon = new google.maps.MarkerImage(upload_image_link, null, null, null, new google.maps.Size(45, 45));

                var marker_set = new google.maps.Marker({
                    position: marker_selected,
                    map: map,
                    icon: myIcon,
                    animation: google.maps.Animation.BOUNCE,
                    title: "test"
                });

                marker_set.addListener('click', function () {
                    SetContent(sno_click_num);
                });

            }

            function go_to_place_daily(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }

                var lat_new = num.getAttribute("lat_daily");
                var long_new = num.getAttribute("long_daily");
                var upload_image_link = num.getAttribute("image_place");
                var sno_daily = num.getAttribute("sno_daily");
                var sno_code = num.getAttribute("sno_code");
                var myIcon;
                var market_set;

                var long_new_head = long_new.split(".");
                var long_new_tail = long_new_head[1].substring(0, 6);
                var long_new_real = long_new_head[0] + "." + long_new_tail;

                var marker_selected = { lat: parseFloat(lat_new), lng: parseFloat(long_new) };

                map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 17,
                    center: marker_selected
                });

                if (sno_code == 1) {

                    myIcon = new google.maps.MarkerImage(busking_image, null, null, null, new google.maps.Size(45, 45));
                    marker_set = new google.maps.Marker({
                        position: marker_selected,
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title: "busking_info"
                    });
                    marker_set.addListener('click', function () {
                        SetContent_busking(sno_daily);
                    });
                }
                else if (sno_code == 2) {
                    myIcon = new google.maps.MarkerImage(foodtruck_image, null, null, null, new google.maps.Size(45, 45));
                    marker_set = new google.maps.Marker({
                        position: marker_selected,
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title: "foodtruck_info"
                    });
                    marker_set.addListener('click', function () {
                        SetContent_foodtruck(sno_daily);
                    });
                }
                else {
                    myIcon = new google.maps.MarkerImage(volunteer_image, null, null, null, new google.maps.Size(45, 45));
                    marker_set = new google.maps.Marker({
                        position: marker_selected,
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title: "volunteer_info"
                    });
                    marker_set.addListener('click', function () {
                        SetContent_volunteer(sno_daily);
                    });
                }
            }

            function exit_content(num) {

                open_window.style.display = 'none';

            }

            function exit_content_busking(num) {

                open_window_busking.style.display = 'none';

            }

            function exit_content_foodtruck(num) {

                open_window_foodtruck.style.display = 'none';

            }

            function exit_content_volunteer(num) {

                open_window_volunteer.style.display = 'none';

            }

            function exit_popup(num) {

                var content_number = num.getAttribute("sno_box_num");
                var e = document.getElementById("popupAlertPostion_" + content_number);
                e.style.display = 'none';

            }

            function SetContent(num) {

                open_window = document.getElementById("popupAlertPosition_" + num);
  
                document.getElementById("popup_image_box_" + num).src = icon_image_array[num-1];
                document.getElementById("popup_score_box_" + num).innerHTML = like_array[num-1];
                document.getElementById("popup_like_box_" + num).innerHTML = parseFloat(parseFloat(heart_amount_array[num-1]) / parseFloat(like_array[num-1]));
                document.getElementById("popup_content_box_" + num).innerHTML = content_array[num-1];

                //$('#popup_image_box_' + num).html(icon_image_array[num]);       // 위도
                //$('#popup_score_box_' + num).html(parseFloat(parseFloat(heart_amount_array[num]) / parseFloat(like_array[num])));   // 경도
                //$('#popup_like_box_' + num).html(like_array[num]);   // 경도
                //$('#popup_content_box_' + num).html(content_array[num]);   // 경도

                if (open_window.style.display == 'block')
                    open_window.style.display = 'none';
                else 
                    open_window.style.display = 'block';

            }

            function SetContent_busking(num) {
                open_window_busking = document.getElementById("popupAlertPosition_2_" + num);

                document.getElementById("popup_image_box_2_" + num).src = d_image_location_busking[num - 1];
                document.getElementById("popup_date_box_2_" + num).innerHTML = d_write_date_busking[num - 1].toString();
                document.getElementById("popup_title_box_2_" + num).innerHTML = d_title_busking[num - 1].toString();
                document.getElementById("popup_profile_box_2_" + num).innerHTML = d_user_profile_busking[num - 1];
                document.getElementById("popup_content_box_2_" + num).innerHTML = d_content_busking[num - 1];

                if (open_window_busking.style.display == 'block')
                    open_window_busking.style.display = 'none';
                else
                    open_window_busking.style.display = 'block';
            }

            function SetContent_foodtruck(num) {
                open_window_foodtruck = document.getElementById("popupAlertPosition_3_" + num);

                document.getElementById("popup_image_box_3_" + num).src = d_image_location_foodtruck[num - 1];
                document.getElementById("popup_date_box_3_" + num).innerHTML = d_write_date_foodtruck[num - 1];
                document.getElementById("popup_title_box_3_" + num).innerHTML = d_title_foodtruck[num - 1];
                document.getElementById("popup_profile_box_3_" + num).innerHTML = d_user_profile_foodtruck[num - 1];
                document.getElementById("popup_content_box_3_" + num).innerHTML = d_content_foodtruck[num - 1];

                if (open_window_foodtruck.style.display == 'block')
                    open_window_foodtruck.style.display = 'none';
                else
                    open_window_foodtruck.style.display = 'block';
            }

            function SetContent_volunteer(num) {
                open_window_volunteer = document.getElementById("popupAlertPosition_4_" + num);

                document.getElementById("popup_image_box_4_" + num).src = d_image_location_volunteer[num - 1];
                document.getElementById("popup_date_box_4_" + num).innerHTML = d_write_date_volunteer[num - 1];
                document.getElementById("popup_title_box_4_" + num).innerHTML = d_title_volunteer[num - 1];
                document.getElementById("popup_profile_box_4_" + num).innerHTML = d_user_profile_volunteer[num - 1];
                document.getElementById("popup_content_box_4_" + num).innerHTML = d_content_volunteer[num - 1];

                if (open_window_volunteer.style.display == 'block')
                    open_window_volunteer.style.display = 'none';
                else
                    open_window_volunteer.style.display = 'block';
            }

            function go_to_busking_write() {

                location.href = "test_busking_write.asp";

            }
            function go_to_foodtruck_write() {

                location.href = "test_foodtruck_write.asp";

            }
            function go_to_volunteer_write(){

                location.href = "test_volunteer_write()";

            }
        </script>
	</head>

	<body>
		<% top_menu = "HOME" %>
		
		<!-- #include virtual="/_include/top_menu.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
        <div id="buttons_box">
            <button type="button" onclick="go_to_write()">글 쓰기</button>
            <button type="button" onclick="get_all_data()">모든 내용 지도에 표시하기</button>
        </div>
        <div id="under_the_nav">
            <div id="map">
                map_box
            </div>
            <div id="insta_box">
                insta_box
                <%
                Do While Not rsSns.EOF
                %>
                <div id="board_box">
                    <div id="personal_box">
                        <div id="from_box1">
                            <%
                                from_sns = rsSns("sns_from_place")
                                if StrComp(from_sns, "instagram")=0 then
                            %>
                          <img id="from_img1" src="images/instagram.png" alt="" />
                            <%
                                elseif StrComp(from_sns, "facebook")=0 then
                            %>
                          <img id="from_img2" src="images/facebook.jpg" alt="" />
                            <%
                                else
                            %>
                          <img id="from_img3" src="images/what3words.png" alt="" />
                            <%
                                end if
                            %>
                        </div>
                        <div id="image_box">
                           <img id="user_img" src="<%=rsSns("sns_file_upload_area_real") %>" alt="" style="cursor:pointer" />
                        </div>
                        <div id="tag_box">
                            <table>
                                <tr style="margin-bottom:3%;">
                                    <td style="width:50%; display:inline-flex; text-align:center;">
                                        <img id="heart_img1_<%=num %>" style="max-width:30px; max-height:30px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click1(this)"/>
                                        <img id="heart_img2_<%=num %>" style="max-width:30px; max-height:30px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click2(this)"/>
                                        <img id="heart_img3_<%=num %>" style="max-width:30px; max-height:30px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click3(this)"/>
                                        <img id="heart_img4_<%=num %>" style="max-width:30px; max-height:30px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click4(this)"/>
                                        <img id="heart_img5_<%=num %>" style="max-width:30px; max-height:30px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click5(this)"/>
                                    </td>
                                    <td style="border:2px blue solid; font-size:8pt; width:25%; text-align:center;">
                                        AVG score - <%= rsSns("sns_like_average") / rsSns("sns_like_number")%>
                                    </td>
                                    <td style="border:2px green solid; width:25%; font-size:8pt; text-align:center">
                                        <%=rsSns("sns_like_number") %> People Like It!
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="content_box">
                            <table>
                                <tr>
                                    <td>
                                        <%=rsSns("sns_content_input_area") %>
                                    </td>
                                </tr>
								<!--
                                <tr style="border:1px solid red">
                                    <td id="latitude_a">
                                        <%=rsSns("sns_latitude")%>
                                    </td>
                                </tr>
                                <tr style="border:1px solid red">
                                    <td id="longitude_a">
                                        <%=rsSns("sns_longitude")%>
                                    </td>
                                </tr>
								-->
                            </table>
                        </div>
                        <div id="go_to_box">
                            <span onclick="go_to_place(this);" sno ="<%=num %>" id="snsbox_<%=num %>" sno_click_num ="<%=rsSns("sns_box_number") %>" latno="<%=rsSns("sns_latitude")%>" lonno="<%=rsSns("sns_longitude")%>" sno_image ="<%=rsSns("sns_file_upload_area_real") %>" >위치로 가기</span>
                        </div>
                    </div>
                </div>
                <hr />
                <%
                    num = num  + 1
                    rsSns.MoveNext
                    Loop

                    rsSns.MoveFirst
                %>
            </div>
        </div>
        <%
            num = 0
            Do While NOT rsSns.EOF
        %>
        <!-- 팝업 창 -->
        <div id="popupAlertPosition_<%=rsSns("sns_box_number") %>" style="position:absolute; top: 10%; left: 30%;position: fixed;width: 20%;height: 60%; text-align:center; border-radius: 10px; background-color: rgba(0,0,0,0.9); display: none; padding:2%; align-content:center;">
            <div id="popupImageBox" style="width:100%; height:50%; border:3px solid red; background:#ffffff;">
                <img id="popup_image_box_<%=rsSns("sns_box_number") %>" src="" alt="" style="width:100%; height:100%; object-fit:contain;" />
            </div>
            <div id="popupScoreBox" style="width:100%; height:5%;">
                <table style="width:100%; height:100%; color:white; font-size:15pt;">
                  <tr style="width:100%; height:100%; color:white; font-size:15pt;">
                    <td id="popup_score_box_<%=rsSns("sns_box_number") %>" style="color: #000000; border:3px red solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                    <td id="popup_like_box_<%=rsSns("sns_box_number") %>" style=" color: #000000; border:3px blue solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                  </tr>
                </table>
            </div>
            <div id="popupContentBox" style="width:100%; height:35%; border:3px red solid; background:#ffffff">
                <span id="popup_content_box_<%=rsSns("sns_box_number") %>" style="color:blue; font-size:20pt; width:100%; height:100%;"></span>
            </div>
            <div id="popupButtonBox" style="width:100%; height:10%; margin-top:1%;">
                    <button type="button" id="send_message" onclick="reqChat(<%=rsSns("sns_box_number") %>, 1)" style="width:30%; height:50%;">채팅 신청</button>
                    <button type="button" id="user_profile" onclick="discover_user();" style="width:30%; height:50%;">이 회원 살펴보기</button>
                    <button type="button" id="exit_content" onclick="exit_content(this);" sno_exit_num="<%=rsSns("sns_box_number") %>" style="width:30%; height:50%;">창 닫기</button>
            </div>
        </div>
        <!-- 팝업 창 -->
        <%
            num = num + 1
            rsSns.MoveNext
            Loop
            rsSns.MoveFirst
        %>
        <div style="font-size:30pt; text-align:center; color:blue; padding:3%;">
            게시판
            <hr />
            <hr />

        </div>
        <div id="extra_content_box" style="width:100%; height:100%; padding:2%;">
            <div style="float:left; width:33%; text-align:center;">
                <button id="busking_info_write" onclick="go_to_busking_write();">버스킹 정보 올리기</button>
                <button id="express_all_busking" onclick="get_all_busking_data();">버스킹 정보 지도에 표출</button>
                <table style="border:1px solid red; width:90%; overflow-x:hidden; overflow-y:scroll; text-align:center;">
                    <% Do While NOT rsSns_busking.EOF%>
                    <tr style="border:1px solid blue">
                        <td style="border:1px solid green; max-height:60px; max-width:60px;">
                            <img src="<%=rsSns_busking("image_place") %>" alt="" style="width:100%;object-fit:contain;"/>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_busking("input_user") %>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_busking("title_input") %>
                        </td>
                        <td style="border:1px solid green">
                            <button type="button" onclick="go_to_place_daily(this);" sno_code ="1" sno_daily="<%=rsSns_busking("article_number") %>" lat_daily="<%=rsSns_busking("latitude") %>" long_daily="<%=rsSns_busking("longitude") %>" image_place="<%=rsSns_busking("image_place") %>">찾아가기</button>
                        </td>
                    </tr>
                    <%
                        num2 = num2 + 1
                        rsSns_busking.MoveNext
                        Loop
                        rsSns_busking.MoveFirst
                    %>
                </table>
            </div>
            <div style="float:left; width:33%; text-align:center;">
                <button id="foodtruck_info_write" onclick="go_to_foodtruck_write();">푸드트럭 정보 올리기</button>
                <button id="express_all_foodtruck" onclick="get_all_foodtruck_data();">푸드트럭 정보 지도에 표출</button>
                <table style="border:1px solid red; width:90%; overflow-x:hidden; overflow-y:scroll; text-align:center;">
                    <% Do While NOT rsSns_foodtruck.EOF%>
                    <tr style="border:1px solid blue">
                        <td style="border:1px solid green; max-height:60px; max-width:60px;">
                            <img src="<%=rsSns_foodtruck("image_place") %>" alt="" style="width:100%; object-fit:contain;"/>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_foodtruck("input_user") %>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_foodtruck("title_input") %>
                        </td>
                        <td style="border:1px solid green">
                            <button type="button" onclick="go_to_place_daily(this);" sno_code ="2" sno_daily="<%=rsSns_foodtruck("article_number") %>" lat_daily="<%=rsSns_foodtruck("latitude") %>" long_daily="<%=rsSns_foodtruck("longitude") %>" image_place="<%=rsSns_foodtruck("image_place") %>">찾아가기</button>
                        </td>
                    </tr>
                    <%
                        num3 = num3 + 1
                        rsSns_foodtruck.MoveNext
                        Loop
                        rsSns_foodtruck.MoveFirst
                    %>
                </table>
            </div>
            <div style="float:left; width:33%; text-align:center;">
                <button id="volunteer_info_write" onclick="go_to_volunteer_write();">봉사활동 정보 올리기</button>
                <button id="express_all_volunteer" onclick="get_all_volunteer_data();">봉사활동 정보 지도에 표출</button>
                <table style="border:1px solid red; width:90%; overflow-x:hidden; overflow-y:scroll; text-align:center;">
                    <% Do While NOT rsSns_volunteer.EOF%>
                    <tr style="border:1px solid blue">
                        <td style="border:1px solid green; max-height:60px; max-width:60px;">
                            <img src="<%=rsSns_volunteer("image_place") %>" alt="" style="width:100%; object-fit:contain;"/>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_volunteer("input_user") %>
                        </td>
                        <td style="border:1px solid green">
                            <%=rsSns_volunteer("title_input") %>
                        </td>
                        <td style="border:1px solid green">
                            <button type="button" onclick="go_to_place_daily(this);" sno_code ="3" sno_daily="<%=rsSns_volunteer("article_number") %>" lat_daily="<%=rsSns_volunteer("latitude") %>" long_daily="<%=rsSns_volunteer("longitude") %>" image_place="<%=rsSns_volunteer("image_place") %>">찾아가기</button>
                        </td>
                    </tr>
                    <%
                        num4 = num4 + 1
                        rsSns_volunteer.MoveNext
                        Loop
                        rsSns_volunteer.MoveFirst
                    %>
                </table>
            </div>
        </div>		
        <!-- 팝업창 Busking -->
        <%
            Do While NOT rsSns_busking.EOF
        %>
        <div id="popupAlertPosition_2_<%=rsSns_busking("article_number") %>" style="position:absolute; display:inline; top: 12%; left: 22%;position: fixed;width: 55%;height: 50%; border-radius: 10px; background-color: rgba(0,0,0,0.9); display: none; padding:2%; align-content:center;">
            <div id="popupInfoBox2" style="display:block; font-size:25pt; width:90%;margin-left:4.5%; color:black; border:white 3px solid; text-align:center; background:#ffffff;">
                BUSKING INFORMATION
            </div>
            <div id="underInfoBox2">
                <div id="popupImageBox2" style="display:inline; float:left; width:45%; margin-left:4.5%; height:90%; border:3px solid red; background:#ffffff;">
                    <img id="popup_image_box_2_<%=rsSns_busking("article_number") %>" src="" alt="" style="width:100%; height:100%; object-fit:contain;" />
                </div>
                <div id="popupTextBox2" style="display:inline; float:left; width:45%; height:90%; border:3px solid red; background:#ffffff">
                    <div id="popupScoreBox2" style="width:100%; height:10%;">
                        <table style="width:100%; height:100%; color:white; font-size:15pt;">
                          <tr style="width:100%; height:100%; color:white; font-size:15pt;">
                            <td id="popup_date_box_2_<%=rsSns_busking("article_number") %>" style="color: #000000; border:3px red solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                            <td id="popup_profile_box_2_<%=rsSns_busking("article_number") %>" style=" color: #000000; border:3px blue solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                          </tr>
                        </table>
                    </div>
                    <div id="popupTitleBox2" style="width:100%; height:10%; border:2px green solid; background:#ffffff;">
                        <span id="popup_title_box_2_<%=rsSns_busking("article_number") %>" style="color:black; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupContentBox2" style="width:100%; height:70%; border:3px red solid; background:#ffffff">
                        <span id="popup_content_box_2_<%=rsSns_busking("article_number") %>" style="color:blue; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupButtonBox2" style="width:100%; height:5%; margin-top:1%; text-align:center;">
                            <button type="button" id="send_message2" onclick="reqChat(<%=rsSns_busking("article_number") %>, 2)" style="width:45%; height:100%; object-fit:contain;">채팅 신청</button>
                            <button type="button" id="exit_content2" onclick="exit_content_busking(this);" sno_exit_num_2="<%=rsSns_busking("article_number") %>" style="width:45%; height:100%; object-fit:contain;">창 닫기</button>
                    </div>
                 </div>
             </div>
        </div>
        <%
            rsSns_busking.MoveNext
            Loop
            rsSns_busking.MoveFirst
        %>
        <!-- 팝업창 Busking -->
        <!-- 팝업창 Foodtruck -->
        <%
            Do While NOT rsSns_foodtruck.EOF
        %>
        <div id="popupAlertPosition_3_<%=rsSns_foodtruck("article_number") %>" style="position:absolute; display:inline; top: 12%; left: 22%;position: fixed;width: 55%;height: 50%; border-radius: 10px; background-color: rgba(0,0,0,0.9); display: none; padding:2%; align-content:center;">
            <div id="popupInfoBox3" style="display:block; font-size:25pt; width:90%;margin-left:4.5%; color:black; border:white 3px solid; text-align:center; background:#ffffff;">
                FOODTRUCK INFORMATION
            </div>
            <div id="underInfoBox3">
                <div id="popupImageBox3" style="display:inline; float:left; width:45%; margin-left:4.5%; height:90%; border:3px solid red; background:#ffffff;">
                    <img id="popup_image_box_3_<%=rsSns_foodtruck("article_number") %>" src="" alt="" style="width:100%; height:100%; object-fit:contain;" />
                </div>
                <div id="popupTextBox3" style="display:inline; float:left; width:45%; height:90%; border:3px solid red; background:#ffffff">
                    <div id="popupScoreBox3" style="width:100%; height:10%;">
                        <table style="width:100%; height:100%; color:white; font-size:15pt;">
                          <tr style="width:100%; height:100%; color:white; font-size:15pt;">
                            <td id="popup_date_box_3_<%=rsSns_foodtruck("article_number") %>" style="color: #000000; border:3px red solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                            <td id="popup_profile_box_3_<%=rsSns_foodtruck("article_number") %>" style=" color: #000000; border:3px blue solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                          </tr>
                        </table>
                    </div>
                    <div id="popupTitleBox3" style="width:100%; height:10%; border:2px green solid; background:#ffffff;">
                        <span id="popup_title_box_3_<%=rsSns_foodtruck("article_number") %>" style="color:black; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupContentBox3" style="width:100%; height:70%; border:3px red solid; background:#ffffff">
                        <span id="popup_content_box_3_<%=rsSns_foodtruck("article_number") %>" style="color:blue; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupButtonBox3" style="width:100%; height:5%; margin-top:1%; text-align:center;">
                            <button type="button" id="send_message3" onclick="reqChat(<%=rsSns_foodtruck("article_number") %>, 3);" style="width:45%; height:100%;">채팅 신청</button>
                            <button type="button" id="exit_content3" onclick="exit_content_foodtruck(this);" sno_exit_num_3="<%=rsSns_foodtruck("article_number") %>" style="width:45%; height:100%; object-fit:contain;">창 닫기</button>
                    </div>
                 </div>
             </div>
        </div>
        <%
            rsSns_foodtruck.MoveNext
            Loop
            rsSns_foodtruck.MoveFirst
        %>
        <!-- 팝업창 Foodtruck -->
        <!-- 팝업창 Volunteer -->
        <%
            Do While NOT rsSns_volunteer.EOF
        %>
        <div id="popupAlertPosition_4_<%=rsSns_volunteer("article_number") %>" style="position:absolute; display:inline; top: 12%; left: 22%;position: fixed;width: 55%;height: 50%; border-radius: 10px; background-color: rgba(0,0,0,0.9); display: none; padding:2%; align-content:center;">
            <div id="popupInfoBox4" style="display:block; font-size:25pt; width:90%;margin-left:4.5%; color:black; border:white 3px solid; text-align:center; background:#ffffff;">
                VOLUNTEERING INFORMATION
            </div>
            <div id="underInfoBox4">
                <div id="popupImageBox4" style="display:inline; float:left; width:45%; margin-left:4.5%; height:90%; border:3px solid red; background:#ffffff;">
                    <img id="popup_image_box_4_<%=rsSns_volunteer("article_number") %>" src="" alt="" style="width:100%; height:100%; object-fit:contain;" />
                </div>
                <div id="popupTextBox4" style="display:inline; float:left; width:45%; height:90%; border:3px solid red; background:#ffffff">
                    <div id="popupScoreBox4" style="width:100%; height:10%;">
                        <table style="width:100%; height:100%; color:white; font-size:15pt;">
                          <tr style="width:100%; height:100%; color:white; font-size:15pt;">
                            <td id="popup_date_box_4_<%=rsSns_volunteer("article_number") %>" style="color: #000000; border:3px red solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                            <td id="popup_profile_box_4_<%=rsSns_volunteer("article_number") %>" style=" color: #000000; border:3px blue solid; width:50%; height:100%; font-size:15pt; text-align:center;background:#ffffff;"></td>
                          </tr>
                        </table>
                    </div>
                    <div id="popupTitleBox4" style="width:100%; height:10%; border:2px green solid; background:#ffffff;">
                        <span id="popup_title_box_4_<%=rsSns_volunteer("article_number") %>" style="color:black; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupContentBox4" style="width:100%; height:70%; border:3px red solid; background:#ffffff">
                        <span id="popup_content_box_4_<%=rsSns_volunteer("article_number") %>" style="color:blue; font-size:20pt; width:95%; height:100%;"></span>
                    </div>
                    <div id="popupButtonBox4" style="width:100%; height:5%; margin-top:1%; text-align:center">
                            <button type="button" id="send_message4" onclick="reqChat(<%=rsSns_volunteer("article_number") %>, 4);" style="width:45%; height:100%;">채팅 신청</button>
                            <button type="button" id="exit_content4" onclick="exit_content_volunteer(this);" sno_exit_num_4="<%=rsSns_volunteer("article_number") %>" style="width:45%; height:100%; object-fit:contain;">창 닫기</button>
                    </div>
                 </div>
             </div>
        </div>
        <%
            rsSns_volunteer.MoveNext
            Loop
            rsSns_volunteer.MoveFirst
        %>
        <input type="hidden" id="test" value="ee">
        <!-- 팝업창 Volunteer -->
		<script type="text/javascript">
            function return_number_of_write() {
                return <%=num %>;
            }

            function return_number_of_busking() {
                return <%=num2 %>;
            }

            function return_number_of_foodtruck() {
                return <%=num3 %>;
            }

            function return_number_of_volunteer() {
                return <%=num4 %>;
            }

		</script>
        <script type="text/javascript" src="/_script/community.js"></script>
	</body>
</html>