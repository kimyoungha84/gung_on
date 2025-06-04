<%@page import="kr.co.gungon.member.login.LoginService"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
pageContext.getAttribute("userData");
  %>
<%
String id = request.getParameter("id");
String pass= request.getParameter("pass");
boolean flag = false;

MemberService ms = new MemberService();
flag = ms.modifyMemberPass(id, pass, session);

if(flag){
	session.invalidate();
}//end if
%>
{ "flag": <%=flag %> }