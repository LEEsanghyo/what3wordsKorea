<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

    strSQL = "p_gim_member_read_detail  '" & Session("member_no") & "'"

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1  
   
    if NOT rs.EOF and NOT rs.BOF then

      member_name = rs("member_name")
      member_alias = rs("member_alias")
      profile_desc = rs("profile_desc")

      if rs("logo_url") <> "" then
        logo_url = rs("logo_url")
      else
        logo_url = ""
      end if

      if rs("back_url") <> "" then
        back_url = rs("back_url")
      else
        back_url = ""
      end if

    end if 

    set rs = nothing   
    

%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>글공유 HOME</title>
<style type="text/css">
* { padding: 0; margin: 0; }

html, body {
    max-width: 100%;
    overflow-x: hidden;
    font-family: Arial, 맑은 고딕, 돋움; background:#FFFFFF;
    padding:0px;margin:0px;
}
a { text-decoration: none; color: #000000; }
li { list-style-type: none; }
header { 
    width: 100%;
	height: 70px; 
	margin: 0px;
    background:#5A6CB4;
    padding: 0px;
    position:fixed;
}
#brand {
    width: 80%; 
	float: left;
	height: 40px;
    padding:0px;
	color: #FFFFFF;
}
nav { width: 100%; text-align: center; top:70px;}
nav a { 
	display: block; 
	padding: 15px 0;
	border-bottom: 1px solid #0076A3;
	color: #00A5CC;
}
nav a:hover { background: #6DCFF6; color: #FFF; }
nav li:last-child a { border-bottom: none; }
/*-----------------------------------------*/
.menu {
	width: 240px;
	height: 100%;
	position: absolute;
	background: #EEEEEE;
	left: -240px;
	transition: all .3s ease-in-out;
	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;
	
}
.menu-icon {
	padding: 10px 10px;
    margin:0px 5px 0px 0px;
	background: #EEEEEE;
    float:right;
	color: #0cc738;
	cursor: pointer;
	margin-top: 4px;
	border-radius: 5px;
    position:absolute;
    top:5px;
    right:5px;
}
#menuToggle { display: none; }
#menuToggle:checked ~ header { position: absolute; left: 0; }
#menuToggle:checked ~ .menu { position: absolute; left: 0; }
#menuToggle:checked ~ .login { position: absolute; left: 60px; top:50px; } 
#menuToggle:checked ~ .title { position: absolute; left: 260px; top:50px; } 
#menuToggle:checked ~ .content { position: absolute; left: 260px; top:70px; }
#menuToggle:checked ~ .bottom { position:absolute; left: 260px; } 


.title {
    text-align:center;
    font-size:25px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    height:30px;
    margin:2px;
    padding:5px;
    color:#0cc738;
//    background: #0cc738;
    border-radius: 2px;
}

.login {
    margin:0px;
    padding:0px;
    display:flex;
    justify-content:center;
    height:60px;
}

.content {
	width: 100%;
	margin: 0px;
    font-size:16px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    background:#FFFFFF;
    padding:0px;
	transition: all .3s ease-in-out;
	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;
}


.bottom {
    font-size:14px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    padding:20px;
    margin:2px;
}

/* 게시판 디자인 */
.main_table {
    width:95%;
    border:0px;
    font-family:Arial, 맑은 고딕, 돋움;
}

.bbcTitle {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 1.2em;
    font-weight:bold;
    color:#000000;
    margin: 5px 5px 5px 5px;
    padding:5px 5px 5px 5px;
}

.bbcContent {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.98em;
    color:#000000;
    margin:5px 5px 5px 20px;
    padding:5px 5px 5px 5px;
}
.bbcDate {
    height:20px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.8em;
    color:#000000;
    margin:5px 5px 5px 20px;
    padding:5px 5px 5px 5px;
}

span td a {
    font-family:Arial, 맑은 고딕, 돋움;
}

/* 게시판 디자인 */

/* 팝업 메뉴 start */
            #popupBoxLogin{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
			}
/* 팝업 메뉴 end */


</style>


