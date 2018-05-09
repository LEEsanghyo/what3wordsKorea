<!-- #include virtual="/_include/login_check.inc" -->
<%
  strSQL = "p_gim_member_read_detail  '" & Session("member_no") & "'"

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbConn

  if NOT rs.EOF and NOT rs.BOF then
    member_name = rs("member_name")
    member_interest = rs("member_interest")
    profile_desc = rs("profile_desc")

    if rs("profile_url") <> "" then
      profile_url = rs("profile_url")
    else
      profile_url = ""
    end if

    if rs("back_url") <> "" then
      back_url = rs("back_url")
    else
      back_url = ""
    end if

  end if
  set rs = nothing
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>What3Words</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">
</head>

<body>
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_detail.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px;"></div>
<div class="content">

        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr>
              <td width="40%"></td>
              <td width="20%" align="center"><span id="member_box"><%=member_name %></span><br /><img src="<%=profile_url %>" style="width:40px;border-radius:20px;" /></td>
              <td width="40%"></td>
          </tr>
        </table>
        </div>

         <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr><td>
              <% if back_url <> "" then %>
              <img src="<%=back_url %>" style="width:50%;" />
              <% else %>
              (배경 이미지 없음)
              <% end if %>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td  align="center">
              <FORM NAME="FormBack" id="FormBack" METHOD="post" ACTION="mi_profile_back_upload.asp" ENCTYPE="multipart/form-data"> 
              <INPUT TYPE="file" NAME="file1" >
              <input type="button" onclick="UploadBack();" value="저장" />
              </FORM>
              </td>
          </tr>
        </table>
        </div>

    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>

        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr><td>
              <% if back_url <> "" then %>
              <img src="<%=back_url %>" style="width:50%;" />
              <% else %>
              (배경 이미지 없음)
              <% end if %>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td  align="center">
              <FORM NAME="FormBack" id="FormBack" METHOD="post" ACTION="mi_profile_back_upload.asp" ENCTYPE="multipart/form-data"> 
              <INPUT TYPE="file" NAME="file1" >
              <input type="button" onclick="UploadBack();" value="저장" />
              </FORM>
              </td>
          </tr>
        </table>
        </div>
    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>
        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr><td>
              <% if logo_url <> "" then %>
              <img src="<%=logo_url %>" style="width:50%;" />
              <% else %>
              (프로필 이미지 없음)
              <% end if %>
          </td></tr>
        </table>
        <table width="100%;" border="0">
          <tr>
              <td  align="center">
              <FORM NAME="FormLogo" id="FormLogo" METHOD="post" ACTION="mi_profile_logo_upload.asp" ENCTYPE="multipart/form-data"> 
              <INPUT TYPE="file" NAME="file1" >
              <input type="button" onclick="UploadLogo();" value="저장" />
              </FORM>
              </td>
          </tr>
        </table>
        </div>
    <div style="text-align:center;">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td></tr>
    </table>
    </div>
        <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr>
              <td>
              <span style="text-align:center" id="profile_desc_box">
              <%  if profile_desc <> "" then %>
                  <%=profile_desc%> 
              <% else %>
              (프로필 설명 없음)
              <% end if %>
              </span>
          </td></tr>
        </table>
        <p align="center"> 관심사 </p>
        <p id="member_interest"></p><button onclick="openInterest()">관심사 수정</button>
        <table width="100%;" border="0">
          <tr>
              <td width="80%" align="center">
                  <input type="text" id="member_name" value="<%=member_name %>" style="width:45%;" />
                  <input type="text" id="member_alias" value="<%=member_alias %>" style="width:45%;" /> 
              </td>
              <td width="20%" align="center" rowspan="2"><input type="button" value="프로필 글 저장" onclick="ChangeProfile();" /></td>
          </tr>
          <tr>
              <td width="100%" align="center"><input type="text" id="profile_desc" value="<%=profile_desc %>" style="width:80%;"/> </td>
          </tr>
        </table>
        </div>
</div>
<script type="text/javascript" src="/_script/account.js"></script>
<script>
  var interest = [<%=member_interest %>];
  var names = "";
  for (i=0; i<interest.length; i++) names += interest[i] + ",";
  setInterestText(names.substring(0,names.length-1));
</script>
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