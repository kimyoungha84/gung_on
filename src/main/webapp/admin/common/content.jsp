<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String contentPage = (String)request.getAttribute("page");
    if (contentPage == null || contentPage.trim().equals("")) {
        contentPage = "/dashboard/dashboard.jsp"; // fallback
    }
    RequestDispatcher rd = request.getRequestDispatcher(contentPage);
    rd.include(request, response);
%>