<%@page import="kr.co.gungon.cs.NoticeDTO"%>
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
    
    NoticeDTO nDTO = css.searchOneNotice(num);
    pageContext.setAttribute("nDTO", nDTO);
    
}
%>



<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 미리보기</title>

  <!-- CSS 포함 (원래 사이트 스타일 유지) -->
  <link rel="stylesheet" type="text/css" href="/Gung_On/cs/cs_notice.css" />
  
<script>
  function editNotice(noticeNum) {
    // 부모 창을 다른 페이지로 이동
    if (window.opener && !window.opener.closed) {
      const url = "cs_notice_modify.jsp?num=" + encodeURIComponent(noticeNum);
      window.opener.location.href = url;
    }

    // 팝업 창 닫기
    window.close();
  }
</script>

  <style>
    .background-image {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0.25;
      z-index: -1;
      width: 850px;
      height: auto;
    }

    body {
      padding: 40px;
      font-family: sans-serif;
    }

    .board_detail_wrap {
      width: 1010px;
      margin: 0 auto;
    }

    .txt_line1 {
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
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <div class="board_detail_wrap bd_wrap">
    <h2 style="font-size: 35px; font-weight: bold; margin-bottom: 30px;">
     <c:choose>
		  <c:when test="${not empty param.num}">
		    상세보기
		  </c:when>
		  <c:otherwise>
		    미리보기
		  </c:otherwise>
	  </c:choose>
    </h2>

    <div class="detail_con board_detail_tit">
      <div class="txt_line1">
      <c:choose>
		  <c:when test="${not empty param.num}">
		    ${nDTO.notice_title}
		  </c:when>
		  <c:otherwise>
		    <%= request.getParameter("title") %>
		  </c:otherwise>
	  </c:choose>
      </div>
    </div>

    <div class="detail_con board_detail_info info_wrap">
      <span class="info">조회수 : ${ nDTO.notice_views }</span>&nbsp;&nbsp;
	  <span class="info">날짜: <fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd"/></span>
    </div>

    <div class="detail_con board_detail_txt">
      <c:choose>
		  <c:when test="${not empty param.num}">
		    ${nDTO.notice_content}
		  </c:when>
		  <c:otherwise>
		    <%= request.getParameter("content") %>
		  </c:otherwise>
	  </c:choose>
    </div>
  </div>

  <div style="text-align: center;">
  
  <c:if test="${not empty param.num}">
    <!-- num 파라미터가 존재할 때 실행될 내용 -->
    <button class="btn-close" id="editBtn" onclick="editNotice('<%= num %>')">수정</button>
  </c:if>
  
    <button class="btn-close" onclick="window.close()">닫기</button>
  </div>
</body>
</html>
