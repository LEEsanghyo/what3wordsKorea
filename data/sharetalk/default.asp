<!-- #include virtual="/_include/connect.inc" -->
<!Doctype html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1.0,user-scalable=no,maximum-scale=1,width=device-width" />
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
			    border: 3px solid rgba(248, 88, 91, 0.7);
			    border-radius: 2px;
				background-color: none;
				font-style: italic;
			}
			.lbutton{
				font-family:'Jeju Gothic', sans-serif;
				font-size:15px;
			    background-color: rgba(248, 88, 91, 0.9);
			    border: none;
			    color:#fff;
			    padding:7px;
			    margin-right:5px;
			    text-align: center;
			    display: inline-block;
			    cursor: pointer;
			    border-radius: 10px;
			}
			html{
				background:none;
				height:100%;
				width: 100%;
			}
			body{
				height:100%;
				width:100%;
				background: url("what3words_logo_real.png") no-repeat center center fixed;
				-webkit-background-size: cover;
				-moz-background-size: cover;
				-o-background-size: cover;
				background-size: 100% 100%;	
			}
			div{
				position: relative;
				top: 40%;
			}
		</style>
	</head>

	<body>
		<!-- 로그인 안되어있을 시 로그인 창 띄우기 -->
		<% if Session("member_no") then
			response.redirect "/map/navigator.asp"
		else %>
		<div>
			<p><input class="login" type="email" placeholder="이메일" id="member_email" onkeypress="if(event.keyCode==13){LoginConfirm(null);}"></p>
			<p><input class="login" type="password" placeholder="비밀번호" id="member_pwd" onkeypress="if(event.keyCode==13){LoginConfirm(null);}"></p>
			<p><a class="lbutton" onclick="LoginConfirm(null);" style="margin-left:20px" style="">로그인</a><a class="lbutton" href="/account/member_register.asp">회원가입</a></p>
		

			<!-- 네이버 / 카카오 / 구글 로그인 -->
			<p><a align="center" id="naverIdLogin" style="margin-left:15px"></a>
			<image align="center" id="kakao-login-btn" src="/images/kl.png" style="margin:-40px 20px 0px 20px;cursor:pointer;width:50px;height:50px" onclick="kLogin()">
			<image align="center" id="firebaseui-auth-contanier" src="/images/glogin.png" style="margin-top:-40px;cursor:pointer;width:50px;height:50px;" onclick="GoogleLogin()">
			</p>
		</div>
		<script type="text/javascript" src="/_script/login.js?ver=1"></script>
		<% end if %>
		</script>
	</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->