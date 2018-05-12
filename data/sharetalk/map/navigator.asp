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

    <link rel="stylesheet" href="/_css/bootstrap.min.css">
    <link rel="stylesheet" href="../_include/navigator.css" />
    
    <style>
        .btnTime {
            background-color: #9DB81A;
            -webkit-border-radius: 10;
            -moz-border-radius: 10;
            border-radius: 10px;
            font-family: Arial,맑은 고딕,돋움;
            color: #ffffff;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            text-decoration: solid;
            display: inline-block;
            width: 60px;
            padding: 5px 10px 5px 10px;
            border: solid #9DB81A 2px;
            text-decoration: none;
        }

        #popupAlertPosition {
            top: 0;
            left: 0;
            position: fixed;
            width: 100%;
            height: 120%;
            border-radius: 10px;
            background-color: rgba(0,0,0,0.7);
            display: none;
            z-index: 4;
        }

        #popupAlertHeader {
            font-size: 16px;
            font-weight: bold;
            font-family: Arial, 맑은 고딕, 돋움;
            text-align: center;
            vertical-align: middle;
            padding: 10px;
            height: 30px;
            border-radius: 10px 10px 0px 0px;
            color: #ffffff;
            background-color: #939393;
            background: linear-gradient(#939393, #424242);
        }

        #popupAlertWrapper {
            width: 250px;
            margin: 100px auto;
            text-align: left;
            border-radius: 10px;
        }

        #popupAlertContent {
            background-color: #FFF;
            padding: 15px;
            border-radius: 0px 0px 10px 10px;
        }
		
		#popupBoxOnePosition{
			top: 0; left: 0; position: fixed; width: 100%; height: 120%;
			background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
		}
		#popupBoxDelete{
			top: 0; left: 0; position: fixed; width: 100%; height: 120%;
			background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
		}
		#popupBoxTwoPosition{
			top: 0; left: 0; position: fixed; width: 100%; height: 120%;
			background-color: rgba(0,0,0,0.7); display: none;
		}#popupBoxThreePosition{
			top: 0; left: 0; position: fixed; width: 100%; height: 120%;
			background-color: rgba(0,0,0,0.7); display: none;
		}
		.popupBoxWrapper{
			width: 300px; margin: 0px; text-align: left;position:absolute;top:50px;left:30px;border-radius:0px;
		}
		.popupBoxContent{
			background-color: #FFF; padding: 0px;border-radius:2px;
		}
    </style>

    <!-- //라는 상대 프로토콜 사용하면 사용자의 http, https 환경에 따라 자동으로 해당 프로토콜을 따라간다 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?&appkey=9a9b328e41d45bb4d7c639a649707e2d&libraries=services,clusterer,drawing"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc"></script>
    <script type="text/javascript" src="../_script/navigator.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script>
		function toggle_visibility(id) {
			var e = document.getElementById(id);
			if (e.style.display == 'block')
				e.style.display = 'none';
			else
				e.style.display = 'block';
		}
	</script>
    




