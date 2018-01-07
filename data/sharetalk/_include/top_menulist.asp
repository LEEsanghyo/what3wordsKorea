<nav class="menu">
	<ul>
    	<li><a href="/">HOME</a></li>
        <li><a href="ws_mytopic.asp">My글</a></li>
        <li><a href="fg_friendlist.asp">친구관리</a></li>
        <li><a href="gi_topiclist.asp">글로벌정보</a></li>
        <li><a href="mi_profile.asp">프로필관리</a></li>
        <li><a href="member_register.asp">회원가입</a></li>
        <li><a href="logout.asp">로그아웃</a></li>
        <% if Session("admin_flag") > "0" then %>
        <li><a href="am_category.asp">카테고리*</a></li>
        <li><a href="am_member.asp">회원관리*</a></li>
        <li><a href="am_config.asp">환경설정*</a></li>
        <% end if %>
    </ul>
</nav>

