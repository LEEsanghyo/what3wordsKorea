var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "ePD3yuxPRSuXMeIBH5DA",
		callbackUrl: "http://" + window.location.hostname + ((location.port==""||location.port==undefined)?"":":" + location.port),
		isPopup: false,
		callbackHandle: true
		/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
	}
);

/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
naverLogin.init();

/* (4-1) 임의의 링크를 설정해줄 필요가 있는 경우 */
$("#gnbLogin").attr("href", naverLogin.generateAuthorizeUrl());

/* (5) 현재 로그인 상태를 확인 */
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고 사용자 정보를 출력합니다. */
			setLoginStatus();
		}
	});
});

/* (6) 로그인 상태가 "true" 인 경우 로그인 버튼을 없애고 사용자 정보를 출력합니다. */
function setLoginStatus() {
	var profileImage = naverLogin.user.getProfileImage();
	var nickName = naverLogin.user.getNickName();
	$("#naverIdLogin_loginButton").html('<br><br><img src="' + profileImage + '" height=50 /> <p>' + nickName + '님 반갑습니다.</p>');
	$("#gnbLogin").html("Logout");
	$("#gnbLogin").attr("href", "#");
	/* (7) 로그아웃 버튼을 설정하고 동작을 정의합니다. */
	$("#gnbLogin").click(function () {
		naverLogin.logout();
		location.reload();
	});
}