﻿﻿<!-- #include virtual="/_include/connect.inc" -->
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
  </head>

  <body>
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_detail.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
    <div class="content" style="margin-top:70px;">
      <div style="margin:5px;border: solid 0px #DDDDDD; position: relative;">
        <img id="back" src="<%=back_url %>" style="width:100%;height:150px" onclick="document.getElementById('id01').style.display='block'"/>
      </div>

      <div align="center" style="position: relative; top: -65px;">
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
    </div >

    <div id="id01" class="w3-modal">
      <div class="w3-modal-content">
        <div class="w3-container">
          <form id="uploadback" method="POST" enctype="multipart/form-data">
            <input type="file" name="backupload" id="b" style="display:none" accept=".jpg,.png,.bmp,.jpeg,.gif" onchange="upload(0)">
            <p onclick="eventOccur(document.getElementById('b'), 'click')">배경 이미지 선택</p>
          </form>
          <form id="uploadprof" method="POST" enctype="multipart/form-data">
            <input type="file" name="profupload" id="p" style="display:none" accept=".jpg,.png,.bmp,.jpeg,.gif" onchange="upload(1)">
            <p onclick="eventOccur(document.getElementById('p'), 'click')">프로필 이미지 선택</p>
          </form>
          <p onclick="deleteImg();document.getElementById('id01').style.display='none'">프로필 이미지 삭제</p>
          <p onclick="document.getElementById('id01').style.display='none'">취소</p>
        </div>
      </div>
    </div>

    <script type="text/javascript" src="/_script/account.js"></script>
    <script type="text/javascript">
      var interest = [<%=member_interest%>];
      document.getElementById('member_interest').value = interest;
      setInterestText(interest);

      function eventOccur(evEle, evType){
        if (evEle.fireEvent) evEle.fireEvent('on' + evType);
        else {
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
<!-- #include virtual="/_include/connect_close.inc" -->