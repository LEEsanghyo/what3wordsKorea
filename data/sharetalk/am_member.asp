<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
    MENU = "FRIEND"
    keyword = request("keyword")

    strSQL = "p_gim_member_admin_read  '" & keyword & "'"

    'response.Write strSQL
    'response.end
    
    set rsFriend = Server.CreateObject("ADODB.Recordset")
    rsFriend.CursorLocation = 3  
    rsFriend.Open strSQL, DbCon

    if rsFriend.EOF or rsFriend.BOF then
	   NoDataFriend = True
    Else
	   NoDataFriend = False
    end if  
      
    '페이징처리관련
    page =request("page")
  
    If NoDataFriend = False then
  	  Cus_pageSize = 100
	  rsFriend.PageSize = Cus_pageSize

	  pagecount=rsFriend.pagecount
  	  totalRecord = rsFriend.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then 
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If	
	  rsFriend.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsFriend.PageSize) + 1)

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
    background:#888;
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

p.speech {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.8em;
    position: relative;
    width: 160px;
    height: 50px;
    text-align: center;
    line-height: 50px;
    background-color: #fff;
    border: 2px solid #666;
    -webkit-border-radius: 30px;
    -moz-border-radius: 30px;
    border-radius: 30px;
    -webkit-box-shadow: 2px 2px 4px #888;
    -moz-box-shadow: 2px 2px 4px #888;
    box-shadow: 2px 2px 4px #888;
}

p.speech:before {
  content: ' ';
  position: absolute;
  width: 0;
  height: 0;
  left: 30px;
  top: 50px;
  border: 17px solid;
  border-color: #666 transparent transparent #666;
}
p.speech:after {
  content: ' ';
  position: absolute;
  width: 0;
  height: 0;
  left: 32px;
  top: 50px;
  border: 15px solid;
  border-color: #fff transparent transparent #fff;
}


.triangle-isosceles {
    font-family:Arial, 맑은 고딕, 돋움;
    font-size : 0.8em;
    position:sticky;
    padding: 5px;
    margin: 1em 0 3em;
    color: #000;
    background: #f3961c;
    border: 2px solid #666;
    border-radius: 10px;
    background: #FFFFFF;
}

/* creates triangle */
.triangle-isosceles:after {
  content: "";
  display: block; /* reduce the damage in FF3.0 */
  position: absolute;
  bottom: -15px;
  left: 30px;
  width: 0;
  border-width: 15px 15px 0;
  border-style: solid;
  border-color: #666 transparent;
}

.date{
    display: block;
    width: 50px;
    font-weight: 400;
    background-color: #00a1e0;
    color: #FFFFFF;
    font-size: 11px;
    text-transform: uppercase;
    padding: 10px 15px;
    position: relative;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
    margin-bottom: 20px;
}

.date:after {
    content: '';
    position: absolute;
    border-style: solid;
    border-width: 10px 10px 0 0;
    border-color: #00a1e0 transparent;
    display: block;
    width: 0;
    z-index: 1;
    bottom: -10px;
    left: 0px;
}

.speech-bubble {
    background-color: #f8f8f8;
    border: 1px solid #c8c8c8;
    border-radius: 5px;
    width: 110px;
    text-align: center;
    padding: 20px;
    position: absolute;
}
.speech-bubble .arrow {
    border-style: solid;
    position: absolute;
}
 
.bottom {
    border-color: #c8c8c8 transparent transparent transparent;
    border-width: 8px 8px 0px 8px;
    bottom: -8px;
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


</style>


<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;

  function toggleAdmin(elem) {
      //alert("1");
      var mno = elem.getAttribute("mno");
      
      //alert(rprocess);
      var strurl = "am_member_admin_set.asp?member_no=" + mno;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = toggleAdminSet;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function toggleAdminSet() {
      if (xhr.readyState == 4) {

          var data = xhr.responseText;
          //alert(data);
          //return false;

          //var slipdata = data.split(',');
          var keyword = document.getElementById("keyword").value;

          var siteurl = "am_member.asp?keyword=" + keyword;

          window.location.href = siteurl;

      }
  }

  function toggleAuth(elem) {
      //alert("1");
      var mno = elem.getAttribute("mno");

      //alert(rprocess);
      var strurl = "am_member_authority_set.asp?member_no=" + mno;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = toggleAuthSet;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function toggleAuthSet() {
      if (xhr.readyState == 4) {

          var data = xhr.responseText;
          //alert(data);
          //return false;

          //var slipdata = data.split(',');
          var keyword = document.getElementById("keyword").value;

          var siteurl = "am_member.asp?keyword=" + keyword;

          window.location.href = siteurl;

      }
  }

  function PostSearch() {

      var keyword = document.getElementById("keyword").value;

      var siteurl = "fg_friendlist.asp?keyword=" + keyword;

      window.location.href = siteurl;

      //alert(keyword);

  }

    //-->
</SCRIPT>


</head>

<body>
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_admin.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px"></div>
<div class="content">

    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>

        <% if NoDataFriend = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
           RowCount = rsFriend.PageSize
           end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsFriend.EOF and RowCount > 0  %>    

        <% if admin_old <> rsFriend("admin_desc") then %>
        <div style="width:100%;padding:15px 20px;color:#3388cc;">   
        <%=rsFriend("admin_desc") %>
        </div>
        <% end if %>

        <div style="padding:5px 0;width:100%;border-top:solid 1px #888888;">   
            <table class="main_table" border="0">
                <tr><td style="width:2%;"></td>
                    <td class="bbcContents" style="width:38%;">
                        <table style="width:100%;" border="0">
                            <tr>
                                <td width="25%" align="left">
                                    <a href="fg_friendtopic.asp?member_no=<%=rsFriend("member_no") %>">
                                        <img src="<%=rsFriend("logo_url") %>" style="width:25px;height:25px;border-radius:20px;"/>
                                        </a>
                                </td>
                                <td width="5px;"></td>
                                <td><a href="fg_friendtopic.asp?member_no=<%=rsFriend("member_no") %>" style="font-size:12px;">
                                    <%=rsFriend("member_name") %></a></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                    <td class="bbcContents" align="center" style="width:22%;">
                    </td>
                    <td class="bbcContents" align="center" style="width:10%;">
                        <span style="padding:3px 0;font-size:12px;font-weight:bold;color:#000000;cursor:pointer;" onclick="toggleAdmin(this);" mno="<%=rsFriend("member_no") %>" >
                            <%=rsFriend("admin_desc") %></span>
                    </td>
                    <td class="bbcContents" align="center" style="width:10%;">
                        <span style="padding:3px 0;font-size:12px;font-weight:bold;color:#000000;cursor:pointer;" onclick="toggleAuth(this);" mno="<%=rsFriend("member_no") %>" >
                            <%=rsFriend("authority_desc") %></span>
                    </td>
                    <td class="bbcContents" align="right" style="width:9%;">
                    </td>
                    <td class="bbcContents" align="right" style="width:9%;">

                    </td>
                </tr>
            </table>
        </div>
     
        <%  admin_old = rsFriend("admin_desc")
        	RowCount = RowCount - 1
        	rsFriend.MoveNext
	        Loop 
        %>
		<% else %>
        <div>
        	회원이 없습니다.
        </div>
        <% end if         
       	set rsFriend = nothing
        %> 

    <!-- 페이징 처리-->					
    <%if NoDataFriend = false Then
	Cus_Tar = "keyword=" & keyword 
    %>
    <!--#include virtual="/_include/asp_page_function.asp"-->
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
    <%
	Response.Write ShowPageBar("fg_friendlist.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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