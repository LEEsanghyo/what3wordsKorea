<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
    MENU = "CATEGORY"
    keyword = request("keyword")

    if request("cat_no") <> "" then
       cat_no = request("cat_no")
      
       strSQL = "p_tsm_category_detail_read  '" & cat_no & "'"
    
       Set rs = Server.CreateObject("ADODB.RecordSet")
       rs.Open strSQL, DbCon, 1, 1  
   
       if NOT rs.EOF and NOT rs.BOF then

        cat_name = rs("cat_name")

       end if 

       set rs = nothing  

    end if

    strSQL = "p_tsm_category_list_read "

    'response.Write strSQL
    'response.end
    
    set rsCategory = Server.CreateObject("ADODB.Recordset")
    rsCategory.CursorLocation = 3  
    rsCategory.Open strSQL, DbCon

    if rsCategory.EOF or rsCategory.BOF then
	   NoDataCategory = True
    Else
	   NoDataCategory = False
    end if  
      
    '페이징처리관련
    page =request("page")
  
    If NoDataCategory = False then
  	  Cus_pageSize = 20
	  rsCategory.PageSize = Cus_pageSize

	  pagecount=rsCategory.pagecount
  	  totalRecord = rsCategory.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then 
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If	
	  rsCategory.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsCategory.PageSize) + 1)

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

/* Category button design start */
		.btnCategory {
		  background: #3498db;
		  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
		  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
		  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
		  background-image: -o-linear-gradient(top, #3498db, #2980b9);
		  background-image: linear-gradient(to bottom, #3498db, #2980b9);
		  -webkit-border-radius: 28;
		  -moz-border-radius: 28;
		  border-radius: 28px;
		  font-family: Arial,맑은 고딕,돋움;
		  color: #ffffff;
		  font-size: 12px;
		  padding: 5px 10px 5px 10px;
		  text-decoration: none;
		  width:50px;
		 
		}

		.btnCategory:hover {
		  background: #3cb0fd;
		  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
		  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
		  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
		  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
		  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
		  text-decoration: none;
		}
/* Category button design end */
</style>


<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;

  function setCatgory() {
      //alert("1");
      var cno = document.getElementById("cat_no").value;
      var cname = document.getElementById("cat_name").value;
      
      //alert(rprocess);
      var strurl = "am_category_set.asp?cat_no=" + cno + "&cat_name=" + cname;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = setCatgoryResult;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function setCatgoryResult() {
      if (xhr.readyState == 4) {

          var data = xhr.responseText;
          alert(data);
          //return false;

          location.reload();

      }
  }

  function deleteCatgory(elem) {
      //alert("1");
      var cno = elem.getAttribute("cno");

      //alert(rprocess);
      var strurl = "am_category_delete.asp?cat_no=" + cno;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = deleteCatgoryResult;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function deleteCatgoryResult() {
      if (xhr.readyState == 4) {

          var data = xhr.responseText;
          alert(data);
          //return false;

          location.reload();

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
		<div style="height:25px;margin:5px;color:#3388cc;font-weight:bold;">
		카테고리
		</div>
        <input type="hidden"  id="cat_no" value="<%=cat_no %>" />

		<div style="margin:5px;">
			<table><tr>
				<td><input type="text" style="width:120px;height:20px;" id="cat_name" value="<%=cat_name %>"></td>
				<td><% if cat_no > "0" then %><a href="am_category.asp"><input type="button" value="NEW" class="btnCategory"></a><% end if %></td>
				<td>
                    <% if cat_no > "0" then %>
                    <input type="button" value="수정" class="btnCategory" onclick="setCatgory();" >
                    <% else %>
                    <input type="button" value="입력" class="btnCategory" onclick="setCatgory();" >
                    <% end if %>
				</td></tr>
			</table>
		</div>
		<div style="margin:5px;">
			<table style="width:100%;border:0px;">
				<tr style="height:1px;background:#cdcdcd;"><td colspan="4"></td></tr>
				<tr style="height:25px;">
					<td style="width:55px;">카테고리</td>
					<td style="width:15px;"></td>
					<td style="width:15px;"></td>
					<td style="width:15px;"></td>
				</tr>

				<% if NoDataCategory = False then ' 데이터가 있으면 데이터 출력 %>
				<% if FirstPage <> 1 then
	               RowCount = rsCategory.PageSize
	               end If ' 데이터가 있으면 데이터 출력 
                   Do While Not rsCategory.EOF and RowCount > 0  %>    

				<tr style="height:1px;background:#cdcdcd;"><td colspan="4"></td></tr>
				<tr>
					<td><a href="am_category.asp?cat_no=<%=rsCategory("cat_no") %>"><%=rsCategory("cat_name") %></a></td>
					<td></td>
					<td><input type="button" value="X" class="btnCategory" cno="<%=rsCategory("cat_no") %>" onclick="deleteCatgory(this);" ></td>
					<td></td>
				</tr>

				<%                                
				RowCount = RowCount - 1
				rsCategory.MoveNext
				Loop 
				%>
				<% else %>
				<tr style="height:1px;background:#cdcdcd;"><td colspan="4"></td></tr>
				<tr>
					<td colspan="4" align="center">카테고리가 없습니다.</td>
				</tr>
				<% end if         
				set rsPost = nothing
				%> 

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