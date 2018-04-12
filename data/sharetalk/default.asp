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
		<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	</head>

	<body>
		<% top_menu = "글공유" %>
		
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
			<p width="100px;"><input type="password" style="width:50px;height:20px;" placeholder="비밀번호" id="member_pwd" onkeypress="if(event.keyCode==13){LoginConfirm();}"></p>&nbsp;&nbsp;
			<p style="cursor:pointer;" onclick="LoginConfirm(null);">로그인</p>
		</div>

		<!-- 네이버 / 카카오 / 구글 로그인 -->
		<div align="center" id="naverIdLogin"></div><p></p>
		<div align="center" id="kakao-login-btn"></div><p></p>
		<div align="center" id="firebaseui-auth-contanier">
			<image src="/images/glogin.png" onclick=GoogleLogin(); style="cursor:pointer;width:120px;height:40px;">
		</div><p></p>
		<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js?callback=setLoginBtn" charset="utf-8"></script>
		<script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-app.js"></script>
		<script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-auth.js"></script>
		<script type="text/javascript">
			var naverLogin = new naver.LoginWithNaverId(
				{
					clientId: "ePD3yuxPRSuXMeIBH5DA",
					callbackUrl: "http://tour.abcyo.kr/callback.html",
					callbackUrl: "http://tour.abcyo.kr:8090/callback.html",
					isPopup: false,
					callbackHandle: true,
					/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
					loginButton: {color: "green", type: 2, height: 40}
				}
			);

			naverLogin.init();

			// 사용할 앱의 JavaScript 키를 설정해 주세요.
			Kakao.init('fd746baa46dfc1f5c9c5dbab60b692d6');
			// 카카오 로그인 버튼을 생성합니다.
			Kakao.Auth.createLoginButton({
				container: '#kakao-login-btn',
				success: function(authObj) {
					Kakao.API.request({
						url: '/v1/user/me',
						success: function(res) {
							var info = JSON.parse(JSON.stringify(res));
							kLogin(info);
						},
						fail: function(error) {
							alert(JSON.stringify(error));
						}
					});
				},
				fail: function(err) {
					alert(JSON.stringify(err));
				},
				size : 'small'
			});

			// Initialize Firebase
			var config = {
				apiKey: "AIzaSyCgbsTJV7viSLJ4bxnW5verdCsbthGLnbU",
				authDomain: "friendship-22539.firebaseapp.com",
				databaseURL: "https://friendship-22539.firebaseio.com",
				projectId: "friendship-22539",
				storageBucket: "friendship-22539.appspot.com",
				messagingSenderId: "239661248738"
			};
			firebase.initializeApp(config);
		</script>
		<% end if %>
		<div id="map"></div>
	</body>
</html>