var xhr;

function openInterest(){
    var openWin;
    window.name = "회원가입";
    openWin = window.open("member_interest_set.html", "관심사 선택", "width=600, height=700, resizable=no, scrollbars = no");
}

function setInterestText(interest){
    alert(interest);
    var index = interest.split(",");
    for (i=0; i<index.length; i++){
        if (index[i]!="")   name[i] = names[index[i]];
    }
    if (opener!=null)   opener.document.getElementById("member_interest").innerHTML = name;
    else document.getElementById("member_interest").innerHTML = name;

}

function setInterest(vars){
    var temp,interest="";
    var count = 0;
    for (i=0; i<vars.elements['int[]'].length; i++){
        temp = vars.elements['int[]'][i];
        if (temp.checked){
            count++;
            interest += temp.value + ",";
        }
    }

    if (count > 10){
        alert("관심사는 10개 이하로 선택해주세요.");
        return false;
    }
    else{
        opener.document.getElementById("member_interest").value = interest.substring(0,interest.length-1);
        setInterestText(interest.substring(0,interest.length-1));
        window.close();
    }
}

function ChangeProfile() {
    var pdesc = document.getElementById("profile_desc").value;
    var mname = document.getElementById("member_name").value;
    var minterest = document.getElementById("member_interest").value;
    var strurl = "my_profile_desc_set.asp?profile_desc=" + pdesc + "&member_name=" + mname + "&member_interest=" + minterest;
    
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = ChangeProfileSet;
    xhr.open("Get", strurl);
    xhr.send(null);
}

function ChangeProfileSet() {
    if (xhr.readyState == 4) {
        var data = xhr.responseText;
        alert(data);

        var pdesc = document.getElementById("profile_desc").value;
        document.getElementById("profile_desc_box").innerHTML = pdesc;

        var mname = document.getElementById("member_name").value;
        document.getElementById("member_box").innerHTML = mname;
    }
}

function UploadBack() {
    formObject = document.getElementById("FormBack");
    formObject.submit()
}

function UploadLogo() {
    formObject = document.getElementById("FormLogo");
    formObject.submit()
}

function toggle_visibility(id) {
    var e = document.getElementById(id);
    if (e.style.display == 'block')
        e.style.display = 'none';
    else
        e.style.display = 'block';
}