<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
    MENU = "MY"
    keyword = request("keyword")

    strSQL = "p_gim_member_read_detail  '" & Session("member_no") & "'"

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1  
   
    if NOT rs.EOF and NOT rs.BOF then

      member_name = rs("member_name")
      member_alias = rs("member_alias")

      if rs("logo_url") <> "" then
        logo_url = rs("logo_url")
      else
        logo_url = "images/image1.jpg"
      end if

      if rs("back_url") <> "" then
        back_url = rs("back_url")
      else
        back_url = "images/back1.jpg"
      end if

    end if 

    set rs = nothing


    strSQL = "p_tsh_post_member_read  '" & Session("member_no") & "','" & keyword & "'"
    
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
	  Cus_pageSize = 100
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

%>
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
    width:100%;
    font-size:14px;
    font-family:Arial, 맑은 고딕, 돋움;
    font-weight:bold;
    padding:0px;
    margin:0px;
    position:fixed;
    bottom:0px;
    left:0px;
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
    font-family:Arial, 맑은 고딕, 돋움; font-size:12px;cursor:pointer;
}

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
				width: 300px; margin: 0px; text-align: left;position:absolute;top:100px;left:50px;right:-50;border-radius:0px;
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

  function postPopup(elem) {

      var pno = elem.getAttribute("pno");
      document.getElementById("post_no").value = pno;
      //alert(pno);

      toggle_visibility('popupBoxOnePosition');

  }


  function postEdit() {

      var pno = document.getElementById("post_no").value;
      //alert(pno);
      toggle_visibility('popupBoxOnePosition');

      var strurl = "ws_mytopic_edit.asp?post_no=" + pno;
      //alert(strurl);
      window.location.href = strurl;

  }

  function postDelete() {

      var pno = document.getElementById("post_no").value;
      //alert(pno);
      toggle_visibility('popupBoxOnePosition');
      toggle_visibility('popupBoxDelete');

  }

  function postDeleteConfirm() {

      var pno = document.getElementById("post_no").value;
     
      //alert(rprocess);
      var strurl = "ws_mytopic_delete_set.asp?post_no=" + pno;

      toggle_visibility('popupBoxDelete');

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = postDeleteConfirmSet;
      xhr.open("Get", strurl);
      xhr.send(null);

  }

  function postDeleteConfirmSet() {
      if (xhr.readyState == 4) {
          var data = xhr.responseText;
          //var slipdata = data.split(',');

          //alert("deleted...");
          //alert(data);

          var strurl = "ws_mytopic.asp";
          window.location.href = strurl;
      }

  }


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


  function PostSearch() {

      var keyword = document.getElementById("keyword").value;

      var siteurl = "ws_mytopic.asp?keyword=" + keyword;

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
    
<input type="hidden" name="post_no" value="" id="post_no" /> 	

    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div class="content" style="margin-top:70px;">
    <div style="text-align:center;">
    <table width="100%;" border="0">
        <tr><td><img src="<%=back_url %>" style="width:100%;" /></td></tr>
    </table>
    <table width="100%;" border="0">
        <tr height="10px;">
            <td width="10%"></td>
            <td width="80%" align="center"><%=member_name %><br /><img src="<%=logo_url %>" style="width:40px;border-radius:20px;" /></td>
            <td width="10%"></td>
        </tr>
    </table>
    </div>

    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>

    	<% if NoDataPost = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsPost.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsPost.EOF and RowCount > 0  %>     
    <div style="width:100%;display:flex;justify-content:center;">  
        <div style="width:95%;margin:10px 0px;">   
           <table class="main_table">
           <tr>
            <td class="bbcTitle">
                <a href="ws_mytopic_detail.asp?post_no=<%=rsPost("post_no") %>"><%=rsPost("post_title") %></a>              
            </td>
               <td align="right"><span style="margin-left:30px;cursor:pointer;" onclick="postPopup(this);" pno="<%=rsPost("post_no") %> ">&#9776;</span></td>
           </tr>
           <tr>
           <td class="bbcDate">
               <table style="width:100%;">
               <tr><td width="8%" rowspan="2" valign="bottom" align="left"><img src="<%=rsPost("logo_url") %>" style="width:40px;height:40px;border-radius:20px;"/></td>
                   <td><%=rsPost("member_name") %></td></tr>
               <tr><td valign="top"><span style="font-size:9px;color:#808080;"><%=rsPost("register_date") %></span></td></tr>
               </table>
           </td>
           </tr>
           <tr height="20">
               <td class="bbcTitle"></td>
           </tr>
           <tr>
            <td class="bbcContent"  style="font-weight:normal;line-height:150%;">
                <a href="ws_mytopic_detail.asp?post_no=<%=rsPost("post_no") %>"><%=rsPost("post_contents") %></a>
            </td>
               <td></td>
           </tr>
           <tr height="20">
               <td class="bbcTitle"></td>
           </tr>

                <tr style="height:15px;"><td></td></tr>

                <%                     
                ' ENGAGE
                strSQL = "p_tsh_post_engage_read '" & rsPost("post_no") & "'"
        
                Set rs = Server.CreateObject("ADODB.RecordSet")
                rs.Open strSQL, DbCon, 1, 1    

                if NOT rs.EOF and NOT rs.BOF then %>
                <tr id="trbox_<%=rsPost("post_no") %>" style="display:block;"><td>                  
                        <div id="engagebox_<%=rsPost("post_no") %>">
                        <% Do While Not rs.EOF %>    
                        <a href="fg_friendtopic.asp?member_no=<%=rs("member_no") %>">
                        <img src="<%=rs("logo_url") %>" style="margin-right:10px;width:30px;height:30px;border-radius:15px;" alt="<%=rs("member_name") %>" />
                        </a>
                        <%     
                        rs.MoveNext
                        Loop 
                        %>
                        </div>
                </td>
                </tr>
                <% else %>
                <tr id="trbox_<%=rsPost("post_no") %>" style="display:none;"><td>
                        <table style="width:90%;">
                        <tr>
                        <td>                                    
                        <div id="engagebox_<%=rsPost("post_no") %>">
                        </div>
                        </td>
                        </tr>
                        </table>
                </td>
                </tr>
                <%
                     end if         
                set rs = nothing
                %> 

           <tr>
                    <td class="bbcDate">
                        <span style="padding:5px 0;font-weight:bold;border-radius:2px;cursor:pointer;" id="engage_<%=rsPost("post_no") %>" name="engage<%=rsPost("post_no") %>" pno="<%=rsPost("post_no") %>" code="GOOD" onclick="PostEngage(this);">공감
                             <%=rsPost("engage_cnt") %> </span> 
                        <a href="ws_mytopic_detail.asp?post_no=<%=rsPost("post_no") %>"><span style="margin-left:20px;padding:5px 0;font-weight:bold;border-radius:2px;cursor:pointer;">댓글 <%=rsPost("answer_cnt") %></span></a>     
                    </td>
           </tr>
           <tr height="2px;"><td  colspan="2"></td></tr>

           </table>
		<div style="height:50px;"></div>
            </div>
        </div>
            <table style="width:100%">
               <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
               </td></tr>
            </table>
        <%                                
        	RowCount = RowCount - 1
        	rsPost.MoveNext
	        Loop 
        %>
        <% end if         
       	set rsPost = nothing
        %> 

    <!-- 페이징 처리-->					
    <%if NoDataPost = false Then
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

<div class="bottom">
    <table style="width:100%; height:40px; text-align: center; vertical-align: middle;background:#FFFFFF;">
        <tr><td colspan="4" style="border-bottom:solid 1px #CCCCCC;"></td></tr>
        <tr><td width="25%;" align="center" style="font-size:14px;font-family:Arial,맑은 고딕,돋움;border-right:solid 1px #CCCCCC;padding:10px;">
                <a href="ws_mytopic_write.asp">글쓰기</a>
            </td>
            <td width="25%;" align="center" style="font-size:14px;font-family:Arial,맑은 고딕,돋움;border-right:solid 1px #CCCCCC;padding:10px;"></td>
            <td width="25%;" style="font-size:14px;font-family:Arial,맑은 고딕,돋움;border-right:solid 1px #CCCCCC;padding:10px;"></td>
            <td width="25%;"></td>
        </tr>
    </table>
</div>
</body>
</html>

    <!-- post action start -->
		<div id="popupBoxOnePosition">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="postEdit();" style="cursor:pointer;">글수정</a>
                        </td>
                    </tr
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="postDelete();" style="cursor:pointer;">글삭제</button>
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

    <!-- delete action start -->
		<div id="popupBoxDelete">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;">
                        <td colspan="3" align="center">
                            해당 글을 삭제하시겠습니까?
                        </td>
                    </tr
                    <tr><td colspan="3" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;">
                        <td width="50%;" align="center">
                            <a onclick="postDeleteConfirm();" style="cursor:pointer;text-align:center;">확인</a>
                        </td>
                        <td style="width:1px;background:#CCCCCC;"></td>
                        <td align="center">
                            <a onclick="toggle_visibility('popupBoxDelete');" style="cursor:pointer;text-align:center;">취소</a>
                        </td>
                    </tr>
                    </table>
				</div>
			</div>
		</div>
    <!-- delete action end -->

<!-- #include virtual="/_include/connect_close.inc" -->