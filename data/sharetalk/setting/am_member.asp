<!-- #include virtual="/_include/login_check.asp" -->
<%
    MENU = "FRIEND"
    keyword = request("keyword")

    strSQL = "p_gim_member_admin_read  '" & keyword & "'"

    'response.Write strSQL
    'response.end
    
    set rsFriend = Server.CreateObject("ADODB.Recordset")
    rsFriend.CursorLocation = 3  
    rsFriend.Open strSQL, DbConn

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
<link rel="stylesheet" href="/_include/style.css" type="text/css">


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
                                        <img src="<%=rsFriend("profile_url") %>" style="width:25px;height:25px;border-radius:20px;"/>
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