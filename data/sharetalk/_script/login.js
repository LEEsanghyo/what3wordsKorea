var xhr;

// 회원가입
function VisitRegister() {
	var siteurl = "member_register.asp";
	window.location.href = siteurl;
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

	strurl = "login_set.asp?member_email=" + email + "&member_pwd=" + pwd + "&member_uniqid=" + uid;
	
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
	strurl = "member_register.asp?member_nickname=" + name + "&member_email=" + email + "&member_uniqid=" + id + "&member_age=" + age;
	location.href = strurl;
}

// 회원가입 or 다른 사이트 연동 로그인 시 정보 등록
function MemberRegister(oflag, uid) {
	//alert("1");
	var mname, memail, mage, mint, mphone, mpwd, mpwd2, strurl;

	// 사이트에서 회원 가입 시 
	
	mname = document.getElementById("member_name").value;
	memail = document.getElementById("member_email").value;
	mage = document.getElementById("member_age").value;
	mint = document.getElementById("member_interest").value;
	mphone = document.getElementById("phone1").value + "-" + document.getElementById("phone2").value + "-" + document.getElementById("phone3").value;
	mpwd = document.getElementById("member_pwd").value;
	mpwd2 = document.getElementById("member_pwd2").value;

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

	strurl = "member_register_set.asp?member_name=" + mname + "&member_email=" + memail + "&member_age=" + mage + "&member_interest=" + mint + "&member_phone=" + mphone + "&member_pwd=" + mpwd + "&org_flag=" + oflag + "&member_uniqid=" + uid;

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
		  var siteurl = "default.asp";
		  window.location.href = siteurl;
	  }
	}
}