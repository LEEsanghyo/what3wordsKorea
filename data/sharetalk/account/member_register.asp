<%
	email = request("member_email")
	nickname = request("member_nickname")
	uniqId = request("member_uniqID")
	age = request("member_age")
	if (email = "") then
		oflag = 0
	else
		oflag = 1
	end if
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="한국형 신주소">
<meta name="keywords" content="Korean word address">
<title>한국형 단어 신주소</title>
		<link rel="stylesheet" href="/_include/style.css" type="text/css">
		<script type="text/javascript" src="/_script/login.js?ver=3"></script>
		<script type="text/javascript" src="/_script/account.js"></script>
<style type="text/css">
    
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
				width: 300px; margin: 0px; text-align: left;position:absolute;top:50px;left:30px;border-radius:0px;
			}
			.popupBoxContent{
				background-color: #FFF; padding: 0px;border-radius:2px;
			}
/* 팝업 메뉴 end */
/* 팝업 카테고리 메뉴 start */
			#popupBoxCategoryPosition{
				top: 0; left: 0; position: fixed; width: 100%; height: 120%;
				background-color: rgba(0,0,0,0.7); display: none;border-radius:0px;
			}
            #popupBoxCategoryDelete{
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
			.popupBoxCategoryWrapper{
				width: 300px; margin: 0px; text-align: left;position:absolute;top:50px;left:30px;border-radius:0px;
			}
			.popupBoxCategoryContent{
				background-color: #FFF; padding: 0px;border-radius:2px;
			}
/* 팝업 카테고리 메뉴 end */

</style>

</head>
    
<body>
    
		<% top_menu = "회원가입" %>
		<!-- #include virtual="/_include/top_menu_account.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->


    <!-- post action start -->
		<div id="popupBoxOnePosition">
			<div class="popupBoxWrapper">
				<div class="popupBoxContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="0" sdesc="개별" >개별</a>
                        </td>
                    </tr
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="1" sdesc="프로젝트" >프로젝트</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="2"  sdesc="전체" >전체</button>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setScope(this);" style="cursor:pointer;" scd="3" sdesc="외부"  >외부</button>
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
    <!-- post category action start -->
		<div id="popupBoxCategoryPosition">
			<div class="popupBoxCategoryWrapper">
				<div class="popupBoxCategoryContent">
                    <table width="100%" border="0">
                    <tr style = "height:40px;text-align:left;border-bottom:solid 1px #CCCCCC">
                        <td width="40px"></td>
                        <td>
                            <a onclick="setCategory(this);" style="cursor:pointer;" catno="0" catdesc="전체">(전체)</a>
                        </td>
                    </tr>
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>

                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="toggle_visibility('popupBoxCategoryPosition');" style="cursor:pointer;">취소</button>
                        </td>
                    </tr>
<!--
                    <tr><td colspan="2" style="height:1px;text-align:left;border-bottom:solid 1px #CCCCCC"></td></tr>
                    <tr style="height:40px;text-align:left;">
                        <td width="40px"></td>
                        <td>
                            <a onclick="toggle_visibility('popupBoxCategoryPosition');" style="cursor:pointer;">유머</button>
                        </td>
                    </tr>   -->
                    </table>
				</div>
			</div>
		</div>
    <!-- post category action end -->
