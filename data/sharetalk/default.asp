<!-- #include virtual="/_include/connect.inc" -->
<%
    MENU = "HOME"
    keyword = request("keyword")


    talk_member_email = Request.Cookies("talk_member_email")
    talk_member_pwd = Request.Cookies("talk_member_pwd")



    strSQL = "p_login_auto_check '" & talk_member_email & "','" & _
                                      talk_member_pwd & "'"




    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1


    'response.write "3"
    'response.end

    if rsData("p_count") > "0" then
      Session("member_no") = rsData("member_no")
      Session("member_name") = rsData("member_name")
      Session("member_email") = rsData("member_email")
      Session("admin_flag") = rsData("admin_flag")
      Session("authority_level") = rsData("authority_level")
    end if

    set rsData = nothing

    strSQL = "p_tsh_post_read '" & keyword & "','" & request("cat_no") & "'"

    'response.Write strSQL
    'response.end

    set rsPost = Server.CreateObject("ADODB.Recordset")
    rsPost.CursorLocation = 3
    rsPost.Open strSQL, DbCon

    if rsPost.EOF or rsPost.BOF then
	  NoDataPost = True
    Else
	   NoDataPost = False
    end if

    '페이징처리관련
    page =request("page")

    If NoDataPost = False then
  	  Cus_pageSize = 20
	  rsPost.PageSize = Cus_pageSize

	  pagecount=rsPost.pagecount
  	  totalRecord = rsPost.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If
	  rsPost.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsPost.PageSize) + 1)

      if page > lastpg then
	  	page = lastpg
      end If

    end if
    '페이징처리관련 끝

    strSQL = "p_tsm_category_list_read "

    Set rsCategory = Server.CreateObject("ADODB.RecordSet")
    rsCategory.Open strSQL, DbCon, 1, 1

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if
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
    /* font-weight:bold; */
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
    width:100%;
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

			.popupBoxWrapper{
				width: 300px; margin: 0px; text-align: left;position:absolute;top:100px;left:20px;right:50;border-radius:0px;
			}
			.popupBoxContent{
				background-color: #FFF; padding: 0px;border-radius:2px;
			}

/* 팝업 메뉴 end */

			/* navigation start */
			ul.category {
				list-style-type:none;
				margin:0;
				padding:0;
				/* position:absolute; */
			}
			li.category {
				display: inline-block;
				float:left;
				margin-right: 1px;
			}
			li.category a {
				display:block;
				min-width:60px;
				height: 40px;
				text-align:center;
				line-height:40px;
				font-size:14px;
				font-family:Arial,맑은 고딕,돋움;
				font-weight:bold;
				color:#000000;
				background: #FFFFFF;
				text-decoration: none;
			}
			/*Hover state for top level links */

			li.category:hover a {
				color: #19C589;
			}
			/* navigation end */
</style>