<SCRIPT LANGUAGE=javascript>
<!--
    var xhr;

    function ChangeProfile() {
        //alert("1");
        var pdesc = document.getElementById("profile_desc").value;
        var mname = document.getElementById("member_name").value;
        var malias = document.getElementById("member_alias").value;

        //alert(rprocess);
        var strurl = "my_profile_desc_set.asp?profile_desc=" + pdesc + "&member_name=" + mname + "&member_alias=" + malias;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = ChangeProfileSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }

    function ChangeProfileSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //var slipdata = data.split(',');
            alert(data);

            var pdesc = document.getElementById("profile_desc").value;
            document.getElementById("profile_desc_box").innerHTML = pdesc;

            var mname = document.getElementById("member_name").value;
            var malias = document.getElementById("member_alias").value;
            document.getElementById("member_box").innerHTML = mname + " (" + malias + ")";

            //alert(data);
        }
    }

    function UploadBack() {

        //alert("1");
        formObject = document.getElementById("FormBack");

        formObject.submit()

    }
    
    function UploadLogo() {

        //alert("1");
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

    //-->
</SCRIPT>

</head>

<body>
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_detail.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px;"></div>
<div class="content">

        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr>
              <td width="40%"></td>
              <td width="20%" align="center"><span id="member_box"><%=member_name %> (<%=member_alias %>)</span><br /><img src="<%=logo_url %>" style="width:40px;border-radius:20px;" /></td>
              <td width="40%"></td>
          </tr>
        </table>
        </div>

    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>

        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr><td>
              <% if back_url <> "" then %>
              <img src="<%=back_url %>" style="width:50%;" />
              <% else %>
              (배경 이미지 없음)
              <% end if %>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td  align="center">
              <FORM NAME="FormBack" id="FormBack" METHOD="post" ACTION="mi_profile_back_upload.asp" ENCTYPE="multipart/form-data"> 
              <INPUT TYPE="file" NAME="file1" >
              <input type="button" onclick="UploadBack();" value="저장" />
              </FORM>
              </td>
          </tr>
        </table>
        </div>
    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>
        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr><td>
              <% if logo_url <> "" then %>
              <img src="<%=logo_url %>" style="width:50%;" />
              <% else %>
              (프로필 이미지 없음)
              <% end if %>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td  align="center">
              <FORM NAME="FormLogo" id="FormLogo" METHOD="post" ACTION="mi_profile_logo_upload.asp" ENCTYPE="multipart/form-data"> 
              <INPUT TYPE="file" NAME="file1" >
              <input type="button" onclick="UploadLogo();" value="저장" />
              </FORM>
              </td>
          </tr>
        </table>
        </div>
    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>
        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr>
              <td>
              <span id="profile_desc_box">
              <% if profile_desc <> "" then %>
              <%=profile_desc %>
              <% else %>
              (프로필 설명 없음)
              <% end if %>
              </span>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td width="80%" align="center">
                  <input type="text" id="member_name" value="<%=member_name %>" style="width:45%;" />
                  <input type="text" id="member_alias" value="<%=member_alias %>" style="width:45%;" /> 
              </td>
              <td width="20%" align="center" rowspan="2"><input type="button" value="프로필 글 저장" onclick="ChangeProfile();" /></td>
          </tr>
          <tr>
              <td width="100%" align="center"><input type="text" id="profile_desc" value="<%=profile_desc %>" style="width:80%;" /> </td>
          </tr>
        </table>
        </div>


    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>


</div>
<div class="bottom">

</div>

</body>
</html>

    <!-- login action start -->
		<div id="popupBoxLogin">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style="height:40px;">
                        <td width="10%;" align="center">
                        </td>
                        <td width="40%;" align="center">
                            <input type="text" style="width:100%;" id="member_pwd" placeholder="비밀번호" />
                        </td>
                        <td style="width:1px;background:#CCCCCC;"></td>
                        <td width="50%;" align="center">
                            <input type="button" value="로그인" onclick="LoginConfirm();"  />
                            <input type="button" value="취소" onclick="toggle_visibility('popupBoxLogin');"  />
                        </td>
                    </tr>
                    </table>
				</div>
			</div>
		</div>
    <!-- login action end -->


<!-- #include virtual="/_include/connect_close.inc" -->