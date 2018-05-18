<%
	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	Set KeyFile = fs.OpenTextFile("C:\Server\what3wordsKorea\data\sharetalk\_include\key.txt", 1)

	Do While KeyFile.AtEndOfStream <> True
		Response.write KeyFile.ReadLine
	loop
%>