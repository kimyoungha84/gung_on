<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.net.ntp.TimeStamp"%>
<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@page import="kr.co.gungon.ticket.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<%
//현재 tDTO에 들어있는 값
//programName, reserveDate, payment
TicketDTO tDTO = (TicketDTO)request.getAttribute("ticketDto");



TicketService tservice=new TicketService();

String chooseDate=tDTO.getReserveDate()+" "+tDTO.getReserveTime(); 

String personString=tservice.personTotalString(tDTO.getAdultCount(), tDTO.getKidCount());


%>     

<jsp:useBean id="ticketDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/>

<%
ticketDTO=tDTO;
session.setAttribute("ticketDTO", ticketDTO);
%>