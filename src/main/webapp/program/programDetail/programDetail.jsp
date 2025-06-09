<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="kr.co.gungon.program.ProgramDAO" %>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String programName = request.getParameter("programName");
    boolean isDetailView = (programName != null && !programName.trim().isEmpty());
    String decodedProgramName = "";

    ProgramDTO dto = null;

    if (isDetailView) {
        decodedProgramName = URLDecoder.decode(programName, "UTF-8");
        ProgramDAO dao = ProgramDAO.getInstance();
        dto = dao.selectProgramByProgramName(programName);
    }
    
    Date now = new Date();
    boolean canReserve = now.after(dto.getReservationStartDate()) && now.before(dto.getReservationEndDate());
    SimpleDateFormat sdfFull = new SimpleDateFormat("yyyy-MM-dd(E) HH:mm", Locale.KOREAN);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>행사 상세 정보</title>
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
  <link rel="stylesheet" href="../programDetail/programDetail.css" />
  
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
      <div class="menu_item <%= request.getRequestURI().endsWith("programDetail.jsp") ? "active" : "" %>">
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

      <h3 class="program_text">행사(상세정보)</h3>

<% if (isDetailView && dto != null) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)", Locale.KOREAN);
    DecimalFormat formatter = new DecimalFormat("#,###");
    String openTimeStr = dto.getOpenTime().toLocalDateTime().toLocalTime().toString().substring(0, 5);
    String closeTimeStr = dto.getCloseTime().toLocalDateTime().toLocalTime().toString().substring(0, 5);
    
    FilePathService fps = new FilePathService();
    
    String imgFullPath = fps.getImageFullPath("program", String.valueOf(dto.getProgramId()));
    if (imgFullPath == null) {
        imgFullPath = request.getContextPath() + "/images/no-image.png";
    }
%>
<div class="program-detail-box">
  <h4>[<%= dto.getProgramPlace() %>] <%= dto.getProgramName() %></h4>

  <div class="centered-container">
    <img src="<%= imgFullPath %>" alt="<%= dto.getProgramName() %> 행사 이미지" class="program-detail-img" />
  </div>

  <p>행사기간 : <%= sdf.format(dto.getStartDate()) %> ~ <%= sdf.format(dto.getEndDate()) %></p>
  <p>행사장소 : <%= dto.getProgramPlace() %></p>
  <p>담당자 : <%= dto.getContactPerson() %></p>

  <p><strong>[상세내용]</strong></p>
  <p>행사시간 : <%= openTimeStr %> ~ <%= closeTimeStr %></p>
  <p>가격 (성인/어린이) : <%= formatter.format(dto.getPriceAdult()) %> / <%= formatter.format(dto.getPriceChild()) %> 원</p>
  <p>해설 언어 :
    <% if ("ko".equals(dto.getLanguageKorean())) { %>
      한국어
    <% } else if ("en".equals(dto.getLanguageKorean())) { %>
      영어
    <% } else { %>
      없음
    <% } %>
  </p><br>
  <p style="color: red; font-size: 15px;">※ [<%= dto.getProgramPlace() %>] 정기 휴무일 및 특별 운영일을 관람안내에서 꼭 확인해주시기 바랍니다.</p>
  <p style="font-size: 15px;">※ 기상 상황이나 기관 사정에 따른 일정변동이 있을 수 있습니다.</p>

	<div id="reservationSection">
  		<button class="detail-btn" type="button" onclick="history.back()">목록보기</button>

  <% if (canReserve) { %>
    <button class="detail-btn black" type="button"
          onclick="location.href='/Gung_On/ticket/ticket_frm.jsp?programName=<%= java.net.URLEncoder.encode(dto.getProgramName(), "UTF-8") %>&imgFullPath=<%=imgFullPath%>'">
      예약하기
    </button>
  <% } else { %>
    <button id="reserveBtn" class="detail-btn black" type="button" onclick="handleUnavailableReservation()">
      예약하기
    </button>
  <% } %>
	</div>

	<div id="reservationMessage" style="display: none; margin-top: 10px; font-size: 15px; color: red;">
  		예약 가능 기간: <%= sdfFull.format(dto.getReservationStartDate()) %> ~ <%= sdfFull.format(dto.getReservationEndDate()) %>
	</div>

</div>
<% } else if (isDetailView) { %>
<%   		  out.print("<li>해당 행사를 찾을 수 없습니다.</li>"); %>
<% } %>

    </div>
  </main>
</div>

<footer>
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  function handleUnavailableReservation() {
    const reserveBtn = document.getElementById('reserveBtn');
    reserveBtn.textContent = '예약은 현재 불가합니다.';
    reserveBtn.disabled = true;
    document.getElementById('reservationMessage').style.display = 'block';
  }
</script>

</body>
</html>