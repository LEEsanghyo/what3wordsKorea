<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/words.asp" -->
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
        <link rel="stylesheet" href="/_css/style.css" type="text/css">      
        <style>
            #buttons_box{
                margin-top:70px;
                padding:1%;
                height:10px;
                text-align:center;
            }
            #under_the_nav{
                margin-top:1%;
                padding-left:5%;
                padding-right:5%;
                padding-top:1%;
            }
            #map_box{
                font-size:20px;
                text-align:center;
                height:90%;
                display:inline-block;
            }
            #map{
              height:100%;
            }
            #insta_box{
                height:100%;
                overflow-x:hidden;
                overflow-y:scroll;
            }
            #board_box{
                height:100%;
                border-top:5px solid rgba(128,128,128,0.7);
                border-bottom:5px solid rgba(128,128,128,0.7);
                margin-bottom:30px;
            }
            #date_box{
                margin:5px;
                height:5%;
                text-align:left;
                font-size:20pt;
                font-style:italic;
            }
            #personal_box{
                margin-top:5px;
                padding:5px;
                height:100%;
            }
            #from_box1{
                margin:5px;
                height:5%;
                text-align:left;
            }
           #from_box2{
                margin:5px;
                height:5%;
                text-align:left;
            }
            #tag_box{
                margin:5px;
                padding:5px;
                height:5%;
                font-style:italic;
                color:#25529c;
            }
            #image_box{
                margin:5px;
                padding:5px;
                height:50%;
            }
            #content_box{
                margin:5px;
                height:25%;
                padding:5px;
                border:5px solid rgba(128,128,128,0.5); 
            }
            #link_box{
                text-align:center;
                margin:5px;
                height:3%;
                cursor:pointer;
            }
            #go_to_box{
                text-align:center;
                margin:5px;
                height:3%;
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
            .popup_content_viewer{
                font-size:20px;
                text-align:center;
                color:#00ff00;
            }
            @media screen and (min-width:200px){
                #map{
                    height:60%;
                    border:10px ridge #25529c;
                }
                body::-webkit-scrollbar{
                    display:none;
                }
                #insta_box {
                    height: 100%;
                    overflow-x: hidden;
                    overflow-y: scroll;
                    margin-top:20px;
                }
                #insta_box::-webkit-scrollbar{
                    display:none;
                }
                #board_box{
                    height:90%;
                    border-top:5px solid rgba(128,128,128,0.7);
                    border-bottom:5px solid rgba(128,128,128,0.7);
                }
                .modal::-webkit-scrollbar{
                    display:none;
                }
                .container{
                    width:100%;
                    max-width: none !important;
                }
            }
            .modal{
                background:rgb(0,0,0);
                background:rgba(0,0,0,0.4);
                z-index:1;
                margin-top:70px;
            }
            .modal-dialog{
                background:rgb(255,255,255);
            }
        </style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <script src="/_script/login.js"></script>
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
            var insta_profile_array = [];

            var d_user_profile_busking = [];
            var d_title_busking = [];
            var d_content_busking = [];
            var d_image_location_busking = [];
            var d_write_date_busking = [];
            var d_lat_busking = [];
            var d_long_busking = [];

            var d_user_profile_foodtruck = [];
            var d_title_foodtruck = [];
            var d_content_foodtruck = [];
            var d_image_location_foodtruck = [];
            var d_write_date_foodtruck = [];
            var d_lat_foodtruck = [];
            var d_long_foodtruck = [];

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
            var open_window_busking_content;
            var open_window_foodtruck_content;
            var open_window_volunteer_content;
            var modal_define = 0;
            var marker_define = 0;

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
                        insta_profile_array[num2] = "<%=rsSns("sns_profile")%>";
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
                    latitude_array[num2] = "<%=rsSns("sns_latitude") %>";
                    long1 = "<%=rsSns("sns_longitude") %>";
                    if (long1 != 'from_insta') { 
                        long1 = long1.toString();
                        long2 = long1.split(".");
                        long3 = long2[1].substring(0, 6);
                    }
                    longitude_array[num2] = long2[0] + "." + long3;
                    image_link = "<%=rsSns("sns_file_upload_area_real") %>";
                    icon_image_array[num2] = image_link;
                    like_array[num2] = <%=rsSns("sns_like_number") %>;
                    heart_amount_array[num2] = <%=rsSns("sns_like_average") %>;
                    content_array[num2] = "<%=rsSns("sns_content_input_area") %>";
                    insta_profile_array[num2] = "<%=rsSns("sns_profile")%>";
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
                    zoom: 10,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(parseFloat(latitude_array[0]), parseFloat(longitude_array[0]))
                }

                map = new google.maps.Map(document.getElementById('map'), mapOptions_place);
                
                for (var i = 0; i < return_number_of_write(); i++) {
                    addMarker(i);
                }
            }

            function addMarker(num_iter) {

                myIcon = new google.maps.MarkerImage(icon_image_array[num_iter], null, null, null, new google.maps.Size(25, 25));

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
                    myIcon = new google.maps.MarkerImage(busking_image, null, null, null, new google.maps.Size(35, 35));

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
                    myIcon = new google.maps.MarkerImage(foodtruck_image, null, null, null, new google.maps.Size(35, 35));

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
                    myIcon = new google.maps.MarkerImage(volunteer_image, null, null, null, new google.maps.Size(35, 35));

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
                    zoom: 12,
                    center: marker_selected
                });

                var myIcon = new google.maps.MarkerImage(upload_image_link, null, null, null, new google.maps.Size(35, 35));

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

            function go_to_place_insta(elem) {
                if (define_done == 0) {
                    get_all_data_sub();
                }

                insta_marker = elem.getAttribute("insta_marker");
                insta_img = elem.getAttribute("insta_img");
                sno_click_num = elem.getAttribute("sno_click_num");

                var geocoder;
           
                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ "address": insta_marker }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var faddr_lat = results[0].geometry.location.lat();
                        var faddr_lng = results[0].geometry.location.lng();
                    } else {
                        var faddr_lat = "";
                        var faddr_lng = "";
                    }

                    lat_r = faddr_lat;
                    log_r = faddr_lng;

                    var marker_selected = { lat: parseFloat(faddr_lat), lng: parseFloat(faddr_lng) };
                    map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 12,
                        center: marker_selected
                     });             

                    var myIcon = new google.maps.MarkerImage(insta_img, null, null, null, new google.maps.Size(35, 35));

                    var marker_set = new google.maps.Marker({
                        position: marker_selected,
                        map: map,
                        icon: myIcon,
                        animation: google.maps.Animation.BOUNCE,
                        title: "test"
                    });

                    marker_set.addListener('click', function () {
                        SetContent_insta(sno_click_num);
                    });

                    return;
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
                    zoom: 10,
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
                modal_define = 1;
            }

            function exit_content(num) {

                //open_window.style.display = 'none';

            }

            function exit_content_busking(num) {

                //open_window_busking.style.display = 'none';

            }

            function exit_content_foodtruck(num) {

                //open_window_foodtruck.style.display = 'none';

            }

            function exit_content_volunteer(num) {

                //open_window_volunteer.style.display = 'none';

            }

            function exit_popup(num) {

                //var content_number = num.getAttribute("sno_box_num");
               // var e = document.getElementById("popupAlertPostion_" + content_number);
                //e.style.display = 'none';

            }

            function SetContent(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }
  
                document.getElementById("popup_image_box_" + num).src = icon_image_array[num-1];
                document.getElementById("popup_score_box_" + num).innerHTML = like_array[num - 1];
                var score = parseFloat(heart_amount_array[num - 1]) / parseFloat(like_array[num - 1]);
                score = score.toString();
                score = score.substring(0,3);
                document.getElementById("popup_like_box_" + num).innerHTML = score;
                document.getElementById("popup_content_box_" + num).innerHTML = content_array[num-1];

                //$('#popup_image_box_' + num).html(icon_image_array[num]);       // 위도
                //$('#popup_score_box_' + num).html(parseFloat(parseFloat(heart_amount_array[num]) / parseFloat(like_array[num])));   // 경도
                //$('#popup_like_box_' + num).html(like_array[num]);   // 경도
                //$('#popup_content_box_' + num).html(content_array[num]);   // 경도

                $(document).ready(function () {
                    $("#popupAlertPosition_" + num).modal();
                });

            }

            function SetContent_insta(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }

                document.getElementById("popup_image_box_" + num).src = icon_image_array[num - 1];
                document.getElementById("popup_profile_box_" + num).innerHTML = insta_profile_array[num - 1];
                document.getElementById("popup_content_box_" + num).innerHTML = content_array[num-1];

                //$('#popup_image_box_' + num).html(icon_image_array[num]);       // 위도
                //$('#popup_score_box_' + num).html(parseFloat(parseFloat(heart_amount_array[num]) / parseFloat(like_array[num])));   // 경도
                //$('#popup_like_box_' + num).html(like_array[num]);   // 경도
                //$('#popup_content_box_' + num).html(content_array[num]);   // 경도

                $(document).ready(function () {
                    $("#popupAlertPosition_" + num).modal();
                });

            }

            function SetContent_busking(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }

                document.getElementById("popup_image_box_2_" + num).src = d_image_location_busking[num - 1];
                document.getElementById("popup_date_box_2_" + num).innerHTML = d_write_date_busking[num - 1].toString();
                document.getElementById("popup_title_box_2_" + num).innerHTML = d_title_busking[num - 1].toString();
                document.getElementById("popup_profile_box_2_" + num).innerHTML = d_user_profile_busking[num - 1];
                document.getElementById("popup_content_box_2_" + num).innerHTML = d_content_busking[num - 1];
                if (modal_define == 0) {
                    $(document).ready(function () {
                        $("#popupAlertPosition_busking").modal('toggle');
                    });
                } else {

                    modal_define = 0;
                }
                $(document).ready(function () {
                        $("#popupAlertPosition_2_" + num).modal();
                });
            }

            function SetContent_foodtruck(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }

                document.getElementById("popup_image_box_3_" + num).src = d_image_location_foodtruck[num - 1];
                document.getElementById("popup_date_box_3_" + num).innerHTML = d_write_date_foodtruck[num - 1];
                document.getElementById("popup_title_box_3_" + num).innerHTML = d_title_foodtruck[num - 1];
                document.getElementById("popup_profile_box_3_" + num).innerHTML = d_user_profile_foodtruck[num - 1];
                document.getElementById("popup_content_box_3_" + num).innerHTML = d_content_foodtruck[num - 1];
                if (modal_define == 0) {
                    $(document).ready(function () {
                        $("#popupAlertPosition_foodtruck").modal('toggle');
                    });
                } else {
                    modal_define = 0;
                }
                $(document).ready(function () {
                        $("#popupAlertPosition_3_" + num).modal();
                });

            }

            function SetContent_volunteer(num) {

                if (define_done_daily == 0) {
                    get_all_busking_data();
                    get_all_foodtruck_data();
                    get_all_volunteer_data();
                }

                document.getElementById("popup_image_box_4_" + num).src = d_image_location_volunteer[num - 1];
                document.getElementById("popup_date_box_4_" + num).innerHTML = d_write_date_volunteer[num - 1];
                document.getElementById("popup_title_box_4_" + num).innerHTML = d_title_volunteer[num - 1];
                document.getElementById("popup_profile_box_4_" + num).innerHTML = d_user_profile_volunteer[num - 1];
                document.getElementById("popup_content_box_4_" + num).innerHTML = d_content_volunteer[num - 1];
                if (modal_define == 0) {
                    $(document).ready(function () {
                        $("#popupAlertPosition_volunteer").modal('toggle');
                    });
                } else {
                    modal_define = 0;
                }
                $(document).ready(function () {
                        $("#popupAlertPosition_4_" + num).modal();
                });

            }



            function busking_popup_open() {

                /*open_window_busking_content = document.getElementById("popupAlertPosition_busking");

                open_window_busking_content.modal();
                if (open_window_busking_content == 'block')
                    open_window_busking_content.style.display = 'none';
                else
                    open_window_busking_content.style.diaplay = 'block';*/

            }

            function foodtruck_popup_open() {

                /*open_window_foodtruck_content = document.getElementById("popupAlertPosition_foodtruck");

                if (open_window_foodtruck_content == 'block') {
                    open_window_foodtruck_content.style.display = 'none';
                }
                else {
                    open_window_foodtruck_content.style.diaplay = 'block';
                }*/

            }

            function volunteer_popup_open() {

                /*open_window_volunteer_content = document.getElementById("popupAlertPosition_volunteer");

                if (open_window_volunteer_content == 'block')
                    open_window_volunteer_content.style.display = 'none';
                else
                    open_window_volunteer_content.style.diaplay = 'block';*/

            }

            function exit_window_busking_content() {

                //open_window_busking_content.style.display = 'none';

            }

            function exit_window_foodtruck_content() {

                //open_window_foodtruck_content.style.display = 'none';

            }

            function exit_window_volunteer_content() {

                //open_window_volunteer_content.style.display = 'none';

            }

            function open_insta_link(elem) {
                link = elem.getAttribute("insta_link");
                window.open(link);
            }

            $(document).ready(function (){
                $("#myBtn1").click(function () {
                    $("#popupAlertPosition_busking").modal();
                });
            });

            $(document).ready(function (){
                $("#myBtn2").click(function () {
                    $("#popupAlertPosition_foodtruck").modal();
                });
            });

            $(document).ready(function (){
                $("#myBtn3").click(function () {
                    $("#popupAlertPosition_volunteer").modal();
                });
            });
        </script>
    </head>

    <body>

        <% top_menu = "HOME" %>
        
        <!-- #include virtual="/_include/top_menu.asp" -->
        <!-- #include virtual="/_include/top_menulist.asp" -->
        <div class="row" id="buttons_box">
            <div class="col-xs-3" >
                <button type="button" onclick="get_all_data()" class="btn btn-primary btn-lg btn-block" style="font-size:6pt;">SNS</button>
            </div>
            <div class="col-xs-3">
                <button type="button" id="myBtn1" class="btn btn-primary btn-lg btn-block" onclick="busking_popup_open();" style="font-size:6pt;">버스킹</button>
            </div>
            <div class="col-xs-3">
                <button type="button" id="myBtn2" class="btn btn-primary btn-lg btn-block" onclick="foodtruck_popup_open();" style="font-size:6pt;">푸드트럭</button>
            </div>
            <div class="col-xs-3">
                <button type="button" id="myBtn3" class="btn btn-primary btn-lg btn-block" onclick="volunteer_popup_open();" style="font-size:6pt;">봉사활동</button>
            </div>
        </div>
        <hr />

        <div class="row" id="under_the_nav">
            <div class="col-sm-8" id="map">
                map_box
            </div>
            <div class="col-sm-4" id="insta_box">
                <%
                Do While Not rsSns.EOF
                    if StrComp(rsSns("sns_from_place"), "what3words")=0 then
                %>
                <div class="row" id="board_box">
                    <div class="row" id="personal_box">
                        <div class="row" id="from_box1">
                          <img id="from_img3" src="images/what3words.png" alt="" />
                        </div>
                        <div class="row" id="image_box">
                           <img id="user_img" src="<%=rsSns("sns_file_upload_area_real") %>" alt="" style="cursor:pointer" />
                        </div>
                        <div class="row" id="tag_box">
                                <div class="col-xs-1">
                                        <img id="heart_img1_<%=num %>" style="max-width:22px; max-height:22px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" onclick="img_click1(this)"/>
                                </div>
                                <div class="col-xs-1">
                                        <img id="heart_img2_<%=num %>" style="max-width:22px; max-height:22px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" onclick="img_click2(this)"/>
                                </div>
                                <div class="col-xs-1">
                                        <img id="heart_img3_<%=num %>" style="max-width:22px; max-height:22px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" onclick="img_click3(this)"/>
                                </div>
                                <div class="col-xs-1">
                                        <img id="heart_img4_<%=num %>" style="max-width:22px; max-height:22px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" onclick="img_click4(this)"/>
                                </div>
                                <div class="col-xs-1">
                                        <img id="heart_img5_<%=num %>" style="max-width:22px; max-height:22px; cursor:pointer;" sno="<%=num %>" src="images/heart_empty.png" alt="" style="cursor:pointer" onclick="img_click5(this)"/>
                                </div>
                                <%
                                    s_number = Cstr(rsSns("sns_like_average")/rsSns("sns_like_number"))
                                    s_number = LEFT(s_number, 3)
                                %>
                                <div class="col-xs-3" style=" margin-left:20px; background-color:#3fbb74; text-align:center; margin-top:1%; border-right:4px solid white; font-size:70%;">
                                        공감도 <%=s_number%>
                                </div>
                                <div class="col-xs-3" style="background-color:#3fbb74; text-align:center; margin-top:1%; font-size:70%;">
                                        공감 <%=rsSns("sns_like_number") %> 명
                                </div>
                        </div>
                        <div class="row" id="content_box">
                            <%=rsSns("sns_content_input_area") %>
                        </div>
                        <div class="row" id="go_to_box">
                            <button type="button" class="btn btn-warning" onclick="go_to_place(this);" sno ="<%=num %>" id="snsbox_<%=num %>" sno_click_num ="<%=rsSns("sns_box_number") %>" latno="<%=rsSns("sns_latitude")%>" lonno="<%=rsSns("sns_longitude")%>" sno_image ="<%=rsSns("sns_file_upload_area_real") %>" >위치로 가기</button>
                        </div>
                    </div>
                </div>
                <hr />
                <%
                    else
                %>
                <div class="row" id="board_box">
                    <div class="row" id="personal_box">
                        <div class="row" id="from_box1">
                          <img id="from_img1" src="images/instagram.png" alt="" />
                        </div>
                        <div class="row" id="image_box">
                           <img id="user_img" src="<%=rsSns("sns_file_upload_area_real") %>" alt="" style="cursor:pointer" />
                        </div>
                        <div class="row" id="tag_box">
                            <div class="col-xs-6" style="font-size:70%; text-align: center;">
                                [USER PROFILE] <%=rsSns("sns_profile") %>
                            </div>
                            <div class="col-xs-6" style="font-size:70%; color:#25529c; text-align:center">
                                <%=rsSns("sns_date") %>
                            </div>
                        </div>
                        <div class="row" id="content_box" style="margin-top:1%;">
                            <%=rsSns("sns_content_input_area") %>
                        </div>
                        <div class="row" id="link_box">
                            <div class="col-xs-6">
                            <button class="btn btn-warning" onclick="go_to_place_insta(this);" insta_marker = "<%=rsSns("sns_address")%>" sno_click_num ="<%=rsSns("sns_box_number") %>" insta_img = "<%=rsSns("sns_file_upload_area_real")%>">위치로 가기</button>
                            </div>
                            <div class="col-xs-6">
                            <button class="btn btn-info" onclick="open_insta_link(this);" insta_link = "<%=rsSns("sns_insta_link") %>">인스타그램 연결</button>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <%
                    end if
                    num = num  + 1
                    rsSns.MoveNext
                    Loop
                    rsSns.MoveFirst
                %>
            </div>
        </div>
        <!-- BUSKING 게시판 팝업 -->
            <div class="modal" id="popupAlertPosition_busking" role="dialog" style="position:absolute; position:fixed; height:90%; border-radius:10px; display:none; padding:2%; overflow-x:none; overflow-y:scroll;">
                <div class="modal-dialog">
                    <div class="modal-body" style="width:100%;">
                        <div class="container-fluid">
                            <div class="row" style="width:100%; font-size:20pt; text-align:center; color:black; background:#ffffff;">
                                BUSKING INFO
                            </div>
                            <div class="row" style="width:100%; font-size:10pt; text-align:center; color:black; background:#eb27de;">
                                이미지를 클릭하면 정보가 나와요
                            </div>
                            <% Do While NOT rsSns_busking.EOF%>
                            <div class="row" style="font-style:italic; text-align:left;">
                                <%=rsSns_busking("write_date") %>
                            </div>
                            <div class="row" style="font-size:10pt; text-align:center; height:70px;">
                                <div class="col-xs-6" style="border-right:rgba(128, 128, 128, 0.5) solid 2px; height:100%; font-size:70%;">
                                    <img src="<%=rsSns_busking("image_place") %>" onclick="SetContent_busking(<%=rsSns_busking("article_number") %>);" alt="" style="width:100%; height:100%; object-fit:contain; padding:1%;"  sno_code ="1" sno_daily="<%=rsSns_busking("article_number") %>" lat_daily="<%=rsSns_busking("latitude") %>" long_daily="<%=rsSns_busking("longitude") %>" image_place="<%=rsSns_busking("image_place") %>"/>
                                </div>
                                <div class="col-xs-2" style="font-size:70%; border-right:rgba(128, 128, 128, 0.5) solid 2px;height:100%; font-style: italic;">
                                    <p>
                                        TITLE<br>
                                        USER
                                    </p>
                                </div>
                                <div class="col-xs-4" style="font-size:70%; height:100%;">
                                    <p>
                                        <%=rsSns_busking("title_input") %><br>
                                        <%=rsSns_busking("input_user") %>
                                    </p>
                                </div>
                            </div>
                            <div class="row" style="text-align:center;">
                                <div class="col-xs-6 col-xs-offset-3">
                                <button type="button" class="btn btn-warning btn-lg btn-block" style="font-size:70%;" onclick="go_to_place_daily(this);" sno_code ="1" sno_daily="<%=rsSns_busking("article_number") %>" lat_daily="<%=rsSns_busking("latitude") %>" long_daily="<%=rsSns_busking("longitude") %>" image_place="<%=rsSns_busking("image_place") %>">지도에 위치 표시</button>
                                </div>
                            </div>
                            <hr style="border:rgba(128,128,128,0.3) solid 3px;" />
                            <%
                                rsSns_busking.MoveNext
                                Loop
                                rsSns_busking.MoveFirst
                            %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" onclick="exit_window_busking_content();" style="font-size:20pt;">창 닫기</button>
                </div>
            </div>
            <!-- 버스킹 게시판 팝업 -->
            <!-- 푸드트럭 게시판 팝업 -->
            <div class="modal" id="popupAlertPosition_foodtruck" role="dialog" style="position:absolute; position:fixed; height:90%; border-radius:10px; display:none; padding:2%; overflow-x:none; overflow-y:scroll;">
                <div class="modal-dialog">
                    <div class="modal-body" style="width:100%;">
                        <div class="container-fluid">
                            <div class="row" style="width:100%; font-size:20pt; text-align:center; color:black; background:#ffffff;">
                                FOODTRUCK INFO
                            </div>
                            <div class="row" style="width:100%; font-size:10pt; text-align:center; color:black; background:#eb27de;">
                                이미지를 클릭하면 정보가 나와요
                            </div>
                            <% Do While NOT rsSns_foodtruck.EOF%>
                            <div class="row" style="font-style:italic; text-align:left;">
                                <%=rsSns_foodtruck("write_date") %>
                            </div>
                            <div class="row" style="font-size:10pt; text-align:center; height:70px;">
                                <div class="col-xs-6" style="border-right:rgba(128, 128, 128, 0.5) solid 2px; height:100%; font-size:70%;">
                                    <img src="<%=rsSns_foodtruck("image_place") %>" onclick="SetContent_foodtruck(<%=rsSns_foodtruck("article_number") %>);" alt="" style="width:100%; height:100%; object-fit:contain; padding:1%;"  sno_code ="1" sno_daily="<%=rsSns_foodtruck("article_number") %>" lat_daily="<%=rsSns_busking("latitude") %>" long_daily="<%=rsSns_foodtruck("longitude") %>" image_place="<%=rsSns_foodtruck("image_place") %>"/>
                                </div>
                                <div class="col-xs-2" style="font-size:70%; border-right:rgba(128, 128, 128, 0.5) solid 2px;height:100%; font-style: italic;">
                                    <p>
                                        TITLE<br>
                                        USER
                                    </p>
                                </div>
                                <div class="col-xs-4" style="font-size:70%; height:100%;">
                                    <p>
                                        <%=rsSns_foodtruck("title_input") %><br>
                                        <%=rsSns_foodtruck("input_user") %>
                                    </p>
                                </div>
                            </div>
                            <div class="row" style="text-align:center;">
                                <div class="col-xs-6 col-xs-offset-3">
                                <button type="button" class="btn btn-warning btn-lg btn-block" style="font-size:70%;" onclick="go_to_place_daily(this);" sno_code ="2" sno_daily="<%=rsSns_foodtruck("article_number") %>" lat_daily="<%=rsSns_foodtruck("latitude") %>" long_daily="<%=rsSns_foodtruck("longitude") %>" image_place="<%=rsSns_foodtruck("image_place") %>">지도에 위치 표시</button>
                                </div>
                            </div>
                            <hr style="border:rgba(128,128,128,0.3) solid 3px;" />
                            <%
                                rsSns_foodtruck.MoveNext
                                Loop
                                rsSns_foodtruck.MoveFirst
                            %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" onclick="exit_window_foodtruck_content();" style="font-size:20pt;">창 닫기</button>
                </div>
            </div>
            <!-- 푸드트럭 게시판 팝업 -->
            <!-- 봉사활동 게시판 팝업 -->
            <div class="modal" id="popupAlertPosition_volunteer" role="dialog" style="position:absolute; position:fixed; height:90%; border-radius:10px; display:none; padding:2%; overflow-x:none; overflow-y:scroll;">
                <div class="modal-dialog">
                    <div class="modal-body" style="width:100%;">
                        <div class="container-fluid">
                            <div class="row" style="width:100%; font-size:20pt; text-align:center; color:black; background:#ffffff;">
                                VOLUNTEER INFO
                            </div>
                            <div class="row" style="width:100%; font-size:10pt; text-align:center; color:black; background:#eb27de;">
                                이미지를 클릭하면 정보가 나와요
                            </div>
                            <% Do While NOT rsSns_volunteer.EOF%>
                            <div class="row" style="font-style:italic; text-align:left;">
                                <%=rsSns_volunteer("write_date") %>
                            </div>
                            <div class="row" style="font-size:10pt; text-align:center; height:70px;">
                                <div class="col-xs-6" style="border-right:rgba(128, 128, 128, 0.5) solid 2px; height:100%; font-size:70%;">
                                    <img src="<%=rsSns_volunteer("image_place") %>" onclick="SetContent_volunteer(<%=rsSns_volunteer("article_number") %>);" alt="" style="width:100%; height:100%; object-fit:contain; padding:1%;"  sno_code ="3" sno_daily="<%=rsSns_volunteer("article_number") %>" lat_daily="<%=rsSns_volunteer("latitude") %>" long_daily="<%=rsSns_volunteer("longitude") %>" image_place="<%=rsSns_volunteer("image_place") %>"/>
                                </div>
                                <div class="col-xs-2" style="font-size:70%; border-right:rgba(128, 128, 128, 0.5) solid 2px;height:100%; font-style: italic;">
                                    <p>
                                        TITLE<br>
                                        USER
                                    </p>
                                </div>
                                <div class="col-xs-4" style="font-size:70%; height:100%;">
                                    <p>
                                        <%=rsSns_volunteer("title_input") %><br>
                                        <%=rsSns_volunteer("input_user") %>
                                    </p>
                                </div>
                            </div>
                            <div class="row" style="text-align:center;">
                                <div class="col-xs-6 col-xs-offset-3">
                                <button type="button" class="btn btn-warning btn-lg btn-block" style="font-size:70%;" onclick="go_to_place_daily(this);" sno_code ="3" sno_daily="<%=rsSns_volunteer("article_number") %>" lat_daily="<%=rsSns_volunteer("latitude") %>" long_daily="<%=rsSns_volunteer("longitude") %>" image_place="<%=rsSns_volunteer("image_place") %>">지도에 위치 표시</button>
                                </div>
                            </div>
                            <hr style="border:rgba(128,128,128,0.3) solid 3px;" />
                            <%
                                rsSns_volunteer.MoveNext
                                Loop
                                rsSns_volunteer.MoveFirst
                            %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" onclick="exit_window_volunteer_content();" style="font-size:20pt;">창 닫기</button>
                </div>
            </div>
            <!-- 봉사활동 게시판 팝업 -->
        <!-- 팝업 창 -->
        <%
            num = 0
            Do While NOT rsSns.EOF
            if StrComp(rsSns("sns_from_place"), "what3words")=0 then
        %>
       <div class="modal fade" id="popupAlertPosition_<%=rsSns("sns_box_number") %>" role="dialog" style=" position: fixed; font-size:70%; height: 90%; overflow-x:hidden; overflow-y:scroll; margin-top:70px; border-radius: 10px; display: none; padding:2%; align-content:center;">
            <div class="modal-dialog">
                <div class="modal-body">
                    <div class="container-fluid" style="width:90%;">
                        <div class="row" style="font-size:15pt; font-style:italic;">
                            USER CONTENT INFO
                        </div>
                        <div class="row">
                            <img id="popup_image_box_<%=rsSns("sns_box_number") %>" src="" alt="" style="width:100%; object-fit:contain;" />
                        </div>
                        <div class="row" style="border-bottom:3px white solid;">
                            <div class="col-xs-3 col-xs-offset-1" style="text-align:center;">
                                <p>공감 인원</p>
                            </div>
                            <div class="col-xs-2" style="border:2px solid white; text-align:left; align-content:left;">
                                <p id="popup_score_box_<%=rsSns("sns_box_number")%>"></p> 
                            </div>
                            <div class="col-xs-3" style="text-align:center;"><p style="text-align:center;">공감도</p></div>
                            <div class="col-xs-2" style="border:2px solid white; text-align:center;">
                                <p id="popup_like_box_<%=rsSns("sns_box_number") %>"></p>
                            </div>
                        </div>
                        <hr style="border:2px solid gray;">
                        <div class="row" style="height:20%; border-right:2px solid white; border-left:2px solid white; border-bottom:2px solid white;">
                            <span id="popup_content_box_<%=rsSns("sns_box_number") %>" ></span>
                        </div>
                        <hr style="border:2px solid gray;">
                        <div class="row">
                            <div class="col-xs-4">
                                <button type="button" class="btn btn-primary btn-lg btn-block" id="send_message" onclick="reqChat(<%=rsSns("sns_box_number") %>, 1)" style="font-size:8pt; font-style:oblique;">채팅 신청</button>
                            </div>
                            <div class="col-xs-4">
                                <button type="button" class="btn btn-info btn-lg btn-block" id="user_profile" onclick="discover_user();" style="font-size:8pt; font-style:oblique;">회원 정보</button>
                            </div>
                            <div class="col-xs-4">
                                <button type="button" class="btn btn-danger btn-lg btn-block" id="exit_content"  data-dismiss="modal" sno_exit_num="<%=rsSns("sns_box_number") %>" style="font-size:8pt; font-style:oblique;">창 닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 팝업 창 -->
        <%
            else
        %>
       <div class="modal fade" id="popupAlertPosition_<%=rsSns("sns_box_number") %>" role="dialog" style=" position: fixed; font-size:70%; height: 90%; overflow-x:hidden; overflow-y:scroll; margin-top:70px; border-radius: 10px; display: none; padding:2%; align-content:center;">
            <div class="modal-dialog">
                <div class="modal-body">
                    <div class="container-fluid" style="width:90%;">
                        <div class="row" style="font-size:15pt; font-style:italic;">
                            USER CONTENT INFO
                        </div>
                        <div class="row">
                            <img id="popup_image_box_<%=rsSns("sns_box_number") %>" src="" alt="" style="width:100%; object-fit:contain;" />
                        </div>
                        <div class="row" style="border-bottom:3px white solid;">
                            <div class="col-xs-6" style="font-size:8pt; font-style:italic; text-align:center">
                                <p>[USER PROFILE]</p>
                            </div>
                            <div class="col-xs-6" style="text-align:center;">
                                <p id="popup_profile_box_<%=rsSns("sns_box_number") %>"></p>
                            </div>
                        </div>
                        <hr style="border:2px solid gray;">
                        <div class="row" style="height:20%; border-right:2px solid white; border-left:2px solid white; border-bottom:2px solid white;">
                            <span id="popup_content_box_<%=rsSns("sns_box_number") %>" ></span>
                        </div>
                        <hr style="border:2px solid gray;">
                        <div class="row">
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-danger btn-lg btn-block" id="exit_content"  data-dismiss="modal" sno_exit_num="<%=rsSns("sns_box_number") %>" style="font-size:8pt; font-style:oblique;">창 닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            end if
            num = num + 1
            rsSns.MoveNext
            Loop
            rsSns.MoveFirst
        %>
        <!-- 팝업창 Busking -->
        <%
            Do While NOT rsSns_busking.EOF
        %>
       <div class="modal fade" id="popupAlertPosition_2_<%=rsSns_busking("article_number") %>" role="dialog" style="z-index:1; font-size:70%; position: fixed;height: 90%; overflow-x:hidden; overflow-y:scroll; border-radius: 10px; display: none; padding:2%; align-content:center;">
            <div class="modal-dialog">
                <div class="modal-body">
                    <div class="container-fluid" style="width:90%;">
                        <div class="row" style="font-size:15pt; font-style:italic;">
                            BUSKING CONTENT INFO
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:left;">
                            <p id="popup_date_box_2_<%=rsSns_busking("article_number") %>"></p>
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:center;">
                            <div class="col-xs-6">
                                <p id="popup_title_box_2_<%=rsSns_busking("article_number") %>"></p>
                            </div>
                            <div class="col-xs-6">
                                <p id="popup_profile_box_2_<%=rsSns_busking("article_number") %>"></p>
                            </div>
                        </div>
                        <div class="row">
                            <img id="popup_image_box_2_<%=rsSns_busking("article_number") %>" src="" alt="" style="width:100%; object-fit:contain;" />
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row" style="height:20%; border:3px solid white;">
                            <span id="popup_content_box_2_<%=rsSns_busking("article_number") %>" ></span>
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-primary btn-lg btn-block" id="send_message2" onclick="reqChat(<%=rsSns_busking("article_number") %>, 2)">채팅 신청</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" id="exit_content2" onclick="exit_content_busking(this)" sno_exit_num_2="<%=rsSns_busking("article_number") %>">창 닫기</button>
                            </div>
                        </div>
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
        <div class="modal fade" id="popupAlertPosition_3_<%=rsSns_foodtruck("article_number") %>" role="dialog" style="z-index:1; font-size:70%; position: fixed;height: 90%; overflow-x:hidden; overflow-y:scroll; border-radius: 10px; display: none; padding:2%; align-content:center;">
            <div class="modal-dialog">
                <div class="modal-body">
                    <div class="container-fluid" style="width:90%;">
                        <div class="row" style="font-size:15pt; font-style:italic;">
                            FOODTRUCK CONTENT INFO
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:left;">
                            <p id="popup_date_box_3_<%=rsSns_foodtruck("article_number") %>"></p>
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:center;">
                            <div class="col-xs-6">
                                <p id="popup_title_box_3_<%=rsSns_foodtruck("article_number") %>"></p>
                            </div>
                            <div class="col-xs-6">
                                <p id="popup_profile_box_3_<%=rsSns_foodtruck("article_number") %>"></p>
                            </div>
                        </div>
                        <div class="row">
                            <img id="popup_image_box_3_<%=rsSns_foodtruck("article_number") %>" src="" alt="" style="width:100%; object-fit:contain;" />
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row" style="height:20%; border:3px solid white;">
                            <span id="popup_content_box_3_<%=rsSns_foodtruck("article_number") %>" ></span>
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-primary btn-lg btn-block" id="send_message3" onclick="reqChat(<%=rsSns_foodtruck("article_number") %>, 3);">채팅 신청</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" id="exit_content3" onclick="exit_content_foodtruck(this)" sno_exit_num_2="<%=rsSns_foodtruck("article_number") %>">창 닫기</button>
                            </div>
                        </div>
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
       <div class="modal fade" id="popupAlertPosition_4_<%=rsSns_volunteer("article_number") %>" role="dialog" style="z-index:1; font-size:70%; position: fixed;height: 90%; overflow-x:hidden; overflow-y:scroll; border-radius: 10px; display: none; padding:2%; align-content:center;">
            <div class="modal-dialog">
                <div class="modal-body">
                    <div class="container-fluid" style="width:90%;">
                        <div class="row" style="font-size:15pt; font-style:italic;">
                            VOLUNTEERING CONTENT INFO
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:center;">
                            <p id="popup_title_box_4_<%=rsSns_volunteer("article_number") %>"></p>
                        </div>
                        <div class="row" style="border-bottom:3px white solid; text-align:center;">
                            <div class="col-xs-6">
                                <p id="popup_date_box_4_<%=rsSns_volunteer("article_number") %>"></p>
                            </div>
                            <div class="col-xs-6">
                                <p id="popup_profile_box_4_<%=rsSns_volunteer("article_number") %>"></p>
                            </div>
                        </div>
                        <div class="row">
                            <img id="popup_image_box_4_<%=rsSns_volunteer("article_number") %>" src="" alt="" style="width:100%; object-fit:contain;" />
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row" style="height:20%; border:3px solid white;">
                            <span id="popup_content_box_4_<%=rsSns_volunteer("article_number") %>" ></span>
                        </div>
                        <hr style="border: 3px solid rgba(128, 128, 128, 0.3);" />
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-primary btn-lg btn-block" id="send_message4" onclick="reqChat(<%=rsSns_volunteer("article_number") %>, 4);">채팅 신청</button>
                            </div>
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-danger btn-lg btn-block" data-dismiss="modal" id="exit_content4" onclick="exit_content_volunteer(this)" sno_exit_num_4="<%=rsSns_volunteer("article_number") %>">창 닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            rsSns_volunteer.MoveNext
            Loop
            rsSns_volunteer.MoveFirst
        %>
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
    </body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->