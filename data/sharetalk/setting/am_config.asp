<!-- #include virtual="/_include/login_check.asp" -->
<%
    MENU = "FRIEND"
    keyword = request("keyword")

    strSQL = "p_admin_config_read "
    
    'response.Write strSQL
    'response.end
    
    set rsConfig = Server.CreateObject("ADODB.Recordset")
    rsConfig.CursorLocation = 3  
    rsConfig.Open strSQL, DbConn

    if rsConfig.EOF or rsConfig.BOF then
	   NoDataConfig = True
    Else
	   NoDataConfig = False
    end if  
      
    '페이징처리관련
    page = request("page")
  
    If NoDataConfig = False then
  	  Cus_pageSize = 100
	  rsConfig.PageSize = Cus_pageSize

	  pagecount=rsConfig.pagecount
  	  totalRecord = rsConfig.RecordCount

	  cPage = page
	  if page <> "" Then
		if cPage < 1 Then 
			cPage = 1
		end if
      else
		page = 1
		cPage = 1
	  end If	
	  rsConfig.AbsolutePage = cPage

	  lastpg = int(((totalRecord -1) / rsConfig.PageSize) + 1)

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
<title>글공유 상세</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">

<SCRIPT LANGUAGE=javascript>
<!--
  var xhr;
  
  function MemberRegister() {
      //alert("1");
      var mname = document.getElementById("member_name").value;
      var memail = document.getElementById("member_email").value;
      var mphone = document.getElementById("member_phone").value;
      var malias = document.getElementById("member_alias").value;
      var mpwd = document.getElementById("member_pwd").value;
      var mpwd2 = document.getElementById("member_pwd2").value;

      if (mname == "") {
          alert("성명을 입력하세요.");
          document.getElementById("member_name").focus();
          return false;
      }

      if (memail == "") {
          alert("이메일을 입력하세요.");
          document.getElementById("member_email").focus();
          return false;
      }
      var n = memail.search("@")
      if (n < 1) {
          alert("이메일 형식이 아닙니다.");
          document.getElementById("member_email").focus();
          return false;
      }

      if (mpwd == "") {
          alert("비밀번호를 입력하세요.");
          document.getElementById("member_pwd").focus();
          return false;
      }

      if (mpwd.length < 5) {
          alert("비밀번호 5자리 이상입니다.");
          document.getElementById("member_pwd").focus();
          return false;
      }

      if (mpwd != mpwd2) {
          alert("비밀번호 확인이 일치하지 않습니다.");
          document.getElementById("member_pwd2").focus();
          return false;
      }


      var wflag = document.getElementById("warrant_flag");

      if (wflag.checked != true) {
          alert("약관동의가 필요합니다.");
          document.getElementById("warrant_flag").focus();
          return false;
      }
      
      //alert(rprocess);
      var strurl = "member_register_set.asp?member_name=" + mname + "&member_email=" + memail + "&member_phone=" + mphone + "&member_alias=" + malias + "&member_pwd=" + mpwd;

      //alert(strurl);
      //return false;

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = MemberRegisterSet;
      xhr.open("Get", strurl);
      xhr.send(null);
  }

  function MemberRegisterSet() {
      if (xhr.readyState == 4) {
          var data = xhr.responseText;
          var slipdata = data.split(',');

          //document.getElementById("message").innerHTML = data;
          //return false;
          //alert(data);

          if (slipdata[0] > 0) {
              document.getElementById("message").innerHTML = slipdata[1];
          }
          else {
              alert(slipdata[1]);

              var siteurl = "default.asp";

              window.location.href = siteurl;
          }
      }
  }

    //-->
</SCRIPT>

</head>

<body>

    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_menu_admin.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
    <table style="width:100%">
       <tr height="4px;">
           <td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td>
       </tr>
    </table>

<div class="content" style="margin-top:70px;">

        <div style="padding:5px 0;width:100%;border-top:solid 1px #888888;">   
            <table class="main_table" border="0">
                <tr><td style="width:2%;"></td>
                    <td class="bbcContents" align="center" style="width:23%;font-size:12px;font-weight:bold;">
                        코 드
                    </td>
                    <td class="bbcContents" align="left" style="width:75%;font-size:12px;font-weight:bold;">
                        값
                    </td>
                </tr>
            </table>
        </div>
        <% if NoDataConfig = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsConfig.EOF   %>    

        <div style="padding:5px 0;width:100%;border-top:solid 1px #888888;">   
            <table class="main_table" border="0">
                <tr><td style="width:2%;"></td>
                    <td class="bbcContents" align="center" style="width:23%;font-size:12px;font-weight:normal;">
                        <%=rsConfig("CONFIGCODE") %>
                    </td>
                    <td class="bbcContents" align="left" style="width:75%;font-size:12px;font-weight:normal;">
                        <%=rsConfig("CONFIGVALUE") %>
                    </td>
                </tr>
            </table>
        </div>
     
        <%  rsConfig.MoveNext
	        Loop 
        %>
		<% else %>
        <div>
        환경변수가 없습니다.
        </div>
        <% end if         
       	set rsConfig = nothing
        %> 

    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td></tr>
    </table>
</div>

</body>
</html>