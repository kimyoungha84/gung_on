<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String ranNumStr=request.getParameter("authenNum");

String adminSHAStr=(String)session.getAttribute("ranNumSha256");


TicketService tservice=new TicketService();
String ranNumStrSHA256=tservice.encryptSHA256(ranNumStr);

//System.out.println("authenCheck_process.jsp 사용자 만듦====="+ranNumStrSHA256);
//System.out.println("authenCheck_process.jsp 관리자 만듦======="+adminSHAStr);

if(adminSHAStr.equals(ranNumStrSHA256)){
%>
	yes
<%
}else{
%>
	no
<%
}
%>