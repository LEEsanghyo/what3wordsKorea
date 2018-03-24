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
body { font-family: sans-serif; overflow: hidden; background:#FFFFFF;}
a { text-decoration: none; color: #00A5CC; }
li { list-style-type: none; }
header { 
	width: 100%; 
	height: 50px; 
	margin: auto;
    background:#0cc738;
	border-bottom: 1px solid #EEE;
}
#brand {
	float: left;
	line-height: 50px;
	color: #FFFFFF;
	font-size: 25px;
	font-weight: bolder;
}
nav { width: 100%; text-align: center; }
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
	padding: 10px 20px;
	background: #EEEEEE;
	color: #0cc738;
	cursor: pointer;
	float: right;
	margin-top: 4px;
	border-radius: 5px;
}
#menuToggle { display: none; }
#menuToggle:checked ~ .menu { position: absolute; left: 0; }
#menuToggle:checked ~ .title { position: absolute; left: 260px; top:50px; } 
#menuToggle:checked ~ .content { position: absolute; left: 260px; top:90px; }
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

.content {
	width: 100%;
	margin: auto;
    font-size:16px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    margin:10px;
    background:#FFFFFF;

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
    width:90%;
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

</style>

<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;
  
  function PostSave() {
      //alert("1");
      var pno = document.getElementById("post_no").value;
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
      var strurl = "ws_mytopic_edit_set.asp?post_no=" + pno + "&post_title=" + ptitle + "&post_contents=" + pcontents;

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
          window.location.href = strurl;

      }
  }

//-->
</SCRIPT>


</head>

<body>
<input type="hidden" id="post_no" value="<%=post_no %>" />
<input type="checkbox" id="menuToggle">

    <% top_menu = "글공유" %>
<header>
        <div id="brand">
            <a href="ws_mytopic.asp"><span style="margin:3px 3px 3px 10px;padding:3px 10px;font-size:24px;color:#ffffff;">←</span></a>
            <select>
                <option><span style="padding:5px 3px;font-size:16px;color:#000000;">전체공개</span></option>
                <option><span style="padding:5px 3px;font-size:16px;color:#000000;">비공개</span></option>
            </select>
            <span style="padding:5px 3px;font-size:16px;color:#000000;cursor:pointer;" onclick="PostSave();">올리기</span>
        </div>
</header>

<div class="title">
    글수정
</div>
<div class="content">

    <table class="main_table">
        <tr>
            <td class="bbcTitle">
                <input type="text" style="width:100%;" id="post_title" value="<%=post_title %>" />
            </td>
        </tr>
        <tr>
            <td class="bbcContent">

                <textarea style="width:100%;" rows="5"  id="post_contents"><%=post_contents %></textarea>

            </td>
        </tr>
        <tr height="2px;"><td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: #dddddd"></td></tr>
    </table>

    <div style="margin:20px 0;">
            <a href="#"><span style="margin:3px 3px;padding:3px 3px;border:solid 3px #888888;border-radius:3px;color:#0000ff;">사진</span></a>
            <a href="#"><span style="margin:3px 3px;padding:3px 3px;border:solid 3px #888888;border-radius:3px;color:#0000ff;">동영상</span></a>
    </div>
</div>
<div class="bottom">
</div>
</body>
</html>