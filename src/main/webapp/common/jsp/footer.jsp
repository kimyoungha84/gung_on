<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 푸터 -->
<footer class="footer">
  <div class="footer-inner">
    <div class="footer-logo">
      <img src="${pageContext.request.contextPath}/common/images/mainpage/footer_icon.png" alt="궁온 로고">
      <br>
    </div>
    <div class="footer-menus">
      <div>
        <strong>궁 안내</strong>
        <ul>
          <li><a href="${pageContext.request.contextPath}/gung/gyungbukgung.jsp">경복궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/gyeonghuigung.jsp">경희궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/changdeokgung.jsp">창덕궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/changgyeonggung.jsp">창경궁</a></li>
          <li><a href="${pageContext.request.contextPath}/gung/deoksugung.jsp">덕수궁</a></li>
        </ul>
      </div>
      <div>
        <strong>행사 안내</strong>
        <ul>
          <li><a href="${pageContext.request.contextPath}/program/programInfo/programInfo.jsp">행사 안내</a></li>
          <li><a href="${pageContext.request.contextPath}/program/programAll/programAll.jsp">행사 모아보기</a></li>
        </ul>
      </div>
      <div>
        <strong>관람 안내</strong>
        <ul>
          <li><a href="${pageContext.request.contextPath}/course/course_rule.jsp">관람 규칙</a></li>
          <li><a href="${pageContext.request.contextPath}/course/course_time.jsp">관람 시간</a></li>
          <li><a href="${pageContext.request.contextPath}/course/course.jsp">관람 코스</a></li>
          <li><a href="${pageContext.request.contextPath}/course/users_course.jsp">사용자 추천 코스</a></li>
        </ul>
      </div>
      <div>
        <strong>고객센터</strong>
        <ul>
          <li><a href="${pageContext.request.contextPath}/cs/notice_main.jsp">공지사항</a></li>
          <li><a href="${pageContext.request.contextPath}/cs/faq_main.jsp">자주 묻는 질문</a></li>
          <li><a href="${pageContext.request.contextPath}/cs/myinquiry.jsp">1:1 문의</a></li>
        </ul>
      </div>
      <div>
        <strong>마이페이지</strong>
        <ul>
          <li><a href="${pageContext.request.contextPath}/mypage/mypage.jsp">내 정보</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    &copy; 2025 Brand, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a> · <a href="#">Sitemap</a>
  </div>
</footer>

