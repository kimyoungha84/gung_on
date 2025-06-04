<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%
String inputCode = request.getParameter("inputCode");
String sessionCode = (String) session.getAttribute("authCode");
Long authTime = (Long) session.getAttribute("authTime");

String result = "fail";

if (sessionCode == null || authTime == null) {
    result = "fail";
} else {
    long now = System.currentTimeMillis();
    if (now - authTime > 3 * 60 * 1000) { // 3분 초과
        result = "timeout";
    } else if (sessionCode.equals(inputCode)) {
        result = "success";
        session.removeAttribute("authCode");
        session.removeAttribute("authTime");
    }
}

%>
{ "result": "<%= result %>" }
