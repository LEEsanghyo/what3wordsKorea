<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/words.asp" -->
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>What3Words Home</title>
		<link rel="stylesheet" href="/_css/style.css" type="text/css">		
        <style>
            .info_this_page{
                margin-top:80px;
                display:block;
                text-align:center;
                font-size:30pt;
                font-style:italic;
            }
            .write_content_box{
                margin-top:30px;
                width:100%;
                height:50%;
                padding:3%;
            }
            .whatsta_write_box{
                width:100%;
                height:100%;
                border:2px black solid;
                vertical-align:middle;
                font-size:20pt;
                font-style:italic;
                padding:1%;
                background:url('images/what3words.png') no-repeat center center;
                background-size:cover;
                opacity:0.8;
                display:block;
                border-radius: 10%;
                text-align:center;
                cursor:pointer;
            }
            .busking_write_box{
                width:100%;
                height:100%;
                border:2px black solid;
                font-size:20pt;
                font-style:italic;
                padding:1%;
                background:url('images/busking1.jpg') no-repeat center center;
                background-size:cover;
                opacity:0.8;
                display:block;
                border-radius: 10%;
                text-align:center;
                cursor:pointer;
            }
            .foodtruck_write_box{
                width:100%;
                height:100%;
                border:2px black solid;
                font-size:20pt;
                font-style:italic;
                padding:1%;
                background:url('images/foodtruck2.jpg') no-repeat center center;
                background-size:cover;
                opacity:0.8;
                display:inline-block;
                border-radius: 10%;
                text-align:center;
                cursor:pointer;
                
            }
            .volunteer_write_box{
                width:100%;
                height:100%;
                border:2px black solid;
                font-size:20pt;
                font-style:italic;
                padding:1%;
                background:url('images/volunteer1.jpg') no-repeat center center;
                background-size:cover;
                opacity:0.8;
                display:block;
                border-radius: 10%;
                text-align:center;
                cursor:pointer;
            }
        </style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <!-- 합쳐지고 최소화된 최신 CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	    <script type="text/javascript">
            function go_to_whatsta_page() {

                location.href = "test_page_insta_write.asp";

            }
            function go_to_busking_page() {

                location.href = "test_busking_write.asp";

            }
            function go_to_foodtruck_page() {

                location.href = "test_foodtruck_write.asp";

            }
            function go_to_volunteer_page() {

                location.href = "test_volunteer_write.asp";

            }
	    </script>
    
    </head>

	<body>
		<% top_menu = "HOME" %>
		
		<!-- #include virtual="/_include/top_menu.asp" -->
		<!-- #include virtual="/_include/top_menulist.asp" -->
        <div class="info_this_page">
            회원님의 소중한 글이 올라갈 곳을 선택해 주세요
        </div>
        <div class="write_content_box row">
            <div class="whatsta_write_box col-sm-3 col-md-3 col-lg-3 col-xl-3" onclick="go_to_whatsta_page();">
                WHATSTAGRAM
            </div>
            <div class="busking_write_box col-sm-3 col-md-3 col-lg-3 col-xl-3" onclick="go_to_busking_page();">
                BUSKING
            </div>
            <div class="foodtruck_write_box col-sm-3 col-md-3 col-lg-3 col-xl-3" onclick="go_to_foodtruck_page();">
                FOODTRUCK
            </div>
            <div class="volunteer_write_box col-sm-3 col-md-3 col-lg-3 col-xl-3" onclick="go_to_volunteer_page();">
                VOLUNTEER
            </div>
        </div>
             
	</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->