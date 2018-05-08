<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
    member_no = request("member_no")
    keyword = request("keyword")
    

    strSQL = "p_gim_member_read_detail  '" & member_no & "'"

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
    
    strSQL = "p_tsh_post_member_read  '" & member_no & "','" & keyword & "'"

    
   ' response.Write back_url & "SSSSSSSSS"
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
<title>글공유 HOME</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">


<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;
  
  function PostEngage(elem) {
      //alert("1");
      var pno = elem.getAttribute("pno");
      var code = elem.getAttribute("code");      

      var myNodelist = document.getElementsByName("engage"+pno);
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
    <!-- #include virtual="/_include/top_detail_friend.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px;"></div>
<div class="content">

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

    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>

    	        <% if NoDataPost = False then ' 데이터가 있으면 데이터 출력 %>
                <% if FirstPage <> 1 then
	               RowCount = rsPost.PageSize
	               end If ' 데이터가 있으면 데이터 출력 
                   Do While Not rsPost.EOF and RowCount > 0  %>    
        <div style="width:100%;padding: 20px 10px;">   
            <table class="main_table" border="0">
                <tr>
                    <td class="bbcTitle"><a href="fg_friendtopic_detail.asp?post_no=<%=rsPost("post_no") %>"><%=rsPost("post_title") %></a></td>
                </tr>
                <tr>
                    <td class="bbcDate">
                        <table style="width:100%;">
                            <tr><td width="8%" rowspan="2" valign="bottom" align="left">
                                <%  if rsPost("logo_url") <> "" then
                                      logo_url = rsPost("logo_url")
                                    else
                                      logo_url = "images/member1.png"
                                    end if  %>
                                <img src="<%=logo_url %>" style="width:40px;height:40px;border-radius:20px;"/></td>
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
                        <a href="ws_bbc_detail.asp?post_no=<%=rsPost("post_no") %>"><%=rsPost("post_contents") %></a>
                    </td>
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
                        <img src="<%=rs("logo_url") %>" style="margin-right:10px;width:30px;height:30px;border-radius:15px;"/>
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
                        <a href="ws_bbc_detail.asp?post_no=<%=rsPost("post_no") %>"><span style="margin-left:20px;padding:5px 8px;font-weight:bold;border-radius:2px;cursor:pointer;">댓글 <%=rsPost("answer_cnt") %></span></a>                        
                    </td>
                </tr>
            </table>
        </div>
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
                          </td></tr>
    </table>
     
        <%                                
        	RowCount = RowCount - 1
        	rsPost.MoveNext
	        Loop 
        
            end if         
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
	Response.Write ShowPageBar("fg_friendtopic.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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