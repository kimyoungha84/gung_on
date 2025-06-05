<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); 
request.setAttribute("currentMenu", "notice");
%>

<%
String numStr = request.getParameter("num");
int num = 0;
if (numStr != null && !numStr.isEmpty()) {
    try {
        num = Integer.parseInt(numStr);
    } catch (NumberFormatException e) {
        out.println("숫자로 변환할 수 없습니다: " + numStr);
    }
    
    CsService css = new CsService();
	
    css.addViews(num);
    
    NoticeDTO nDTO = css.searchOneNotice(num);
    pageContext.setAttribute("nDTO", nDTO);
    
}



%>
<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 공지사항 - 상세</title>
  <link rel="stylesheet" type="text/css" href="cs_notice.css" />

  <style>

  </style>
  
  <script>
  
  function moveToNoticeMain() {
	    const previousPage = document.referrer;

	    // 이전 페이지 URL에 'notice_main'이 포함되어 있으면 이전 페이지로 이동
	    if (previousPage.includes("notice_main")) {
	        window.location.href = previousPage;
	    } else {
	        // 그렇지 않으면 notice_main.jsp로 이동
	        window.location.href = "notice_main.jsp";
	    }
	}
  

  
  </script>
  
  
</head>

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>


  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="main">
   <h2>공지사항</h2><br>
  <div class="board_detail_wrap bd_wrap">
    <div class="detail_con board_detail_tit">
      <div class="txt_line1">${ nDTO.notice_title }</div>
    </div>
    <div class="detail_con board_detail_info info_wrap">
      <span class="info">조회수 : ${ nDTO.notice_views } </span>&nbsp;&nbsp;
      <span class="info">등록일 : <fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd "/></span>
    </div>
    <div class="detail_con board_detail_txt">
      ${ nDTO.notice_content }
    </div>
  </div>
</div>


<div class="btn_wrap flex_center mt60">
	<button type="button" onclick="moveToNoticeMain();" class="btn btn_r bd_black"><strong>목록</strong></button>
</div>


<div class="lnb_wrap" >
	<div class="lnb_wrap current" id="lnbMenuDiv">


<!-- Empty Layout -->


<!-- //Empty Layout --></div>

					</div>



  <%@ include file="side.jsp" %>



  <br>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
