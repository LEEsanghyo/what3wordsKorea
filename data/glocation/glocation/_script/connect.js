
// Print
function PrintArticle(url) {
    var newPopupWindow = window.open(url, 'print', 'width=680,height=760,scrollbars=1,resizable=yes');

    if (newPopupWindow) { newPopupWindow.focus(); }
}

//  Send to SNS
function SendTwitter(title, url) {
    var newPopupWindow = window.open("http://twitter.com/home?status=" + encodeURIComponent(title) + " " + encodeURIComponent(url), 'twitter', '');

    if (newPopupWindow) { newPopupWindow.focus(); }
}

function SendFaceBook(title, url) {
    var newPopupWindow = window.open("http://www.facebook.com/sharer.php?u=" + url + "&t=" + encodeURIComponent(title), 'facebook', '');
    if (newPopupWindow) { newPopupWindow.focus(); }
}

function SendMe2Day(title, url, tag) {
    title = "\"" + title + "\":" + url;
    var newPopupWindow = window.open("http://me2day.net/posts/new?new_post[body]=" + encodeURIComponent(title) + "&new_post[tags]=" + encodeURIComponent(tag), 'me2Day', '');

    if (newPopupWindow) { newPopupWindow.focus(); }
}

function SendYozm(link, prefix, parameter) {
    var href = "http://yozm.daum.net/api/popup/prePost?link=" + encodeURIComponent(link) + "&prefix=" + encodeURIComponent(prefix) + "&parameter=" + encodeURIComponent(parameter);
    var a = window.open(href, 'yozmSend', '');

    if (a) { a.focus(); }
}


// Send to Bookmark
function BookmarkGoogle(title, url, labels) {
    var newPopupWindow = window.open("http://www.google.com/bookmarks/mark?op=add&title=" + encodeURIComponent(title) + "&bkmk=" + encodeURIComponent(url) + "&labels=" + encodeURIComponent
(labels), "google", '');
    if (newPopupWindow) { newPopupWindow.focus(); }
}

function BookmarkNaver(title, url) {
    var newPopupWindow = window.open("http://bookmark.naver.com/post?ns=1&title=" + encodeURIComponent(title) + "&url=" + encodeURIComponent(url), "naver", '');
    if (newPopupWindow) { newPopupWindow.focus(); }
}


function sendCyWorld(url, title, thumbnail, summary) {
    var newPopupWindow = window.open("http://csp.cyworld.com/bl/bo_recommend_pop.php?url=" + encodeURIComponent(url) + "&title=" + encodeURIComponent(title) + "&thumbnail=" + encodeURIComponent
(url) + "&summary=" + encodeURIComponent(summary), "xu", '');
    if (newPopupWindow) { newPopupWindow.focus(); }
}


function sendCblog(title, url, thumbnail, summary, writer) {
    var newPopupWindow = window.open("http://csp.cyworld.com/bi/bi_recommend_pop.php?url=" + encodeURIComponent(url) + "&title_nobase64=" + encodeURIComponent
(title) + "&thumbnail=" + encodeURIComponent(thumbnail) + "&summary_nobase64=" + encodeURIComponent(summary) + "&writer=" + encodeURIComponent(writer) + "&corpid=65962485", "recom_icon_pop",
"width=400,height=364,scrollbars=no,resizable=no");
    if (newPopupWindow) { newPopupWindow.focus(); }
}

function ClipBoard(str) {
    window.clipboardData.setData("Text", str);
    alert("해당내용이 복사 되었습니다. \n\n\HTML 모드로 하신 후에 \n\nCtrl-V로 내용을 붙여 넣어주세요.   ");
}