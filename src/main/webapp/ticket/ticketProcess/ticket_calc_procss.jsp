<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@page import="kr.co.gungon.ticket.TicketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:useBean id="ticketDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/>
<%
/*한국어 변환*/
request.setCharacterEncoding("UTF-8");
String phoneNum=request.getParameter("hidPhoneNum");

TicketDTO tDTO=(TicketDTO)session.getAttribute("ticketDTO");
TicketService tservice=new TicketService();


//System.out.println("ticket_calc_process.jsp session---------"+tDTO);


//1.예매번호 생성
String bookingNum=tservice.makeBookingNum();

//2.결제일 생성
String paymentTimeStamp=tservice.makePaymentTimeStamp();


//tDTO에 넣기
//예매번호, 전화번호, 결제 일자
tDTO.setBookingNum(bookingNum);
tDTO.setPhoneNum(phoneNum);
tDTO.setPaymentTimeStamp(paymentTimeStamp);

request.setAttribute("ticketDTO", tDTO);
%>
<script type="text/javascript">
$(function(){
	window.addEventListener("popstate", function(event) {
	    alert("뒤로가기 버튼이 클릭되었습니다!");
	    // 뒤로가기 버튼이 클릭되었을 때 수행할 추가 작업
	});
});
</script>
<jsp:forward page="../ticketPaymentCompleteFrm.jsp"/>
