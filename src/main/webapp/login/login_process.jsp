<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.login.LoginService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../common/jsp/site_config.jsp" %> --%>
<%
//1. 한글처리
request.setCharacterEncoding("UTF-8");

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="lDTO" class="kr.co.gungon.member.login.LoginDTO" scope="page"/>
<jsp:setProperty name="lDTO" property="*" />



<%
if("POST".equals(request.getMethod().toUpperCase()) ){
	LoginService ls = new LoginService();
	boolean flag = ls.loginProcess(lDTO, session);
	boolean loginFlag = false;
	loginFlag = "Y".equals(((MemberDTO) session.getAttribute("userData")).getFlag());
%>
{"loginResult":<%= flag %>,"loginFlag": <%=loginFlag%> }
<%

}//end if
%>
