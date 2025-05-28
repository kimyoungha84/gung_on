<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>궁온 메인</title>
  <!-- Swiper CSS -->
  <c:import url="/common/jsp/external_file.jsp"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

  <!-- 기타 공통 스타일 -->
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
 
  
  <!-- <style>
  .header-nav-link {
  font-size: 20px;
  }
  </style> -->
  
<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script src="/Gung_On/common/js/slide.js"></script>
  <script>
    
  </script>
</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  
  <jsp:include page="/common/jsp/header.jsp" />


  <!-- 본문: 캐러셀 포함 -->
  <main>

	<div style="margin-left:250px;padding-top:20px; margin-bottom: 30px; ">
	<span style="font-size: 20px;">궁궐을 보존·활용하고 그 가치를 새롭게 창출해 나가는</span><br>
	<h2 style="font-size: 60px;">궁온</h2>
	</div>

    <div> 
    <jsp:include page="/mainpage/banner.jsp"/>
    </div>
    
    <div class= "/mainpage/banner2-main">
	<jsp:include page="/mainpage/banner2.jsp"/>
    </div>
    
    <div style="padding-left: 300px; padding-right: 300px">
    <jsp:include page="/mainpage/mainboard.jsp" />
    </div>
  </main>

  <!-- 푸터 -->
   <jsp:include page="/common/jsp/footer.jsp"/>
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
