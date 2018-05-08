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
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="author" content="S A Bokhari">
		<meta name="description" content="글공유">
		<meta name="keywords" content="글공유">
		<title>글공유 상세</title>
		<link rel="stylesheet" href="/_include/style.css" type="text/css">
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="/_script/login.js"></script>
	</head>

	<body>
		<% top_menu = "글공유" %>
		<!-- #include virtual="/_include/top_menu_detail.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
		<table style="width:100%">
			<tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
			</td></tr>
		</table>

		<div class="content" style="margin-top:70px;">
			<div style="width:100%;display:flex;justify-content:center;">  
				<div style="width:95%;margin:10px 0px;">
					<table class="main_table">
						<tr>
							<td align="center">
								<span id="message" style="padding:10px 0;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#3388cc;font-weight:normal;">
									<% if email <> "" then %>
										아래 사항을 입력해주시면 가입이 완료됩니다.
									<% end if %>
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<div style="padding:2px;">
								<table style="width:100%;">
									<tr>
										<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">이&nbsp;메&nbsp;일</td>
										<td width="10px;"></td>
										<td class="td_content">
											<input type="email" name="member_email" size="255" style="width:70%;background-color:#ecfaa0;" class="input" ID="member_email"
											<% if email = "" then %>
												placeholder="이메일" required >
											<% else %>
												value="<%=email%>" disabled >
											<% end if %>
										</td>
									</tr>
								</table>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div style="padding:2px;">
								<table style="width:100%;">
									<tr>
										<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">닉&nbsp;네&nbsp;임</td>
										<td width="10px;"></td>
										<td class="td_content">
											<input type="text" name="member_name" size="255" style="width:50%;background-color:#ecfaa0;" class="input" ID="member_name" 
											<% if email = "" then %>
												placeholder="닉네임" required >
											<% else %>
												value = "<%=nickname%>">
											<% end if %>
										</td>
									</tr>
								</table>
								</div>
							</td>
						</tr>
						<% if email="" then %>
						<tr>
							<td>
							<div style="padding:2px;">
								<table style="width:100%;">
									<tr>
										<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">비밀번호</td>
										<td width="10px;"></td>
										<td class="td_content"><input type="password" name="member_pwd" size="200" style="width:50%;background-color:#ecfaa0;" class="input" ID="member_pwd" placeholder="비밀번호 (6자리 이상)" required ></td>
										<td style="width:10%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">확인</td>
										<td width="10px;"></td>
										<td class="td_content"><input type="password" name="member_pwd2" size="255" style="width:50%;background-color:#ecfaa0;" class="input" ID="member_pwd2" placeholder="비밀번호 확인" required ></td>
									</tr>
								</table>
							</div>
							</td>
						</tr>
						<% else %>
							<input type="hidden" id = "member_pwd" value = "">
							<input type="hidden" id = "member_pwd2" value = "">
						<% end if %>
						<tr>
							<td>
								<div style="padding:2px;">
									<table style="width:100%;">
										<tr>
											<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">전&nbsp;화&nbsp;번&nbsp;호</td>
											<td width="10px;"></td>
											<td class="td_content">
												<input type="hidden" name="member_phone" class="input" id="member_phone">
												<select name="telecom" id="telecom">
													<option value="SKT">SKT</option>
													<option value="KT">KT</option>
													<option value="LG">LG U+</option>
												</select>
												<input type="text" name="phone1" maxlength="3" style="width:30px" class="input" ID="phone1">
												-
												<input type="text" name="phone2" maxlength="4" style="width:40px" class="input" ID="phone2">
												-
												<input type="text" name="phone3" maxlength="4" style="width:40px" class="input" ID="phone3">
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div style="padding:2px;">
									<table style="width:100%;">
										<tr>
											<% if age = "" or age = "undefined" then %>
											<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">연&nbsp;&nbsp;령&nbsp;&nbsp;대</td>
											<td width="10px;"></td>
											<td style="width:25%">
												<select name="member_age" ID="member_age">
												<option value=10>10대</option>
												<option value=20>20대</option>
												<option value=30>30대</option>
												<option value=40>40대</option>
												<option value=50>50대 이상</option>
											</select>
											<% else %>
											<input type="hidden" name = "member_age" id = "member_age" value="
												<% select case age
													case "10-19" %> 10
												<% case "20-29" %>	20
												<% case "30-39" %>	30
												<% case "40-49" %>	40
												<% case else %>	50
												<% end select %>
											">
											</td>
											<% end if %>
											<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">관&nbsp;&nbsp;심&nbsp;&nbsp;사</td>
											<td width="10px;"></td>
											<td>
												<button onclick="openInterest()">관심사 선택하기</button>
												<p id="member_interest"> <%=interest %></p>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<table style="width:100%;">
									<tr>
										<td align="center">
											<button onclick="MemberRegister(<%=oflag%>, <%=uniqId%>);">회원가입</button>	
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<table style="width:100%">
				<tr height="4px;">
					<td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE"></td>
				</tr>
			</table>

			<div style="width:100%;display:flex;justify-content:center;">  
				<div style="width:95%;margin:10px 0px;">   

				<form action="member_find_set.asp" id="form2" name="formMember" method="post">

					<table class="main_table">
						<tr>
							<td>
								<table style="width:100%;">
									<tr>
										<td style="width:20%;font-size:12px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;color:#000000;text-align:center;">이&nbsp;메&nbsp;일</td>
										<td width="10px;"></td>
										<td><input type="email" name="find_email" size="255" style="width:70%;" class="input" ID="find_email" placeholder="이메일" required ></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table style="width:100%;">
									<tr>
										<td align="center">   
											<button>비밀번호 찾기</button>                             
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

				</form>

				</div>
			</div>
			<table style="width:100%">
				<tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
				</td></tr>
			</table>
		</div>
		<script type="text/javascript" src="/_script/account.js"></script>
	</body>
</html>