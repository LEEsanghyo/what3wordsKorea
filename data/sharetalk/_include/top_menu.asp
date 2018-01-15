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
                    <td width="20%">
                        <% if Session("member_no") > "0" then %>
                          <% if MENU = "MY" then %>
                          <a href="ws_mytopic.asp"><img src="images/topicon_my_white.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="ws_mytopic.asp"><img src="images/topicon_my_white.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                        <% else %>
                        <img src="images/topicon_my_white.png" border="0" style="height:25px;opacity:0.2;" />
                        <% end if %>                        
                    </td>
                    <td width="20%">
                        <% if Session("member_no") > "0" then %>
                          <% if MENU = "FRIEND" then %>
                          <a href="fg_friendlist.asp"><img src="images/topicon_friend_white.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="fg_friendlist.asp"><img src="images/topicon_friend_white.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                        <% else %>
                        <img src="images/topicon_friend_white.png" border="0" style="height:25px;opacity:0.2;" />
                        <% end if %>
                        </td>
                    <td width="20%">
                          <% if MENU = "GI" then %>
                          <a href="gi_topiclist.asp"><img src="images/topicon_gi_white.png" border="0" style="height:25px;" /></a>
                          <% else %>
                          <a href="gi_topiclist.asp"><img src="images/topicon_gi_white.png" border="0" style="height:25px;opacity:0.5;" /></a>
                          <% end if %>
                    </td>
                    <td width="15%"></td>
                </tr>
            </table>
        </div>
    <label for="menuToggle" class="menu-icon">&#9776;</label>
</header>


