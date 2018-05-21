/* 지역 별 채팅방 */

// 나와 상대방의 세션 ID 불러오고, 채팅 서버에 내 ID 저장
var socket = io.connect('http://tour.abcyo.kr:1337');
var flag = 0;

// 단체 채팅방 입장
function joinRoom(){
    socket.emit('joinRoom', rid);
}

// 단체 채팅방 메세지 보내기
function sendRoom(){
    var my = 'my';
    var data = new Array();
    data[0] = rid;
    data[1] = nick + " : " + $('#o').val();
    data[2] = imgsrc;
    $('#chat').append('<p align=right> 나 : <text>' + $('#o').val() + '</text>');
    socket.emit('statechat', data);
    $('#o').val('');
    return false;
}

// 채팅 매세지 받기
socket.on('statechat', function(msg){
    $('#chat').append('<p>' + msg[2] + '<font>' + msg[1] + '</font><text>' + $('#o').val() + '</text>');
});

/* 1 대 1 채팅 */

// 1 대 1 채팅을 위해 채팅 서버에 내 세션 설정
function sendSession(){
    socket.emit('session', id[0]);
}

// 상대방에게 채팅 메세지 보내기
function sendOne(){
    $('#chat').append('<p align=right> 나 : <text>' + $('#o').val() + '</text>');
    var data = new Array();
    data[0] = id[1];
    data[1] = nick + " : " + $('#o').val();
    data[2] = imgsrc;
    socket.emit('individual', data);
    $('#o').val('');
    return false;
}

// 채팅 매세지 받기
socket.on('individual', function(msg){
    $('#chat').append('<p>' + msg[2] + '<font>' + msg[1] + '</font><text>' + $('#o').val() + '</text>');
});

socket.on('end', function(){
    alert("상대방이 채팅을 종료했습니다.");
    self.close();
});

/* 공통 스크립트 */
// 이미지 클릭 시 상대방과 경로 찾아주기
function getRoute(id){
    var words;
    $.get("/map/Location.asp?member_no=" + id + "&flag=1", function(data){
        if (opener != null){
            opener.window.close();
            window.open('/map/navigator.asp?route=' + data);
        }
        else   words = data;
        return words;
    }, 'text');
}

// 상대방이 내 위치를 볼 수 있는지 여부
function setMyLocation(){
    if (my == false)    my = true;
    else    my = false;
}