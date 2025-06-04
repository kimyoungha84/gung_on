<%@page import="kr.co.gungon.member.login.LoginService"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
pageContext.getAttribute("userData");
  %>
<%

String name= request.getParameter("name");
String email= request.getParameter("email");
boolean flag = false;
MemberDTO mDTO = null;
MemberService ms = new MemberService();


String id="";
if( (id=ms.searchMemberName(name, email)) != null  ){
	flag =true;
}
mDTO = ms.searchOneMember(id);
if("Y".equals(mDTO.getFlag())){
	flag = false;
}
System.out.println(flag);
%>
{ "flag": <%=flag %>, "id": "<%=id %>" }