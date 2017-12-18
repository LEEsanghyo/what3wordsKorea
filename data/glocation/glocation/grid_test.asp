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

    strSQL = "p_gmap_grid_read '" & search_lat & "','" & search_lon & "'"
  
    Set rsGrid = Server.CreateObject("ADODB.RecordSet")
    rsGrid.Open strSQL, DbCon, 1, 1     
        
    if rsGrid.EOF or rsGrid.BOF then
      NoDataGrid = True
    Else
	  NoDataGrid = False
    end if        

    strSQL = "p_gmap_word_read "
  
    Set rsWords = Server.CreateObject("ADODB.RecordSet")
    rsWords.Open strSQL, DbCon, 1, 1     
        
    if rsWords.EOF or rsWords.BOF then
      NoDataWords = True
    Else
	  NoDataWords = False
    end if        
      
  %>

<html>
<head>
<title>지구촌 한글좌표</title>
</head>
<body>

	<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

<SCRIPT LANGUAGE="JavaScript">

    var xhr;

    function gridSet() {

        var lat_value = document.getElementById("lat_value").value;
        var lon_value = document.getElementById("lon_value").value;
        var pos_word1 = document.getElementById("pos_word1").value;
        var pos_word2 = document.getElementById("pos_word2").value;
        var pos_word3 = document.getElementById("pos_word3").value;


        if (lat_value == "") {
            alert("위도가 비었습니다.");
            document.getElementById("lat_value").focus();
            return false;
        }

        if (isNaN(lat_value) == true) {
            alert("위도가 숫자가 아닙니다.");
            document.getElementById("lat_value").focus();
            return false;
        }

        if (lat_value > 90 || lat_value < -90 ) {
            alert("위도는 -90 ~ 90 범위입니다.");
            document.getElementById("lat_value").focus();
            return false;
        }
        
        if (lon_value == "") {
            alert("경도가 비었습니다.");
            document.getElementById("lon_value").focus();
            return false;
        }

        if (isNaN(lon_value) == true) {
            alert("경도가 숫자가 아닙니다.");
            document.getElementById("lon_value").focus();
            return false;
        }

        if (lon_value > 180 || lon_value < -180) {
            alert("경도는 -180 ~ 180 범위입니다.");
            document.getElementById("lon_value").focus();
            return false;
        }

        if (pos_word1 == "") {
            alert("위치1 비었습니다.");
            document.getElementById("pos_word1").focus();
            return false;
        }

        if (pos_word2 == "") {
            alert("위치2 비었습니다.");
            document.getElementById("pos_word2").focus();
            return false;
        }

        if (pos_word3 == "") {
            alert("위치3 비었습니다.");
            document.getElementById("pos_word3").focus();
            return false;
        }


        //alert("2");

        str_url = "grid_set_ajax.asp?lat_value=" + lat_value + "&lon_value=" + lon_value
                                                 + "&pos_word1=" + pos_word1 + "&pos_word2=" + pos_word2 + "&pos_word3=" + pos_word3;

        //alert(str_url);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = gridSetResult;
        xhr.open("Get", str_url);
        xhr.send(null);
    }

    function gridSetResult() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            //alert(data);
            //alert("1");

            document.getElementById("result_msg").innerHTML = data;

            location.reload();
        }
    }

    function checkWord(elem) {
        elem.style.backgroundColor = "FFFF00";
    }

    function allocateWord(elem) {
        var word = elem.innerHTML;
        var pos_word1 = document.getElementById("pos_word1").value;
        var pos_word2 = document.getElementById("pos_word2").value;
        var pos_word3 = document.getElementById("pos_word3").value;

        if (pos_word1 == "") { 
            document.getElementById("pos_word1").value = word;
            document.getElementById("pos_word1").style.color = "FF6600";
            return false;
        }

        if (pos_word2 == "") {
            document.getElementById("pos_word2").value = word;
            document.getElementById("pos_word2").style.color = "FF6600";
            return false;
        }

        document.getElementById("pos_word3").value = word;
        document.getElementById("pos_word3").style.color = "FF6600";
    }

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

        strurl = "default.asp?search_lat=" + slat + "&search_lon=" + slon;
        //alert(strurl);
        document.location.href = strurl;
    }
    

