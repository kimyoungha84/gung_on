<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@page import="kr.co.gungon.ticket.ticketConfig.SiteProperty"%>


<%
String gungPicturePath=SiteProperty.gungPicturePath;
String gabiaPath=SiteProperty.gabiaPath;
String authenPhoneNum=SiteProperty.authenPhoneNum;
String qrStorePath=SiteProperty.qrStorePath;
String defaultIP=SiteProperty.defaultIP;

session.setAttribute("gungPicturePath", gungPicturePath);
session.setAttribute("gabiaPath", gabiaPath);
session.setAttribute("authenPhoneNum", authenPhoneNum);
session.setAttribute("qrStorePath", qrStorePath);
session.setAttribute("defaultIP", defaultIP);


%>