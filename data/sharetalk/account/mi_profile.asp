﻿<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
  strSQL = "p_gim_member_read_detail  '" & Session("member_no") & "'"

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbConn

  if NOT rs.EOF and NOT rs.BOF then
    member_name = rs("member_name")
    member_interest = rs("member_interest")
    profile_desc = rs("profile_desc")
    prof_url = rs("profile_url")
    back_url = rs("back_url")
  end if
  set rs = nothing
%>

<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="/_css/modal.css?ver=1">
    <meta name="author" content="S A Bokhari">
    <meta name="description" content="글공유">
    <meta name="keywords" content="글공유">
    <title>What3Words</title>
    <link rel="stylesheet" href="/_css/style.css" type="text/css">
    <style type="text/css">
      #profile { 
        width: 120px; height: 120px;
        object-fit: cover;
        object-position: top;
        border-radius: 50%;
      }
    </style>
  </head>

  <body>
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_detail.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
    <div class="content" style="margin-top:70px;">
      <div style="margin:5px;border: solid 0px #DDDDDD; position: relative;">
        <input type="hidden" id="back_url">
        <img id="back" src="<%=back_url %>" style="width:100%;height:150px" onclick="document.getElementById('id01').style.display='block'"/>
      </div>
      <div align="center" style="position: relative; top: -65px;">
        <input type="hidden" id="profile_url">
        <img id="profile" src="<%=prof_url %>" onclick="document.getElementById('id01').style.display='block'"/>
        <p>
          <input id="member_name" type="text" align="center" style="text-align: center; background-color: #FFFFFF; border: none;" value="<%=member_name%>" >
        </p>
      </div>
      <div style="width:100%;display:flex;justify-content:center;margin: 10px; position: relative; top: -50px">  
        <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="70%" style="border-bottom:solid  1px #CCCCCC;">
              관심사 <text style="margin-left: 15px; width:50%;background-color: #FFFFFF;" id="interest_text" disabled></text>
                <input type="hidden" id="member_interest"><button style="margin-left: 10px;" onclick="openInterest()">관심사 수정</button>
            </td>
          </tr>
          <tr>
           <td>소개</td>
          </tr>
          <tr>
            <td width="70%" style="border-bottom:solid  1px #CCCCCC;"><input type="text" id="profile_desc" style="border:none; margin-left: 15px; width:50%;background-color: #FFFFFF;" type="text" value="<%=profile_desc%>"></td>
          </tr>
          <tr>
            <td align="center">
              <input type="button" value="프로필 글 저장" onclick="ChangeProfile();" />
            </td>
          </tr>
        </table>
      </div>
    </div>

<!--
    <div class="content">
      <div style="margin:20px 0;text-align:center;">
        <table width="100%;" border="0">
          <tr>
            <td  align="center">
              <FORM NAME="FormBack" id="FormBack" METHOD="post" ACTION="http://localhost:1337/uploadback" ENCTYPE="multipart/form-data"> 
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
            <img src="<%=prof_url %>" style="width:100px;height:100px" />
          </td></tr>
          </table>
          <table width="100%;" border="0">
            <tr>
              <td  align="center">
                <FORM NAME="FormLogo" id="FormLogo" METHOD="post" ACTION="http://localhost:1337/uploadprof" ENCTYPE="multipart/form-data"> 
                <INPUT TYPE="file" NAME="file1" >
                <input type="submit" value="저장" />
                </FORM>
              </td>
            </tr>
        </table>
      </div>
-->
    </div>
    <div id="id01" class="w3-modal">
      <div class="w3-modal-content">
        <div class="w3-container">
            <form id="upload" method="POST" enctype="multipart/form-data">
              <input type="file" name="imgupload" id="file" style="display:none" accept=".jpg,.png,.bmp,.jpeg,.gif" onchange="upload()">
              <p onclick="eventOccur(document.getElementById('file'), 'click')">이미지 선택</p>
            </form>
            <p>이미지 삭제</p>
            <p onclick="document.getElementById('id01').style.display='none'">취소</p>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript" src="/_script/account.js?ver=1"></script>
    <script type="text/javascript">
      var purl = '<%=prof_url%>';
      var interest = [<%=member_interest%>];
      setInterestText(interest);

      function eventOccur(evEle, evType){
        if (evEle.fireEvent) {
          evEle.fireEvent('on' + evType);
        } else {
          //MouseEvents가 포인트 그냥 Events는 안됨~ ??
          var mouseEvent = document.createEvent('MouseEvents');
          /* API문서 initEvent(type,bubbles,cancelable) */
          mouseEvent.initEvent(evType, true, false);
          var transCheck = evEle.dispatchEvent(mouseEvent);
          if (!transCheck) {
          //만약 이벤트에 실패했다면
          console.log("클릭 이벤트 발생 실패!");
          }
        }
        document.getElementById('id01').style.display='none';
      }
    </script>
  </body>
</html>

<!-- login action start -->
<div id="popupBoxLogin">
  <div class="popupBoxWrapper">
    <div class="popupBoxContent">
      <table width="100%" border="0">
        <tr style="height:40px;">
          <td width="10%;" align="center"></td>
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