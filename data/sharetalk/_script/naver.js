window.onload = function (){
	

	/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
				var email = naverLogin.user.getEmail();
				if( email == undefined || email == null) {
					alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}

				window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/sample/main.html");
			} else {
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	});
}