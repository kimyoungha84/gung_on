<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/login_chk.jsp" %>

<jsp:useBean id="m1DTO" class="kr.co.gungon.member.MemberDTO" scope="page"/>
<jsp:setProperty name="m1DTO" property="*"/>
<%
MemberService ms = new MemberService();
boolean modifyFlag=ms.modifyMember(m1DTO, session);
%>
{ "modifyFlag":<%=modifyFlag %> }