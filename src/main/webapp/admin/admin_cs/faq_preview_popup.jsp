<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
    
    FaqDTO fDTO = css.searchOneFaq(num);
    pageContext.setAttribute("fDTO", fDTO);
    
}
%>



<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 미리보기</title>

  <!-- CSS 포함 (원래 사이트 스타일 유지) -->
  <link rel="stylesheet" type="text/css" href="../royal_css/common.css" />
  <link rel="stylesheet" type="text/css" href="../royal_css/reset.css" />
  <link rel="stylesheet" type="text/css" href="../royal_css/layout.css" />
  <link rel="stylesheet" href="cs_common/mainCSS.css">
<script>
  function editFaq(faqNum) {
    // 부모 창을 다른 페이지로 이동
    if (window.opener && !window.opener.closed) {
      const url = "cs_faq_modify.jsp?num=" + encodeURIComponent(faqNum);
      
      window.opener.location.href = url;
    }

    // 팝업 창 닫기
    window.close();
  }
  let openItem = null;
  
  
  function toggleAnswer(element, event) {
	    event.preventDefault(); // 페이지 리로드 방지

	    var parentItem = element.closest('.q_item'); // 클릭한 항목의 부모 <li> 요소

	    // 이미 열린 항목이 있고, 그 항목이 현재 클릭된 항목이 아니면 닫기
	    if (openItem && openItem !== parentItem) {
	        openItem.classList.remove('open');
	    }

	    // 현재 클릭된 항목을 'open' 상태로 토글
	    parentItem.classList.toggle('open');

	    // 열린 항목을 추적
	    openItem = parentItem.classList.contains('open') ? parentItem : null;
	}
  
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cs/cs_notice.css" />

  <style>
   /* .background-image {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0.25;
      z-index: -1;
      width: 850px;
      height: auto;
    } */

    body {
      padding: 40px;
      font-family: sans-serif;
    }

    .board_detail_wrap {
      width: 1010px;
      margin: 0 auto;
    }

   /*  .txt_line1 {
      font-size: 24px;
      font-weight: bold;
    }

    .board_detail_info {
      margin-top: 15px;
      font-size: 14px;
      color: #666;
    }

    .board_detail_txt {
      margin-top: 30px;
      font-size: 16px;
      line-height: 1.6;
    }
    */

    .btn-close {
      margin-top: 40px;
      padding: 10px 20px;
      font-size: 14px;
      background-color: #666;
      color: white;
      border: none;
      cursor: pointer;
    } 
  
  
  </style>
</head>

<body>
  <!-- 배경 이미지 -->
  <img class="background-image" src="${pageContext.request.contextPath}/common/images/cs/궁온.png" alt="배경 이미지">

  <div class="board_detail_wrap bd_wrap">
    <h2 style="font-size: 35px; font-weight: bold; margin-bottom: 30px;">
     <c:choose>
		  <c:when test="${not empty param.num}">
		    FAQ상세
		  </c:when>
		  <c:otherwise>
		    미리보기
		  </c:otherwise>
	  </c:choose>
    </h2>

    
    <ul class="q_list">
    <li class="q_item open">
				    <div class="q_box">
				        <a href="#" class="box_inn ic_q" onclick="toggleAnswer(this, event);" title="답변 열기">
				            <span class="ic">Q</span>
				            <span class="txt">
				                <div class="tit_txt"> 
				                <c:choose>
								  <c:when test="${not empty param.num}">
								    ${fDTO.faq_title}
								  </c:when>
								  <c:otherwise>
								    <%= request.getParameter("title") %>
								  </c:otherwise>
							  	</c:choose>
							  </div>
				            </span>
				        </a>
				    </div>
				    <div class="a_box">
				        <div class="box_inn ic_a_yes">
				            <span class="ic">A</span>
				            <span class="txt" id="answer-1"></span>
				             <c:choose>
								  <c:when test="${not empty param.num}">
								    ${fDTO.faq_content}
								  </c:when>
								  <c:otherwise>
								    <%= request.getParameter("content") %>
								  </c:otherwise>
							 </c:choose>
				            
				        </div>
				    </div>
				</li>
			</ul>

  </div>
  <div style="text-align: center;">
  
  <c:if test="${not empty param.num}">
    <!-- num 파라미터가 존재할 때 실행될 내용 -->
    <button class="btn-close" id="editBtn" onclick="editFaq('<%= num %>')">수정</button>
  </c:if>
  
    <button class="btn-close" onclick="window.close()">닫기</button>
  </div>
</body>
</html>
