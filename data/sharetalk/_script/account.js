var xhr;

// 회원가입
function VisitRegister() {
	var siteurl = "member_register.asp";
	window.location.href = siteurl;
}

// 로그인
function LoginConfirm() {
	var email = document.getElementById("member_email").value;
	var pwd = document.getElementById("member_pwd").value;
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

	var strurl = "login_set.asp?member_email=" + email + "&member_pwd=" + pwd;

	xhr = new XMLHttpRequest();
	xhr.onreadystatechange = LoginConfirmSet;
	xhr.open("Get", strurl);
	xhr.send(null);
}

function LoginConfirmSet() {
	if (xhr.readyState == 4) {
		var data = xhr.responseText;
		var siteurl = "default.asp";
		window.location.href = siteurl;
	}
}