<div class="content" style="margin-top:70px;">

      <div style="height:5px;">
      </div>
      <div style="margin:5px;border:solid 0px #DDDDDD;">
      <table border="0" CELLSPACING="0" cellpadding="0" style="width:100%;" >
      <tr>
      <td width="60%"><span style="margin-left:3px;font-size:16px;color:#888888;font-weight:bold;">MEMBER REGISTER
      <% if email <> "" then %> - 나머지 정보를 입력해주시면 가입이 완료됩니다. <% end if %>
      </span>
      </td>
      <td width="40%" align="right">
      </td>
      </tr>
      </table>
      </div>

    <div style="width:100%;display:flex;justify-content:center;">  
        <div style="width:95%;margin:10px 0px;">   
                <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3" style="border-bottom:solid  1px #CCCCCC;">
                            <input type="email" style="width:99%;border:none 0px #CCCCCC; padding: 2px; margin: 2px; font-family: Arial, '맑은 고딕', 돋움; text-decoration: none; font-size: 16px; height: 30px;background-color:#ffffff;" name="member_email"  id="member_email" 
											<% if email = "" then %>
												placeholder="이메일" required >
											<% else %>
												value="<%=email %>" disabled >
											<% end if %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border-bottom:solid  1px #CCCCCC;">
                            <input type="email" style="width:99%;border:none 0px #CCCCCC; padding: 2px; margin: 2px; font-family: Arial, '맑은 고딕', 돋움; text-decoration: none; font-size: 16px; height: 30px;background-color:#ffffff;" name="member_name"  id="member_name" placeholder="닉네임" required 
                            <% if email <> "" then %>
                                value = "<%=nickname%>">
                            <% else %>
                                >
                            <% end if %>
                        </td>
                    </tr>
					<% if email="" then %>
					<tr height=38>
                         <td width="70%" style="border-bottom:solid  1px #CCCCCC;">비밀번호
						<input type="password" name="member_pwd" size="200" style="width:50%;border:none 0px #CCCCCC; padding: 2px; margin: 2px; font-family: Arial, '맑은 고딕', 돋움; text-decoration: none; font-size: 16px; height: 30px;background-color:#ffffff;" class="input" ID="member_pwd" placeholder="비밀번호 (6자리 이상)" required >
                        </td>
                        <td width="1%" style="border-bottom:solid  1px #CCCCCC;">
                        </td>
                        <td width="30%" style="border-bottom:solid  1px #CCCCCC;">확인
							<input type="password" name="member_pwd2" size="255" style="width:50%;border:none 0px #CCCCCC; padding: 2px; margin: 2px; font-family: Arial, '맑은 고딕', 돋움; text-decoration: none; font-size: 16px; height: 30px;background-color:#ffffff;" class="input" ID="member_pwd2" placeholder="비밀번호 확인" required >
                        </td>
                    </tr>
					<% else %>
					<input type="hidden" id = "member_pwd" value = "">
					<input type="hidden" id = "member_pwd2" value = "">
					<% end if %>
                    <tr height="38">
                        <td style="border-bottom:solid  1px #CCCCCC;">
												<input type="hidden" name="member_phone" class="input" id="member_phone">
												<select name="telecom" id="telecom" style="width:15%;height: 30px;font-size: 16px; text-align:center;border: solid 1px #dddddd;">
													<option value="SKT">SKT</option>
													<option value="KT">KT</option>
													<option value="LG">LG U+</option>
												</select>
                            <span style="font-size: 12px; font-weight:normal;">
                            <input type="text" name="phone1" style="width:15%;height: 30px;font-size: 16px; text-align:center;border: solid 1px #dddddd;" class="input" ID="phone1"  > 
                            - <input type="text" name="phone2" style="width:15%;height: 30px;font-size: 16px; text-align:center;border: solid 1px #dddddd;" class="input" ID="phone2" >   
                            - <input type="text" name="phone3" style="width:15%;height: 30px;font-size: 16px; text-align:center;border: solid 1px #dddddd;" class="input" ID="phone3" >   
                            </span> 
                        </td>
                    </tr>
                    <tr height="38">
                        <td colspan="3" style="border-bottom:solid 1px #CCCCCC;">
                            연령대 : 
                            <% if age <> "undefined" then %>
                                <input type="hidden" name="member_age" ID="member_age" value="
                                <% if age = "10-19" then %>10"
                                <% elseif age = "20-29" then %>20"
                                <% elseif age = "30-39" then %>30"
                                <% elseif age = "40-49" then %>40"
                                <% elseif age = "50-59" then %>50"
                                <% elseif age = "60-69" then %>60"
                                <% elseif age = "70-79" then %>70"
                                <% else %>80"
                                <% end if %>
                                >
                            <% else %>
                            <select name="member_age" ID="member_age" style="width:15%;height: 30px;font-size: 16px; text-align:center;border: solid 1px #dddddd;"  >
                            <option value="10">10대</option>
                            <option value="20">20대</option>
                            <option value="30">30대</option>
                            <option value="40">40대</option>
                            <option value="50">50대 이상</option>
                            </select>
                            <% end if %>
                        </td>
                    </tr>
                    <tr height="38">
                        <td width="70%" style="border-bottom:solid  1px #CCCCCC;">
						<p id="member_interest" style="font-size: 16px;"><%=interest %></p>
                        </td>
                        <td width="1%" style="border-bottom:solid  1px #CCCCCC;">
                        </td>
                        <td width="30%" style="border-bottom:solid  1px #CCCCCC;">
						<button onclick="openInterest()" style="font-size: 16px;" >관심사 선택하기</button>
                        </td>
                    </tr>
                    <tr height="38">
                        <td style="text-align:center; border-bottom:solid 1px #CCCCCC;">비밀번호 찾기</td>
                    </tr>
                    <tr height="38">
                        <td width="70%" style="border-bottom:solid  1px #CCCCCC;">
                            <input type="email" style="width:98%;border: 0px none #FFFFFF; padding: 2px; margin: 2px; font-family: Arial, '맑은 고딕', 돋움; text-decoration: none; font-size: 16px; height: 30px;" name="find_email"  id="find_email" placeholder="이메일을 입력하세요." /> 
                        </td>
                        <td width="1%" style="border-bottom:solid  1px #CCCCCC;">
                        </td>
                        <td width="29%" style="border-bottom:solid  1px #CCCCCC;">
                            <button  style="font-size: 16px;" >비밀번호 찾기</button> 
                        </td>
                    </tr>
                </table>
        </div>
      </div>

</div>

</body>
</html>
