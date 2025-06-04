<%@page import="kr.co.gungon.ticket.FileUploadFTP"%>
<%@page import="kr.co.gungon.ticket.ticketConfig.SiteProperty"%>
<%@page import="kr.co.gungon.ticket.admin.OverlayCompleteQR"%>
<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@ page language="java" contentType="application/x-www-form-urlencoded; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//관리자 로그인이 완료되어야 한다.//비밀번호가 맞는지 확인
String adminNumStr=request.getParameter("adminNum");
String imgStr=request.getParameter("img");


String password="12345";

System.out.println(adminNumStr);
System.out.println(imgStr);


if(adminNumStr.equals(password)){
	//qr을 찍었을 떄, 처리하는 부분
	AdminTicketService adminTs=new AdminTicketService();
	adminTs.modifyStatus(imgStr);
	//이미지도 덮어쓰도록 바꿔줘야하지
	OverlayCompleteQR overlay=new OverlayCompleteQR();
	
	//내부 저장소, 외부 저장소에 저장된 이미지 모두 사용할 수 없도록 변경해야함.
	overlay.usedCompleteQRcode(SiteProperty.uploadQRPathInCom, imgStr);//내부 저장소
	
	//외부 저장소로 전송
	FileUploadFTP fileUpload=new FileUploadFTP(SiteProperty.gabiaIP, SiteProperty.gabiaId, SiteProperty.gabiaPass);
	fileUpload.uploadFile(SiteProperty.uploadQRPathInCom+imgStr+".png", imgStr+".png", "ticket/QR/");
%>
	yes
<%
}else{
%>
	no
<%
}
%>
