<!-- #include virtual="/_include/connectgi.inc" -->
<%
  keynorm_no =  request("keynorm_no")

  strSQL = "p_gim_keynorm_select_detail '" & keynorm_no & "'"
             
  'response.Write strSQL             
    
   Set rs = Server.CreateObject("ADODB.RecordSet")
   rs.Open strSQL, giDbCon, 1, 1  
   
  if NOT rs.EOF and NOT rs.BOF then

    keynorm_name = rs("keynorm_name")
    keynorm_name_en = rs("keynorm_name_en")
    keynorm_name_origin = rs("keynorm_name_origin")
    keynorm_short = rs("keynorm_short")
    keynorm_desc = rs("keynorm_desc")
    keynorm_note = rs("keynorm_note")
    cat_desc = rs("cat_desc")
    profiletemplate_no = rs("profiletemplate_no")
    profiletemplate_name =  rs("profiletemplate_name")
    image_url =  rs("image_url")

  end if 

  set rs = nothing    
  
  strSQL = "p_gim_keynorm_profile_user_read '" & keynorm_no & "','" & cat_menu & "'"  
  
  'response.Write strSQL
  'response.end             
    
   Set rsKeynormProfile = Server.CreateObject("ADODB.RecordSet")
   rsKeynormProfile.Open strSQL, giDbCon, 1, 1  
 
  if rsKeynormProfile.EOF or rsKeynormProfile.BOF then
    	NoDataKeynormProfile = True
  Else
    	NoDataKeynormProfile = False
  end if 


%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>global intelligence</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">
</head>

<body>
    
<input type="hidden" name="post_no" value="" id="post_no" /> 	
    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_detail_gi.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px"></div>
<div class="content">
    <div style="padding:5px 0px 5px 0px;display:flex;justify-content:center;">
        <table style="width:95%">
           <tr height="25px;">
                <td width="80%" valign="bottom" style="font-size:16px;font-weight:bold;font-family:Arial,맑은 고딕,돋움;vertical-align:middle;text-align:left;">
                    <%=keynorm_name %><br /> (<%=keynorm_name_en %>)</td>
                <td>
                </td>
                <td width="20%" valign="bottom" style="text-align:right;">
                <% if image_url <> "" then %>
                <img src="<%=image_url %>" border="0" style="width:80px;" />
                <% end if %>
                </td>
           </tr>
        </table>
    </div>

    <table style="width:100%">
       <tr height="3px;"><td style="width:100%;height:3px;background:#dddddd;"></td></tr>
    </table>
    
    <!-- 하단 기사내용 start -->
    <div style="padding:0 0px 10px 0px;border-bottom:solid 1px #dddddd;display:flex;justify-content:center;">
    <table style="width:95%;border:0px;">
        <tr height="25px">
            <td style="font-family:Arial,맑은 고딕,돋움;padding:10px 0;font-size:14px;line-height:180%;font-weight:normal;">
            <%=keynorm_desc %>
            </td>
        </tr>
        <tr height="25px"><td style="font-size:12px;font-family:Arial,맑은 고딕,돋움;font-weight:normal;">
        [<%=cat_desc %>] 약어:<%=keynorm_short %>
        <% if  keynorm_name_origin <> "" then %>
        &nbsp;&nbsp;&nbsp;원문:<%=keynorm_name_origin %>
        <% end if %>
        </td></tr>
    </table>
    </div>

    <%      
    if NoDataKeynormProfile = False then
    
    Do While Not rsKeynormProfile.EOF
    
    if section_old <> rsKeynormProfile("section_no")  then %>
    <div style="width:95%;padding:10px 0px 10px 10px;">
      <span style="font-family:맑은 고딕,Arial;font-size:18px;color:#000000;font-weight:normal;"><%=rsKeynormProfile("section_title") %></span>
      </div>
      <% end if %>       

    
    <div style="padding:10px 0px 10px 0px;display:flex;justify-content:center;">
      <table width="95%" border="0" cellpadding="0" cellspacing="0">
      <tr style="border-top:solid 0 #9c9f9c;">
      <td width="75%" valign="top">
        <% if rsKeynormProfile("exist_flag") = "1" then %>
        <div>
        <span style="font-family:맑은 고딕,Arial;font-size:14px;color:#3388cc;font-weight:normal;"><%=rsKeynormProfile("contents_title") %></span>  
        <span style="font-family:맑은 고딕,Arial;font-size:14px;color:#000000;font-weight:normal;"><%=rsKeynormProfile("contents_note") %></span>      
        </div>
        <% else %>
        <span style="font-family:맑은 고딕,Arial;font-size:14px;color:#888888;">(해당 프로필 없음)</span>
        <% end if %>
      </td>
      <td width="25%" align="right" valign="top">
        <div>
        <% if index_old <> rsKeynormProfile("index_no") then %>
        <div style="font-family:맑은 고딕,Arial;font-size:14px;color:#9c9f9c;"><%=rsKeynormProfile("item_title") %></div>
        <% end if %>
        <% if rsKeynormProfile("link_url") <> "0" then  %>
        <a href="<%=rsKeynormProfile("link_url") %>" target="_blank">
        <div style="color:#0000ff;font-size:16px;font-weight:normal;">∞</div>
        </a>
        <% end if %>
        </div>
        <% if rsKeynormProfile("exist_flag") = "1" then %>
        <div style="font-family:맑은 고딕,Arial;font-size:10px;color:#888888;font-weight:normal;"> <%=mid(rsKeynormProfile("update_date"),3,8) %></div>   
        <% end if %>
        
       <% if rsKeynormProfile("image_url") <> "" then %>
        <div style="padding:3px 0;"><img src="<%=rsKeynormProfile("image_url") %>" border="0" style="width:90%;" /></div>   
       <% end if %>
                
      </td>
      </tr>
      </table>    
      </div>
    
    <%  index_old = rsKeynormProfile("index_no")
        section_old = rsKeynormProfile("section_no")
        keynorm_old = rsKeynormProfile("keynorm_name")
     	rsKeynormProfile.MoveNext
	    Loop 
    else
    %>
    <div style="padding:20px;text-align:center;">KEYNORM PROFILE이 없습니다</div>
    <%
    end if 
    
    set rsKeynormProfile = nothing    
    %>  

<div style="height:50px;"></div>

<div class="bottom" style="margin-top:10px;padding:10px 0;border-top:solid 1px #dddddd;background-color:#ffffff;">
    <div style="text-align:center;width:100%;">
    <table style="width:100%;border:0px;">
        <tr>
            <td align="center"><span style="font-size:12px;font-family:Arial,맑은 고딕,돋움;color:darkgray;font-weight:normal;">Powered by  Global Intelligence . kr</span></td>
        </tr>
    </table>
    </div>
</div>
</body>
</html>

<!-- #include virtual="/_include/connectgi_close.inc" -->