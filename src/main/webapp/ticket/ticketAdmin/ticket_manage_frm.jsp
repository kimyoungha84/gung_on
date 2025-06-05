<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 관리</title>

<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	

<meta name="viewport" content="width=device-width, initial-scale=1"/>

<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>

<!-- 달력 -->
<link rel="stylesheet" href="../datepicker/air-datepicker/dist/css/datepicker.min.css">
<script src="../datepicker/jquery-3.1.1.min.js"></script>
 <script src="../datepicker/air-datepicker/dist/js/datepicker.min.js"></script>
 <script src="../datepicker/air-datepicker/dist/js/i18n/datepicker.ko.js"></script>
 
 <!-- 내가 만든 js -->
 <script src="./js/ticket_manage_js.js" type="text/javascript"></script>
 
 <!-- 내가 만든 CSS -->
 <link rel="stylesheet" type="text/css" href="./css/ticket_manage_css.css"/>
 

 
</head>
<body>
 
 <div class="topSearch">
 <img src="../images/ico_date.png"/><input id="datepicker" name="datepicker" type="text" readonly placeholder="날짜를 선택해주세요."/>
 <input type="text"/><input type="button" placeholder="아이디를 입력해주세요." value="검색"/>
 
 
 </div>
 
 
 <table class="table table-striped table-hover">
 <thead>
 <tr>
 	<th>예매번호</th>
 	<th>이름</th>
 	<th>아이디</th>
 	<th>인원</th>
 	<th>핸드폰 번호</th>
 	<th>해설 선택 여부</th>
 </tr>
 

 
 </thead>
 <tbody>
 <tr>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 </tr>
 <tr>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 	<td>123</td>
 </tr>
 
 
 </tbody>
 
 
 
 </table>
 
 
 
 
 
</body>
</html>