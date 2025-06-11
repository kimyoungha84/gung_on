<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
TicketService tservice=new TicketService();


String ranNumStr=request.getParameter("authenNum");

String adminSHAStr=(String)session.getAttribute("ranNumSha256");

//여기가 인증번호를 체크하는 곳임.

//선생님 IP가 아니면 count 증가아아~~ㅋㅋㅋ
if(!request.getRemoteAddr().equals("192.168.10.68")){
	//자아~~ count를 올립시다아~~~ 20개 제한이여~~
	System.out.println(request.getRemoteAddr());
	System.out.println(tservice.getAuthenCount());
	if(tservice.countAuthenNum(request.getRemoteAddr())>20){
		System.out.println("여기 안들어오지 않나?");
		System.out.println(tservice.countAuthenNum(request.getRemoteAddr()));		
		%>
		badstatus
		<%
		return;
	}//end if	
	//(그럴일은 없겠지만, 만약 20개 다 소모하면 이걸로 test 해야징)
	
}//end if 

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