// 사용자 위치 DB에 저장
function setRoute(data){
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/map/Location.asp?member_no=" + data[0] +"&flag=0" + "&location=" + data[1]);
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            if (this.responseText != "")    alert(this.responseText);
            xhr = null;
        }
    }
    xhr.send(null);
}

// 채팅 신청이 오는지 확인
function Community(){
    var pageUrl = '/chat/chat_set.asp';
    var openWin;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            if (this.responseText == "채팅") alert(this.responseText);
            var data = this.responseText.split(',');
            if (data[0] == "새 채팅"){
                alert("채팅 신청이 도착했습니다.");
                PopupChatReq(data);
            }
            else if (data[0] == "채팅 시작"){
                var id = [data[1],data[2]];
                window.name = "w3w";
                openWin = window.open("/chat/chat.asp?otherid=" + data[1], "1대1 채팅", "width=500, height=600, resizable=no, scrollbars = no");
            }
            else if (this.responseText != "")   alert(this.responseText);
            xhr = null;
        }
    }
    xhr.open("GET", pageUrl);
    xhr.send(null);
}
setInterval(Community, 5000);

function PopupChatReq(data){
    // 상대방이 채팅 신청 시 팝업띄움
    window.open("/chat/chat_popup.asp?member_nickname=" + data[1] + "&member_no=" + data[2], "채팅 신청", "width=500, height=600, resizable=no, scrollbars = no");
}

// 채팅 신청
function reqChat(aid, code){
    var strurl = "/chat/chat_set.asp?article_number=" + aid + "&code=" + code;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
            if (this.responseText == "오류가 발생했습니다.") alert(this.responseText);
            else if (this.responseText != "")   alert(this.responseText);
            xhr = null;
        }
    }
    xhr.open("GET", strurl);
    xhr.send(null);
}

// 채팅 수락/거절
function resChat(accept, id){
    var strurl = "/chat/chat_set.asp?accept=" + accept + "&id=" + id;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            var data = this.responseText.split(',');
            if (data[0] == "수락"){
                location.replace("/chat/chat.asp?otherid=" + data[1]);
            }
            else if (this.responseText == "거절") window.close();
            xhr = null;
        }
    }
    xhr.open("GET", strurl);
    xhr.send("null")
}

// 브라우저 종료 시 사용자 로그아웃
var MouseEventObj = new Object();

function addEvent(obj, evt, fn) {
    if (obj.addEventListener) {
        obj.addEventListener(evt, fn, false);
    }
    else if (obj.attachEvent) {
        obj.attachEvent("on" + evt, fn);
    }
}

addEvent(document, "mouseout", function(e) {
    e = e ? e : window.event;
    var from = e.relatedTarget || e.toElement;
    if(!from) {
        MouseEventObj.clientX = e.clientX;
        MouseEventObj.clientY = e.clientY;
    }
});

addEvent(document, "mouseover", function(e) {
    e = e ? e : window.event;
    var from = e.relatedTarget || e.toElement;
    if(from) {
        MouseEventObj.clientX = e.clientX;
        MouseEventObj.clientY = e.clientY;
    } 
});

window.onbeforeunload = function(e) {
 e = e ? e : window.event;
 if(e.clientX && e.clientY) {
     MouseEventObj.clientX = e.clientX;
     MouseEventObj.clientY = e.clientY;
 }
 
 if ((MouseEventObj.clientY <0) ||(e.altKey) ||(e.ctrlKey)||((MouseEventObj.clientY < 129) && (MouseEventObj.clientY>107))) { 
  console.log(MouseEventObj);
  $.get( "/account/logout.asp", function( data ) {});
 } 
}