<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
pageContext.getAttribute("userData");
  %>
<!DOCTYPE html>
<html>
<head>
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="/gung_on/common/css/common.css">
    <c:import url="/common/jsp/external_file.jsp"/>
</head>
<body class="login">
<!-- 상단 메뉴 등 -->
<jsp:include page="/common/jsp/header.jsp"/>
<div class="login-container" style="width: 450px; height: 290px;">
    <h2>회원탈퇴</h2>
    <form action="login.do" method="post">
    	 <label style="position: absolute; left: 50px;">아이디 :</label>
  <span style="position: absolute; left: 120px;">${ userData.id }</span>
        <input type="hidden" style="display: none;"><br>
        <input type="text" name="username" placeholder="비밀번호" required><br>
        <input type="hidden" style="display: none;"><br>
        <button type="submit">회원탈퇴</button>
    </form>

</div>
<!-- 푸터 -->
<jsp:include page="/common/jsp/footer.jsp"/>
</body>
</html>
