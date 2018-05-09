<nav class="menu">
	<ul>
    	<li><a href="/">지도</a></li>
        <li><a href="/map/navigator.asp">길찾기</a></li>
        <li><a href="/sns/test_page_insta.asp">SNS</a></li>
        <li><a href="/account/mi_profile.asp">프로필관리</a></li>
		<% if Session("member_no") < "1" then %>
        <li><a href="/account/member_register.asp">회원가입</a></li>
		<% end if %>
        <li><a href="/account/logout.asp">로그아웃</a></li>
        <% if Session("admin_flag") > "0" then %>
        <li><a href="/setting/am_category.asp">카테고리*</a></li>
        <li><a href="/setting/am_member.asp">회원관리*</a></li>
        <li><a href="/setting/am_config.asp">환경설정*</a></li>
        <% end if %>
    </ul>
</nav>

