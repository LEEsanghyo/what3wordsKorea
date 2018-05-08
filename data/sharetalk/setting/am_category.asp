<!-- #include virtual="/_include/login_check.asp" -->
<%
    MENU = "CATEGORY"
    keyword = request("keyword")

    if request("cat_no") <> "" then
       cat_no = request("cat_no")
      
       strSQL = "p_tsm_category_detail_read  '" & cat_no & "'"
    
       Set rs = Server.CreateObject("ADODB.RecordSet")
       rs.Open strSQL, DbConn, 1, 1  
   
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
    rsCategory.Open strSQL, DbConn

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
<link rel="stylesheet" href="/_include/style.css" type="text/css">


<SCRIPT LANGUAGE=javascript>
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