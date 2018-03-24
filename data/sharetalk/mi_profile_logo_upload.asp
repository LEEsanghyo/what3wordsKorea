<!-- #include virtual="/_include/connect.inc" -->
<% 
	Public Function LeftFillString ( strValue, fillChar, makeLength )
		Dim strRet
		Dim strLen, diff, i
		
		strRet  = ""
		strLen  = Len(strValue)
		diff    = CInt(makeLength) - strLen
		
		if diff > 0 then
				for i=1 to diff
						strRet = strRet & CStr(fillChar)
				next
		end if
		
		LeftFillString = strRet & CStr(strValue)
	End Function


	Set uploadform = Server.CreateObject("DEXT.FileUpload")
	uploadform.CodePage = 65001
	uploadform.AutoMakeFolder = True
	uploadform.DefaultPath = "E:\greenmedia\talkimages\"

    filename = uploadform("file1").FileName 
    'response.write filename & ":::::::000:::::::::<br>"
    
    if filename <> "" then
    
      fileext = Mid(filename, InStrRev(filename, ".")) 
    
      dtNow = now()
      Randomize()
      newname = Year(dtNow)
      newname = newname & LeftFillString( Month(dtNow),   "0", 2 )
      newname = newname & LeftFillString( Day(dtNow),     "0", 2 )
      newname = newname & LeftFillString( Hour(dtNow),    "0", 2 )
      newname = newname & LeftFillString( Minute(dtNow),  "0", 2 )
      newname = newname & LeftFillString( Second(dtNow),  "0", 2 )
      newname = newname & "_"  
      newname = newname & LeftFillString ( Int(Rnd * 10000), "0", 5 )

      filepath = uploadform.DefaultPath & "" & newname & fileext
    
      uploadform("file1").SaveAs filepath 
    
      'response.Write filepath & "<br>"
      'response.Write newname & fileext & "<br>"

      fileUrl = "http://media.gncsolution.co.kr/talkimages/" & newname & fileext

      strSQL = "p_gim_member_logo_upload '" &  Session("member_no") & "','" & _
                                               fileUrl & "'"

      Set rs = Server.CreateObject("ADODB.RecordSet")
      rs.Open strSQL, DbCon, 1, 1      

      Set rs = nothing
    
    
      'response.write filename & ":::::::::111:::::::<br>"
    
        
    end if
   
    Set uploadform = Nothing 

    response.redirect "mi_profile.asp"

%>
<!-- #include virtual="/_include/connect_close.inc" -->

