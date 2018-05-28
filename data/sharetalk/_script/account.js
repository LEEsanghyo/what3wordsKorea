var i = 0;
var items = new Array();
function openInterest(){
    var openWin;
    window.name = "회원가입";
    openWin = window.open("member_interest_set.html", "관심사 선택", "width=400,height=500,resizable=0,scrollbars=0");
}

function setInterestText(interest){
    var names = ['영화','노래부르기','당구','요리','클럽','스포츠 관람','장기/체스','공연/콘서트','주거 개선','드라이브','음주','스파/마사지샵','박물관/전시회','수다','봉사활동','쇼핑','게임','산책','등산','캠핑','음악 감상','악기 연주','사진촬영','애완동물 기르기','독서','그림그리기','운동','먹방','여행','차(Tea)'];
    var name = new Array();

    if (interest == null)   for (i=0; i<items.length; i++)   name[i] = names[items[i]-1];
    else    for (i=0; i<interest.length; i++)   name[i] = names[interest[i]-1];

    if (opener!=null)   opener.document.getElementById("interest_text").innerHTML = name;
    else document.getElementById("interest_text").innerHTML = name;

}

function setInterest(){
    opener.document.getElementById("member_interest").value = items;
    setInterestText(null);
    window.close();
}

function count(item){
    if (item.checked == true){
        items[i] = item.value;
        i++;
    }
    else if (item.checked == false){
        for (var j=0; j<count; j++){
            if(items[j] == item.value)  items[j] = null;
        }
        i--;
    }

    // 관심사 10개 넘어갈 시 오류 출력
    if (i > 10){
        items[i-1] = null;
        item.checked = false;
        i--;
        alert("관심사는 10개 이하로 선택해주세요.");
    }

    // 주 관심사 3개 선택 시 보조관심사 선택으로
    if (i > 2){
        document.getElementById("title").innerHTML = "보조 관심사를 선택하세요.";
    }
}

function ChangeProfile() {
    var pdesc = document.getElementById("profile_desc").value;
    var mname = document.getElementById("member_name").value;
    var minterest = document.getElementById("member_interest").value;
    var profurl = document.getElementById("profile_url").value;
    var strurl = "my_profile_desc_set.asp?profile_desc=" + pdesc + "&member_name=" + mname + "&member_interest=" + minterest + "&profile_url=" + profurl;
    
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
            var data = xhr.responseText;
            alert(data);
            xhr = null;
            location.href = "";
        }
    }
    xhr.open("Get", strurl);
    xhr.send(null);
}

// 파일 업로드하기
function upload(id){
    var data, src;
    var surl;   // 파일 POST 주소

    // 배경 사진 업로드
    if (id == 0){
        data = new FormData(document.getElementById('uploadback'));
        src = document.getElementById('back');
        surl = 'http://tour.abcyo.kr:1337/uploadback';
    }

    // 프로필 사진 업로드
    else if (id == 1){
        data = new FormData(document.getElementById('uploadprof'));
        src = document.getElementById('profile');
        surl = 'http://tour.abcyo.kr:1337/uploadprof';
    }

    // SNS 사진 업로드
    else if (id == 2){ 
        data = new FormData(document.getElementById('uploadsns'));
        src = null;
        surl = 'http://tour.abcyo.kr:1337/uploadsns';
    }
    var xhr = new XMLHttpRequest();
    if (src != null) data.append('img_url', src.src);
    xhr.onload = function(){
      if (this.status == 200 || this.status == 201){
        if(src != null) src.src = this.responseText;
        else    document.getElementById('sns_url').value = this.responseText;
      }
      else  alert("오류가 발생했습니다.");
      xhr = null;
    };
    xhr.open('POST', surl);
    xhr.send(data);
}

function deleteImg(){
	document.getElementById('profile_url').value = '/images/my.png'
	document.getElementById('profile').src = '/images/my.png'
}

function toggle_visibility(id) {
    var e = document.getElementById(id);
    if (e.style.display == 'block')
        e.style.display = 'none';
    else
        e.style.display = 'block';
}