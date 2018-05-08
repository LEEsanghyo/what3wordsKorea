<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<%
    post_no = request("post_no")

    strSQL = "p_tsh_post_detail_read  '" & post_no & "'"
    
    'response.Write strSQL
    'response.end

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1    

    if NOT rs.EOF and NOT rs.BOF then
      post_title = rs("post_title")
      post_contents = rs("post_contents")
      register_date = rs("register_date")
      member_name = rs("member_name")
      answer_cnt = rs("answer_cnt")
      engage_cnt = rs("engage_cnt")
      logo_url = rs("logo_url")
    end if  

    set rs = nothing

    ' ANSWER
    strSQL = "p_tsh_post_answer_read '" & post_no & "'"
    
    'response.Write strSQL
    'response.end
    
    Set rsAnswer = Server.CreateObject("ADODB.RecordSet")
    rsAnswer.Open strSQL, DbCon, 1, 1    

    if rsAnswer.EOF or rsAnswer.BOF then
	  NoDataAnswer = True
    Else
	  NoDataAnswer = False
    end if 

%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="S A Bokhari">
<meta name="description" content="글공유">
<meta name="keywords" content="글공유">
<title>글공유 상세</title>
<link rel="stylesheet" href="/_include/style.css" type="text/css">


<SCRIPT LANGUAGE=javascript>
<!--
    var xhr;

    function PostAnswer(elem) {
        //alert("1");

        answer_desc = document.getElementById("answer_desc").value;
        post_no = document.getElementById("post_no").value;

        if (answer_desc == "") {
            document.getElementById("answer_desc").focus();
            return false;
        }
        else {
            answer_desc = answer_desc.replace(/\n/g, "<BR>");
            answer_desc = answer_desc.replace(/\r/g, "<BR>");
            answer_desc = answer_desc.replace(/&/g, "<amp>");
            answer_desc = answer_desc.replace(/,/g, "<comma>");
            answer_desc = answer_desc.replace(/'/g, "<apostrophe>");
            answer_desc = answer_desc.replace(/"/g, "<quote>");
        }

        //alert(answer_desc);
        //return false;

        var strurl = "ws_answer_set.asp?post_no=" + post_no + "&answer_desc=" + answer_desc;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = PostAnswerSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }

    function PostAnswerSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;

            post_no = document.getElementById("post_no").value;

            var siteurl = "fg_friendtopic_detail.asp?post_no=" + post_no;
            //alert(siteurl);

            window.location.href = siteurl;
        }
    }

    function PostEngage(elem) {
        //alert("1");
        var pno = elem.getAttribute("pno");
        var code = elem.getAttribute("code");

        var myNodelist = document.getElementsByName("engage" + pno);
        var i;
        for (i = 0; i < myNodelist.length; i++) {
            myNodelist[i].style.color = "#000000";
        }
        //alert("2");

        elem.style.color = "#3388cc";

        //alert(rprocess);
        var strurl = "ws_engage_set.asp?post_no=" + pno + "&engage_code=" + code;

        //alert(strurl);
        //return false;

        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = PostEngageSet;
        xhr.open("Get", strurl);
        xhr.send(null);
    }

    function PostEngageSet() {
        if (xhr.readyState == 4) {
            var data = xhr.responseText;
            var slipdata = data.split(',');

            //alert(data);
            //alert(slipdata[2]);
            document.getElementById("engage_" + slipdata[0]).innerHTML = "공감 " + slipdata[1];
            if (slipdata[2] == "") {
                document.getElementById("trbox_" + slipdata[0]).style.display = "none";
            }
            else {
                document.getElementById("trbox_" + slipdata[0]).style.display = "block";
                document.getElementById("engagebox_" + slipdata[0]).innerHTML = slipdata[2];
            }

            //alert(slipdata[2]);
        }
    }

//-->
</SCRIPT>

</head>

<body>
<input type="checkbox" id="menuToggle">
<input type="hidden" id="post_no" value="<%=post_no %>" >

    <% top_menu = "글공유" %>
    <!-- #include virtual="/_include/top_detail_friendtopic.asp" -->
    <!-- #include virtual="/_include/top_menulist.asp" -->
