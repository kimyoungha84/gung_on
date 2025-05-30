<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ page import="kr.co.gungon.admin.*" %>
<%
    String id = request.getParameter("admin_id");
    String pass = request.getParameter("admin_pass");

    AdminService service = new AdminService();
    boolean success = service.loginCheck(id, pass);

    if (success) {
        session.setAttribute("admin_id", id);
        response.sendRedirect("adminMain.jsp");
    } else {
%>
<script>alert("로그인 실패"); history.back();</script>
<% } %>