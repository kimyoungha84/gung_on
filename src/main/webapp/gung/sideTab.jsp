<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String currentPath = request.getRequestURI();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/common/css/common.css">
<link rel="stylesheet" href="/sideTab.css">
<style type="text/css">

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
  $(".toggle").click(function(){
    $(this).toggleClass("active");
    $(this).next(".submenu").slideToggle();
    $(".toggle").not(this).removeClass("active").next(".submenu").slideUp(); // 하나만 열리도록
  });
});
</script>
</head>
<body>

<main>
<div class="side-menu">
  <h2>궁능소개</h2>
  <ul class="accordion">

    <li>
      <button class="toggle">경복궁</button>
      <ul class="submenu">
        <li><a href="../gung/gyungbukgung.jsp"
               class="<%= currentPath.contains("/gung/gyungbukgung.jsp") ? "active" : "" %>">경복궁 소개·역사</a></li>
        <li><a href="../Story/gung_story.jsp"
               class="<%= currentPath.contains("/Story/gung_story.jsp") ? "active" : "" %>">경복궁 이야기</a></li>
      </ul>
    </li>

    <li>
      <button class="toggle">창덕궁</button>
      <ul class="submenu">
        <li><a href="../gung/changdeokgung.jsp"
               class="<%= currentPath.contains("/gung/changdeokgung.jsp") ? "active" : "" %>">창덕궁 소개</a></li>
        <li><a href="../Story/changdeokgung_story.jsp"
               class="<%= currentPath.contains("/Story/changdeokgung_story.jsp") ? "active" : "" %>">창덕궁 이야기</a></li>
      </ul>
    </li>

    <li>
      <button class="toggle">창경궁</button>
      <ul class="submenu">
        <li><a href="../gung/changgyeonggung.jsp"
               class="<%= currentPath.contains("/gung/changgyeonggung.jsp") ? "active" : "" %>">창경궁 소개</a></li>
        <li><a href="../Story/changgyeonggung_story.jsp"
               class="<%= currentPath.contains("/Story/changgyeonggung_story.jsp") ? "active" : "" %>">창경궁 이야기</a></li>
      </ul>
    </li>

    <li>
      <button class="toggle">덕수궁</button>
      <ul class="submenu">
        <li><a href="../gung/deoksugung.jsp"
               class="<%= currentPath.contains("/gung/deoksugung.jsp") ? "active" : "" %>">덕수궁 소개</a></li>
        <li><a href="../Story/deoksugung_story.jsp"
               class="<%= currentPath.contains("/Story/deoksugung_story.jsp") ? "active" : "" %>">덕수궁 이야기</a></li>
      </ul>
    </li>

    <li>
      <button class="toggle">경희궁</button>
      <ul class="submenu">
        <li><a href="../gung/gyeonghuigung.jsp"
               class="<%= currentPath.contains("/gung/gyeonghuigung.jsp") ? "active" : "" %>">경희궁 소개·역사</a></li>
        <li><a href="../Story/gyeonghuigung_story.jsp"
               class="<%= currentPath.contains("/Story/gyeonghuigung_story.jsp") ? "active" : "" %>">경희궁 이야기</a></li>
      </ul>
    </li>

  </ul>
</div>
</main>

</body>
</html>
