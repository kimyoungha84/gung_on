<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 미리보기</title>
  <link rel="stylesheet" href="mainCSS.css">
  <!-- <link rel="stylesheet" type="text/css" href="https://royal.khs.go.kr/resource/templete/royal/css/common.css" /> -->
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/common.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/reset.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/layout.css" />
  

  <style>
    /* 이미지 정중앙 고정 및 반투명 처리 */
    .background-image {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0.15;
      z-index: -1;
      width: 850px; /* 필요에 따라 조절 */
      height: auto;
    }
   .lnb_wrap {
  	position: fixed;
  	top: 300px; /* 상단에서 거리 조절 */
  	left: 65px;
  	width: 300px; /* 원하는 너비 */
  	z-index: 1000; /* 다른 요소보다 위로 오도록 */
	}

  </style>
  
  <script>
  
  function moveToNoticeMain(){

	  window.location.href = "previewNotice_Main.jsp";
  
  }
  
  </script>
</head>

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="../common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <h2>공지사항 미리보기</h2>

  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="mb-4" style="width: 1000px; margin: 150px auto 0 auto;">
   <h2 style="font-size: 35px; font-weight: bold;">공지사항</h2><br>
  <div class="board_detail_wrap bd_wrap">
    <div class="detail_con board_detail_tit">
      <div class="txt_line1">${ nDTO.notice_title }</div>
    </div>
    <div class="detail_con board_detail_info info_wrap">
      <span class="info">조회수 : ${ nDTO.notice_views }</span>
      <span class="info">등록일 : <fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd "/></span>
    </div>
    <div class="detail_con board_detail_txt">
      ${ nDTO.notice_content }
    </div>
  </div>
</div>


<div class="btn_wrap flex_center mt60">
	<button type="button" onclick="moveToNoticeMain();" class="btn btn_r bd_black"><strong>목록</strong></button>
</div>

<!--  -->
<div class="lnb_wrap" >
	<div class="lnb_wrap current" id="lnbMenuDiv">


<!-- Empty Layout -->

<div class="lnb_tit">고객센터</div>			
<ul class="lnb_depth2_wrap">
	<li class="lnb_depth2_item current" id="SNB_R403000000">
		<a href="#void">공지사항</a>
	</li>
	<li class="lnb_depth2_item" id="SNB_R402000000">
		<a href="#void">자주묻는 질문</a>
	</li>
	<li class="lnb_depth2_item" id="SNB_R405000000">
		<a href="#void">1:1문의</a>
	</li>
</ul>

<!-- //Empty Layout --></div>

						<!-- [E] 관람안내 -->
						<!--
						<div class="left_info_wrap sub_reservation_info">
							<div class="left_info_tit">관람안내</div>
							<div class="left_info_time">
								<div class="left_info_sub_tit">관람시간</div>
								<div class="time">09:00~18:30</div>
								<div class="small">*입장마감 17:30</div>
							</div>
							<div class="left_info_closed_day">
								<div class="left_info_sub_tit">휴관일</div>
								<div class="closed_day">매주 화요일</div>
								<div class="small">* 단, 정기휴일이 공휴일 및 대체공휴 일과 겹칠경우에는 개방하며, 그 다음날 정기휴일 (영월 장릉은 정기휴일 없음)</div>
							</div>
						</div>
						-->
						<!--  -->
					</div>




  <br>
  <a href="summernoteExample.jsp" class="btn btn-secondary">돌아가기</a>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
