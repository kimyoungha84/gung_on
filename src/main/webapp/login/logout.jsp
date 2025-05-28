<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
  // 세션 무효화 (모든 세션 속성 제거 + 세션 종료)
  session.invalidate();

  // 또는 특정 세션 속성만 제거 (선택적 삭제 예시)
  // session.removeAttribute("userData");

  // 로그아웃 후 메인 페이지나 로그인 페이지로 리디렉션
  response.sendRedirect("/Gung_On/mainpage/mainpage.jsp");
%>