<%
  Dim Dbcon
  Set Dbcon = Server.CreateObject("ADODB.Connection")
  Dbcon.Open "Driver={MySQL ODBC 3.51 driver}; Server= 117.52.74.202;Database=test; Uid=root; Pwd=1q2w3e4r5%;"

 if Dbcon.errors.count = 0 then ' 접속 시, 에러 발생 여부를 확인합니다.
    Response.Write "MySQL 접속 성공!" 

else

    Response.Write "MySQL 접속 실패!"

    Response.End
end if 

 Dbcon.Execute "CREATE TABLE my_ado(id int Not null primary key, name varchar(20)," _
& "txt text, dt date, tm time, ts timestamp)"
 

%>
