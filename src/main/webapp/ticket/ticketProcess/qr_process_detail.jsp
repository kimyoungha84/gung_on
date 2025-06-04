<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//관리자 로그인이 완료되어야 한다.//비밀번호가 맞는지 확인
String str=(String)request.getAttribute("param");
System.out.println(str);



//qr을 찍었을 떄, 처리하는 부분
//String imgName = request.getParameter("img");
//AdminTicketService adminTs=new AdminTicketService();
//adminTs.modifyStatus(imgName);


%>

    