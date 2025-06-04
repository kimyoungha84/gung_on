<%@page import="kr.co.gungon.ticket.TicketDTO"%>
<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page language="java" contentType="application/x-www-form-urlencoded; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
TicketService tservice=new TicketService();
String phoneNum=request.getParameter("phoneNum");
%>
<jsp:useBean id="ticketDTO" class="kr.co.gungon.ticket.TicketDTO" scope="page"/>
<%
ticketDTO=(TicketDTO)session.getAttribute("ticketDTO");

//System.out.println("authen_process.jsp   "+tservice.checkPhoneNum(phoneNum));

if(tservice.checkPhoneNum(phoneNum)){
	//알맞은 핸드폰 형식일 경우
	//random값 생성후, 사용자 핸드폰 번호로 전송
	//지금은 id를 test로 default로 줌 ....
	String ranNumSha256=tservice.makeRandomNum(phoneNum, "test",ticketDTO);
	//System.out.println("authen_process.jsp-------"+ranNumSha256);
	//여기서 randomNum을 만들어서 setAttribute를 통해 session에 저장
	session.setAttribute("ranNumSha256", ranNumSha256);
	
	ticketDTO.setAuthenCnt(ticketDTO.getAuthenCnt()+1);
	
%>
	yes
<%
}else{
	//알맞지 않은 형태의 핸드폰 번호 형식일 경우
%>
	no
<%
}//if~else
%>