<SCRIPT LANGUAGE=javascript>
<!--
    var xhr;

    function PostEngage(elem) {
        //alert("1");
        var pno = elem.getAttribute("pno");
        var code = elem.getAttribute("code");

        var myNodelist = document.getElementsByName("engage" + pno);
        var i;
        for (i = 0; i < myNodelist.length; i++) {
            myNodelist[i].style.color = "#000000";
        }
        //alert("2");

        elem.style.color = "#3388cc";

        //alert(rprocess);
        var strurl = "ws_engage_set.asp?post_no=" + pno + "&engage_code=" + code;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = PostEngageSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }

    function PostEngageSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');

            //alert(data);
            //alert(slipdata[2]);
            document.getElementById("engage_" + slipdata[0]).innerHTML = "공감 " + slipdata[1];
            if (slipdata[2] == "") {
                document.getElementById("trbox_" + slipdata[0]).style.display = "none";
            }
            else {
                document.getElementById("trbox_" + slipdata[0]).style.display = "block";
                document.getElementById("engagebox_" + slipdata[0]).innerHTML = slipdata[2];
            }

            //alert(slipdata[2]);
        }
    }

    function VisitRegister() {

        var siteurl = "member_register.asp";
        //alert(siteurl);

        window.location.href = siteurl;

    }

    function LoginPopup() {
        var email = document.getElementById("member_email").value;
        var n = email.search(/@/i);
        //alert(n);

        if (email == "") {
            //alert("이메일을 입력하세요.");
            document.getElementById("member_email").placeholder = "이메일을 입력하세요.";
            document.getElementById("member_email").focus();
            return false;
        }

        toggle_visibility('popupBoxLogin');
        document.getElementById("member_pwd").focus();
    }

    function LoginConfirm() {

        var email = document.getElementById("member_email").value;
        var pwd = document.getElementById("member_pwd").value;

        if (pwd == "") {
            alert("비밀번호를 입력하세요.");
            document.getElementById("member_pwd").focus();
            return false;
        }

        var strurl = "login_set.asp?member_email=" + email + "&member_pwd=" + pwd;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = LoginConfirmSet;
        xhr.open("Get", strurl);
        xhr.send(null);

    }

    function LoginConfirmSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //var slipdata = data.split(',');

            var siteurl = "default.asp";

            window.location.href = siteurl;
        }
    }

    function PostSearch() {

        var keyword = document.getElementById("keyword").value;

        var siteurl = "default.asp?keyword=" + keyword;

        window.location.href = siteurl;

        //alert(keyword);

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
    <!-- #include virtual="/_include/top_menu.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->



<div class="content" style="margin-top:70px;">

<div style="margin-top:90px;width:100%;height:40px;">
	<nav2>
		<ul class="category">
            <li class="category"><a href="default.asp">(전체)</a></li>
			<% if NoDataCategory = False then ' 데이터가 있으면 데이터 출력
			Do While Not rsCategory.EOF %>
			<li class="category"><a href="default.asp?cat_no=<%=rsCategory("cat_no") %>"><%=rsCategory("cat_name") %></a></li>
			<%
			rsCategory.MoveNext
			Loop
			end if
			set rsCategory = nothing
			%>
		</ul>
	</nav2>
</div>


    <% if Session("member_no") < "1" then %>
    <div class="login">
    <table width="280px;" border="0">
        <tr height="10px;"><td colspan="3"></td></tr>
        <tr><td width="10%"></td>
            <td width="150px;"><input type="text" style="width:150px;height:20px;" placeholder="이메일" id="member_email" /></td>
            <td style="width:10px;"></td>
            <td><span style="cursor:pointer;" onclick="LoginPopup();">로그인</span></td>
            <td width="10%"></td>
        </tr>
        <tr height="1px;"><td colspan="3"></td></tr>
    </table>
    </div>
    <% end if %>


	<div style="width:100%;">
		<div style="width:100%;height:7px;background:#F2F2F4"></div>
		<div style="width:100%;display:flex;justify-content:center;">

		<table style="width:95%;" border="0">

		<% if NoDataPost = False then ' 데이터가 있으면 데이터 출력 %>
		<% if FirstPage <> 1 then
	               RowCount = rsPost.PageSize
	               end If ' 데이터가 있으면 데이터 출력
                   Do While Not rsPost.EOF and RowCount > 0  %>

				<tr style="height:30px;"><td><a href="ws_bbc_detail.asp?post_no=<%=rsPost("post_no") %>"><%=rsPost("post_title") %></a></td></tr>
				<tr style="height:1px;background:#F2F2F4;"><td></td></tr>


		<%
        	RowCount = RowCount - 1
        	rsPost.MoveNext
	        Loop
        %>
		<% else %>
				<tr style="height:30px;"><td>글이 없습니다.</td></tr>
				<tr style="height:1px;background:#F2F2F4;"><td></td></tr>
        <% end if
       	set rsPost = nothing
        %>
	    </table>


    <!-- 페이징 처리-->
    <%if NoDataPost = false Then
	Cus_Tar = "peio_no=" & peio_no
    %>
    <!--#include virtual="/_include/asp_page_function.asp"-->
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
    <%
	Response.Write ShowPageBar("default.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
    %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    </table>
	<%end if%>
	<!-- 페이징 처리 끝-->

		</div>
	</div>




</body>
</html>

    <!-- login action start -->
		<div id="popupBoxLogin">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style="height:40px;">
                        <td colspan="2" align="center">
                            <input type="password" style="width:60%;height:25px;" id="member_pwd" placeholder="비밀번호" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height:1px;background:#CCCCCC;"></td></tr>
                    <tr style="height:40px;">
                        <td width="50%;" align="center" style="font-size:14px;font-family:Arial,맑은 고딕,돋움;cursor:pointer;border-right:solid 1px #CCCCCC;">
                            <a onclick="LoginConfirm();"  />로그인</a>
                        </td>
                        <td width="50%;" align="center" style="font-size:14px;font-family:Arial,맑은 고딕,돋움;cursor:pointer;">
                            <a onclick="toggle_visibility('popupBoxLogin');"  />취소</a>
                        </td>
                    </tr>
                    </table>
				</div>
			</div>
		</div>
    <!-- login action end -->


<!-- #include virtual="/_include/connect_close.inc" -->
