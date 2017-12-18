<!-- #include virtual="/_include/connect.inc" -->
  <%

    strSQL = "p_mlp_costdata_yyyymm  "

    'response.write  strSQL
    'response.End 
  
    Set rsYYYYMM = Server.CreateObject("ADODB.RecordSet")
    rsYYYYMM.Open strSQL, DbCon, 1, 1     
        
    if rsYYYYMM.EOF or rsYYYYMM.BOF then
      NoDataYYYYMM = True
    Else
	  NoDataYYYYMM = False
    end if        

  %>

<html>
<head>
<title>Áö±¸ÃÌ ÇÑ±ÛÁÂÇ¥</title>

<style>
       #map {
        height: 600px;
        width: 60%;
       }
</style>

</head>
<body>

<!-- #include virtual="/_include/top_menu.asp" -->

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" valign=top  align="center">  
    
    <div style="margin:5px 0;text-align:center;">COST DATA</div>

    <div style="margin:20px 0;text-align:center;">
      <a href="costdata_download.asp"><input type="button"  value="DOWNLOAD" onclick="downloadGrid();" /></a>
    </div>

    <div style="margin:10px 0;text-align:center;">       

        <div style="padding:10px 0 10px 0;">
        <table border="1">
        <%   
        if NoDataYYYYMM = False then     
        %>
            <tr>
            <%
            strSQL = "p_mlp_costdata_read  '" & rsYYYYMM("yyyymm") & "'" 

            'response.write  strSQL
            'response.End 
  
            Set rs = Server.CreateObject("ADODB.RecordSet")
            rs.Open strSQL, DbCon, 1, 1     
        
            if NOT rs.EOF and NOT rs.BOF then
            Do While Not rs.EOF 
            %> 
            <td align="right"><span style="font-size:9px;font-weight:normal;"><%=rs("c_name") %></span></td>
            <%
            rs.MoveNext
            Loop 

            end if        

            set rs = nothing
            %>
            </tr>
        <%
    	Do While Not rsYYYYMM.EOF 
            %>
            <tr>
            <%
            strSQL = "p_mlp_costdata_read  '" & rsYYYYMM("yyyymm") & "'" 

            'response.write  strSQL
            'response.End 
  
            Set rs = Server.CreateObject("ADODB.RecordSet")
            rs.Open strSQL, DbCon, 1, 1     
        
            if NOT rs.EOF and NOT rs.BOF then
            Do While Not rs.EOF 
            %> 
            <td align="right"><span style="font-size:9px;font-weight:normal;"><%=rs("c_amt") %></span></td>
            <%
            rs.MoveNext
            Loop 

            end if        

            set rs = nothing
            %>
            </tr>
        <%
        rsYYYYMM.MoveNext
        
	    Loop  
	    %>
	    <%                                  
	    end if
            
        set rsYYYYMM = nothing
	    %>   
        </table>
        </div>
    
    </div>

    <div style="height:50px;""></div>
</td>
</tr>
</table>

<!-- #include virtual="/_include/connect_close.inc" -->


</body>

</html>




