<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션 종료
    session.invalidate();

    // 캐시 방지 설정 (뒤로가기 막기)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 로그인 페이지로 리디렉션
    response.sendRedirect("adminLoginForm.jsp");
%>