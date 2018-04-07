<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
    MENU = "FRIEND"
    keyword = request("keyword")

    strSQL = "p_admin_config_read "
    
    'response.Write strSQL
    'response.end
    
    set rsConfig = Server.CreateObject("ADODB.Recordset")
    rsConfig.CursorLocation = 3  
    rsConfig.Open strSQL, DbConn

    if rsConfig.EOF or rsConfig.BOF then
	   NoDataConfig = True
    Else
	   NoDataConfig = False
    end if  
      
    '페이징처리관련
    page =request("page")
  
    If NoDataConfig = False then
  	  Cus_pageSize = 100
	  rsConfig.PageSize = Cus_pageSize

	  pagecount=rsConfig.pagecount
  	  totalRecord = rsConfig.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then 
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If	
	  rsConfig.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsConfig.PageSize) + 1)

      if page > lastpg then
	  	page = lastpg
      end If

    end if
    '페이징처리관련 끝    

%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>글공유 상세</title>
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
#menuToggle:checked ~ .content { position: absolute; left: 260px; top:10px; }
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

td_header{
    width:30%;
    height:25px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.98em;
    color:#ffffff;
    background:deepskyblue;

}

td_content{
    height:25px;
    padding:2px 2px 2px 10px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.98em;
    color:#000000;
}

span td a {
    font-family:Arial, 맑은 고딕, 돋움;
}

/* Google Fonts */
@import url(http://fonts.googleapis.com/css?family=Open+Sans);

/* set global font to Open Sans */
body {
  font-family: 'Open Sans', 'sans-serif';
  background-image: url(http://benague.ca/files/pw_pattern.png);
}

/* css for title */
h1 {
  color: #55acee;
  text-align: center;
}

.link {
  border-bottom: 2px dotted #55acee;
  text-decoration: none;
  color: #55acee;
  transition: .3s;
  -webkit-transition: .3s;
  -moz-transition: .3s;
  -o-transition: .3s;
}

.link:hover {
  color: #2ecc71;
  border-bottom: 2px dotted #2ecc71;
}

/* css for the shiny buttons */
.btn {
  cursor: pointer;
  margin: 5px;
  border-radius: 5px;
  text-decoration: none;
  padding: 5px 10px 5px 10px;
  font-size: 12px;
  transition: .3s;
  -webkit-transition: .3s;
  -moz-transition: .3s;
  -o-transition: .3s;
  display: inline-block;
}

.btn:hover {
  cursor: url(http://cur.cursors-4u.net/symbols/sym-1/sym46.cur), auto;
}
.blue {
  color: #55acee;
  border: 2px #55acee solid;
}

.blue:hover {
  background-color: #55acee;
  color: #fff
}

.green {
  color: #2ecc71;
  border: 2px #2ecc71 solid;
}

.green:hover {
  color: #fff;
  background-color: #2ecc71;
}

.red {
  color: #e74c3c;
  border: 2px #e74c3c solid;
}

.red:hover {
  color: #fff;
  background-color: #e74c3c;
}

.purple {
  color: #9b59b6;
  border: 2px #9b59b6 solid;
}

.purple:hover {
  color: #fff;
  background-color: #9b59b6;
}

.orange {
  color: #e67e22;
  border: 2px #e67e22 solid;
}

.orange:hover {
  color: #fff;
  background-color: #e67e22;
}

.yellow {
  color: #f1c40f;
  border: 2px #f1c40f solid;
}

.yellow:hover {
  color: #fff;
  background-color: #f1c40f;
}

.buttons {
  padding-top: 10px;
  text-align: center;
}

/* copyright stuffs.. */
p {
  text-align: center;
  color: #55acee;
  padding-top: 20px;
}
/* 게시판 디자인 */

</style>

<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;
  
  function MemberRegister() {
      //alert("1");
      var mname = document.getElementById("member_name").value;
      var memail = document.getElementById("member_email").value;
      var mphone = document.getElementById("member_phone").value;
      var malias = document.getElementById("member_alias").value;
      var mpwd = document.getElementById("member_pwd").value;
      var mpwd2 = document.getElementById("member_pwd2").value;

      if (mname == "") {
          alert("성명을 입력하세요.");
          document.getElementById("member_name").focus();
          return false;
      }

      if (memail == "") {
          alert("이메일을 입력하세요.");
          document.getElementById("member_email").focus();
          return false;
      }
      var n = memail.search("@")
      if (n < 1) {
          alert("이메일 형식이 아닙니다.");
          document.getElementById("member_email").focus();
          return false;
      }

      if (mpwd == "") {
          alert("비밀번호를 입력하세요.");
          document.getElementById("member_pwd").focus();
          return false;
      }

      if (mpwd.length < 5) {
          alert("비밀번호 5자리 이상입니다.");
          document.getElementById("member_pwd").focus();
          return false;
      }

      if (mpwd != mpwd2) {
          alert("비밀번호 확인이 일치하지 않습니다.");
          document.getElementById("member_pwd2").focus();
          return false;
      }


      var wflag = document.getElementById("warrant_flag");

      if (wflag.checked != true) {
          alert("약관동의가 필요합니다.");
          document.getElementById("warrant_flag").focus();
          return false;
      }
      
      //alert(rprocess);
      var strurl = "member_register_set.asp?member_name=" + mname + "&member_email=" + memail + "&member_phone=" + mphone + "&member_alias=" + malias + "&member_pwd=" + mpwd;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = MemberRegisterSet;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function MemberRegisterSet() {
      if (xhr.readyState == 4) {
          var data = xhr.responseText;
          var slipdata = data.split(',');

          //document.getElementById("message").innerHTML = data;
          //return false;
          //alert(data);

          if (slipdata[0] > 0) {
              document.getElementById("message").innerHTML = slipdata[1];
          }
          else {
              alert(slipdata[1]);

              var siteurl = "default.asp";

              window.location.href = siteurl;
          }
      }
  }

    //-->
</SCRIPT>

</head>

<body>

    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_admin.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
    <table style="width:100%">
       <tr height="4px;">
           <td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td>
       </tr>
    </table>

<div class="content" style="margin-top:70px;">

        <div style="padding:5px 0;width:100%;border-top:solid 1px #888888;">   
            <table class="main_table" border="0">
                <tr><td style="width:2%;"></td>
                    <td class="bbcContents" align="center" style="width:23%;font-size:12px;font-weight:bold;">
                        코 드
                    </td>
                    <td class="bbcContents" align="left" style="width:75%;font-size:12px;font-weight:bold;">
                        값
                    </td>
                </tr>
            </table>
        </div>
        <% if NoDataConfig = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsConfig.EOF   %>    

        <div style="padding:5px 0;width:100%;border-top:solid 1px #888888;">   
            <table class="main_table" border="0">
                <tr><td style="width:2%;"></td>
                    <td class="bbcContents" align="center" style="width:23%;font-size:12px;font-weight:normal;">
                        <%=rsConfig("CONFIGCODE") %>
                    </td>
                    <td class="bbcContents" align="left" style="width:75%;font-size:12px;font-weight:normal;">
                        <%=rsConfig("CONFIGVALUE") %>
                    </td>
                </tr>
            </table>
        </div>
     
        <%  rsConfig.MoveNext
	        Loop 
        %>
		<% else %>
        <div>
        환경변수가 없습니다.
        </div>
        <% end if         
       	set rsConfig = nothing
        %> 

    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td></tr>
    </table>
</div>

</body>
</html>