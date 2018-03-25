<!-- #include virtual="/_include/words.asp" -->
<%
	'카테고리 리스트 불러오기
    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbConn, 1, 1

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if
%>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>What3Words Home</title>
		<link rel="stylesheet" href="/_include/style.css" type="text/css">		
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
	</head>

	<body>
		<% top_menu = "HOME" %>
		
		<!-- #include virtual="/_include/top_menu.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
		<div class="content" style="margin-top:70px;">
		<!-- 네비게이션 바 -->
		<div style="margin-top:90px;width:100%;height:40px;">
			<nav2>
				<ul class="category">
					<% if NoDataCategory = False then ' 데이터가 있으면 데이터 출력
					Do While Not rsCategory.EOF %>
					<li class="category"><a href="default.asp?cat_no=<%=rsCategory("cat_no") %>"><%=rsCategory("cat_name") %></a></li>
					<%
					rsCategory.MoveNext
					Loop
					end if
					set rsCategory = nothing
					%>
				</ul>
			</nav2>
		</div>

		<!-- 로그인 안되어있을 시 로그인 창 띄우기 -->
		<% if Session("member_no") < "1" then %>
		<div class="login">
			<p width="150px;"><input type="text" style="width:150px;height:20px;" placeholder="이메일" id="member_email"></p>&nbsp&nbsp
			<p width="100px;"><input type="password" style="width:50px;height:20px;" placeholder="비밀번호" id="member_pwd" onkeypress="if(event.keyCode==13){LoginConfirm();}"></p>&nbsp&nbsp
			<p style="cursor:pointer;" onclick="LoginConfirm();">로그인</p>
		</div>
		<% end if %>
		<div id="naverIdLogin"></div>
		<div id="map"></div>
		
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
		</script>
	</body>
</html>