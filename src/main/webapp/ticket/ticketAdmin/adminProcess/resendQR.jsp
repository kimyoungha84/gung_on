<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String bookingNum=request.getParameter("bookingNum");
pageContext.setAttribute("bookingNum", bookingNum);

String ageClassification=request.getParameter("ageClassification");
pageContext.setAttribute("ageClassification", ageClassification);

String numClassification=request.getParameter("numClassification");
pageContext.setAttribute("numClassification", numClassification);




%>