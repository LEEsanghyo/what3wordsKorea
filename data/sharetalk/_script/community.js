function reqChat(id){
	var openWin;
	window.name = "채팅신청";
	openWin = window.open("/chat/chat_popup.html", "채팅신청이 도착했습니다.", "width=600, height=700, resizable=no, scrollbars = no");
}

function resChat(res){
	if (res){
		alert("상대방이 거절했습니다.");
		window.close();
	}else{
		var strurl = "/chat/index.html";
		window.open(strurl, "Chat", "width=600, height=700, resizable=no, scrollbars = no");
	}
}