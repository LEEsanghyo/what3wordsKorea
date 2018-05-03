<!-- #include virtual="/_include/connect.inc" -->
<%
    Server.ScriptTimeout = 600

%>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="LIM-YOUN-SOO" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Whar3Words</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="./_include/navigator.css" />

    <!-- //라는 상대 프로토콜 사용하면 사용자의 http, https 환경에 따라 자동으로 해당 프로토콜을 따라간다 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?&appkey=9a9b328e41d45bb4d7c639a649707e2d&libraries=services,clusterer,drawing"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc"></script>
    <script type="text/javascript" src="./_script/navigator.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>




</head>
<body onload="initMap()">
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
                <input type="text" id="addressSpace" class="form-control" placeholder="검색할 주소를 입력하세요">
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
                    <div class="col-xs-12 col-sm-12" id="route">
            

                    </div>
                        
                </div>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-12">
                        <input type="button" style="float: right" value="경로 저장" />
                    </div>
                </div>

                <hr />
                <div class="row">
                    <!--
                    <div class="col-xs-1 col-sm-1" style="background-color: brown">q  </div>
                    <div class="col-xs-5 col-sm-5" style="background-color: black">w  </div>
                    <div class="col-xs-5 col-sm-5" style="background-color: red">e  </div>
                    <div class="col-xs-1 col-sm-1" style="background-color: brown">r  </div>
                    -->
                    <div class="col-xs-12 col-sm-12">
                       <!-- <input type="button" style="float: right" onclick="sendParameterToSearchRoute()" value="경로 탐색" /> -->
                    </div>
                </div>
            </div>

        </div>

    </div>



    <script type="text/javascript">
        var map;  // 지도 변수 
        var myPosition; // gps로 따오는 내 위치
        var myPositionMarker; // gps로 따오는 내 위치에 찍는 마커
        var myPositionInfowindow;

        var destinationMarker; // 검색시 찍는 마커

        var centerMarker; // 지도 조작시 지도의 중앙에 찍는 마커
        var centerLatlng; // 중심 lat, lng
        var centerInfowindow; // 중심 infowindow


        var autoGpsFlag = 0;
        var geocoder = new google.maps.Geocoder(); // 주소 검색 google 이용 

        var currentBound;
        
     
        var count = 0;

       // var apikey = encodeURIComponent("nxb4coDQx0Z6d7mjF6RT+g");



        var routeMarker = [];
        var routeCount =0;
        var routeinfowindow = []; 
        var checkOpenRouteinfowindow = [];

        var startMarker, endMarker;
        var polyline;
       // var cnt = 0;

        var placeOverlay = new daum.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
            markers = [], // 마커를 담을 배열입니다
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
        var ps = new daum.maps.services.Places(map);


        var node = function (name, x, y) {
            this.name = name;
            this.x = x;
            this.y = y;
            this.next = null;
        }

        var linkedList = function () {
            this.length = 0;
            this.headNode = new node(null);
        }

        var routeItem = new linkedList();

        linkedList.prototype.add = function (name, x, y, position) {
            //position이 null일 경우 마지막위치로
            var position = position == undefined ? this.length + 1 : position;

            //입력값으로 node 생성

            var newNode = new node(name, x, y);

            var preNode = this.headNode;
            for (i = 1; i < position; i++) {
                preNode = preNode.next;
            }
            newNode.next = preNode == null ? null : preNode.next;
            preNode.next = newNode;
            this.length++;
        }

        linkedList.prototype.remove = function (position) {
            var ret = null;
            var position = position == undefined ? 0 : position;
            if (this.isEmpty()) {
                console.log("list is Empty");
            }
            else if (position < this.length) {
                var preNode = this.headNode;

                for (i = 0; i < position; i++) {
                    preNode = preNode.next;
                }
                ret = preNode.next.data;
                preNode.next = preNode.next.next;

                this.length--;
            }
            else {
                console.log("index error");
            }

            return ret;
        }


        linkedList.prototype.peek = function (position) {

            var ret = null;
            var position = position == undefined ? 0 : position;
            if (this.isEmpty()) {
                console.log("list is Empty");
            }
            else if (position < this.length) {
                var preNode = this.headNode;

                for (i = 0; i < position; i++) {
                    preNode = preNode.next;

                }
                ret = preNode.next.data;

            }
            else {
                console.log("index error");
            }

            return ret;
        }
         //var inode = routeItem.headNode.next;
        linkedList.prototype.print = function () {

            $("#route").empty();
            
            var inode = this.headNode.next;
            while (inode != null) {
         
                var str = document.createElement('input');
                
                str.type = "button";
                //str.addEventListener('click', deleteNode(inode, cnt));
                (function (inode) {
                    str.addEventListener("click", function () {
                        alert(inode.name + " " + cnt);
                    });            
                })(inode);

        
                str.value = inode.name;
                route.appendChild(str);

                if (inode.next != null) {
                    var obj = document.createElement('input');
                   
                    obj.type = "button";
                   // obj.onclick = showRoute(node, node.next);
                    obj.value = "->";
                    route.appendChild(obj);       
                    (function (inode, nextinode) {
                        obj.addEventListener("click", function () {
                            //alert(inode.name + nextinode.name);
                            sendParameterToSearchRoute(inode, nextinode);
                        });
                    })(inode, inode.next);

                }
               
                inode = inode.next;
            };

        }


        linkedList.prototype.isEmpty = function () {
            var ret = false;
            if (!this.length) {
                ret = true;
            }
            return ret;
        }

        function deleteNode(node, cnt) {
            alert(node.name + " " + cnt);
        }

        function showRoute(node, nextnode) {
            alert(node.name + " " + nextnode.name);
        }

        function initMap() {
            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            var options = { //지도를 생성할 때 필요한 기본 옵션
                center: new daum.maps.LatLng(37.561143,126.985856 ), //지도의 중심좌표.
                level:6,//지도의 레벨(확대, 축소 정도)
            };
            map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
            getMyLocation(); // gps에서 사용자 위치 따와 마커로 표시
            setTile(); // 화면 선으로 분할 

            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
            var zoomControl = new daum.maps.ZoomControl();
            map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

            // zoom 변할 때 마다, 화면 분할 함수 호출
            daum.maps.event.addListener(map, 'zoom_changed', function () {
                setTile();                            
            });

            daum.maps.event.addListener(map, 'idle', searchPlaces);

            // 커스텀 오버레이 컨텐츠를 설정합니다
            placeOverlay.setContent(contentNode);
        }

        function drawCenterMarker() { // center마커 그리는 함수  
            if (centerMarker != null) centerMarker.setMap(null);
            if (centerInfowindow != null) centerInfowindow.close();
            var center3words;

            $.ajax({
                url: 'range_find_ajax.asp',
                type: 'get',
                data: 'x_center=' + centerLatlng.getLat() + '&y_center=' + centerLatlng.getLng(),
                success: function (data) {
                    center3words = data;

                    var content = '<div style="padding:5px;">' + center3words + '</div>';

                    centerMarker = new daum.maps.Marker({
                        map: map,
                        position: centerLatlng
                    });

                    centerInfowindow = new daum.maps.InfoWindow({
                        content: content,
                        position: centerLatlng
                    });
                    centerInfowindow.open(map, centerMarker);
                }
            });
        }

        function setTile() {  // Tile 그리기 함수
            // 지도의 현재 레벨을 얻어옵니다
            var level = map.getLevel();
            map.removeOverlayMapTypeId(daum.maps.MapTypeId.TILE_NUMBER);

            if (level <= 7) { // ZOOM-LEVLE 7 = 1km
                daum.maps.Tileset.add('TILE_NUMBER',
                    new daum.maps.Tileset({
                        width: 125,
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

        function drawMyPositionMarker(position) { // 사용자 gps 위치에 마커찍기 

            var coords = new daum.maps.LatLng(position.coords.latitude, position.coords.longitude); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

            if (myPositionInfowindow != null) myPositionInfowindow.close();

            var contents = '<div style="padding:5px;">내 위치</div>';

            myPositionInfowindow = new daum.maps.InfoWindow({
                content: contents,
                position: coords
            });

            if (myPositionMarker != null) myPositionMarker.setMap(null);
            myPositionMarker = new daum.maps.Marker({
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

            myPositionInfowindow.open(map, myPositionMarker);
        }

        function getMyLocation() {
            myPosition = navigator.geolocation.watchPosition(drawMyPositionMarker, error);
        }

        function moveCamera(lat, lng) {     // camera 이동 
            var moveLocation = new daum.maps.LatLng(lat, lng);
            map.panTo(moveLocation);
        }

        function describeSearchType() {
            if (destinationMarker != null) destinationMarker.setMap(null);
            var Option = $("#selectOption option:selected").val();
            if (Option == 1) originalSearch();
            else if (Option == 2) threeWordsSearch();
        }

        function originalSearch() {   // 1.주소로 검색
            var addressSpace = document.getElementById('addressSpace').value;

            geocoder.geocode({ 'address': addressSpace },   // google Map으로 주소 검색하여, 좌표값 받아 Daum 맵에 표출 

                function (results, status) {
                    if (results != "") {
                        var location = results[0].geometry.location;
                        var coords = new daum.maps.LatLng(location.lat(), location.lng());
                        destinationMarker = new daum.maps.Marker({
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

        function threeWordsSearch() { // 2. 3words로 검색
            var threeWords = document.getElementById('addressSpace').value;
            $.ajax({
                url: 'search_ajax.asp',
                type: 'get',
                data: 'word=' + threeWords,
                success: function (data) {   
                    var dataArray = data.split(',');
                    var coords = new daum.maps.LatLng(dataArray[0], dataArray[1]);
                    destinationMarker = new daum.maps.Marker({
                        map: map,
                        position: coords
                    });
                   // console.log(data);
                    moveCamera(dataArray[0], dataArray[1]);
                }
            });
            autoGpsFlag = 1;
        }

        function error(error) { // error 출력 
            console.log("error= " + error);
        }

        // 카테고리 검색을 요청하는 함수
        function searchPlaces() {
            centerLatlng = map.getCenter();
            currentBound = map.getBounds();
            drawCenterMarker();

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
                //console.log(data);
                // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                displayPlaces(data);
            } else if (status === daum.maps.services.Status.ZERO_RESULT) {
                // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
                console.log("장소가 검색되지 않습니다");
            } else if (status === daum.maps.services.Status.ERROR) {
                // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
                console.log("에러가 발생했습니다");
            }
        }

        // 지도에 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var order = document.getElementById(currCategory).getAttribute('data-order');

            //console.log(places.length);

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

        // 지도 위에 표시되고 있는 카테고리 관련 마커를 모두 제거
        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);         
            }
            markers = []; 
        }

        // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
        function displayPlaceInfo(place) {
            var name = place.place_name;
            var content = '<div class="placeinfo">' +
                '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

            if (place.road_address_name) {
                content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
            } else {
                content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
            }

            content += '    <span class="tel" >' + place.phone + '<input type="button" id="' + name + '"value="+" onclick="addRoute(this.id' + ',' + place.x + ',' + place.y + ')" /></span>' +
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

        function addRoute(name, x, y) { // linked list에 항목 이름, x,y node로 만들어 추가 
            routeItem.add(name, x, y);
            routeItem.print(); // 아래 div안에 linked list data들 전부 출력 
        }

        // 경로 탐색시 가장 먼저 실행되는 함수 
        function sendParameterToSearchRoute(startnode, endnode) {
            //var node = routeItem.headNode.next;

            /* 화면 clear */
            routeCount = 0;
            for (var i = 0; i < routeMarker.length; i++)routeMarker[i].setMap(null);

            currCategory = "";
            removeMarker();
            if (startMarker != null) startMarker.setMap(null);
            if (endMarker != null) endMarker.setMap(null);
            if (polyline != null) {
                //alert("a");
                polyline.setMap(null);
            }
            printSelectedCategoryMarker(startnode, endnode); 
            placeOverlay.setMap(null);
            searchRoute(startnode, endnode);
        }

        function printSelectedCategoryMarker(startnode,endnode) {  // startnode, endmarker 
    
            startMarker = new daum.maps.Marker({
                map: map,
                position: new daum.maps.LatLng(startnode.y, startnode.x),
                image: new daum.maps.MarkerImage(
                    'http://t1.daumcdn.net/localimg/localimages/07/2013/img/red_b.png',
                    new daum.maps.Size(31, 35), new daum.maps.Point(13, 34))
            });
            startMarker.setTitle(startnode.name);

            endMarker = new daum.maps.Marker({
                map: map,
                position: new daum.maps.LatLng(endnode.y, endnode.x),
                image: new daum.maps.MarkerImage(
                    'http://t1.daumcdn.net/localimg/localimages/07/2013/img/blue_b.png',
                    new daum.maps.Size(31, 35), new daum.maps.Point(13, 34))
            });
            endMarker.setTitle(endnode.name);
        }

        // 재귀적으로 호출하여 사용 
        function searchRoute(startnode, endnode) {
            var xhr = new XMLHttpRequest();
            // ajax로 출발-도착지 간 대중 교통 정보 요청 - opt=0 최단거리 
            var url = "https://api.odsay.com/v1/api/searchPubTransPath?OPT=0&SX=" + startnode.x + "&SY=" + startnode.y + "&EX=" + endnode.x + "&EY=" + endnode.y + "&apiKey=" + apikey;
            xhr.open("GET", url, true);
            xhr.send();
            xhr.onreadystatechange = function () {          
                if (xhr.readyState == 4 && xhr.status == 200) {
                    //노선그래픽 데이터 호출
                    detailRouteSearch(JSON.parse(xhr.responseText), startnode, endnode);
                    }
            }

        }


        function detailRouteSearch(result, startnode, endnode) {
            var xhr = new XMLHttpRequest();

            drawdetail(result["result"]["path"][0].info.mapObj, startnode, endnode);
            console.log(result["result"]["path"]);
            //alert("traffic type = " + result["result"]["searchType"]);
            if (result["result"]["searchType"] == 0) { // 도시내
                console.log("subpath.length = " + result["result"]["path"][0].subPath.length); 
                for (var i = 0; i < result["result"]["path"][0].subPath.length; i++) {
                 
                    if (result["result"]["path"][0].subPath[i].trafficType == 1 || result["result"]["path"][0].subPath[i].trafficType == 2) { // 지하철
                        
                        drawTransitMarker(0, routeMarker, result["result"]["path"][0].subPath[i]);
                            //result["result"]["path"][0].subPath[i].startX, result["result"]["path"][0].subPath[i].startY, result["result"]["path"][0].subPath[i].endX, result["result"]["path"][0].subPath[i].endY, result["result"]["path"][0].subPath[i].startName, result["result"]["path"][0].subPath[i].endName);
                        // type, 탑승/하차 표시 마커, 탑승 x, 탑승 y, 하차 x, 하차 y, 탑승하는 곳 이름, 하차하는 곳 이름
                    }
                    else if (result["result"]["path"][0].subPath[i].trafficType == 3) { // 도보
                        //alert("도보로 이동");

                                 
                    }

                }
            }

            else if (result["result"]["searchType"] == 1) { // 도시간 직통

            }

            else if (result["result"]["searchType"] == 2) { // 도시간 환승

            }

        }
        //function drawTransitMarker(type,routeMarker, startx, starty, endx,endy,startname,endname) {

        function drawTransitMarker(type, routeMarker, object) {
            var startx = object.startX;
            var starty = object.startY;
            var endx = object.endX;
            var endy = object.endY;
            var startname = object.startName;
            var endname = object.endName;
            //console.log("a" + object);
            
            
            routeMarker[routeCount] = new daum.maps.Marker({  // 탑승 지점 마커
                position: new daum.maps.LatLng(starty, startx),
                map: map,
            });


            routeMarker[routeCount+1] = new daum.maps.Marker({  // 하차 지점 마커
                position: new daum.maps.LatLng(endy, endx),
                map:map
            });
            //console.log("rc= " + routeCount);

            
            var content = startname + '에서 승차 후 ' + endname + '에서 하차';
            routeinfowindow[routeCount] = new daum.maps.InfoWindow({
                content: content,
                position: new daum.maps.LatLng(starty, startx)
            });
     
           
      
          

            (function (routeMarker, routeinfowindow,checkOpenRouteinfowindow, routeCount) {
                console.log("routeCount =" + routeCount);
                console.log("content= " + content);
         
                //alert(checkOpenRouteinfowindow);
                daum.maps.event.addListener(routeMarker, "click", function () {
                    //alert("check" + checkOpenRouteinfowindow);
                    //alert(routeCount);
                    /* flag이용해 infowindow on/off 클릭이벤트 조절 */
                    if (checkOpenRouteinfowindow == 0 || checkOpenRouteinfowindow == undefined) {
                        routeinfowindow.open(map, routeMarker);
                        checkOpenRouteinfowindow = 1;
                    }
                    else {
                        routeinfowindow.setMap(null);
                        checkOpenRouteinfowindow = 0;
                    }

                    });
            })(routeMarker[routeCount], routeinfowindow[routeCount],checkOpenRouteinfowindow[routeCount],routeCount);

            routeMarker[routeCount].setTitle(startname); //+ "에서 출발하여 " + endname + "에서 하차");
            routeMarker[routeCount + 1].setTitle(endname);

            routeCount++;
        }


        function drawdetail(mapObj, startnode, endnode) {  // 선그리기
            
            var xhr = new XMLHttpRequest();
            var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@" + mapObj + "&apiKey=" + apikey;
            xhr.open("GET", url, true);
            xhr.send();
            xhr.onreadystatechange = function () {
;                if (xhr.readyState == 4 && xhr.status == 200) {
                    var resultJsonData = JSON.parse(xhr.responseText);
                       drawPolyLine(resultJsonData);		// 노선그래픽데이터 지도위 표시
                }
            }
        }

        // 노선그래픽 데이터를 이용하여 지도위 폴리라인 그려주는 함수
        function drawPolyLine(data) {
            var lineArray;
            for (var i = 0; i < data.result.lane.length; i++) {

                for (var j = 0; j < data.result.lane[i].section.length; j++) {
                    lineArray = null;
                    lineArray = new Array();
                    for (var k = 0; k < data.result.lane[i].section[j].graphPos.length; k++) {
                        lineArray.push(new daum.maps.LatLng(data.result.lane[i].section[j].graphPos[k].y, data.result.lane[i].section[j].graphPos[k].x));
                    }
                    polyline = new daum.maps.Polyline({
                        map: map,
                        path: lineArray,
                        strokeWeight: 5,
                        strokeColor: '#CC0033'
                    });

                }
            }
        }
        addCategoryClickEvent();
    </script>


    <!-- #include virtual="/_include/connect_close.inc" -->
</body>


</html>
