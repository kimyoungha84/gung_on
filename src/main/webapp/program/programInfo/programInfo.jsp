<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
  String selectedDate = request.getParameter("selectedDate");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>궁온 헤더 탭</title>
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
  <link rel="stylesheet" href="../programInfo/programInfo.css" />
  <style>

  </style>
</head>
<body>

<header>
  <jsp:include page="/common/jsp/header.jsp" />
</header>

<div class="sub_visual">
  <div class="img_wrap">
    <img src="<%= request.getContextPath() %>/program/images/program.png" alt="행사 이미지" />
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
        <li>행사</li>
      </ol>

      <h3 class="program_text">행사</h3>

      <div id="calendarAndList" style="display: flex; gap: 50px;">
        <div class="calendar_wrapper">
          <iframe id="calendarIframe" src="<%= request.getContextPath() %>/program/programInfo/scheduler.jsp" frameborder="0"></iframe>
        </div>

        <div id="eventList">
          <h3 style="text-align: center;">행사 목록</h3>
          <ul id="eventsUl">
            <%
              if (selectedDate == null || selectedDate.isEmpty()) {
            %>
              <!--<li>날짜를 선택하세요.</li>-->
              <li>안녕하세요. 궁온에 오신 걸 환영합니다.<br>
              	  저는 행사관리 담당자 김영하입니다.<br>
              	  날짜를 선택하세요.<br>
              </li>              
            <%
              } else {
                RequestDispatcher rd = request.getRequestDispatcher("programEvents.jsp?date=" + selectedDate);
                rd.include(request, response);
              }
            %>
          </ul>
        </div>
      </div>
    </div>
  </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
window.addEventListener("message", function (event) {
	  if (event.data && event.data.type === "dateSelected") {
	    const dateStr = event.data.date;
	    const $eventsUl = $("#eventsUl");

	    $eventsUl.fadeOut(100, function () {
	      $eventsUl.html("<li>로딩 중...</li>").fadeIn(100);

	      $.ajax({
	        url: "programEvents.jsp",
	        method: "GET",
	        data: { date: dateStr },
	        success: function (data) {
	          $eventsUl.fadeOut(100, function () {
	            $eventsUl.html(data).fadeIn(200);
	          });
	        },
	        error: function () {
	          $eventsUl.fadeOut(100, function () {
	            $eventsUl.html("<li>행사 정보를 불러오지 못했습니다.</li>").fadeIn(200);
	          });
	        }
	      });
	    });
	  }
	});
</script>

<footer>
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>