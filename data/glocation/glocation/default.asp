<!-- #include virtual="/_include/connect.inc" -->
  <%

    Server.ScriptTimeout=3600
    '서버 session time = 1시간


    if request("search_lat") <> "" then
      search_lat = request("search_lat")
    else
      search_lat = "42163"
    end if

    if request("search_lon") <> "" then
      search_lon = request("search_lon")
    else
      search_lon = "111670"
    end if

    search_word = request("search_word")

    if request("lat_value") <> "" then
      lat_value = request("lat_value")
    else
      lat_value = 37.946976
    end if

    if request("lon_value") <> "" then
      lon_value = request("lon_value")
    else
      lon_value = 127.670702
    end if

    if request("lat1") <> "" then
      lat1 = request("lat1")
    else
      lat1 = "32.910549"
    end if

    if request("lon1") <> "" then
      lon1 = request("lon1")
    else
      lon1 = "123.715624"
    end if

    if request("lat2") <> "" then
      lat2 = request("lat2")
    else
      lat2 = "42.983403"
    end if

    if request("lon2") <> "" then
      lon2 = request("lon2")
    else
      lon2 = "131.625780"
    end if

    if request("pos_words") <> "" then
      pos_words = request("pos_words")
    else
      pos_words = "Korea"
    end if

    if request("zoom_level") <> "" then
      zoom_level = request("zoom_level")
    else
      zoom_level = 6
    end if




    'strSQL = "p_gmap_wordgrid_read  '" & search_lat & "','" & search_lon & "'"
    strSQL = "p_gmap_wordgrid_read_lat_new  '" & search_lat & "','" & search_lon & "'"

    'response.write  strSQL
      'response.End

    Set rsGrid = Server.CreateObject("ADODB.RecordSet")
    rsGrid.Open strSQL, DbCon, 1, 1

    if rsGrid.EOF or rsGrid.BOF then
      NoDataGrid = True
    Else
	  NoDataGrid = False
    end if

    strSQL = "p_gmap_wordgrid_list  '" & search_word & "'"

    'response.write  strSQL
    'response.End

    Set rsGridList = Server.CreateObject("ADODB.RecordSet")
    rsGridList.Open strSQL, DbCon, 1, 1

    if rsGridList.EOF or rsGridList.BOF then
      NoDataGridList = True
    Else
	  NoDataGridList = False
    end if

  %>

<html>
<head>
<title>������ �ѱ���ǥ</title>

<style>
       #map {
        height: 600px;
        width: 60%;
       }
</style>

</head>
<body>

<script src="https://maps.googleapis.com/maps/api/js?sensor=false&language=en"></script>

<SCRIPT LANGUAGE="JavaScript">


    var xhr;

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

        var search_lat = elem.getAttribute("search_lat");
        var search_lon = elem.getAttribute("search_lon");
        var search_word = document.getElementById("search_word").value;

        var lat_value = elem.getAttribute("lat_value");
        var lon_value = elem.getAttribute("lon_value");
        var lat1 = elem.getAttribute("lat1");
        var lon1 = elem.getAttribute("lon1");
        var lat2 = elem.getAttribute("lat2");
        var lon2 = elem.getAttribute("lon2");
        var pos_words = elem.getAttribute("pos_words");



        //alert(lat1);
        //alert(lon1);

        var strurl = "default.asp?lat_value=" + lat_value + "&lon_value=" + lon_value + "&pos_words=" + pos_words
                                                     + "&lat1=" + lat1 + "&lon1=" + lon1 + "&lat2=" + lat2 + "&lon2=" + lon2 + "&search_lat=" + search_lat + "&search_lon=" + search_lon + "&search_word=" + search_word + "&zoom_level=15";
        //alert(strurl);
        document.location.href = strurl;

    }

    function downloadGrid() {

        var slat = document.getElementById("search_lat").value;
        var slon = document.getElementById("search_lon").value;

        strurl = "download_map.asp?search_lat=" + slat + "&search_lon=" + slon;
        //alert(strurl);
        document.location.href = strurl;
    }

    function searchWords() {

        var word = document.getElementById("search_word").value;

        strurl = "default.asp?search_word=" + word;
        //alert(strurl);
        document.location.href = strurl;
    }

    function search(){
      var word = document.getElementById("test3word").value;
      var strsql = "search_ajax.asp?word=" + word;

      //alert(typeof(word));

      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = return_search;
      xhr.open("Get", strsql);
      xhr.send(null);

    }
    function return_search(){
    if (xhr.readyState == 4) {
                  var data = xhr.responseText;
                  var arr = data.split(',');
                  //var i = 0;
                  center_marker.setMap(null);
                  center_marker = new google.maps.Marker({
                        position: {
                                  lat: parseFloat(arr[0]),
                                  lng: parseFloat(arr[1])
                                },
                                map: map,
                                title: arr[2]
                              });

                  map.moveCamera()
                  }
    }

