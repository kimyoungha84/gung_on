<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%-- <%@ include file="../common/jsp/site_config.jsp"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEARCH - 아이디 찾기 / 비밀번호 찾기</title>
<link rel="stylesheet" href="/gung_on/common/css/common.css">
<c:import url="/common/jsp/external_file.jsp"/>
</head>
<body class="page-body">
	<!-- 상단 메뉴 등 -->
<jsp:include page="/common/jsp/header.jsp"/>
	<div class="search-container">
		<h1 class="title">
			<strong>아이디 찾기  /  비밀번호 찾기</strong>
		</h1>
		<hr class="divider">

		<div class="form-container">
			<!-- 아이디 찾기 -->
			<div class="form-section">
				<div class="section-title">아이디 찾기</div>
				<form method="post">
					<input type="hidden" name="action" value="findId" /> 
					<input type="text" name="name" placeholder="이름" class="text-input" required /> 
					<input type="email" name="email" placeholder="이메일" class="text-input" required />
					<input type="text" class="text-input dummy-input" style="visibility: hidden;" tabindex="-1" />
					<button type="submit" class="submit-btn">확인</button>
				</form>
			</div>

			<!-- 비밀번호 변경 -->
			<div class="form-section">
				<div class="section-title">비밀번호 찾기</div>
				<form method="post">
					<input type="hidden" name="action" value="changePassword"  /> 
					<input type="text" name="name" placeholder="이름" class="text-input"  required /> 
					<input type="text" name="userId" placeholder="아이디" class="text-input" required /> 
					<input type="email" name="email" placeholder="이메일"  class="text-input" required />
					<button type="submit" class="submit-btn">확인</button>
				</form>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
<jsp:include page="/common/jsp/footer.jsp"/>
</body>
</html>