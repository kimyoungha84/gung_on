<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.ticket.TicketDetailDTO"%>
<%@page import="kr.co.gungon.ticket.admin.TicketAdminDTO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String bookingNum=request.getParameter("bookingNum");
session.setAttribute("bookingNum", bookingNum);

AdminTicketService ats=new AdminTicketService();
TicketAdminDTO adminDTO=ats.showDetailAdminPageData(bookingNum);
pageContext.setAttribute("adminDTO",adminDTO);

String programName=ats.getProgramNameByprogramId(adminDTO.getProgramId());
pageContext.setAttribute("programName", programName);


String startTime=ats.getProgramStartTimeByProgramId(adminDTO.getProgramId());
pageContext.setAttribute("startTime", startTime);

String person=ats.outputPersonalCount(adminDTO.getAdult_person(), adminDTO.getKid_person());
pageContext.setAttribute("person", person);

String paymentStr= ats.changeCosttoStr(adminDTO.getPayment());
pageContext.setAttribute("paymentStr", paymentStr);

%>