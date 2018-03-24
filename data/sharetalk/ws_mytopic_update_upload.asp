<%@ LANGUAGE="VBSCRIPT"%> 
<HTML> 
<BODY> 
<% 
Response.ChaRset = "UTF8" 

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
    'response.write filename & "::::::::::::::::<br>"
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

      fileUrl = "<img src=http://media.gncsolution.co.kr/talkimages/" & newname & fileext & " style=width:100%; />"

    else
    
      fileUrl = ""
    
    end if

%> 
<!-- #include virtual="/_include/connect.inc" -->
<%
    share_cd = uploadform("scope_cd") 
    post_no = uploadform("post_no") 

    post_title = uploadform("post_title") 
    'response.write post_title & "::::::::::::::::<br>"

    post_contents = uploadform("post_contents") 

    post_title = Replace(post_title,"\n",chr(13) & chr(10))
    post_title = Replace(post_title,"\r",chr(13) & chr(10))
    post_title = Replace(post_title,"<br>",chr(13) & chr(10))
    post_title = Replace(post_title,"&",chr(38))
    post_title = Replace(post_title,",",chr(44))
    post_title = Replace(post_title,"'",chr(39)&chr(39))
    post_title = Replace(post_title,"`",chr(39)&chr(39))
    post_title = Replace(post_title,"""",chr(34))

    post_contents = Replace(post_contents,"\n",chr(13) & chr(10))
    post_contents = Replace(post_contents,"\r",chr(13) & chr(10))
    post_contents = Replace(post_contents,"<br>",chr(13) & chr(10))
    post_contents = Replace(post_contents,"&",chr(38))
    post_contents = Replace(post_contents,",",chr(44))
    post_contents = Replace(post_contents,"'",chr(39)&chr(39))
    post_contents = Replace(post_contents,"`",chr(39)&chr(39))
    post_contents = Replace(post_contents,"""",chr(34))


    post_contents = post_contents & chr(13) & chr(10) & fileUrl

    'response.write  strSQL

    strSQL = "p_tsh_post_update '" &  post_no & "','" & _
                                      post_title & "','" & _
                                      post_contents & "','" & _
                                      share_cd & "'"

    'response.write strSQL & ":::::::3:::::::::<br>"

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1      

    Set rs = nothing
   
    Set uploadform = Nothing 

    response.redirect "ws_mytopic.asp"


%><!-- #include virtual="/_include/connect_close.inc" -->