</SCRIPT>

    <!-- #include virtual="/_include/top_menu.asp" -->



<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign=top  align="center">

    <input type="hidden" id="search_lat" value="<%=search_lat %>" />
    <input type="hidden" id="search_lon" value="<%=search_lon %>" />

    <div style="margin:5px 0;text-align:center;">(42.983403, 123.715624) ~ (32.910549, 131.625780)</div>

    <div style="margin:20px 0;text-align:center;">
      <input type="text" style="width:80px;" id="search_word" value="<%=search_word %>" placeholder="�˻� �ܾ�" />&nbsp;
      <input type="button"  value="SEARCH" onclick="searchWords();" />&nbsp;
    </div>

    <div style="margin:10px 0;text-align:center;">

        <%
        if NoDataGridList = False then

    	Do While Not rsGridList.EOF
        %>

        <div style="margin:10px 0;line-height:200%;">
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="20%" align="center"></td>
                    <td width="36%" align="center">
                    <span style="font-family:���� ����,Arial;color:#3388cc;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("word_grid")%></span>&nbsp;&nbsp;&nbsp;
                    <img src="/_images/mapmark.jpg" border="0" style="width:16px;" onclick="popupMap(this);" pos_words="<%=rsGridList("word_grid")%>" lat1="<%=rsGridList("lat1")%>" lon1="<%=rsGridList("lon1")%>" lat2="<%=rsGridList("lat2")%>" lon2="<%=rsGridList("lon2")%>" lat_value="<%=rsGridList("lat_value")%>" lon_value="<%=rsGridList("lon_value")%>" search_lat="<%=rsGridList("latgrid_no")%>" search_lon="<%=rsGridList("longrid_no")%>"  >
                    </td>
                    <td width="4%" align="center">
                    </td>
                    <td width="20%" align="center">
                    <span style="font-family:���� ����,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("lat_value")%></span>
                    <span style="font-family:���� ����,Arial;color:#000000;font-weight:normal;font-size:14px;margin-right:20px;"><%=rsGridList("lon_value")%></span>
                    </td>
                    <td width="20%" align="center"></td>
                </tr>
            </table>
	    </div>

        <%

        rsGridList.MoveNext
	    Loop
	    %>
	    <%
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">Grid�� �����ϴ�.</div>
	    <%
	    end if

        set rsGridList = nothing
	    %>

    </div>

    <div style="margin:20px 0;text-align:center;">
      <input type="button"  value="DOWNLOAD" onclick="downloadGrid();" />
    </div>


    <div style="margin:10px 0;text-align:center;">

        <div style="background-color:#e8e8e8;padding:10px 0 10px 50px;">
        <%
        if NoDataGrid = False then

        latgrid_low = rsGrid("latgrid_low")
        latgrid_high = rsGrid("latgrid_high")

'response.write latgrid_low & ":::::::" & latgrid_high

    	Do While latgrid_high * 1 - latgrid_low >= 0

            strSQL = "p_gmap_wordgrid_read_lon_new  '"& latgrid_low & "','" & search_lon & "'"

            response.write  strSQL
            'response.End

            Set rs = Server.CreateObject("ADODB.RecordSet")
            rs.Open strSQL, DbCon, 1, 1

            if NOT rs.EOF and NOT rs.BOF then
            Do While Not rs.EOF
            %>
            <% if (latgrid_low * 1 - search_lat = 0) and (rs("longrid_no") * 1 - search_lon = 0) then %>
            <div style="width:8%;padding:10px 3px;font-size:9px;border:solid 1px #000000;line-height:200%;background-color:#66bbff;float:left;" >
            <% else %>
            <div style="width:8%;padding:10px 3px;font-size:9px;border:solid 1px #000000;line-height:200%;background-color:#ffffff;float:left;" >
            <% end if %>
            <img src="/_images/mapmark.jpg" border="0" style="width:16px;cursor:pointer;" onclick="popupMap(this);" pos_words="<%=rs("word_grid")%>" lat1="<%=rs("lat1")%>" lon1="<%=rs("lon1")%>" lat2="<%=rs("lat2")%>" lon2="<%=rs("lon2")%>" lat_value="<%=rs("lat_value")%>" lon_value="<%=rs("lon_value")%>"   search_lat="<%=rs("latgrid_no")%>" search_lon="<%=rs("longrid_no")%>"   /><br />
            <span style="font-size:12px;color:#0000ff;"><%=rs("word_grid") %></span><br />
                (<%=rs("lat_value") %>,<%=rs("lon_value") %>)
            </div>
            <%
            rs.MoveNext
            Loop

            end if

            set rs = nothing
            %>

        <div style="clear:both;"></div>
        <%
        latgrid_low = latgrid_low + 1

	    Loop
	    %>
	    <%
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">�����ϼ���.</div>
	    <%
	    end if

        set rsGrid = nothing
	    %>
        </div>

    </div>




    <div style="text-align:center;">



    <div id="map"  style="margin-left:20%;text-align:center;"></div>
    <script>
    var xhr;
    var map;
    var center_marker;
    var test3word;
    var count = 0;
      function initMap() {
        var uluru = {lat: <%=lat_value %>, lng: <%=lon_value %>};
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: <%=zoom_level %>,
          center: uluru
        });

        var contentString = '<div style="text-align:center;color:#000000;"><%=pos_words %></div>';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

