<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@page import="kr.co.gungon.ticket.admin.TicketAdminDTO"%>
<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@page import="kr.co.gungon.ticket.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <jsp:useBean id="ticketDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/> --%>



<%
//String jsonStr=(String)session.getAttribute("jsonStr");
TicketDTO ticketDTO=(TicketDTO)request.getAttribute("ticketDTO");

if(ticketDTO == null){
	ticketDTO = (TicketDTO)session.getAttribute("ticketDTO");
}//end if


TicketService ts=new TicketService();

//JSONParser parser=new JSONParser();
//JSONObject jsonValue=(JSONObject) parser.parse(jsonStr);

String date=ticketDTO.getReserveDate()+" "+ticketDTO.getReserveTime();

//System.out.println("paymentComplete_process.jsp ======"+ticketDTO);


String totalPersonStr=ts.personTotalString(ticketDTO.getAdultCount(), ticketDTO.getKidCount());


AdminTicketService ats=new AdminTicketService();
String paymentStr=ats.changeCosttoStr(ticketDTO.getPayment());

/*****************************************************************/
//아 ... 코드를 너무 늦게 바꿔서 ... ㅎ...




/*QR 코드와 QR 코드 링크 생성해서 사용자에게 전송하기*/
//1. QR 코드 생성 및 디렉토리에 저장
//2. DB에 저장
ticketDTO=ts.createQR(ticketDTO);

/*값들을 DB로 넘기기*/
ts.addReservationValue(ticketDTO);

//3. QR 코드 서버로 전송, URL 사용자에게 보내기
ts.sendURL(ticketDTO);


request.setAttribute("ticketDTO", ticketDTO);


//session.removeAttribute("ticketDTO");
%>