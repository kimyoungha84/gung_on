<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
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
TicketDTO tDTO = (TicketDTO)session.getAttribute("ticketDto");
String jsonStr= (String)session.getAttribute("jsonStr");
System.out.println("jsonStr------"+jsonStr);


if(jsonStr == null){
	response.sendRedirect("/ticket/ticket_frm.jsp");
}//end if

//JSONParser parser=new JSONParser();
//JSONObject jsonValue=(JSONObject) parser.parse(jsonStr);

TicketService tservice=new TicketService();

//String chooseDate=(String)jsonValue.get("reserveDate")+" "+(String)jsonValue.get("reserveTime"); 
//String personString=tservice.personTotalString(Integer.parseInt(jsonValue.get("adultCount").toString()), Integer.parseInt(jsonValue.get("kidCount").toString()));

String chooseDate=tDTO.getReserveDate()+" "+tDTO.getReserveTime(); 
String personString=tservice.personTotalString(tDTO.getAdultCount(), tDTO.getKidCount());


%>     

<jsp:useBean id="ticketDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/>

<%
ticketDTO=tDTO;
session.setAttribute("ticketDTO", ticketDTO);
session.setAttribute("jsonStr", jsonStr);
%>