/*
        var marker = new google.maps.Marker({
          position: uluru,
          map: map,
          title: 'Words grid'
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });
*/

        var bounds = {
        north: <%=lon2 %>,
        south: <%=lon1 %>,
        east: <%=lat2 %>,
        west: <%=lat1 %>
        };


        map.addListener('center_changed', function(){  // center 바뀔 때, event 등록
            //alert(map.getZoom());
            test3word=document.getElementById("test3word");
            var bounds = map.getBounds();

            /*
            console.log("ZOOM-LEVEL = " + map.getZoom());
            console.log("x Range = " + x_northeast);
            console.log("x2 Range =  " + x_southwest);
            console.log("y Range = " + y_northeast);
            console.log("y2 Range = " + y_southwest);

            var marker = new google.maps.Marker({
              position: {
                lat: x_northeast,
                lng: y_northeast
              },
              map: map,
              title: 'a'
            });

            var marker = new google.maps.Marker({
              position: {
                lat: x_southwest,
                lng: y_southwest
              },
              map: map,
              title: 'b'
            });

            */

            x_southwest = map.getBounds().getSouthWest().lat();
            y_southwest = map.getBounds().getSouthWest().lng();
            x_northeast = map.getBounds().getNorthEast().lat();
            y_northeast = map.getBounds().getNorthEast().lng();

            var x_center = (x_southwest + x_northeast)/2;
            var y_center = (y_southwest + y_northeast)/2;



            if(count!=0) center_marker.setMap(null);
            center_marker = new google.maps.Marker({
                  position: {
                            lat: x_center,
                            lng: y_center
                          },
                          map: map,
                          title: "asd"
                        });

            count++;

          // if(map.getZoom()==15){



           //console.log("zoom level : " + map.getZoom() + "  x_south = " +x_southwest + "x_north = " + x_northeast);


           //return false;



            var strsql = "range_find_ajax.asp?x_center=" + x_center + "&y_center=" + y_center;

            //console.log(strsql);
            //return false;

            xhr = new XMLHttpRequest();
            xhr.onreadystatechange = setMarker;
            xhr.open("Get", strsql);
            xhr.send(null);

              //}  // end if

        });


        // Define a rectangle and set its editable property to true.
        var rectangle = new google.maps.Rectangle({
          bounds: bounds,
          editable: false
        });
        //alert("1");
        rectangle.setMap(map);

      }

      function setMarker(){

      if (xhr.readyState == 4) {
                      var data = xhr.responseText;

                      //alert(data);
                      //console.log(data);
                      //return false;
                      //var arr = data.split(',');
                      //var i = 0;
                      //alert(data);

                      if(data != '')
                      test3word.value = data;

                      /*
                      do{
                      var marker = new google.maps.Marker({
                        position: {
                         lat: parseFloat(arr[i]),
                         lng: parseFloat(arr[i+1])
                        },
                        map:map,
                        title: arr[i+2]
                      });

                      var infowindow = new google.maps.InfoWindow();

                      google.maps.event.addListener(marker, 'click', (function(marker, i) {
                        return function() {
                          infowindow.setContent(arr[i+2]);
                          infowindow.open(map, marker);
                          }
                        })(marker, i));

                      i+=3;

                      }while(arr[i] != '');
                      */

                      }
                  }
    </script>
    <br><br><div><input type="text" id="test3word"><input type ="button" value="search" onclick="search()"></div>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCpEil7kuKIY3O4KzsWQkJ7fYFPkbyWLIc&callback=initMap">
    </script>

    </div>

	    <div style="height:50px;""></div>
</td>
</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->


</body>

</html>
