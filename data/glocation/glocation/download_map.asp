<%
    'Session.codepage = 949
    Response.CharSet = "EUC-KR"

if request("search_lat") = "" or request("search_lon") = "" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("항목이 비었습니다.");
    history.go(-1);
//-->
</SCRIPT>
<% end if
  Response.ContentType = "application/vnd.ms-excel" 
  Response.AddHeader "Content-Disposition","attachment;filename=Processmap" & now() & ".xls"

  'Response.AddHeader "Content-Disposition","attachment; filename=report" & now() & ".doc"
  'Response.ContentType = "application/vnd.ms-word"
%>
<!-- #include virtual="/_include/connect.inc" -->
<style>
.pbox 
{
    border: solid 1px #000000;
}
</style>
<%

      search_lat = request("search_lat")
      search_lon = request("search_lon")

        'strSQL = "p_gmap_wordgrid_read  '" & search_lat & "','" & search_lon & "'" 
     strSQL = "p_gmap_wordgrid_read_lat_new  '" & search_lat & "','" & search_lon & "'" 

    'Response.write  strSQL
    'response.End 
  
    Set rsGrid = Server.CreateObject("ADODB.RecordSet")
    rsGrid.Open strSQL, DbCon, 1, 1     
        
    if rsGrid.EOF or rsGrid.BOF then
      NoDataGrid = True
    Else
	  NoDataGrid = False
    end if   

    'response.end

%>

<table width=1024 align=center>
<tr>
<td width=1024 valign=top> 



    <div style="margin:10px 0;text-align:center;">       

   
        <%   
        if NoDataGrid = False then     
        
        latgrid_low = rsGrid("latgrid_low")
        latgrid_high = rsGrid("latgrid_high")
        %>
        <table border="1">
            <tr>
                <td align="center">latitude</td>
                <td align="center">longitude</td>
                <td align="center">lat1(south)</td>
                <td align="center">lat2(north)</td>
                <td align="center">lon1(west)</td>
                <td align="center">lon2(east)</td>
                <td align="center">words</td>
            </tr>
        <%        
    	Do While latgrid_high * 1 - latgrid_low >= 0

            strSQL = "p_gmap_wordgrid_read_lon_new  '" & latgrid_low & "','" & search_lon & "'" 

            'response.write  strSQL
            'response.End 
  
            Set rs = Server.CreateObject("ADODB.RecordSet")
            rs.Open strSQL, DbCon, 1, 1     
        
            if NOT rs.EOF and NOT rs.BOF then
            Do While Not rs.EOF 
            %> 
            <tr>
                <td><%=rs("lat_value")%></td>
                <td><%=rs("lon_value")%></td>
                <td><%=rs("lat1")%></td>
                <td><%=rs("lat2")%></td>
                <td><%=rs("lon1")%></td>
                <td><%=rs("lon2")%></td>
                <td><%=rs("word_grid")%></td>
            </tr>
            <%
            rs.MoveNext
            Loop 

            end if        

            set rs = nothing
            %>

        <%
        latgrid_low = latgrid_low + 1
        
	    Loop  
	    %>
        </table>
	    <%                                  
	    else
	    %>
	    <div style="padding:20px 0;color:#000000;font-weight:normal;">선택하세요.</div>
	    <%
	    end if
            
        set rsGrid = nothing
	    %>   

    </div>

<!-- #include virtual="/_include/connect_close.inc" -->