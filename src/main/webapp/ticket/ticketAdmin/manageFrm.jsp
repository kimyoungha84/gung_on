<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../config/site_config.jsp"%>
<%@ include file="adminProcess/ticket_manage_process.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<!-- favicon 설정 -->
<link rel="icon shortcut"  href="http://${defaultIP}/Gung_On/common/images/cs/gungOnFavicon.ico"/>
<meta charset="UTF-8">
<title>예매 관리</title>

<!-- 스타일 설정 -->
<link href="css/ticket_manage_css.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>


<script src="js/ticket_manage_js.js"></script>

</head>
<body>

<div class="title">
 <img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">  
 <span class="titlep">예매 관리</span>
</div>

<div class="calendar">
<form method="POST" id="searchInfoFrm">
<input type="date" id="startDate" style="margin-left:10px;" name="startDate" value=""/><span style="font-weight: bold;"></span>
<input type="hidden" name="searchHid" value="true"/>
<!-- <div class="datatable-search" style="width: 300px; height : 69px; display: flex; align-items: center;  gap: 8px;" > -->
<input class="datatable-input" placeholder="입력해주세요" type="search" style="margin-left:100px;" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="">
<input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
    <!-- </div> -->
</form>

</div>


<div class="includeTable">
<table id="datatablesSimple" class="table table-striped">
    <thead>
        <tr>
            <th>번호</th>
            <th  style="height:80px;">예매번호</th>
            <th style="height:80px;">이름</th>
            <th style="height:80px;">아이디</th>
            <th style="height:80px;">총 예매 인원</th>
            <th style="height:80px;">핸드폰 번호</th>
            <th style="height:80px;">해설 선택 여부</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="adminTicketDTO" items="${ ticketAdminList }" varStatus="i">
			<tr class="row" id="${ adminTicketDTO.booking_num }">
			<td>${i.count }</td>
			<td><c:out value="${ adminTicketDTO.booking_num }"/></td>
			<td><c:out value="${ adminTicketDTO.member_name }"/></td>
			<td><c:out value="${ adminTicketDTO.member_id }"/></td>
			<td><c:out value="${ adminTicketDTO.total_person }"/></td>
			<td><c:out value="${ adminTicketDTO.phone_number}"/></td>
			<td><c:out value="${ adminTicketDTO.comment_flag }"/></td>
			</tr>
		</c:forEach>
		<%//페이지네이션 HTML 생성
		String paginationHtml = paginationBuilder.build(request.getRequestURI());
		%>
    </tbody>
</table>
		<nav aria-label="Page navigation"><%= paginationHtml %></nav>
    <div class="datatable-bottom" style="display:flex; align-items: center;">
		
	</div>
</div><!-- includeTable -->






</body>
</html>