<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/Gung_On/common/css/common.css">
<link rel="stylesheet" href="/Gung_On/hjs/sideTab.css">
<style type="text/css">

</style>

<script type="text/javascript">
$(function(){
	$(document).ready(function(){
	  $(".toggle").click(function(){
	    $(this).toggleClass("active");
	    $(this).next(".submenu").slideToggle();
	    $(".toggle").not(this).removeClass("active").next(".submenu").slideUp(); // 하나만 열리도록
	  });
	});
});//ready
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
          <li><a href="http://localhost/Gung_On/hjs/gyungbukgung.jsp">경복궁 소개·역사</a></li>
          <li><a href="http://localhost/Gung_On/Story/gung_story.jsp">경복궁 이야기</a></li>
        </ul>
      </li>
      <li>
        <button class="toggle">창덕궁</button>
        <ul class="submenu">
          <li><a href="http://localhost/Gung_On/hjs/changdeokgung.jsp">창덕궁 소개</a></li>
          <li><a href="http://localhost/Gung_On/Story/changdeokgung_story.jsp">창덕궁 이야기</a></li>
        </ul>
      </li>
      <li>
        <button class="toggle">창경궁</button>
        <ul class="submenu">
          <li><a href="http://localhost/Gung_On/hjs/changgyeonggung.jsp">창경궁 소개</a></li>
          <li><a href="http://localhost/Gung_On/Story/changgyeonggung_story.jsp">창경궁 이야기</a></li>
        </ul>
      </li>
      <li>
        <button class="toggle">덕수궁</button>
        <ul class="submenu">
          <li><a href="http://localhost/Gung_On/hjs/deoksugung.jsp">덕수궁 소개</a></li>
          <li><a href="http://localhost/Gung_On/Story/deoksugung_story.jsp">덕수궁 이야기</a></li>
        </ul>
      </li>
      <li>
        <button class="toggle">경희궁</button>
        <ul class="submenu">
          <li><a href="http://localhost/Gung_On/hjs/gyeonghuigung.jsp">경희궁 소개·역사</a></li>
          <li><a href="http://localhost/Gung_On/Story/gyeonghuigung_story.jsp">경희궁 이야기</a></li>
        </ul>
      </li>
    </ul>
  </div>


</main>

</body>
</html>