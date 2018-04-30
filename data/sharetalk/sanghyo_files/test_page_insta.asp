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

    strSQL2 = "p_sns_contents_read"

    Set rsSns = Server.CreateObject("ADODB.RecordSet")
    rsSns.Open strSQL2, DbConn, 1, 1

    if rsSns.EOF or rsSns.BOF then
        NoDataSns = True
    Else
        NoDataSns = False
    end if

    '================== [  Busking 정보 불러오기  ] ===================

    strSQL2 = "p_sns_busking_contents_read"

    Set rsSns = Server.CreateObject("ADODB.RecordSet")
    rsSns.Open strSQL2, DbConn, 1, 1

    if rsSns.EOF or rsSns.BOF then
        NoDataSns = True
    Else
        NoDataSns = False
    end if

    '================== [  FoodTruck 정보 불러오기  ] ===================

    strSQL2 = "p_sns_foodtruck_contents_read"

    Set rsSns = Server.CreateObject("ADODB.RecordSet")
    rsSns.Open strSQL2, DbConn, 1, 1

    if rsSns.EOF or rsSns.BOF then
        NoDataSns = True
    Else
        NoDataSns = False
    end if

    '================== [  Volunteer 정보 불러오기  ] ===================

    strSQL2 = "p_sns_volunteer_contents_read"

    Set rsSns = Server.CreateObject("ADODB.RecordSet")
    rsSns.Open strSQL2, DbConn, 1, 1

    if rsSns.EOF or rsSns.BOF then
        NoDataSns = True
    Else
        NoDataSns = False
    end if

    Dim num
    num =0
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
                padding:3%;
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

            var image_number = 0;
            var last_number = 0;
            var markers = [];
            var define_done = 0;
            var open_window; //어차피 팝업 윈도우는 하나뿐이 뜰 수밖에 없습니다.

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

                alert(num_iter);
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


                alert(sno_click_num);
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
                })

            }
            function exit_content(num) {
                open_window.style.display = 'none';   
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
            function go_to_busking_write(){
                location.href = "busking_write.asp";
            }
            function go_to_foodtruck_write(){
                location.href = "foodtruck_write.asp";
            }
            function go_to_volunteer_write(){
                location.href = "volunteer_write()";
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
        <div id="extra_content_box" >
            <div style="float:left; width:33%; text-align:center;">
                <button id="busking_info_write" onclick="go_to_busking_write();">버스킹 정보 올리기</button>
                <table>
                    <tr></tr>
                </table>
            </div>
            <div style="float:left; width:33%; text-align:center;">
                <button id="foodtruck_info_write" onclick="go_to_foodtruck_write();">푸드트럭 정보 올리기</button>
                <table>
                    <tr></tr>
                </table>
            </div>
            <div style="float:left; width:33%; text-align:center;">
                <button id="volunteer_info_write" onclick="go_to_volunteer_write();">봉사활동 정보 올리기</button>
                <table>
                    <tr></tr>
                </table>
            </div>
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
                    <button type="button" id="send_message" onclick="send_message();" style="width:30%; height:50%;">채팅 신청</button>
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
		
		<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
		
		<script type="text/javascript">
			var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "ePD3yuxPRSuXMeIBH5DA",
					callbackUrl: "http://tour.abcyo.kr/callback.html",
					isPopup: true,
					callbackHandle: true,
					loginButton: {color: "green", type: 1, height: 30} /* 로그인 버튼의 타입을 지정 */
					/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
				}
			);
		
			/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
			naverLogin.init();
			
			naverLogin.getLoginStatus(function (status) {
				if (status){
					var email = naverLogin.user.getEmail();
					var name = naverLogin.user.getNickName();
					var uniqId = navrLogin.user.getId();
					var age = naverLogin.user.getAge();
				} else {
					console.log("AccessToken이 올바르지 않습니다.");
				}
            });
            function return_number_of_write() {
                return <%=num %>;
            }

		</script>
	</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->