<div style="height:70px;"></div>
<div class="content">
    <table style="width:100%">
       <tr height="4px;"><td class="bbcDate" style="width:100%;height:3px;background:#EEEEEE">
           </td></tr>
    </table>
     <div style="width:100%;padding: 30px 5px;"> 
            <table class="main_table">
                <tr>
                    <td class="bbcTitle"><%=post_title %></td>
                </tr>
                <tr>
                <td class="bbcDate">
                                <table style="width:100%;">
                                    <tr><td width="8%" rowspan="2" width="50px" text-align="center"><img src="<%=logo_url %>" style="width:40px;height:40px;border-radius:20px;"/></td>
                                        <td> <%=member_name %></td></tr>
                                    <tr><td><span style="font-size:9px;color:#808080;">><%=register_date %></span></td></tr>
                                </table>
                </td>
                </tr>
                <tr style="height:20px;"><td></td></tr>
                <tr>
                    <td class="bbcContent" style="font-weight:normal;line-height:150%;">
                    <%=post_contents %>
                    </td>
                </tr>
                <tr style="height:20px;"><td></td></tr>
                <%                     
                ' ENGAGE
                strSQL = "p_tsh_post_engage_read '" & post_no & "'"
        
                Set rs = Server.CreateObject("ADODB.RecordSet")
                rs.Open strSQL, DbCon, 1, 1    

                if NOT rs.EOF and NOT rs.BOF then %>
                <tr id="trbox_<%=post_no %>" style="display:block;"><td>                            
                        <div id="engagebox_<%=post_no %>">
                        <% Do While Not rs.EOF %>    
                        <a href="fg_friendtopic.asp?member_no=<%=rs("member_no") %>">
                        <img src="<%=rs("logo_url") %>" style="margin-right:10px;width:30px;height:30px;border-radius:15px;"/>
                        </a>
                        <%     
                        rs.MoveNext
                        Loop 
                        %>
                        </div>
                </td>
                </tr>
                <% else %>
                <tr id="trbox_<%=post_no %>" style="display:none;"><td>
                        <table style="width:90%;">
                        <tr>
                        <td>                                    
                        <div id="engagebox_<%=post_no %>">
                        </div>
                        </td>
                        </tr>
                        </table>
                </td>
                </tr>
                <%
                     end if         
                set rs = nothing
                %> 

                <tr style="height:5px;"><td></td></tr>
                <tr>
                    <td class="bbcDate">
                        <span style="padding:5px 0;font-weight:bold;border-radius:2px;cursor:pointer;" id="engage_<%=post_no %>" name="engage<%=post_no %>" pno="<%=post_no %>" code="GOOD" onclick="PostEngage(this);">공감
                             <%=engage_cnt %> </span> 
                        <span style="margin-left:20px;padding:5px 0;font-weight:bold;border-radius:2px;">댓글 <%=answer_cnt %></span>
                    </td>
                </tr>
                <tr>
                    <td class="bbcDate" style="vertical-align:middle;">
                        <table width="100%" style="border:solid 0px #dddddd;">
                            <tr><td width="87%">
                                    <textarea style="font-family: Arial, '맑은 고딕', 돋움; font-size: 12px; border: 1px dashed #C0C0C0; width: 100%; height: 30px;" id="answer_desc"></textarea>
                                </td>
                                <td width="5px;"></td>
                                <td text-align="center">
                                    <button onclick="PostAnswer();">저장</button>                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <% if NoDataAnswer = False then ' 데이터가 있으면 데이터 출력 %>
                <% Do While Not rsAnswer.EOF %>    
                <tr style="height:15px;"><td></td></tr>
                <tr><td align="center">
                            <table style="width:100%;">
                                <tr><td width="8%" rowspan="3" width="50px" text-align="center"><img src="<%=rsAnswer("logo_url") %>" style="width:40px;height:40px;border-radius:20px;"/></td>
                                    <td><span style="font-size:12px;color:#808080;"><%=rsAnswer("member_name") %></span></td></tr>
                                <tr><td><span style="font-size:12px;font-weight:normal;"><%=rsAnswer("answer_desc") %></span></td></tr>
                                <tr><td><span style="font-size:12px;font-weight:normal;color:#808080;">2017-03-20 오전 10:02:33</span>
                                    </td></tr>
                            </table>
                </td>
                </tr>
                <%     
                rsAnswer.MoveNext
                Loop 
                %>
                <% end if         
                set rsAnswer = nothing
                %> 

                <tr height="2px;"><td style="border-bottom:solid  1px #dddddd"></td></tr>
           </table>
       </div>
</div>
<div class="bottom">

</div>
</body>
</html>