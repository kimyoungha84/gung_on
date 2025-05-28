<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.login.LoginDTO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
//세션에 존재하는 값을 얻기
//String name=(String)session.getAttribute("name");
Object obj =session.getAttribute("userData");

if(obj==null){
	//세션에 값이 없다면 페이지를 이동.
	//response.sendRedirect("http://192.168.10.72/jsp_prj/day0501/use_session_a.jsp");
	response.sendRedirect("/Gung_On/login/login.jsp");
	return;
}
MemberDTO mDTO =(MemberDTO)obj;
%>
