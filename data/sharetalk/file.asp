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
    lat_value = 37.561143
  end if

  if request("lon_value") <> "" then
    lon_value = request("lon_value")
  else
    lon_value = 126.985856
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
    rsData.Open strSQL, DbConn, 1, 1

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

    'strSQL = "p_tsh_post_read '" & keyword & "','" & request("cat_no") & "'"

    'response.Write strSQL
   ' response.end

    'set rsPost = Server.CreateObject("ADODB.Recordset")
    'rsPost.CursorLocation = 3
    'rsPost.Open strSQL, DbConn
    
    'response.Write strSQL
    'response.end

    'if rsPost.EOF or rsPost.BOF then
	  'NoDataPost = True
    'Else
	   'NoDataPost = False
    'end if

    '페이징처리관련
    'page =request("page")

    'If NoDataPost = False then
  	 ' Cus_pageSize = 20
	  'rsPost.PageSize = Cus_pageSize

	  'pagecount=rsPost.pagecount
  	  'totalRecord = rsPost.RecordCount

	  'cPage = page
	  'if page <> "" Then
		'if cPage < 1 Then
		'	cPage = 1
		'end if
      'else
		'page = 1
		'cPage = 1
	 ' end If
	  'rsPost.AbsolutePage = cPage

	  'lastpg = int(((totalRecord -1) / rsPost.PageSize) + 1)

      'if page > lastpg then
	  	'page = lastpg
      'end If

    'end if
    '페이징처리관련 끝

    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbConn, 1, 1

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

    <title>What3WordsKorea</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <style type="text/css">
        * {
            padding: 0;
            margin: 0;
        }

        html, body {
            max-width: 100%;
            overflow-x: hidden;
            font-family: Arial, 맑은 고딕, 돋움;
            background: #FFFFFF;
            padding: 0px;
            margin: 0px;
        }

        a {
            text-decoration: none;
            color: #000000;
        }

        li {
            list-style-type: none;
        }

        header {
            width: 100%;
            height: 70px;
            margin: 0px;
            background: #5A6CB4;
            padding: 0px;
            position: fixed;
            z-index: 4
        }

        #brand {
            width: 80%;
            float: left;
            height: 40px;
            padding: 0px;
            color: #FFFFFF;
        }

        nav {
            width: 100%;
            text-align: center;
            top: 70px;
        }

            nav a {
                display: block;
                padding: 15px 0;
                border-bottom: 1px solid #0076A3;
                color: #00A5CC;
            }

                nav a:hover {
                    background: #6DCFF6;
                    color: #FFF;
                }

            nav li:last-child a {
                border-bottom: none;
            }
        /*-----------------------------------------*/
        .menu {
            z-index: 5;
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
            margin: 0px 5px 0px 0px;
            background: #EEEEEE;
            float: right;
            color: #0cc738;
            cursor: pointer;
            margin-top: 4px;
            border-radius: 5px;
            position: absolute;
            top: 5px;
            right: 5px;
        }

        #menuToggle {
            display: none;
        }

            #menuToggle:checked ~ header {
                position: absolute;
                left: 0;
            }

            #menuToggle:checked ~ .menu {
                position: absolute;
                left: 0;
            }

            #menuToggle:checked ~ .login {
                position: absolute;
                left: 60px;
                top: 50px;
            }

            #menuToggle:checked ~ .title {
                position: absolute;
                left: 260px;
                top: 50px;
            }

            #menuToggle:checked ~ .content {
                position: absolute;
                left: 260px;
                top: 10px;
            }

            #menuToggle:checked ~ .bottom {
                position: absolute;
                left: 260px;
            }


        .title {
            text-align: center;
            font-size: 25px;
            font-family: Arial, 맑은 고딕, 돋움;
            font-weight: bold;
            height: 30px;
            margin: 2px;
            padding: 5px;
            color: #0cc738;
            // background: #0cc738;
            border-radius: 2px;
        }

        .login {
            margin: 0px;
            padding: 0px;
            display: flex;
            justify-content: center;
            height: 60px;
        }

        .content {
            width: 100%;
            margin: 0px;
            font-size: 16px;
            font-family: Arial, 맑은 고딕, 돋움;
            /* font-weight:bold; */
            background: #FFFFFF;
            padding: 0px;
            transition: all .3s ease-in-out;
            -webkit-transition: all .3s ease-in-out;
            -moz-transition: all .3s ease-in-out;
            -ms-transition: all .3s ease-in-out;
            -o-transition: all .3s ease-in-out;
        }

        .bottom {
            font-size: 14px;
            font-family: Arial, 맑은 고딕, 돋움;
            font-weight: bold;
            padding: 20px;
            margin: 2px;
        }

        /* 게시판 디자인 */
        .main_table {
            width: 100%;
            border: 0px;
            font-family: Arial, 맑은 고딕, 돋움;
        }

        .bbcTitle {
            font-family: Arial, 맑은 고딕, 돋움;
            font-size: 1.2em;
            font-weight: bold;
            color: #000000;
            margin: 5px 5px 5px 5px;
            padding: 5px 5px 5px 5px;
        }

        .bbcContent {
            font-family: Arial, 맑은 고딕, 돋움;
            font-size: 0.98em;
            color: #000000;
            margin: 5px 5px 5px 20px;
            padding: 5px 5px 5px 5px;
        }

        .bbcDate {
            height: 20px;
            font-family: Arial, 맑은 고딕, 돋움;
            font-size: 0.8em;
            color: #000000;
            margin: 5px 5px 5px 20px;
            padding: 5px 5px 5px 5px;
        }

        span td a {
            font-family: Arial, 맑은 고딕, 돋움;
        }

        /* 게시판 디자인 */

        /* 팝업 메뉴 start */
        #popupBoxLogin {
            top: 0;
            left: 0;
            position: fixed;
            width: 100%;
            height: 120%;
            background-color: rgba(0,0,0,0.7);
            display: none;
            border-radius: 0px;
        }

        .popupBoxWrapper {
            width: 300px;
            margin: 0px;
            text-align: left;
            position: absolute;
            top: 100px;
            left: 20px;
            right: 50;
            border-radius: 0px;
        }

        .popupBoxContent {
            background-color: #FFF;
            padding: 0px;
            border-radius: 2px;
        }

        /* 팝업 메뉴 end */

        /* navigation start */
        ul.category {
            list-style-type: none;
            margin: 0;
            padding: 0;
            /* position:absolute; */
        }

        li.category {
            display: inline-block;
            float: left;
            margin-right: 1px;
        }

            li.category a {
                display: block;
                min-width: 60px;
                height: 40px;
                text-align: center;
                line-height: 40px;
                font-size: 14px;
                font-family: Arial,맑은 고딕,돋움;
                font-weight: bold;
                color: #000000;
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

        #panel {
            background-color: #e5e5e5;
            position: absolute;
            left: 65%;
            z-index: 3;
            border: 1px solid #999
        }

        @media(max-width:767px) {
            #selectType {
                text-align: left;
            }
        }

        @media(min-width:768px) {
            #selectType {
                text-align: right;
            }
        }

        #category {
            position: absolute;
            top: 10px;
            left: 10px;
            border-radius: 5px;
            border: 1px solid #909090;
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
            background: #fff;
            overflow: hidden;
            z-index: 2;
        }

            #category li {
                float: left;
                list-style: none;
                width: 60px;
                border-right: 1px solid #acacac;
                padding: 6px 0;
                text-align: center;
                cursor: pointer;
            }

        .placeinfo {
            position: relative;
            width: 100%;
            border: 1px solid;
            padding-bottom: 10px;
            background: #fff;
        }

            .placeinfo a, .placeinfo a:hover, .placeinfo a:active {
                color: #fff;
                text-decoration: none;
            }

            .placeinfo a, .placeinfo span {
                display: block;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .placeinfo span {
                margin: 5px 5px 0 5px;
                cursor: default;
                font-size: 13px;
            }

            .placeinfo .title {
                font-weight: bold;
                font-size: 14px;
                border-radius: 6px 6px 0 0;
                margin: -1px -1px 0 -1px;
                padding: 10px;
                color: #fff;
                background: #d95050;
                background: #d95050 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
            }

            .placeinfo .tel {
                color: #0f7833;
            }

            .placeinfo .jibun {
                color: #999;
                font-size: 11px;
                margin-top: 0;
            }
   
           </style>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?&appkey=9a9b328e41d45bb4d7c639a649707e2d&libraries=services,clusterer,drawing"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc"></script>
    <script type="text/javascript">
        var map;
        var myPosition;
        var myCenterMarker;
        var centerMarker;
        var autoGpsFlag = 0;
        var geocoder = new google.maps.Geocoder(); // 주소 검색 google 이용 
        var centerLatlng;
        var currentBound;

        var placeOverlay = new daum.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
            markers = [], // 마커를 담을 배열입니다
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
        var ps = new daum.maps.services.Places(map);



        function initMap() {
            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            var options = { //지도를 생성할 때 필요한 기본 옵션
                center: new daum.maps.LatLng(<%=lat_value %>, <%=lon_value %>), //지도의 중심좌표.
                level:<%=zoom_level %>,//지도의 레벨(확대, 축소 정도)
            };
            map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
            getMyLocation();
            tileSet();

            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
            var zoomControl = new daum.maps.ZoomControl();
            map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

            daum.maps.event.addListener(map, 'idle', function () {
                centerLatlng = map.getCenter();
                currentBound = map.getBounds();
            });


            // 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
            daum.maps.event.addListener(map, 'zoom_changed', function () {
                tileSet();
            });

            daum.maps.event.addListener(map, 'idle', searchPlaces);

            // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
            //contentNode.className = 'placeinfo_wrap';

            // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
            // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다 

            //            addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
            //addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);

            // 커스텀 오버레이 컨텐츠를 설정합니다
            placeOverlay.setContent(contentNode);
            // 각 카테고리에 클릭 이벤트를 등록합니다

        }


        function tileSet() {  // Tile 그리기 함수
            // 지도의 현재 레벨을 얻어옵니다
            var level = map.getLevel();
            map.removeOverlayMapTypeId(daum.maps.MapTypeId.TILE_NUMBER);

            if (level <= 7) { // ZOOM-LEVLE 7 = 1km

                daum.maps.Tileset.add('TILE_NUMBER',
                    new daum.maps.Tileset({
                        width: 110,
                        height: 100,
                        getTile: function (x, y, z) {
                            var div = document.createElement('div');
                            // div.innerHTML = x + ', ' + y + ', ' + z; 
                            //div.style.fontSize = '36px';
                            //div.style.fontWeight = 'bold';
                            //div.style.lineHeight = '256px'
                            //div.style.textAlign = 'center';
                            //div.style.color = '#000000';
                            div.style.border = '1px dashed #ffffff';
                            return div;
                        }
                    }));
                map.addOverlayMapTypeId(daum.maps.MapTypeId.TILE_NUMBER);
            }
        }

        function drawMycenterMarker(position) { // 사용자 gps 위치에 마커찍기 

            var coords = new daum.maps.LatLng(position.coords.latitude, position.coords.longitude); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

            if (myCenterMarker != null) clearCenterMarker(myCenterMarker);
            myCenterMarker = new daum.maps.Marker({
                map: map,
                position: coords
            });

            $.ajax({
                url: 'range_find_ajax.asp',
                type: 'get',
                data: 'x_center=' + position.coords.latitude + '&y_center=' + position.coords.longitude,
                success: function (data) {
                    my_position = document.getElementById("my_position");
                    my_position.value = data;
                }
            });

            if (autoGpsFlag == 0) {
                moveCamera(position.coords.latitude, position.coords.longitude);
            }
        }

        function getMyLocation() {
            myPosition = navigator.geolocation.watchPosition(drawMycenterMarker, error);
        }


        function moveCamera(lat, lng) {     // camera 이동 
            var moveLocation = new daum.maps.LatLng(lat, lng);
            map.panTo(moveLocation);
        }

        function clearCenterMarker(marker) {
            marker.setMap(null);
        }


        function describeSearchType() {
            if (centerMarker != null) clearCenterMarker(centerMarker);
            var Option = $("#selectOption option:selected").val();

            if (Option == 1) originalSearch();
            else if (Option == 2) threeWordsSearch();
        }


        function originalSearch() {   // 1.주소로 검색
            var originalAddress = document.getElementById('originalAddress').value;

            geocoder.geocode({ 'address': originalAddress },   // google Map으로 주소 검색하여, 좌표값 받아 Daum 맵에 표출 

                function (results, status) {
                    if (results != "") {
                        var location = results[0].geometry.location;
                        var coords = new daum.maps.LatLng(location.lat(), location.lng());
                        // 결과값으로 받은 위치를 마커로 표시합니다
                        centerMarker = new daum.maps.Marker({
                            map: map,
                            position: coords
                        });

                        autoGpsFlag = 1;
                        moveCamera(location.lat(), location.lng());

                        $.ajax({
                            url: 'range_find_ajax.asp',
                            type: 'get',
                            data: 'x_center=' + location.lat() + '&y_center=' + location.lng(),
                            success: function (data) {
                                var destination3Words = document.getElementById("destination3Words");
                                destination3Words.value = data;
                            }
                        });
                    }
                });
        }
        function threeWordsSearch() {
            var threeWords = document.getElementById('originalAddress').value;

            $.ajax({
                url: 'search_ajax.asp',
                type: 'get',
                data: 'word=' + threeWords,
                success: function (data) {
                    var dataArray = data.split(',');
                    var coords = new daum.maps.LatLng(dataArray[0], dataArray[1]);
                    centerMarker = new daum.maps.Marker({
                        map: map,
                        position: coords
                    });

                    moveCamera(dataArray[0], dataArray[1]);

                }

            });
            autoGpsFlag = 1;
        }


        function error(error) {
            alert(error);
        }


        // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
        function addEventHandle(target, type, callback) {
            if (target.addEventListener) {
                target.addEventListener(type, callback);
            } else {
                target.attachEvent('on' + type, callback);
            }
        }

        // 카테고리 검색을 요청하는 함수입니다
        function searchPlaces() {
            if (!currCategory) {
                return;
            }

            // 커스텀 오버레이를 숨깁니다 
            placeOverlay.setMap(null);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();
            ps.categorySearch(currCategory, placesSearchCB, { bounds: currentBound });

        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === daum.maps.services.Status.OK) {
                console.log(data);
                // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                displayPlaces(data);
            } else if (status === daum.maps.services.Status.ZERO_RESULT) {
                // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

            } else if (status === daum.maps.services.Status.ERROR) {
                // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

            }
        }

        // 지도에 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
            // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
            var order = document.getElementById(currCategory).getAttribute('data-order');

            console.log(places.length);

            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var marker = addMarker(new daum.maps.LatLng(places[i].y, places[i].x), order);

                // 마커와 검색결과 항목을 클릭 했을 때
                // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                (function (marker, place) {
                    daum.maps.event.addListener(marker, 'click', function () {
                        displayPlaceInfo(place);
                    });
                })(marker, places[i]);
            }
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, order) {

            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new daum.maps.Size(27, 28),  // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
                    spriteOrigin: new daum.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new daum.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new daum.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {

            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
        function displayPlaceInfo(place) {
            var content = '<div class="placeinfo">' +
                '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

            if (place.road_address_name) {
                content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
            } else {
                content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
            }

            content += '    <span class="tel">' + place.phone + '</span>' +
                '</div>' +
                '<div class="after"></div>';

            contentNode.innerHTML = content;
            placeOverlay.setPosition(new daum.maps.LatLng(place.y, place.x));
            placeOverlay.setMap(map);
        }


        // 각 카테고리에 클릭 이벤트를 등록합니다
        function addCategoryClickEvent() {
            // var category = document.getElementById("category");
            var children = document.getElementById("category").children;

            //children = $("ul").children();

            for (var i = 0; i < children.length; i++) {
                children[i].onclick = onClickCategory;
            }
        }

        // 카테고리를 클릭했을 때 호출되는 함수입니다
        function onClickCategory() {
            var id = this.id,
                className = this.className;

            placeOverlay.setMap(null);

            if (className === 'on') {
                currCategory = '';
                changeCategoryClass();
                removeMarker();
            } else {
                currCategory = id;
                changeCategoryClass(this);
                searchPlaces();
            }
        }

        // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
        function changeCategoryClass(el) {
            var category = document.getElementById('category'),
                children = category.children,
                i;

            for (i = 0; i < children.length; i++) {
                children[i].className = '';
            }

            if (el) {
                el.className = 'on';
            }
        }


    </script>



    <!--  //라는 상대 프로토콜 사용하면 사용자의 http, https 환경에 따라 자동으로 해당 프로토콜을 따라간다. -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<body>
    <!-- #include virtual="/_include/top_menu.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->

    <div style="margin-top: 100px" class="container-fluid">
        <div class="row">
            <div class="col-xs-12 col-sm-3" id="selectType">
                <select class="selectpicker" id="selectOption" data-style="btn-danger">
                    <option value="1">주소로 검색</option>
                    <option value="2">3Words로 검색</option>
                </select>

            </div>
            <div class="col-xs-9 col-sm-6">
                <input type="text" id="originalAddress" class="form-control" placeholder="검색할 주소를 입력하세요">
            </div>
            <div class="col-xs-3 col-sm-3">
                <button type="button" class="btn btn-primary" onclick="describeSearchType()">검색</button>
            </div>
        </div>

        <br>
        <hr>

        <div class="row">

            <div class="col-xs-1 col-md-2"></div>
            <div class="col-xs-10 col-md-8" id="map">
                <script>
                     initMap(); 
                </script>


                <ul id="category" class="category">
                    <li id="FD6" data-order="0">
                        <span class=""></span>
                        음식점
                    </li>
                    <li id="AD5" data-order="1">
                        <span class=""></span>
                        숙박
                    </li>
                    <li id="CE7" data-order="2">
                        <span class=""></span>
                        카페
                    </li>
                    <li id="CS2" data-order="3">
                        <span class=""></span>
                        편의점
                    </li>
                    <li id="AT4" data-order="4">
                        <span class=""></span>
                        관광명소
                    </li>
                    <li id="SW8" data-order="5">
                        <span class=""></span>
                        지하철역
                    </li>
                </ul>


            </div>

        </div>

        <br>
        <br>
        <hr>

        <div>
            <div class="row">
                <div class="col-xs-0 col-sm-1"></div>
                <div class="col-xs-4 col-sm-5" style="text-align: center">내 위치</div>
                <div class="col-xs-8 col-sm-5">
                    <input type="text" id="my_position" class="form-control" disabled>
                </div>
                <div class="col-xs-0 col-sm-1"></div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-0 col-sm-1"></div>
                <div class="col-xs-4 col-sm-5" style="text-align: center">갈 곳 </div>
                <div class="col-xs-8 col-sm-5">
                    <input type="text" class="form-control" id="destination3Words" disabled>
                </div>
                <div class="col-xs-0 col-sm-1"></div>
            </div>
        </div>

        <hr>
        <div class="row">
            <div class="col-xs-12 col-sm-12">
                <textarea class="form-control" style="overflow-y: hidden; overflow-x: hidden" disabled></textarea>
            </div>
        </div>
        <hr>

        <div class="row">
            <div class="col-xs-12 col-sm-12" id="photo">
                <div>

                    <div class="col-xs-12 col-sm-6" id="name"></div>
                    <div class="col-xs-12 col-sm-6" id="tel_no"></div>
                    <div class="col-xs-12 col-sm-12" id="address"></div>
                    <div class="col-xs-12 col-sm-6" id="open_time"></div>
                    <div class="col-xs-12 col-sm-6" id="current_open"></div>
                    <div class="col-xs-12 col-sm-12" id="weekday_text"></div>
                    <div class="col-xs-12 col-sm-12" id="rating"></div>
                    <div class="col-xs-12 col-sm-12" id="reviews"></div>
                    <div class="col-xs-12 col-sm-12" id="website"></div>

                </div>
                <br>
                <div class="row">
                    <div class="col-xs-1 col-sm-1" style="background-color: brown">q  </div>
                    <div class="col-xs-5 col-sm-5" style="background-color: black">w  </div>
                    <div class="col-xs-5 col-sm-5" style="background-color: red">e  </div>
                    <div class="col-xs-1 col-sm-1" style="background-color: brown">r  </div>
                </div>
            </div>

        </div>

    </div>



    <script>   addCategoryClickEvent();</script>
    <!-- #include virtual="/_include/connect_close.inc" -->
</body>


</html>
