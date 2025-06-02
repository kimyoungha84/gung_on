<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title><c:out value="${ site_name }"/></title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<link rel="stylesheet" href="/Gung_On/common/css/common.css">
<link rel="stylesheet" href="mainGung.css">
<link rel="stylesheet" href="sideTab.css">
<style>
    


</style>
</head>
<body>

<header data-bs-theme="dark">
 <jsp:include page="/common/jsp/header.jsp" />
</header>

<main>
  <div id="container">

    <!-- ✅ 사이드탭 왼쪽 고정 -->
    <div id="side-tab">
      <jsp:include page="sideTab.jsp" />
    </div>

    <!-- ✅ 궁 정보 내용 오른쪽 출력 -->
    <div id="gung-content">
    <%
        GungService service = new GungService();
        GungDTO gung = service.getGungDetail("덕수궁");

        if (gung != null) {
    %>
        <h2><%= gung.getGung_name() %></h2>
        	<% if (gung.getImg_path() != null && !gung.getImg_path().trim().isEmpty()) { %>
    <img src="<%= gung.getImg_path() %>" alt="<%= gung.getGung_name() %> 이미지" class="gung-img" />
<% } %>
        <p> <%= gung.getGung_info() %></p>
        <p2> <%= gung.getGung_history() %></p2>
    <%
        } else {
    %>
        <p>경복궁 정보를 불러올 수 없습니다.</p>
    <%
        }
    %>
    <!-- 구글 지도  -->
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.5440448164695!2d126.97257653956333!3d37.56580487215515!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca28d3199c531%3A0x7a2d35df0efd2d8!2z642V7IiY6raB!5e0!3m2!1sko!2skr!4v1747701229784!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
  </div>
</main>

<footer class="text-body-secondary py-5">
 <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>
