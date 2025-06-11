<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹페이지를 찾을 수 없습니다.</title>

<style>
/* 페이지 전체 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.error-page {
    text-align: center;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    padding: 40px;
    width: 60%;
    max-width: 600px;
    margin-top: -200px; 
}

.error-image img {
    width: 150px;  /* 이미지 크기 조절 */
    height: auto;
}

.error-message h1 {
    font-size: 32px;
    color: #333;
    margin: 20px 0;
}

.back-btn button {
    background-color: #007bff;
    color: white;
    font-size: 18px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.back-btn button:hover {
    background-color: #0056b3;
}

</style>

<script type="text/javascript">




$(function(){

});//ready


</script>
</head>
<body>

 <div class="error-page">
        <!-- 상단 이미지 -->
        <div class="error-image">
            <img src="${pageContext.request.contextPath}/common/images/cs/궁온.png">  <!-- 이미지 경로 수정 -->
        </div>
        
        <!-- 오류 메시지 -->
        <div class="error-message">
            <h1>웹페이지를 찾을 수 없습니다</h1>
        </div>

        <!-- 이전 페이지로 돌아가기 버튼 -->
        <div class="back-btn">
            <button onclick="history.back()">이전 페이지</button>
        </div>
    </div>

</body>
</html>