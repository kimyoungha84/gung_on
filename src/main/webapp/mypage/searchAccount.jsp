<%@page import="kr.co.gungon.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%-- <%@ include file="../common/jsp/site_config.jsp"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%session.getAttribute("userData"); 
MemberService ms = new MemberService();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEARCH - 아이디 찾기 / 비밀번호 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">
<c:import url="/common/jsp/external_file.jsp"/>

<script>
$(function(){
	
	$("#idBtn").click(function(){
		var paramId={name:$("#idName").val(), email:$("#idEmail").val()};
		$.ajax({
			  url:"${pageContext.request.contextPath}searchId_process.jsp",
		  type:"POST",
		  data:paramId,
		  dataType:"JSON",
		  error: function(xhr){
			  console.log(xhr.status);
		  },
		  success: function(jsonObj){
			  if (jsonObj.flag) {
			        alert("아이디 : "+jsonObj.id);
			      } else {
			        alert("아이디를 찾을 수 없습니다.");
			      }
		  	}
		  });//ajax
	});//click
	
	
	$("#passBtn").click(function(){
		var paramPass={name:$("#passName").val(),id:$("#passId").val() , email:$("#passEmail").val()};
		$.ajax({
			  url:"${pageContext.request.contextPath}searchPass_process.jsp",
		  type:"POST",
		  data:paramPass,
		  dataType:"JSON",
		  error: function(xhr){
			  console.log(xhr.status);
		  },
		  success: function(jsonObj){
			  if (jsonObj.flag) {
			        location.href = "changePassword.jsp"
			      } else {
			        alert("잘 못 입력했거나 없는 아이디입니다.");
			      }
		  	}
		  });//ajax
	});//click
	
});//ready

</script>
</head>
<body class="page-body">
	<!-- 상단 메뉴 등 -->
<jsp:include page="${pageContext.request.contextPath}/common/jsp/header.jsp"/>
	<div class="search-container">
		<h1 class="title">
			<strong>아이디 /  비밀번호 찾기</strong>
		</h1>
		<hr class="divider">

		<div class="form-container">
			<!-- 아이디 찾기 -->
			<div class="form-section">
				<div class="section-title">아이디 찾기</div>
				<form method="post" id="searchId">
					<input type="hidden" name="action" value="findId" /> 
					<input type="text" name="name" id="idName" placeholder="이름" class="text-input" required /> 
					<input type="email" name="email" id="idEmail" placeholder="이메일" class="text-input" required />
					<input type="text" class="text-input dummy-input" style="visibility: hidden;" tabindex="-1" />
					<button type="button" id="idBtn" class="submit-btn">아이디 찾기</button>
				</form>
			</div>

			<!-- 비밀번호 변경 -->
			<div class="form-section">
				<div class="section-title">비밀번호 찾기</div>
				<form method="post" id="searchPass">
					<input type="hidden" name="action" value="changePassword"  /> 
					<input type="text" name="name" id="passName" placeholder="이름" class="text-input"  required /> 
					<input type="text" name="userId" id="passId" placeholder="아이디" class="text-input" required /> 
					<input type="email" name="email" id="passEmail" placeholder="이메일"  class="text-input" required />
					<button type="button" id="passBtn" class="submit-btn">비밀번호 찾기</button>
				</form>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
<jsp:include page="${pageContext.request.contextPath}/common/jsp/footer.jsp"/>
</body>
</html>