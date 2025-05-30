<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람코스</title>
  <style type="text/css">
 
  </style>

  <!-- Swiper CSS -->
	<link rel="stylesheet" type="text/css" href="/Gung_On/course/css/users_course_style.css" />
	<c:import url="/common/jsp/external_file.jsp"/>

<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <main>

    
    <!-- 사이드바와 콘텐츠를 감싸는 container div -->
    <!-- sub-header와 container 사이에 margin-top 또는 sub-header에 margin-bottom으로 간격 조절 -->
    <div class="container">
    
        <div class="sidebar">
        
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="/Gung_On/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="/Gung_On/course/course_time.jsp">관람시간</a></li>
                    <li><a href="/Gung_On/course/course.jsp">관람코스</a></li>
                    <li><a href="/Gung_On/course/users_course.jsp" class="active" >사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>

	<article class="content">
            <h1>사용자 추천 코스</h1>
			
	<div class="board-header">
      <button class="write-button">글쓰기</button>
    </div>
    
			<table class="board-table">
      <thead>
        <tr>
          <th>번호</th>
          <th colspan="2">제목</th>
          <th>작성자</th>
          <th>작성일</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td colspan="2"><img src="/Gung_On/common/images/program/ChangdeokgungMoonlightTravel.jpg" alt="썸네일" class="thumbnail"> 첫 번째 게시글입니다</td>
          <td>홍길동</td>
          <td>2025-05-29</td>
        </tr>
        <tr>
		  <td>1</td>        
          <td colspan="2"><img src="/Gung_On/common/images/program/GyeongbokgungStarlightNight.jpg" alt="썸네일" class="thumbnail"> 두 번째 게시글입니다</td>
          <td>이순신</td>
          <td>2025-05-28</td>
        </tr>
      </tbody>
    </table>
			
			
			
	</article>
           
    </div> <!-- .container 닫는 태그 -->


  </main>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
