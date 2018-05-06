var xhr;

function Community(){
    var pageUrl = '/chat_set.asp';
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            var data = this.responseText.split(',');
            if (data[0] == "새 채팅")  PopupChatReq(data);
            else if (data[0] == "채팅 시작")    window.open("http://localhost:1337", "1 대 1 채팅", "width=500, height=600, resizable=no, scrollbars = no");
            else if (this.responseText != "")   alert(this.responseText)
        }
    }
    xhr.open("GET", pageUrl);
    xhr.send(null);
    setTimeout('Community()', 5000);
}
Community();

function PopupChatReq(data){
    // 상대방이 채팅 신청 시 팝업띄움
    window.open("/chat_popup.asp?member_nickname=" + data[1] + "&member_no=" + data[2], "채팅 신청", "width=500, height=600, resizable=no, scrollbars = no");
}

function reqChat(aid, code){
    var strurl = "/chat_set.asp?article_number=" + aid + "&code=" + code;
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText == "오류가 발생했습니다.")
                alert(this.responseText);
            else{
                alert("채팅신청을 보냈습니다. 상대방이 수락할 시 채팅이 시작됩니다.")
            }
        }
    }
    xhr.open("GET", strurl);
    xhr.send(null);
}

// 채팅 수락/거절
function resChat(accept, id){
    var strurl = "/chat_set.asp?accept=" + accept + "&id=" + id;
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            if (this.responseText == "수락")  location.href("http://localhost:1337");
            else if (this.responseText == "거절") window.close();
        }
    }
    xhr.open("GET", strurl);
    xhr.send("null")
}