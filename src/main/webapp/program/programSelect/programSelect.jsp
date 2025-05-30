<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
    String userName = (String) session.getAttribute("userName");
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
  
    <script>
    function autoTabNext(event, nextFieldId) {
      if (event.target.value.length == event.target.maxLength) {
        document.getElementById(nextFieldId).focus();
      }
    }
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
      <div class="menu_item <%= request.getRequestURI().endsWith("programSelect.jsp") ? "active" : "" %>">
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
      
      <div class="info_text">
        예약 시 입력했던 정보로 예약내역을 확인하실 수 있습니다.
      </div>
      
	<form action="<%= request.getContextPath() %>/program/programSelect/programSelectDetail.jsp" method="get">
  	<div class="form_box">
    <div class="form_row">
      <label class="form_label" for="reservationNum">예약(등록)번호</label>
      	<input type="text" id="reservationNum" name="reservationNum"
      		class="form_input input_yellow" placeholder="예약(등록)번호를 입력해주세요.">
    </div>
    
    <div class="form_row">
      <label class="form_label" for="phoneNum">휴대폰 번호</label>
      <div class="phone_input">
        <input type="text" id="phoneFirst" name="phoneFirst"
        	class="form_input" maxlength="3" placeholder="010" onkeyup="autoTabNext(event, 'phoneSecond')">
        <span>_</span>
        <input type="text" id="phoneSecond" name="phoneSecond"
        	class="form_input" maxlength="4" placeholder="1234" onkeyup="autoTabNext(event, 'phoneThird')">
        <span>_</span>
        <input type="text" id="phoneThird" name="phoneThird"
        	class="form_input" maxlength="4" placeholder="5678">
      </div>
      </div>
  	</div>

  		<div class="form_row btn">
    		<button type="submit" class="confirm_btn">확인하기</button>
  		</div>
	</form>

    </div>
  </main>
</div>

<footer>
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>