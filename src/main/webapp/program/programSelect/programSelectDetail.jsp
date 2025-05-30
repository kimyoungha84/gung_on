<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String userName = (String) session.getAttribute("userName");

	String reservationNum = "202506151900"; // request.getParameter("reservationNum");
	String phoneFirst = "010";// request.getParameter("phoneFirst");
	String phoneSecond = "1234"; // request.getParameter("phoneSecond");
	String phoneThird = "5678"; // request.getParameter("phoneThird");

	String phone = phoneFirst + "-" + phoneSecond + "-" + phoneThird;

	String programName = "창덕궁 달빛기행";
	String reservationDate = "2025-06-15(일) 19:00";
	String language = "한국어";
	int peopleCount = 2;
	int totalAmount = 30000;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>궁온 헤더 탭</title>
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
  <link rel="stylesheet" href="../programSelect/programSelect.css" />
  
  <style>
    
  </style>
  
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
      <div class="menu_item <%= request.getRequestURI().endsWith("programSelectDetail.jsp") ? "active" : "" %>">
        <a href="<%= request.getContextPath() %>/program/programSelect/programSelect.jsp">예약조회 / 취소</a>
      </div>
    </div>
  </div>

  <main class="contents_wrap" id="contents_wrap">
    <div class="contents contents_sub">
      <ol class="breadcrumb_list">
        <li>홈</li>
        <li>행사안내</li>
        <li>예약조회 / 취소</li>
      </ol>

      <h3 class="program_text">예약조회 / 취소</h3>
      
	<div class="form_box" style="width: 500px; margin: 0 auto; text-align: center;">
  		<div class="form_row">
  		<h4 style="font-size: 20px">[예약정보]</h4>
  		
    	<label class="form_label">예약(등록)번호</label>
    		<input type="text" class="form_input input_yellow" value="<%= reservationNum %>" readonly>
  	</div>
  	<div class="form_row">
    	<label class="form_label">행사</label>
    		<input type="text" class="form_input input_yellow" value="<%= programName %>" readonly>
  	</div>
  	<div class="form_row">
    	<label class="form_label">예약일자</label>
    		<input type="text" class="form_input input_yellow" value="<%= reservationDate %>" readonly>
  	</div>
  	<div class="form_row">
    	<label class="form_label">해설언어</label>
    		<input type="text" class="form_input input_yellow" value="<%= language %>" readonly>
  	</div>
  	<div class="form_row">
    	<label class="form_label">예약인원</label>
    		<input type="text" class="form_input input_yellow" value="<%= peopleCount %>명" readonly>
  	</div>
  	<div class="form_row">
    	<label class="form_label">결제금액</label>
    		<input type="text" class="form_input input_yellow" value="<%= String.format("%,d", totalAmount) %>원" readonly>
  	</div>
	</div>

	<div class="form_row btn">
  		<button type="button" class="confirm_btn" onclick="history.back()">확인</button>
  		<button type="button" class="cancel_btn" onclick="location.href='cancelReservation.jsp?reservationNum=<%= reservationNum %>'">예약취소</button>
	</div>
    </div>
  </main>
</div>

<footer>
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>