</SCRIPT>

    <!-- #include virtual="/_include/top_menu.asp" -->


<div style="height:10px;"></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="65%" valign=top  align="left">  
    <div style="margin:10px 0;text-align:center;font-size:12px;color:#3388cc;" id="result_msg"></div>

    <div style="margin:20px 0;text-align:center;">       
      <input type="text" style="width:80px;" id="search_lat" value="" placeholder="경도" /> ~ <input type="text" style="width:80px;" id="search_lon"  value="" placeholder="위도"   />&nbsp;
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
                    <td width="60%" align="left">
                    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGrid("grid_no")%></span>
                    <span style="font-family:맑은 고딕,Arial;color:#3388cc;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGrid("pos_words")%></span>
                    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:50px;">
                        </span>
                    </td>
                    <td width="30%" align="left">
                    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;">
                    (<%=rsGrid("lat1")%>, <%=rsGrid("lon1")%>)
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    (<%=rsGrid("lat2")%>, <%=rsGrid("lon2")%>)
                    </span>
                    </td>
                    <td width="10%" align="center">
                    <input type="button" value="위치" onclick="popupMap(this);" pos_words="<%=rsGrid("pos_words")%>" lat1="<%=rsGrid("lat1")%>" lon1="<%=rsGrid("lon1")%>" lat2="<%=rsGrid("lat2")%>" lon2="<%=rsGrid("lon2")%>" lat_value="<%=rsGrid("lat_center")%>" lon_value="<%=rsGrid("lon_center")%>" />
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
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">Grid가 없습니다.</div>
	    <%
	    end if
            
        set rsGrid = nothing
	    %>   
    
    </div>

</td>
<td width="35%" valign=top>  
    <div style="margin:10px 5px;width:96%;background:#23B6BA;border-radius:3px;padding:10px 5px;color:#ffffff;text-align:center;">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr height="35">
      <td width="100%" align="center">  
      <input type="input" id="lat_value" style="width:49%;" placeholder="위도" value="<%=lat_value %>" />
      <input type="input" id="lon_value"  style="width:49%;" placeholder="경도"  value="<%=lon_value %>" />
      </td>
      </tr>
      <tr height="35">
      <td width="100%" align="center">  
      <input type="input" id="pos_word1"  style="width:32%;" placeholder="위치1" value="<%=pos_word1 %>" onblur="checkWord(this);" />.
      <input type="input" id="pos_word2"  style="width:32%;" placeholder="위치2" value="<%=pos_word2 %>"  />.
      <input type="input" id="pos_word3"  style="width:32%;" placeholder="위치3" value="<%=pos_word3 %>"  />
      </td>
      </tr>
      <tr height="35">
      <td width="100%" align="right" colspan="2">  
      <span style="color:#000000;" id="grid_desc"></span>
      <input type="button" onclick="gridSet()" value="저장" />&nbsp;
      </td>
      </tr>
      </table>          
    </div>

    <div style="margin:20px 5px;padding:20px 0;text-align:center;background:#f8f8f8;">DICTIONARY</div>

    <div style="margin:10px 5px;">       
        
        <%   
        if NoDataWords = False then     
        
    	Do While Not rsWords.EOF 
        %>
        <% if chartype_old <> rsWords("char_type") then %>
        <div style="margin-top:10px;padding:5px 0;background:#ffffff;border-top:solid 1px #888888;">
	    <span style="font-family:맑은 고딕,Arial;color:#ff6600;font-weight:normal;font-size:14px;margin-right:20px;white-space:nowrap;cursor:pointer;" >
            <%=rsWords("char_type")%></span>
        </div>
        <% end if %>
	    <span style="font-family:맑은 고딕,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;white-space:nowrap;cursor:pointer;" onclick="allocateWord(this);"><%=rsWords("word_name")%></span>
        <%
        chartype_old = rsWords("char_type")
        rsWords.MoveNext
	    Loop  

	    end if

        set rsWords = nothing
	    %>   
    
    </div>
</td>
</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->


</body>

</html>




