var xhr;

// 회원가입
function VisitRegister() {
	var siteurl = "/account/member_register.asp";
	window.location.href = siteurl;
}

// 카카오톡 로그인
function kLogin(res){
	var properties = JSON.stringify(res.properties);
	alert(properties);
	var vals = {
		memail : res.kaccount_email,
		verified : res.kaccount_email_verified,
		mid : res.id,
		mname : res.properties.nickname,
		//mage : 2018-res.kstory_birthday.split('-')*1
	}
	alert(vals);
	if (vals.verified == false)	return 0;
	else	LoginConfirm(vals);
}

// 로그인
function LoginConfirm(vals) {
	var email;
	var pwd;
	var uid;
	var strurl;

	if (vals == null){
		email = document.getElementById("member_email").value;
		pwd = document.getElementById("member_pwd").value;

		if (email == ""){
			alert("이메일을 입력하세요.");
			document.getElementById("member_email").focus();
			return false;
		}
		else if (pwd == "") {
			alert("비밀번호를 입력하세요.");
			document.getElementById("member_pwd").focus();
			return false;
		}
	}else{
		uid = vals.mid;
	}

	strurl = "/account/login_set.asp?member_email=" + email + "&member_pwd=" + pwd + "&member_uniqid=" + uid;
	
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText == "0")
				callbackfunc(vals);
			else{
				var siteurl = "default.asp";
				window.location.href = siteurl;
			}
		}
	};
	xhr.open("Get", strurl);
	xhr.send(null);
}

function callbackfunc(vals){
	var name = vals.mname;
	var email = vals.memail;
	var id = vals.mid;
	var age = vals.mage;
	strurl = "/account/member_register.asp?member_nickname=" + name + "&member_email=" + email + "&member_uniqID=" + id + "&member_age=" + age;
	location.href = strurl;
}

// 회원가입 or 다른 사이트 연동 로그인 시 정보 등록
function MemberRegister(oflag, uid) {
	var mname, memail, mage, mint, mphone, mpwd, mpwd2, strurl;

	// 사이트에서 회원 가입 시 
	
	mname = document.getElementById("member_name").value;
	memail = document.getElementById("member_email").value;
	mage = document.getElementById("member_age").value;
	mint = document.getElementById("member_interest").value;
	mphone = document.getElementById("phone1").value + "-" + document.getElementById("phone2").value + "-" + document.getElementById("phone3").value;
	mpwd = document.getElementById("member_pwd").value;
	mpwd2 = document.getElementById("member_pwd2").value;
	if (mint == undefined)	mint = "";
	if (document.getElementById("phone1").value == "")	mphone = "";

	if (mname == "") {
	  alert("닉네임을 입력하세요.");
	  document.getElementById("member_name").focus();
	  return false;
	}

	if (memail == "") {
	  alert("이메일을 입력하세요.");
	  document.getElementById("member_email").focus();
	  return false;
	}
	var n = memail.search("@")
	if (n < 1) {
	  alert("이메일 형식이 아닙니다.");
	  document.getElementById("member_email").focus();
	  return false;
	}

	if (mpwd == "" && oflag==0) {
	  alert("비밀번호를 입력하세요.");
	  document.getElementById("member_pwd").focus();
	  return false;
	}

	if (mpwd.length < 6 && oflag==0) {
	  alert("비밀번호 6자리 이상입니다.");
	  document.getElementById("member_pwd").focus();
	  return false;
	}

	if (mpwd != mpwd2 && oflag==0) {
	  alert("비밀번호 확인이 일치하지 않습니다.");
	  document.getElementById("member_pwd2").focus();
	  return false;
	}

	strurl = "/account/member_register_set.asp?member_name=" + mname + "&member_email=" + memail + "&member_age=" + mage + "&member_interest=" + mint + "&member_phone=" + mphone + "&member_pwd=" + mpwd + "&org_flag=" + oflag + "&member_uniqid=" + uid.substring(0,9);
	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = MemberRegisterSet;
	xhr.open("Get", strurl);
	xhr.send(null);
}

function MemberRegisterSet() {
	if (xhr.readyState == 4) {
	  var data = xhr.responseText;
	  var slipdata = data.split(',');

	  if (slipdata[0] > 0) {
		  document.getElementById("message").innerHTML = slipdata[1];
	  }
	  else {
		  alert(slipdata);
		  var siteurl = "/default.asp";
		  window.location.href = siteurl;
	  }
	}
}

function GoogleLogin(){
	var provider = new firebase.auth.GoogleAuthProvider();
	firebase.auth().signInWithPopup(provider).then(function(result){
		var token = result.credential.accessToken; // 액세스 토큰 발급
		var user = result.user;	// 로그인 할 유저 정보
		var providerData = user.providerData[0];
		var vals = {
			mname : providerData.displayName,
			memail : user.email,
			verified : user.emailVerified,
			mid : providerData.uid.substring(0,9)
		}
		alert(vals.mid);
		if (vals.verified)	LoginConfirm(vals);
		else	alert("이메일을 인증받으신 후 로그인하시기 바랍니다.");
	}).catch(function(error){
		var errorCode = error.code;	// 에러 코드를 받아 처리한다.
		var errorMessage = error.message;
		var email = error.email
		var credentail = error.credential;
	})
}

var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "ePD3yuxPRSuXMeIBH5DA",
		callbackUrl: "http://tour.abcyo.kr/account/callback.html",
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