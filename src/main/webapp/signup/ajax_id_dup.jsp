<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
String id = request.getParameter("id");

MemberService ms = new MemberService();
boolean idFlag=!ms.searchId(id);
%>
{ "idFlag":<%=idFlag %> }