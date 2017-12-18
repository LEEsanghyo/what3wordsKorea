<!-- #include virtual="/_include/connect.inc" -->
  <%

    if request("search_lat") <> "" then
      search_lat = request("search_lat")
    else
      search_lat = "0"
    end if

    if request("search_lon") <> "" then
      search_lon = request("search_lon")
    else
      search_lon = "0"
    end if

    strSQL = "p_gmap_grid_read2 '" & search_lat & "','" & search_lon & "'"
  
    Set rsGrid = Server.CreateObject("ADODB.RecordSet")
    rsGrid.Open strSQL, DbCon, 1, 1     
        
    if rsGrid.EOF or rsGrid.BOF then
      NoDataGrid = True
    Else
	  NoDataGrid = False
    end if        

  %>

<html>
<head>
<title>Áö±¸ÃÌ ÇÑ±ÛÁÂÇ¥</title>
</head>
<body>

<SCRIPT LANGUAGE="JavaScript">

    var xhr;

    function popupMap(elem) {

        var lat_value = elem.getAttribute("lat_value");
        var lon_value = elem.getAttribute("lon_value");
        var lat1 = elem.getAttribute("lat1");
        var lon1 = elem.getAttribute("lon1");
        var lat2 = elem.getAttribute("lat2");
        var lon2 = elem.getAttribute("lon2");
        var pos_words = elem.getAttribute("pos_words");
        
        var strurl = "grid_map_popup.asp?lat_value=" + lat_value + "&lon_value=" + lon_value + "&pos_words=" + pos_words
                                                     + "&lat1=" + lat1 + "&lon1=" + lon1 + "&lat2=" + lat2 + "&lon2=" + lon2;
        window.open(strurl, 'popup', 'width=530,height=450,left=450,top=200,toolbar=no,location=no,directories=no, status=no, menubar=no, resizable=yes, scrollbars=no, copyhistory=no');

    }

    function searchGrid() {

        var slat = document.getElementById("search_lat").value;
        var slon = document.getElementById("search_lon").value;

        strurl = "grid_korea.asp?search_lat=" + slat + "&search_lon=" + slon;
        //alert(strurl);
        document.location.href = strurl;
    }
    

</SCRIPT>


    <!-- #include virtual="/_include/top_menu.asp" -->

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="65%" valign=top  align="left">  
    <div style="margin:10px 0;text-align:center;font-size:12px;color:#3388cc;" id="result_msg"></div>

    <div style="margin:20px 0;text-align:center;">       
      <input type="text" style="width:80px;" id="search_lat" value="" placeholder="°æµµ" /> ~ <input type="text" style="width:80px;" id="search_lon"  value="" placeholder="À§µµ"   />&nbsp;
      <input type="button"  value="SEARCH" onclick="searchGrid();" />&nbsp;
    </div>

    <div style="margin:10px 0;">       

        <%   
        if NoDataGrid = False then     
        
    	Do While Not rsGrid.EOF 
        %>
                
        <div style="margin:10px 0;line-height:200%;">
            <table width="100%">
                <tr>
                    <td width="40%" align="left">
                    <span style="font-family:¸¼Àº °íµñ,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGrid("grid_no")%></span>
                    <span style="font-family:¸¼Àº °íµñ,Arial;color:#3388cc;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGrid("pos_words")%></span>
                    <span style="font-family:¸¼Àº °íµñ,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:50px;">
                        </span>
                    </td>
                    <td width="50%" align="left">
                    <span style="font-family:¸¼Àº °íµñ,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;">
                    (<%=rsGrid("lat1")%>, <%=rsGrid("lon1")%>)
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    (<%=rsGrid("lat2")%>, <%=rsGrid("lon2")%>)
                    </span>
                    </td>
                    <td width="10%" align="center">
                    <input type="button" value="À§Ä¡" onclick="popupMap(this);" pos_words="<%=rsGrid("pos_words")%>" lat1="<%=rsGrid("lat1")%>" lon1="<%=rsGrid("lon1")%>" lat2="<%=rsGrid("lat2")%>" lon2="<%=rsGrid("lon2")%>" lat_value="<%=rsGrid("lat_center")%>" lon_value="<%=rsGrid("lon_center")%>" />
                    </td>            
                </tr>
            </table>	    
	    </div>

        <%
        
        rsGrid.MoveNext
	    Loop  
	    %>
	    <%                                  
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">Grid°¡ ¾ø½À´Ï´Ù.</div>
	    <%
	    end if
            
        set rsGrid = nothing
	    %>   
    
    </div>

</td>
<td width="15%" valign=top>  

</td>
</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->


</body>

</html>




