<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>궁온 헤더 탭</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">
  <link rel="stylesheet" href="../programAll/programAll.css" />
  
  <style>
    
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

  function loadEventsByPlace(place) {

    $(".swiper-slide").removeClass("current");
    $(".swiper-slide." + place).addClass("current");

    $("#eventList").html("로딩 중...");

    $.ajax({
      url: "programAllEvents.jsp",
      method: "GET",
      data: { programPlace: place },
      success: function(data) {
        $("#eventList").html(data);
      },
      error: function() {
        $("#eventList").html("<li>행사 정보를 불러오지 못했습니다.</li>");
      }
    });
  }

  $(document).ready(function() {

    loadEventsByPlace("경복궁");
  });
</script>
</head>
<body>
<header>
  <jsp:include page="/common/jsp/header.jsp" />
</header>

<div class="sub_visual">
  <div class="img_wrap">
    <img src="<%= request.getContextPath() %>/program/images/program.png" alt="행사 이미지">
  </div>
  <div class="txt_wrap">
    <h2 class="sub_tit">행사 안내</h2>
  </div>
</div>

<div class="main_wrapper">

  <div class="sub_menu_box">
    <div class="menu_title_box">
    <div class="menu_title">행사 안내</div>
    </div>
    <div class="menu_items_wrapper">
      <div class="menu_item <%= request.getRequestURI().endsWith("programInfo.jsp") ? "active" : "" %>">
        <a href="<%= request.getContextPath() %>/program/programInfo/programInfo.jsp">행사</a>
      </div>
      <div class="menu_item <%= request.getRequestURI().endsWith("programAll.jsp") ? "active" : "" %>">
        <a href="<%= request.getContextPath() %>/program/programAll/programAll.jsp">행사 모아보기</a>
      </div>
    </div>
  </div>

  <main class="contents_wrap" id="contents_wrap">
    <div class="contents contents_sub">
      <ol class="breadcrumb_list">
        <li>홈</li>
        <li>행사안내</li>
        <li>행사 모아보기</li>
      </ol>

      <h3 class="program_text">행사 모아보기</h3>

<div class="reservation_tab sub_tab">
  <div class="swiper-wrapper">
    <div class="swiper-slide 경복궁 current">
      <a href="#;" onclick="loadEventsByPlace('경복궁');" title="경복궁">경복궁</a>
    </div>
    <div class="swiper-slide 창덕궁">
      <a href="#;" onclick="loadEventsByPlace('창덕궁');" title="창덕궁">창덕궁</a>
    </div>
    <div class="swiper-slide 덕수궁">
      <a href="#;" onclick="loadEventsByPlace('덕수궁');" title="덕수궁">덕수궁</a>
    </div>
    <div class="swiper-slide 창경궁">
      <a href="#;" onclick="loadEventsByPlace('창경궁');" title="창경궁">창경궁</a>
    </div>
    <div class="swiper-slide 경희궁">
      <a href="#;" onclick="loadEventsByPlace('경희궁');" title="경희궁">경희궁</a>
    </div>
  </div>
</div>
      
            <div id="eventList">
        로딩 중...
      </div>

    </div>
  </main>
</div>

<footer>
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>