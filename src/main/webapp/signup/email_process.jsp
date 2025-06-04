<%@page import="java.util.Properties"%>
<%@page import="kr.co.gungon.util.SendMail"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
String to = request.getParameter("email");
boolean emailFlag = false;
int code = (int)(Math.random() * 900000) + 100000; // 100000 ~ 999999
String title = "궁온 이메일 인증코드";
String content =String.valueOf(code);
String user_name = "gungjaein@gmail.com";//보내는사람의 이메일 (로그인용)
String password = "wijg xtyt wlie eelo";//보내는사람의 비밀번호 (로그인용)

SendMail sendMail = new SendMail();
try {
	sendMail.goMail(sendMail.setting(new Properties(), user_name, password), title, content,to);
    emailFlag = true;  // 실제로 메일 전송 성공했을 때만 true
	session.setAttribute("authCode", String.valueOf(code));
	session.setAttribute("authTime", System.currentTimeMillis());
} catch (Exception e) {
    emailFlag = false;
    e.printStackTrace();
}
%>

{ "emailFlag":<%=emailFlag %> }