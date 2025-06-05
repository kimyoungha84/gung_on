<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>


<% request.setCharacterEncoding("UTF-8"); 
   request.setAttribute("currentMenu", "inquiry");
%>

<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 1:1문의 - 나의문의</title>
  <link rel="stylesheet" type="text/css" href="cs_notice.css" />
  <!-- <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/common.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/reset.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/layout.css" /> -->
  

  <style>

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

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="main" style="width: 1000px; margin: 150px auto 0 auto;">
   <h2 style="font-size: 35px; font-weight: bold;">1:1문의 작성</h2><br>
   
   
   <div class="sub_con_wrap pt0" id="sub_con_wrap">
   
   <div id="tabDiv" style="" class="tabDiv">
		<div class="reservation_tab2 sub_tab">
	</div>
	<div class="swiper-button-next noti_next"></div>
	<div class="swiper-button-prev noti_prev"></div></div><!-- [E] reservation_tab -->
 <div class="sub_con_section">
	<!-- [S] condition_wrap -->
	<div class="condition_wrap">
		<%-- <div class="left">
			<div class="count_wrap">전체: <fmt:formatNumber value="${rowCounts}" pattern="#.###"/>건</div>
		</div> --%>
	<div class="inquiry_wrap" style="width: 100%; padding: 20px; background-color: #f8f8f8; border: 1px solid #ccc; border-radius: 8px;">
    <!-- 라벨 추가 -->
    <label for="inquiry_textarea" style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 10px; display: block;">
        문의 내용
    </label>
    
    <!-- 텍스트 영역 -->
   <form action="inquirywrite_process.jsp">
   <textarea id="inquiry_textarea" name="inquiryContent"
    placeholder="문의 내용을 입력해주세요." 
    maxlength="2000"
    style="width: 100%; height: 400px; padding: 10px; border: 2px solid #c6c6c6; border-radius: 5px; font-size: 14px; resize: none; outline: none; background-color: #fff; color: #333;"></textarea>

	<div id="char_counter" style="text-align: right; font-size: 13px; color: #666; margin-top: 5px;">
	    0 / 2000
	</div>
	<div class="inquiry_footer" style="margin-top: 10px; display: flex; justify-content: space-between; align-items: center;">
    <div class="inquiry_notice" style="font-size: 13px; color: #888;">
        ※ 욕설, 비방, 허위 사실 등의 부적절한 내용은 제재를 받을 수 있습니다.
    </div>
    <button type="submit" id="registerBtn" style="width:100px; height:40px; background-color: #323247; color: white; font-size: 14px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease, color 0.3s ease;">
        문의등록
    </button>
	</div>
   </form>
	</div>


		
		
	</div>
	<!-- [E] condition_wrap -->
	<div class="wrap">
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
