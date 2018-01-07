<%
'#################################################################################
'# 페이징 관련 함수
'#################################################################################

'/* 페이징시 전체 페이지수 계산 */
Function GetPageCount(ByVal pPageSu, ByVal pTotalRecord)
    Dim retVal
    
    pTotalRecord = CLng(pTotalRecord)
    retVal = Fix(pTotalRecord / pPageSu)
    If (pTotalRecord Mod pPageSu) > 0 Then
        retVal = retVal + 1
    End If
    GetPageCount = CLng(retVal)
End Function

'/* 페이지 네비게이션을 뿌려주는 함수 */
'/* pUrl : url주소(파라미터를 제외한 주소) */
'/* pPageSize : 한화면에 나타내는 리스트 수 */
'/* pTotalList : 총 리스트 수 */
'/* pCurPage : 현재 페이지 */
'/* pPreImg : 이전이미지 */
'/* pNextImg : 다음이미지 */
'/* param : 파라미터 */
Public Function ShowPageBar(ByVal pUrl, ByVal pPageSize, ByVal pTotalList, ByVal pCurPage, ByVal pPreImg, ByVal pNextImg, ByVal param)
    Dim nPREV
    Dim nCUR
    Dim nNEXT
    Dim i
    Dim nPageCount
    Dim retVal
    Dim strLink
    Dim pageKubun
		Dim nGSize : nGSize = 10

    If pCurPage = "" or isNull(pCurPage) Then pCurPage = 1
    
    nPageCount = GetPageCount(pPageSize, pTotalList)
    
    If pPreImg = "" Then
        pPreImg = "[이전]"
    Else
        pPreImg = "<img src='" & pPreImg & "' border=0 align=absmiddle>"
    End If
    
    If pNextImg = "" Then
        pNextImg = "[다음]"
    Else
        pNextImg = "<img src='" & pNextImg & "' border=0 align=absmiddle>"
    End If
    
    nPREV = (Fix((pCurPage - 1) / nGSize) - 1) * nGSize + 1
    nCUR = (Fix((pCurPage - 1) / nGSize)) * nGSize + 1
    nNEXT = (Fix((pCurPage - 1) / nGSize) + 1) * nGSize + 1

    ' [이전] 페이지 조합
    If nPREV > 0 Then
        strLink = purl & "?page=" & nPREV & "&" & param
        retVal = "<a href=""" & strLink & """>" & pPreImg & "</a> "
    Else
        retVal = ""
    End If
    i = 1
    Do While i < Fix(nGSize+1) And nCUR <= nPageCount
        If nCUR = nPageCount Or i = nGSize Then
            pageKubun = " "
        Else
            pageKubun = " | "
        End If
        
        If CInt(pCurPage) = CInt(nCUR) Then
            retVal = retVal & "<font style='color:#FF0000;font-weight: bold;'>" & nCUR & "</font>" & pageKubun
        Else
            strLink = purl & "?page=" & nCUR & "&" & param
            retVal = retVal & "<a href=""" & strLink & """>" & nCUR & "</a>" & pageKubun
        End If
        nCUR = nCUR + 1
        i = i + 1
    Loop
    ' [다음] 페이지 조합 
    If nNEXT <= nPageCount Then
        strLink = purl & "?page=" & nNEXT & "&" & param
        retVal = retVal & " <a href=""" & strLink & """>" & pNextImg & "</a>"
    Else
        retVal = retVal & ""
    End If
    
    ShowPageBar = retVal
End Function
%>