</head>
<body onload="initMap()">
	
    <!-- #include virtual="/_include/top_menu_map.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
	<div style="margin:90px 0 10px 0;">
		<table width=100%>
			<tr>
				<td width=50%>
					<div style="margin:5px">
						<input type="text" id="my_position" class="form-control" disabled>
					</div>
					</td>
				<td width=50%>
					<div style="margin:5px">
						<input type="text" class="form-control" id="destination3Words" disabled>
					</div>
				</td>
			</tr>
			<tr>
				<td width=100% colspan="2">
					<div style="margin:5px">
						<textarea class="form-control" style="overflow-y: hidden; overflow-x: hidden" disabled></textarea>
					</div>
				</td>
			</tr>
		</table>
		<table width=100%>
			<tr>
				<td>
					<div style="clear:both;height:10px"></div>
					<div id="route"></div><input type="button" style="float: right" value="경로 저장" />
				</td>
			</tr>
		</table>
	</div>
    <div style="margin-top: 100px" class="container-fluid">
        <div class="row">
			
			<div style="clear:both;height:5px"></div>
            <div class="col-lg-12" id="map" style="box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">


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
                    <li>
                        <input type="button" value="내 위치" onclick="backToMyPosition()" style="z-index: 3" />
                    </li>
                </ul>


            </div>

        </div>

        <div class="row">
            <div class="col-xs-12 col-sm-12" id="photo">
                <div>
                    

                </div>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-12">
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


    <div id="popupAlertPosition">
        <div id="popupAlertWrapper">
            <div id="popupAlertHeader">
                What3Words
            </div>
            <div id="popupAlertContent">
                <table width="100%" border="0" style="padding: 0; margin: 0; border-color: gray">
                    <tr>
                        <td style="text-align: center; height: 40px;"><span id="alerttext"></span>
                        </td>
                    </tr>
                </table>
                <br />
                <table width="100%" border="0" style="padding: 0px; margin: 0px;">
                    <tr>
                        <td style="text-align: justify;" id="customAlert">
                            <!-- <a href="javascript:void(0)" onclick="toggleAlert();"><span class="btnTime">OK</span></a> -->
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        var map;  // 지도 변수 
        var myPosition; // gps로 따오는 내 위치
        var myPositionMarker; // gps로 따오는 내 위치에 찍는 마커
        var myPositionInfowindow;
        var coords;

        var destinationMarker; // 검색시 찍는 마커

        var centerMarker; // 지도 조작시 지도의 중앙에 찍는 마커
        var centerLatlng; // 중심 lat, lng
        var centerInfowindow; // 중심 infowindow


        var autoGpsFlag = 0;
        var geocoder = new google.maps.Geocoder(); // 주소 검색 google 이용 

        var currentBound;


        var count = 0;

        // var apikey = encodeURIComponent("nxb4coDQx0Z6d7mjF6RT+g");



        var select = 0;

        var startRouteMarker = [];
        var startRouteCount = 0;
        var endRouteMarker = [];
        var endRouteCount = 0;

        var routeinfowindow = [];
        var checkOpenRouteinfowindow = [];

        var startMarker, endMarker;
        var polyline = [];
        var polylineCount = 0;

        var walkingPolyline = [];
        var walkingPolylineCount = 0;

        var mouseMarker = [];
        var mouseMarkerCount = 0;
        var mouse3words = [];
        var mouseInfowindow = [];
        var checkOpenMouseinfowindow = [];

        var placeOverlay = new daum.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
            markers = [], // 마커를 담을 배열입니다
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
        var ps = new daum.maps.services.Places(map);

     //   var tmap = "ff86385d-b74a-429a-b76b-72e1d7ca293a";
        var headers = {}; 
        headers["appKey"] = encodeURIComponent("2ef43265-0641-4807-aa97-e00e7f22ad19");

        var node = function (name, x, y) {
            this.name = name;
            this.x = x;
            this.y = y;
            this.next = null;
        }

        var objectNode = function (object) {
            //function objectNode(object) {
            this.object = object;
            this.next = null;
        }

        var linkedList = function () {
            this.length = 0;
            this.headNode = new node(null);
        }
        /*
        var objectLinkedList = function () {
            this.length = 0;
            this.headNode = new objectNode(null);
        }
        */
        var routeItem = new linkedList();
        /*
        var str = new objectLinkedList();
        var obj = new objectLinkedList();
        var strcnt = 1;
        var objcnt = 1;
        */

        str = [];
        obj = [];
        var strcnt = 0;
        var objcnt = 0;

        /*
        objectLinkedList.prototype.add = function (object, position) {
            var position = position == undefined ? this.length + 1 : position;
           // alert("c");
            var newObjectNode = new objectNode(object);
            //alert("d");
            
            var preNode = this.headNode;
            for (i = 1; i < position; i++) {
                preNode = preNode.next;
            }
            newObjectNode.next = preNode == null ? null : preNode.next;
            preNode.next = newObjectNode;

          //  alert(position);
            this.length++;
        }
        objectLinkedList.prototype.peek = function (position) {
          //  alert(position);
           // alert(this.length);
            var ret = null;
            var position = position == undefined ? 0 : position;
            
            
            if (this.isEmpty()) { // 링크드리스트가 비었으면
                console.log("list is Empty");
            }
            else if (position < this.length) { 
                var preNode = this.headNode;

                for (i = 0; i < position; i++) {
                    preNode = preNode.next;

                }
                ret = preNode.next.objet;

            }
            else {
                console.log("index error");
            }

            return ret;
        }
        objectLinkedList.prototype.remove = function (position) {
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

        objectLinkedList.prototype.isEmpty = function () {
            var ret = false;
            if (!this.length) {
                ret = true;
            }
            return ret;
        }
        */
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

                str[strcnt] = document.createElement('input');
                str[strcnt].type = "button";
         
                str[strcnt].value = inode.name;

                route.appendChild(str[strcnt]);



                if (inode.next != null) {
                    obj[objcnt] = document.createElement('input');
                    obj[objcnt].type = "button";
                    // obj.onclick = showRoute(node, node.next);
					obj[objcnt].style = "padding:0 5px;margin:0 5px;";
                    obj[objcnt].value = "->";

                    (function (str, strcnt, obj, inode) {
                        str[strcnt].addEventListener("click", function () {
                            deleteNode(str, strcnt, obj, inode);
                            // alert(inode.name + " " + strcnt);
                        });
                    })(str, strcnt++, obj, inode);
           
                    route.appendChild(obj[objcnt]);

                    
                    (function (inode, nextinode, objcnt) {
                        $(obj[objcnt]).on("click", function () {
                            sendParameterToSearchRoute(inode, nextinode);
                        });

                    })(inode, inode.next, objcnt);

                    objcnt++;

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

        function deleteNode(str, strcnt, obj, inode) {
            //  alert(node.name + " " + cnt);

            route.removeChild(str[strcnt]);
            //alert(obj[strcnt]);
            if (obj[strcnt] != undefined || obj[strcnt] != "" || obj[strcnt] != 0)
                route.removeChild(obj[strcnt]);

            //var dummy = routeItem.headNode.next;
            var preNode = routeItem.headNode;
            while (preNode.next != inode) preNode = preNode.next;


            while (inode != null) {
                if (inode.name == str[strcnt].value) {
                    //alert("A");
                    preNode.next = inode.next;
                    inode = null;

                    //obj[strcnt - 1].removeEventListener("click", sendParameterToSearchRoute);
                    //obj[strcnt - 1].onclick = null;


                    $(obj[strcnt-1]).off("click");
                      $(obj[strcnt-1]).on("click", function () {
                            sendParameterToSearchRoute(preNode, preNode.next);
                        });

                    break;
                }
                inode = inode.next;
                preNode = preNode.next;
            }
            str[strcnt] = null;
            obj[strcnt] = null;
            routeItem.length--;
            clearScreen();

        }

        function callback(inode, nextinode) {
         sendParameterToSearchRoute(inode, nextinode);
        }

        function serach() {
             $.ajax({
                url : 'http://192.168.0.14:8000/test',
                data : { "member_no": <%=Session("member_no")%>},
                type : 'post',
                success:function(response) {
                    document.getElementById("output").value = response.data;
                }
             })
        }

        function initMap() {
            serach()
            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            var options = { //지도를 생성할 때 필요한 기본 옵션
                center: new daum.maps.LatLng(37.561143, 126.985856), //지도의 중심좌표.
                level: 6,//지도의 레벨(확대, 축소 정도)
                disableDoubleClickZoom: true
            };
            map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
     
           // alert(tmap);

            getMyLocation(); // gps에서 사용자 위치 따와 마커로 표시
            setTile(); // 화면 선으로 분할 

            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
            var zoomControl = new daum.maps.ZoomControl();
            map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

            // zoom 변할 때 마다, 화면 분할 함수 호출
            daum.maps.event.addListener(map, 'zoom_changed', function () {
                setTile();
                if (centerMarker != null) centerMarker.setMap(null);
            });

            daum.maps.event.addListener(map, 'idle', searchPlaces);

            daum.maps.event.addListener(map, 'dblclick', function (mouseEvent) {

                $.ajax({
                    url: 'range_find_ajax.asp',
                    type: 'get',
                    data: 'x_center=' + mouseEvent.latLng.getLat() + '&y_center=' + mouseEvent.latLng.getLng(),
                    success: function (data) {
                        mouse3words[mouseMarkerCount] = data;

                        var content = '<div style="padding:5px;">' + mouse3words[mouseMarkerCount] + '</div>';

                        mouseMarker[mouseMarkerCount] = new daum.maps.Marker({
                            map: map,
                            position: new daum.maps.LatLng(mouseEvent.latLng.getLat(), mouseEvent.latLng.getLng())
                        });

                        mouseInfowindow[mouseMarkerCount] = new daum.maps.InfoWindow({
                            content: content,
                            position: mouseEvent.latLng
                        });
                        (function (mouseMarker, mouseInfowindow,mouse3words) {
                            
                            mouseMarker.addListener("click", function () {

                                var e = document.getElementById("popupAlertPosition");
                                if (e.style.display == 'block')
                                    e.style.display = 'none';
                                else
                                    e.style.display = 'block';

                                document.getElementById("alerttext").innerHTML = "'" + mouse3words + "'를 경로에 추가하시겠습니까?";
                                var t = $("<a href='javascript:void(0)' id = " + mouse3words + " onclick='addRoute(this.id," + mouseMarker.getPosition().getLng() + "," + mouseMarker.getPosition().getLat() + ")'><span class='btnTime'>OK</span></a>");
                                $("#customAlert").append(t);
                                var t = $("<a href='javascript:void(0)' onclick='closePopUp();'><span class='btnTime'>NO</span></a>");
                                $("#customAlert").append(t);




                                //mouseMarker.setMap(null);
                                //mouseInfowindow.close();
                            });
                            
                            /*
                            $(mouseMarker).on("click", function () {
                                mouseMarker.setMap(null);
                                mouseInfowindow.close();
                            });
                            */
                        })(mouseMarker[mouseMarkerCount], mouseInfowindow[mouseMarkerCount],mouse3words[mouseMarkerCount]);


                        mouseInfowindow[mouseMarkerCount].open(map, mouseMarker[mouseMarkerCount]);
                        mouseMarkerCount++;
                    }
                });

                //    },2000);
            });

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

                    (function (center3words, centerLatlng) {
                        daum.maps.event.addListener(centerMarker,'click', function () {


                        var e = document.getElementById("popupAlertPosition");
                        if (e.style.display == 'block')
                            e.style.display = 'none';
                        else
                            e.style.display = 'block';

                        document.getElementById("alerttext").innerHTML = "'"+center3words + "'를 경로에 추가하시겠습니까?";
                        var t = $("<a href='javascript:void(0)' id = "+center3words+" onclick='addRoute(this.id," + centerLatlng.getLng() + "," + centerLatlng.getLat()+ ")'><span class='btnTime'>OK</span></a>");
                        $("#customAlert").append(t);
                        var t = $("<a href='javascript:void(0)' onclick='closePopUp();'><span class='btnTime'>NO</span></a>");
                        $("#customAlert").append(t);
                        });

                    })(center3words, centerLatlng);
                    
                        
                
                    
                    centerInfowindow = new daum.maps.InfoWindow({
                        content: content,
                        position: centerLatlng
                    });
                    
                    centerInfowindow.open(map, centerMarker);
                }
            });
        }
        function closePopUp() {
            $("#customAlert").empty();
            var e = document.getElementById("popupAlertPosition");
            if (e.style.display == 'block')
                e.style.display = 'none';
            else
                e.style.display = 'block';
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

            coords = new daum.maps.LatLng(position.coords.latitude, position.coords.longitude); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

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

        function backToMyPosition() {  // 내 위치로 복귀
            //alert(coords);
            if (coords == undefined) { alert("GPS에 연결할 수 없습니다"); return; }
            else moveCamera(position.coords.latitude, position.coords.longitude);
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
            console.log("error= " + error.code);
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

            content += '    <span class="tel" >' + place.phone + '<input type="button" style="margin-left:10px;padding:2px 8px;" id="' + name + '"value="+" onclick="addRoute(this.id' + ',' + place.x + ',' + place.y + ')" /></span>' +
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
            $("#customAlert").empty();
            var e = document.getElementById("popupAlertPosition");
            if (e.style.display == 'block')  // popup close
                e.style.display = 'none';
           
            routeItem.add(name, x, y);
            routeItem.print(); // 
        }
        function clearScreen() {
            /* 화면 clear */
            //alert("a");
            startRouteCount = 0;
            endRouteCount = 0;
            select = 0;
            for (var i = 0; i < startRouteMarker.length; i++)startRouteMarker[i].setMap(null);
            for (var i = 0; i < endRouteMarker.length; i++) endRouteMarker[i].setMap(null);
            for (var i = 0; i < routeinfowindow.length; i++) routeinfowindow[i].close();
            

            currCategory = "";
            removeMarker();
            if (startMarker != null) startMarker.setMap(null);
            if (endMarker != null) endMarker.setMap(null);

            for (var i = 0; i < polyline.length; i++)  polyline[i].setMap(null);
            for (var i = 0; i < walkingPolyline.length; i++) walkingPolyline[i].setMap(null);
            
            polylineCount = 0;
            walkingPolylineCount = 0;
            placeOverlay.setMap(null);
        }

        // 경로 탐색시 가장 먼저 실행되는 함수 
        function sendParameterToSearchRoute(startnode, endnode) {
            //var node = routeItem.headNode.next;

            //alert(startnode.name + endnode.name);


            clearScreen();
            printSelectedCategoryMarker(startnode, endnode);
            searchRoute(startnode, endnode);
            moveCamera(startnode.y, startnode.x);
;            // printSelectedCategoryMarker(startnode, endnode); 

            //searchRoute(startnode, endnode);
        }

        function printSelectedCategoryMarker(startnode, endnode) {  // startnode, endmarker 

            startMarker = new daum.maps.Marker({
                map: map,
                position: new daum.maps.LatLng(startnode.y, startnode.x),
                image: new daum.maps.MarkerImage(
                    'http://t1.daumcdn.net/localimg/localimages/07/2013/img/red_b.png',
                    new daum.maps.Size(40, 36), new daum.maps.Point(13, 34))
            });
            startMarker.setTitle(startnode.name);
          //  alert(startMarker.getTitle());
            endMarker = new daum.maps.Marker({
                map: map,
                position: new daum.maps.LatLng(endnode.y, endnode.x),
                image: new daum.maps.MarkerImage(
                    'http://t1.daumcdn.net/localimg/localimages/07/2013/img/blue_b.png',
                    new daum.maps.Size(40, 36), new daum.maps.Point(13, 34))
            });
            endMarker.setTitle(endnode.name);
        }

    
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
           
              console.log(result["result"]);

            //console.log("search type=\n" + result["result"]["searchType"]);
            //console.log(result["result"]["path"]);
            //alert("traffic type = " + result["result"]["searchType"]);
            if (result["result"]["searchType"] == 0) { // 도시내
                drawdetail(result["result"]["path"][0].info.mapObj, startnode, endnode);
                // console.log("subpath.length = " + result["result"]["path"][0].subPath.length); 
                for (var i = 0; i < result["result"]["path"][0].subPath.length; i++) {

                    if (result["result"]["path"][0].subPath[i].trafficType == 1 || result["result"]["path"][0].subPath[i].trafficType == 2) { // 지하철

                        drawTransitMarker(0, startRouteMarker, endRouteMarker, result["result"]["path"][0].subPath[i]);
                        //result["result"]["path"][0].subPath[i].startX, result["result"]["path"][0].subPath[i].startY, result["result"]["path"][0].subPath[i].endX, result["result"]["path"][0].subPath[i].endY, result["result"]["path"][0].subPath[i].startName, result["result"]["path"][0].subPath[i].endName);
                        // type, 탑승/하차 표시 마커, 탑승 x, 탑승 y, 하차 x, 하차 y, 탑승하는 곳 이름, 하차하는 곳 이름
                    }
                    else if (result["result"]["path"][0].subPath[i].trafficType == 3) { // 도보
                        //alert("도보로 이동");
                        //drawTransitMarker(1, startRouteMarker, endRouteMarker, result["result"]["path"][0].subPath[i]);
                    }

                }

                

            }

            else if (result["result"]["searchType"] == 1) { // 도시간 직통 -> 상세 경로 루트 좌표가 안나옴 (출발지 - 역) - 직선 - (역 - 도착지)
                //console.log(result["result"]);


                var e = document.getElementById("popupAlertPosition");
                if (e.style.display == 'block')
                    e.style.display = 'none';
                else
                    e.style.display = 'block';

                document.getElementById("alerttext").innerHTML = "보고 싶은 경로를 선택해주세요";

                var airplaneCount = 0, exbusCount = 0, outbusCount = 0, trainCount = 0;


                if (result["result"].airRequest.count != undefined || result["result"].airRequest.count != 0) { // 비행기
                    var t = $("<a href='javascript:void(0)' onclick='selectNavigateType();'><span class='btnTime'>비행기</span></a>");
                    $("#customAlert").append(t);
                    /*
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
                    */

                }
                // 고속버스
                if (result["result"].exBusRequest.count != undefined || result["result"].exBusRequest.count != 0) {
                    /*
                    var t = $("<a href='javascript:void(0)' onclick='selectNavigateType();'><span class='btnTime'>고속 버스</span></a>");
                    $("#customAlert").append(t);
                    */

                    //<a href="javascript:void(0)" onclick="toggleAlert();"><span class="btnTime">OK</span></a>
                }

                // 시외버스
                if (result["result"].outBusRequest.count != undefined || result["result"].outBusRequest.count != 0) {
                    /*
                    var t = $("<a href='javascript:void(0)' onclick='selectNavigateType();'><span class='btnTime'>시외 버스</span></a>");
                    $("#customAlert").append(t);
               */
                }

                // 기차
                if (result["result"].trainRequest.count != undefined || result["result"].trainRequest.count != 0) {
                    /*
                    var t = $("<a href='javascript:void(0)' onclick='selectNavigateType();'><span class='btnTime'>기차</span></a>");
                    $("#customAlert").append(t);
                */
                }
                /*
                var t = $("<a href='javascript:void(0)' onclick='selectNavigateType();'><span class='btnTime'>취소</span></a>");
                $("#customAlert").append(t);
                */





            }

            else if (result["result"]["searchType"] == 2) { // 도시간 환승
                // console.log(result["result"]["path"]);

            }


            WalkingMarker(startRouteMarker, endRouteMarker);

        }

        function drawTransitMarker(type, startRouteMarker, endRouteMarker, object, startnode, endnode) {
                var startx = object.startX;
                var starty = object.startY;
                var endx = object.endX;
                var endy = object.endY;
                var startname = object.startName;
                var endname = object.endName;
                //console.log("a" + object);


                startRouteMarker[startRouteCount] = new daum.maps.Marker({  // 탑승 지점 마커
                    position: new daum.maps.LatLng(starty, startx),
                    map: map,
                });

                endRouteMarker[endRouteCount] = new daum.maps.Marker({  // 하차 지점 마커
                    position: new daum.maps.LatLng(endy, endx),
                    map: map
                });


                //console.log("rc= " + routeCount);

                if (object.trafficType == 1) { // subway
                    var content = startname + '역 에서 ' + object.passStopList.stations[1].stationName + '역 방향 ' + object.lane[0].name + ' 열차 승차 후 ' + endname + '역 에서 하차\n';
                    content += '소요 시간= ' + object.sectionTime + ' 분';
                }

                else if (object.trafficType == 2) { // bus
                    var content = startname + '에서 ' + object.lane[0].busNo + '번 승차 후 ' + endname + '에서 하차\n';
                    content += '소요 시간 = ' + object.sectionTime + '분';

                }


                routeinfowindow[startRouteCount] = new daum.maps.InfoWindow({
                    content: content,
                    position: new daum.maps.LatLng(starty, startx)
                });


                (function (routeMarker, routeinfowindow, checkOpenRouteinfowindow, routeCount) {
                    //   console.log("routeCount =" + routeCount);
                    //  console.log("content= " + content);

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
                })(startRouteMarker[startRouteCount], routeinfowindow[startRouteCount], checkOpenRouteinfowindow[startRouteCount], startRouteCount);

                startRouteMarker[startRouteCount].setTitle(startname); //+ "에서 출발하여 " + endname + "에서 하차");
                endRouteMarker[endRouteCount].setTitle(endname);

                startRouteCount++;
                endRouteCount++;
          


        }
        function WalkingMarker(startRouteMarker, endRouteMarker) {  // tamp 도보 api 
            var i = 0;
       //     for (var i = 0; i < endRouteCount + 1; ) {
                //  alert(endRouteCount + " " + i);
                //i가 넘어가서
            // ajax 비동기라서
            console.log(endRouteCount);
            var t = setInterval(function () { 
                console.log("i = " + i);
                if (i == endRouteCount) clearInterval(t);
                

                    if (i == 0) {  // startmarker - startRoutemarker[first]
                        //  alert(startMarker.getPosition().getLat());
                        //  alert(startRouteMarker[i].getPosition());
                        // console.log(startMarker.getPosition());

                         
                        
                        drawWalkingMarker(startMarker, startRouteMarker[i]);
                        //console.log(startMarker.getPosition());

                    }
                    else if (i == endRouteCount) { // endRouteMarker[last] - endmarker
                        //alert(endRouteMarker[i].getPosition());
                        // alert(endMarker.getPosition());
                         // console.log(endMarker.getPosition());
                        drawWalkingMarker(endRouteMarker[i - 1], endMarker);
                       // console.log(endMarker.getPosition());
                    }
                    else { // endRouteMarker[] - startRouteMarker[]
                        //  alert(startRouteMarker[i].getPosition());
                        // alert(endRouteMarker[i-1].getPosition());
                        //console.log(startRouteMarker[i].getPosition());
                        drawWalkingMarker(endRouteMarker[i - 1], startRouteMarker[i]);
                      //  console.log(startRouteMarker[i].getPosition());
                    }

                i++;

     //       }
                }, 1000);
        }

        function drawWalkingMarker(start, end) {
            console.log("b");
            
            $.ajax({
                method: "POST",
                headers: headers,
                url: "https://api2.sktelecom.com/tmap/routes/pedestrian?version=1&format=xml",//보행자 경로안내 api 요청 url입니다.
                async: false,
                data: {
                    //출발지 위경도 좌표입니다.
                    startX: start.getPosition().getLng(),
                    startY: start.getPosition().getLat(),
                    //목적지 위경도 좌표입니다.
                    endX: end.getPosition().getLng(),
                    endY: end.getPosition().getLat(),
                    //경유지의 좌표입니다.
                    //   passList: "126.987319,37.565778_126.983072,37.573028",
                    //출발지, 경유지, 목적지 좌표계 유형을 지정합니다.
                    reqCoordType: "WGS84GEO",
                    // resCoordType: "EPSG3857",
                    //각도입니다.
                    //angle: "172",
                    //출발지 명칭입니다.
                    startName: start.getTitle(),
                    //목적지 명칭입니다.
                    endName: end.getTitle()
                },
   
                success: function (response) {
                    prtcl = response;
                    
                    // 결과 출력
                    var innerHtml = "";
                    var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String	
                    xmlDoc = $.parseXML(prtclString),
                        $xml = $(xmlDoc),
                        $intRate = $xml.find("Document");

                    var tDistance = "총 거리 : " + ($intRate[0].getElementsByTagName("tmap:totalDistance")[0].childNodes[0].nodeValue / 1000).toFixed(1) + "km,";
                    var tTime = " 총 시간 : " + ($intRate[0].getElementsByTagName("tmap:totalTime")[0].childNodes[0].nodeValue / 60).toFixed(0) + "분";


                    var result = ($intRate[0].getElementsByTagName("coordinates"));
                    //console.log(result);
                    //console.log(result);
                    //console.log(result.length);
                   // return;
                    var lineArray = new Array();

                    for (var i = 0; i < result.length; i++) {
                        var data = result[i].innerHTML.split(' ');
                        lineArray = null;
                        lineArray = new Array();
             
                       // console.log("data length = " + data.length-1);
                        for (var j = 0; data[j] != ""; j++) {                      
                            var latlng = data[j].split(',');
                          
                            if (latlng[1] != undefined && latlng[[0]] != undefined)
                                lineArray.push(new daum.maps.LatLng(latlng[1], latlng[0]));
                
                        }

                            walkingPolyline[walkingPolylineCount++] = new daum.maps.Polyline({
                                map: map,
                                path: lineArray,
                                strokeWeight: 5,
                                strokeColor: '#006600'
                            });

                    }
                                    
                },
                //요청 실패시 콘솔창에서 에러 내용을 확인할 수 있습니다.
                error: function (request, status, error) {
                    console.log(request);
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
            


        }




        function drawdetail(mapObj, startnode, endnode) {  // 선그리기

            var xhr = new XMLHttpRequest();
            var url = "https://api.odsay.com/v1/api/loadLane?mapObject=0:0@" + mapObj + "&apiKey=" + apikey;
            xhr.open("GET", url, true);
            xhr.send();
            xhr.onreadystatechange = function () {
                 if (xhr.readyState == 4 && xhr.status == 200) {
                    var resultJsonData = JSON.parse(xhr.responseText); console.log(resultJsonData);
                    drawPolyLine(resultJsonData);		// 노선그래픽데이터 지도위 표시
                }
            }
        }

        // 노선그래픽 데이터를 이용하여 지도위 폴리라인 그려주는 함수
        function drawPolyLine(data) {
            var lineArray;
            for (var i = 0; i < data.result.lane.length; i++) {
                // alert("B");
                for (var j = 0; j < data.result.lane[i].section.length; j++) {
                    lineArray = null;
                    lineArray = new Array();
                    for (var k = 0; k < data.result.lane[i].section[j].graphPos.length; k++) {
                        lineArray.push(new daum.maps.LatLng(data.result.lane[i].section[j].graphPos[k].y, data.result.lane[i].section[j].graphPos[k].x));
                    }
                    polyline[polylineCount++] = new daum.maps.Polyline({
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
    <textarea id="output"></textarea>
	
</body>
<!-- post action start -->
		<div id="popupBoxOnePosition">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="10" sdesc="외부공개" >외부공개</a>
                        </td>
                    </tr
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="20" sdesc="전체공개" >전체공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="30"  sdesc="그룹공개" >그룹공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="40" sdesc="비공개"  >비공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="toggle_visibility('popupBoxOnePosition');" style="cursor:pointer;">취소</button>
                        </td>
                    </tr>
                    </table>
				</div>
			</div>
		</div>
    <!-- post action end -->

</html>
