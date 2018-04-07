<input type="checkbox" id="menuToggle">
<header>
        <div id="brand">
            <table width="100%" border="0">
                <tr height="3px;"><td colspan="6"></td></tr>
                <tr><td width="3%"></td>
                    <td width="20%">
                          <% if MENU = "HOME" then %>
                          <a href="/"><img src="images/topicon_list_white.gif" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="/"><img src="images/topicon_list_white.gif" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
					<% if Session("admin_flag") = 1 then %>
					<td width="15%">
                          <% if MENU = "GI" then %>
                          <a href="am_poi_manage.asp"><img src="images/topicon_gi_white.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="am_poi_manage.asp"><img src="images/topicon_gi_white.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
					<% end if %>
                </tr>
            </table>
        </div>
    <label for="menuToggle" class="menu-icon">&#9776;</label>
    
</header>


