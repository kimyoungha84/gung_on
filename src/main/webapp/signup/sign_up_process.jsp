<%@page import="kr.co.gungon.member.MemberService"%>
<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%-- <%@ include file="../common/jsp/site_config.jsp" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="/common/jsp/external_file.jsp"/>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">

<style type="text/css">
</style>

<script type="text/javascript">
$(function(){
	
});//ready


</script>
</head>
<body>
<header>
  <jsp:include page="${pageContext.request.contextPath}/common/jsp/header.jsp"/>
</header>
<main>


<%
//1. 한글처리
request.setCharacterEncoding("UTF-8");

%>

<jsp:useBean id="mDTO" class="kr.co.gungon.member.MemberDTO" scope="page"/>
<jsp:setProperty property="*" name="mDTO"/>
<% 
	mDTO.setIp(request.getRemoteAddr());
	
	MemberService ms = new MemberService();
	//비연결성인 웹에서 한정적인 자원을 먼저 선점하는 접속자 이외에는 "해당자원을 다른 접속자가
	// 사용중입니다." 를 제공해야한다.
	boolean flag=ms.searchId(mDTO.getId());//아이디가 사용중인지 사용중이면 true
	if(!flag){
	pageContext.setAttribute("addResult", ms.addMember(mDTO));
	
	
%>
<div style="width: 700px; height: 300px; margin:0px auto; position: relative; top: 100px;">
<c:choose>
<c:when test="${ addResult }">

<%-- 회원가입 성공 --%>
<div>
<div style="position: relative; margin:0px auto; font-size: 25px">
<strong><c:out value="${ param.name }"/>님 </strong> 회원가입 되셨습니다.
<a href="javascript:location.replace('${pageContext.request.contextPath}/mainpage/mainpage.jsp')" class="btn btn-secondary btn-sm">메인으로</a>
</div>
</div>
</c:when>
<c:otherwise>
<%-- 회원가입 실패 --%>
<div>
<h2>회원가입이 정상적으로 이루어지지 않았습니다.</h2>
</div>
<h3>잠시 후 다시 시도해주세요.</h3>
<a href="${pageContext.request.contextPath}/mainpage/mainpage.jsp">메인화면</a>
<a href="javascript:history.back()" class="btn btn-danger btn-sm">다시시도</a>
</c:otherwise>

</c:choose>
<%}else{ %>
	<div style="margin: 0 auto; width: 300px; height: 300px; position: relative; top: 100px;">
	<c:out value="${param.id }"/>는 이미 사용중 입니다.<br>
	<a href="javascript:history.back()" class="btn btn-info btn-sm">다시시도</a></div>
<% }%>

</div>

</main>
<footer>
 <jsp:include page="${pageContext.request.contextPath}/common/jsp/footer.jsp"/>
  
</footer>


</body>
</html>
