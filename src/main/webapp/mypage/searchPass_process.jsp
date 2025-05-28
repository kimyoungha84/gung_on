<%@page import="kr.co.gungon.member.login.LoginService"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
pageContext.getAttribute("userData");
  %>
<%
String name= request.getParameter("name");
String email= request.getParameter("email");
String id = request.getParameter("id");
boolean flag = false;

MemberService ms = new MemberService();
MemberDTO mDTO = null;
mDTO=ms.searchOneMember(id);

	if(mDTO.getEmail() == email && mDTO.getName() == name){
		flag =true;
		session.setAttribute("changePass", true);
		session.setAttribute("id", id);
	}
	if("Y".equals(mDTO.getFlag())){
		flag = false;
	}
%>
{ "flag": <%=flag %> }