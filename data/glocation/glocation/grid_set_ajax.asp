<!-- #include virtual="/_include/connect.inc" -->
<%   
    response.CharSet = "EUC-KR"

    strSQL = "p_gmap_grid_insert_ajax '" &       request("lat_value") & "','" & _
                                                 request("lon_value") & "','" & _
                                                 request("pos_word1") & "','" & _
                                                 request("pos_word2") & "','" & _
                                                 request("pos_word3") & "'"   
        
   set rsData = Server.CreateObject("ADODB.RecordSet")
   rsData.Open strSQL, DbCon, 1, 1   
    
   data_desc = rsData("data_desc")

   set rsData = nothing
   
   'Response.write strSQL
   Response.write data_desc
    
%>
<!-- #include virtual="/_include/connect_close.inc" -->