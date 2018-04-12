var xhr;

function ChangeProfile() {
    var pdesc = document.getElementById("profile_desc").value;
    var mname = document.getElementById("member_name").value;
    var strurl = "my_profile_desc_set.asp?profile_desc=" + pdesc + "&member_name=" + mname;
    
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