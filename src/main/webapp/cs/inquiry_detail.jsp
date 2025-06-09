<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>


<% 

   request.setCharacterEncoding("UTF-8"); 
   request.setAttribute("currentMenu", "inquiry");
   
   
   
   String paramNum = request.getParameter("num");
   int inquiryNum = 0;
   if( paramNum != null ){
	   inquiryNum = Integer.parseInt(paramNum);
	   
   }
   
   
   
   
   
   
   CsService css = new CsService();
   InquiryDTO iDTO = css.searchOneInquiry(inquiryNum);
   
   pageContext.setAttribute("iDTO", iDTO);
%>

<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 1:1문의 - 나의문의</title>
  <link rel="stylesheet" type="text/css" href="cs_notice.css" />
  

  <style>
  
.qa-card {
    background-color: #fff;
    border: 1px solid #ccc;
    width: 1000px;
    margin: 0 auto;
    padding: 30px;
    font-family: '맑은 고딕', sans-serif;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

.qa-title {
    font-size: 20px;
    font-weight: bold;
    border-bottom: 1px solid #000;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.qa-section {
    margin-bottom: 30px;
}

.qa-date {
    font-size: 14px;
    color: #555;
    margin-bottom: 5px;
}

.qa-label {
    font-weight: bold;
    margin-bottom: 8px;
    font-size: 16px;
}

.qa-content {
    background-color: #f8f8f8;
    padding: 15px;
    border-radius: 5px;
    line-height: 1.6;
    border: 1px solid #d8d8d8;
}
	
  </style>
  
  
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script>
  $(function () {
	    var maxLength = 1500;
	    var warningThreshold = 0.8; // 80%

	    var $textarea = $('#inquiry_textarea');
	    var $counter = $('#char_counter');

	    function updateCounter(val) {
	        var len = val.length;
	        $counter.text(len + ' / ' + maxLength);

	        if (len >= maxLength * warningThreshold && len < maxLength) {
	            $counter.css('color', '#e57f6a'); // 80% 이상 경고 색상
	        } else if (len >= maxLength) {
	            $counter.css('color', 'red');    // 최대치 도달 색상
	        } else {
	            $counter.css('color', '#666');   // 기본 색상
	        }
	    }

	    // 초기 카운터 텍스트 및 색상
	    updateCounter('');

	    $textarea.on('input', function () {
	        var val = $(this).val();

	        if (val.length > maxLength) {
	            alert('문의 내용은 최대 ' + maxLength + '자까지 입력 가능합니다.');
	            val = val.substring(0, maxLength);
	            $(this).val(val);
	        }

	        updateCounter(val);
	    });
	});

</script>

  
</head>

<body>
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="${pageContext.request.contextPath}/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="main">
   <h2 style="font-size: 35px; font-weight: bold;">나의 1:1문의</h2><br>
   
   
   <div class="sub_con_wrap pt0" id="sub_con_wrap">
   
   <div id="tabDiv" style="" class="tabDiv">
		<div class="reservation_tab2 sub_tab">
	</div>
	<div class="swiper-button-next noti_next"></div>
	<div class="swiper-button-prev noti_prev"></div></div><!-- [E] reservation_tab -->
 <div class="sub_con_section">
 <div class="qa-card">
    <div class="qa-title">1:1 문의</div>

    <div class="qa-section">
        <div class="qa-date"><fmt:formatDate value="${iDTO.inquiry_regDate}" pattern="yyyy-MM-dd" /></div>
        <div class="qa-label">문의 내용</div>
        <div class="qa-content">${iDTO.inquiry_content}</div>
    </div>

    <div class="qa-section">
        <div class="qa-date"><fmt:formatDate value="${iDTO.inquiry_answerDate}" pattern="yyyy-MM-dd" /></div>
        <div class="qa-label">문의 답변</div>
        <div class="qa-content">
            <c:choose>
                <c:when test="${empty iDTO.inquiry_answer}">
                    <span style="font-size: 30px; font-weight: bold;">답변 준비중입니다.</span>
                </c:when>
                <c:otherwise>
                    ${iDTO.inquiry_answer}
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
 
</div>

</div>

<div class="paging_wrap flex flex_jc mt40" style="background-color: #e5e5e5; margin-top: 10px; height: 120px; border-top: solid 1px #333; border-bottom: solid 2px #333; position: relative; justify-content: center;">
    	 <button type="button" id="goBackBtn" style="width:100px; height:40px; background-color: #282828; color: white; font-size: 14px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease, color 0.3s ease; 
        	position: absolute; top: 20px; right: 20px;">돌아가기</button>
</div>

<script>
    document.getElementById("goBackBtn").addEventListener("click", function () {
        location.href = "myinquiry.jsp"; 
    });
</script>


	</div>

	<!-- [E] paging_wrap -->



<%@ include file="side.jsp" %>

  <br>


  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
  
  
</body>
</html>
