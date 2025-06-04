<%@page import="kr.co.gungon.member.login.LoginService"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
pageContext.getAttribute("userData");
  %>
<jsp:useBean id="lDTO" class="kr.co.gungon.member.login.LoginDTO" scope="page"/>
<jsp:setProperty name="lDTO" property="*" />
<%
boolean removeFlag =false;
LoginService ls = new LoginService();
boolean flag = ls.loginProcess(lDTO, session);
if(flag){
	MemberService ms = new MemberService();
	removeFlag=ms.removeMember((MemberDTO) session.getAttribute("userData"), session);
}
%>
{ "removeFlag":<%=removeFlag %> }