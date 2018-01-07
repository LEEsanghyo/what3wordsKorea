<!-- #include virtual="/_include/connect.inc" -->
<%
    post_no = request("post_no")

    strSQL = "p_tsh_post_detail_read  '" & post_no & "'"
    
    'response.Write strSQL
    'response.end

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1    

    if NOT rs.EOF and NOT rs.BOF then
      post_title = rs("post_title")
      post_contents = rs("post_contents")
      register_date = rs("register_date")
      member_name = rs("member_name")
    end if  

    post_contents = Replace(post_contents,"<BR>",chr(13) & chr(10))

    set rs = nothing
     %>
<!-- #include virtual="/_include/connect_close.inc" -->
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>글공유</title>
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
    background:#6FC230;
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
			#popupBoxOnePosition{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
			}
            #popupBoxDelete{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
			}
			#popupBoxTwoPosition{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;
			}#popupBoxThreePosition{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;
			}
			.popupBoxWrapper{
				width: 300px; margin: 0px; text-align: left;position:absolute;top:50px;left:30px;border-radius:0px;
			}
			.popupBoxContent{
				background-color: #FFF; padding: 0px;border-radius:2px;
			}
/* 팝업 메뉴 end */
</style>

<SCRIPT LANGUAGE=javascript>
<!--
    var xhr;

    function PostSave() {
        //alert("1");
        var ptitle = document.getElementById("post_title").value;
        var pcontents = document.getElementById("post_contents").value;

        if (ptitle == "") {
            alert("제목이 비었습니다.");
            document.getElementById("post_title").focus();
            return false;
        }

        ptitle = ptitle.replace(/\n/g, "<BR>");
        ptitle = ptitle.replace(/\r/g, "<BR>");
        ptitle = ptitle.replace(/&/g, "<amp>");
        ptitle = ptitle.replace(/,/g, "<comma>");
        ptitle = ptitle.replace(/'/g, "<apostrophe>");
        ptitle = ptitle.replace(/"/g, "<quote>");

        pcontents = pcontents.replace(/\n/g, "<BR>");
        pcontents = pcontents.replace(/\r/g, "<BR>");
        pcontents = pcontents.replace(/&/g, "<amp>");
        pcontents = pcontents.replace(/,/g, "<comma>");
        pcontents = pcontents.replace(/'/g, "<apostrophe>");
        pcontents = pcontents.replace(/"/g, "<quote>");

        //alert(rprocess);
        var strurl = "ws_mytopic_write_set.asp?post_title=" + ptitle + "&post_contents=" + pcontents;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = PostSaveSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }

    function PostSaveSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //var slipdata = data.split(',');

            alert(data);
            //document.getElementById("post_contents").innerHTML = data;
            var strurl = "ws_mytopic.asp";
            //alert(strurl);
            window.location.href = strurl;

        }
    }

    function PostUpload() {

        var ptitle = document.getElementById("post_title").value;
        var pcontents = document.getElementById("post_contents").value;

        if (ptitle == "") {
            alert("제목이 비었습니다.");
            document.getElementById("post_title").focus();
            return false;
        }

        pcontents = pcontents.replace(/\n/g, "<BR>");
        pcontents = pcontents.replace(/\r/g, "<BR>");
        pcontents = pcontents.replace(/&/g, "<amp>");

        document.getElementById("post_contents").value = pcontents;
        
        //alert("1");
        formObject = document.getElementById("PostForm");

        formObject.submit()


    }

    function setScope(elem) {

        var scd = elem.getAttribute("scd");
        var sdesc = elem.getAttribute("sdesc");

        document.getElementById("scope_cd").value = scd;
        //alert(sdesc);
        document.getElementById("share_desc").innerHTML = sdesc;

        toggle_visibility('popupBoxOnePosition');
    }


    function PickImages(elem) {

        var file = elem.valueOf;

        alert(file);

    }



    function previewFile() {
        var preview = document.querySelector('img'); //selects the query named img
        var file = document.querySelector('input[type=file]').files[0]; //sames as here
        var reader = new FileReader();
        var imgsrc = "";

        reader.onloadend = function() {
            preview.src = reader.result;
        }

        alert("1");

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
            var con = document.getElementById("post_contents").innerHTML;
            document.getElementById("post_contents").innerHTML = con + "\n" + "<img src=" + imgsrc + " />";
            alert("1");
        } else {
            preview.src = "";
            alert("2");
        }
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
<input type="checkbox" id="menuToggle">

    <% top_menu = "글수정" %>
    <!-- #include virtual="/_include/top_menu_write_detail.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->

  <!-- post action start -->
		<div id="popupBoxOnePosition">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="10" sdesc="외부공개" >외부공개</a>
                        </td>
                    </tr
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="20" sdesc="전체공개" >전체공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="30"  sdesc="그룹공개" >그룹공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="40" sdesc="비공개"  >비공개</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="toggle_visibility('popupBoxOnePosition');" style="cursor:pointer;">취소</button>
                        </td>
                    </tr>
                    </table>
				</div>
			</div>
		</div>
    <!-- post action end -->
<div class="content" style="margin-top:70px;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td>
       </tr>
    </table>
      <FORM NAME="PostForm" id="PostForm" METHOD="post" ACTION="ws_mytopic_update_upload.asp" ENCTYPE="multipart/form-data"> 
    <div style="width:100%;display:flex;justify-content:center;">  
        <div style="width:95%;margin:10px 0px;">  
                <input type="hidden" style="width:100%;" name="scope_cd"  id="scope_cd"  value="10" />
                <input type="hidden" style="width:100%;" name="post_no"  id="post_no"  value="<%=post_no %>" />
                <table style="width:100%;" border="0">
                    <tr>
                        <td>
                            <input type="text" style="width:90%;border: 0px none #FFFFFF; padding: 2px; margin: 2px; width:100%; font-family: Arial, '맑은 고딕', 돋움;
                         text-decoration: none; font-size: 12px; height: 30px;" name="post_title"  id="post_title" name="post_title" id="post_title" value="<%=post_title %>" />
                        </td>
                    </tr>
                    <tr><td style="height:1px;background:#CCCCCC;"></td></tr>
                    <tr>
                        <td>

                            <textarea style="width:90%;border: 0px none #FFFFFF; padding: 2px; margin: 2px; width:100%; font-family: Arial, '맑은 고딕', 돋움; 
                            font-size: 12px; text-decoration: none; height: 80px;" rows="5"  name="post_contents" id="post_contents"><%=post_contents %></textarea>

                        </td>
                    </tr>
                    <tr><td style="height:1px;background:#CCCCCC;"></td></tr>
                    <tr>
                        <td>
                        <img src="" />
                        </td>
                    </tr>
                    <tr><td style="height:1px;background:#CCCCCC;"></td></tr>
                    <tr>
                        <td>
                        <div style="margin:20px 5px;">
                        <INPUT TYPE="file" NAME="file1" id="File1">
                        </div>
                        </td>
                    </tr>
                    <tr height="20"><td></td></tr>
                    <tr>
                        <td class="bbcContent"  style="font-weight:normal;line-height:150%;">
                            <%=post_contents %>
                        </td>
                    </tr>
                </table>
        </div>
    </div>
    </FORM> 
   
</div>
<div class="bottom">
</div>
</body>
</html>