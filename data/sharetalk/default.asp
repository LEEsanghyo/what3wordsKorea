<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/words.asp" -->
<%
    MENU = "HOME"

	'카테고리 리스트 불러오기
    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbConn, 1, 1

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if
	
	set rsCategory = nothing
%>
<!Doctype html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>What3Words Home</title>
		<link rel="stylesheet" href="/_css/style.css" type="text/css">
		<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
		<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js?callback=setLoginBtn" charset="utf-8"></script>
		<script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-app.js"></script>
		<script src="https://www.gstatic.com/firebasejs/4.9.0/firebase-auth.js"></script>
		<style type="text/css">
			@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
			.login {
				margin:auto;
				width:200px;
				height:20px;
				border: none;
				border-bottom:skyblue solid 0.2px;
				background-color: none;
			}
			.lbutton{
				margin: 0px 15px 0px 15px;
				color: #6666CC;
				font-family:'Jeju Gothic', sans-serif;
				font-size:20px;
			}
		</style>
	</head>

	<body>
		<% MENU = "HOME" %>
		
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
		<% if Session("member_no") then
			response.redirect "/map/navigator.asp"
		else %>
		<div style="margin:auto;width:30%">
			<h1 style="color:#148CFF">What3Words</h1>
			<p><input class="login" type="email" placeholder="이메일" id="member_email" onkeypress="if(event.keyCode==13){LoginConfirm(null);}"></p>
			<p><input class="login" type="password" placeholder="비밀번호" id="member_pwd" onkeypress="if(event.keyCode==13){LoginConfirm(null);}"></p>
			<p><a class="lbutton" onclick="LoginConfirm(null);">로그인</a><a class="lbutton" href="/account/member_register.asp">회원가입</a></p>
		</div>

		<!-- 네이버 / 카카오 / 구글 로그인 -->
		<p><a align="center" id="naverIdLogin"></a>
		<image align="center" id="kakao-login-btn" src="/images/kl.png" style="margin:-40px 20px 0px 20px;cursor:pointer;width:50px;height:50px" onclick="kLogin()">
		<image align="center" id="firebaseui-auth-contanier" src="/images/glogin.png" style="margin-top:-40px;cursor:pointer;width:50px;height:50px;" onclick="GoogleLogin()">
		</p>
		<script type="text/javascript" src="/_script/login.js?ver=1"></script>
		<% end if %>
		</script>
	</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->