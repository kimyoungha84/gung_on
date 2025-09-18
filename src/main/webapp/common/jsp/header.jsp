<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  .header-nav-link {
  font-size: 20px;
  }
</style>

  <!-- 사용자 상태 표시 영역 -->
<div class="user-status-bar" >
  <jsp:include page="/common/jsp/userStatus.jsp"/>
</div>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">
<!-- 헤더 네비게이션 -->
<div class="header">
  <nav class="header-nav">
    <ul class="header-nav-list">
      <li class="header-nav-item">
        <a href="${pageContext.request.contextPath}/gung/gyungbukgung.jsp" class="header-nav-link">궁 안내</a>
        <ul class="header-submenu">
          <li><a href="${pageContext.request.contextPath}/gung/gyungbukgung.jsp">경복궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/gyeonghuigung.jsp">경희궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/changdeokgung.jsp">창덕궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/changgyeonggung.jsp">창경궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/deoksugung.jsp">덕수궁</a></li>
        </ul>
      </li>
      <li class="header-nav-item">
        <a href="#" class="header-nav-link">행사 안내</a>
        <ul class="header-submenu">
          <li><a href="${pageContext.request.contextPath}/program/programInfo/programInfo.jsp">행사 안내</a></li>
          <li><a href="${pageContext.request.contextPath}/program/programAll/programAll.jsp">행사 모아보기</a></li>
        </ul>
      </li>
      <li class="header-nav-item">
       <a href="${pageContext.request.contextPath}/mainpage/mainpage.jsp"> <img src="${pageContext.request.contextPath}/common/images/mainpage/header_icon.png" alt="로고"></a>
      </li>
      <li class="header-nav-item">
        <a href="${pageContext.request.contextPath}/course/course_rule.jsp" class="header-nav-link">관람 안내</a>
        <ul class="header-submenu">
          <li><a href="${pageContext.request.contextPath}/course/course_rule.jsp">관람 규칙</a></li>
          <li><a href="${pageContext.request.contextPath}/course/course_time.jsp">관람 시간</a></li>
          <li><a href="${pageContext.request.contextPath}/course/course.jsp">관람 코스</a></li>
          <li><a href="${pageContext.request.contextPath}/course/users_course.jsp">사용자 추천 코스</a></li>
        </ul>
      </li>
      <li class="header-nav-item">
        <a href="${pageContext.request.contextPath}/cs/notice_main.jsp" class="header-nav-link">고객센터</a>
        <ul class="header-submenu">
          <li><a href="${pageContext.request.contextPath}/cs/notice_main.jsp">공지사항</a></li>
          <li><a href="${pageContext.request.contextPath}/cs/faq_main.jsp">자주 묻는 질문</a></li>
          <li><a href="${pageContext.request.contextPath}/cs/myinquiry.jsp">1:1 문의</a></li>
        </ul>
      </li>
    </ul>
  </nav>
</div>

