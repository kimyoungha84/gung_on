<%@page import="kr.co.gungon.ticket.TicketDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.catalina.filters.SetCharacterEncodingFilter"%>
<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<!-- 자... 예매 버튼을 눌렀어 그러면 여기서  -->
<!--
예매정보(booking num), 결제일 (timestamp) - 이거는 내가 새로 생성해서 넘겨야함.
-->
<!--
소인인원, 대인 인원, 소인 가격, 대인 가격, 총 금액 가격을  http://192.168.10.71/gungProject/ticket/ticketPayment.jsp 로 넘겨줘야 해
행사이름

-->

<jsp:useBean id="tDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/>

<%
/*한국어 변환*/
request.setCharacterEncoding("UTF-8");

/*예매를 DB에 추가*/
TicketService ticketService=new TicketService();


String programName=request.getParameter("programName");//행사 이름
String date=request.getParameter("datepicker");//관람일자
String reserveTime=ticketService.startTimeProgram(programName);

int adult=Integer.parseInt(request.getParameter("adult"));//관람인원 - 대인
int kid=Integer.parseInt(request.getParameter("kid"));//관람인원 - 소인

int adultCost=ticketService.changeStrToInt(request.getParameter("adultCost"));//관람가격 - 대인
int kidCost=ticketService.changeStrToInt(request.getParameter("kidCost"));//관람가격 - 소인

String langChoose=request.getParameter("langChoose");//해설관람
String langFlag=ticketService.makeCommentFlag(langChoose);//해설관람 Flag

int payment=(adultCost*adult)+(kidCost*kid);

tDTO.setMember_id("test");//memeberID를 넣어 주어야 한다. session으로 받아와서...
tDTO.setProgramName(programName);//programName
tDTO.setReserveDate(date);//reserveDate
tDTO.setReserveTime(reserveTime);//reserveTime
tDTO.setAdultCount(adult);//adultCount
tDTO.setKidCount(kid);//kidCount
tDTO.setCommentLang(langChoose);//commentLang
tDTO.setCommentFlag(langFlag);//commentFlag
tDTO.setPayment(payment);//payment

request.setAttribute("ticketDto", tDTO);
System.out.println("ticket_process.jsp --------"+tDTO);

%>
<jsp:forward page="../ticketPayment.jsp"/>