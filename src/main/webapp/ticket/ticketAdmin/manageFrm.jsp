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
<!-- CSS 설정 -->
<link rel="stylesheet" type="text/css" href="http://${defaultIP}/Gung_On/ticket/css/payment.css"/>
<link rel="stylesheet" type="text/css" href="http://${defaultIP}/Gung_On/ticket/css/paymentComplete.css"/>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>

<script type="text/javascript">
$(function(){

	$(".wrap").click(function(){
		alert("들어오나?");
		var id=$(this).attr("id");
		window.location.href="http://localhost/Gung_On/ticket/ticketAdmin/manage_detail_Frm.jsp?bookingNum="+id;
	});	
	
	$("#btn").click(function(){
		alert("되긴하는건가");
	});
		
		
});//ready


</script>

</head>
<body>

<div class="title">
 <img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">  
 <span class="titlep">예매 관리</span>
</div>

<div class="">
<form method="POST" id="">
<input type="date" id="date" style="margin-left:10px;" name="date" value=""/><span style="font-weight: bold;"></span>
<input class="" placeholder="입력해주세요" type="search" style="margin-left:100px;" title="wow" />
<input type="button" id="btn" value="검색" class=""/>
    
</form>

</div>
<br><br>


<div class="">
<table class="table-bordered" style="width:1566px; font-size: 20px; text-align: center; border: 1px solid #9398A2; padding:20px;">
    <thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
        <tr>
            <th>번호</th>
            <th>예매번호</th>
            <th>이름</th>
            <th>아이디</th>
            <th>총 예매 인원</th>
            <th>핸드폰 번호</th>
            <th>해설 선택 여부</th>
        </tr>
    </thead>
    <tbody class="border-start border-end" style="height:90px">
    	<c:forEach var="adminTicketDTO" items="${ ticketAdminList }" varStatus="i">
			<tr class="wrap" id="${ adminTicketDTO.booking_num }">
				<td>${i.count }</td>
				<td><c:out value="${ adminTicketDTO.booking_num }"/></td>
				<td><c:out value="${ adminTicketDTO.member_name }"/></td>
				<td><c:out value="${ adminTicketDTO.member_id }"/></td>
				<td><c:out value="${ adminTicketDTO.total_person }"/></td>
				<td><c:out value="${ adminTicketDTO.phone_number}"/></td>
				<td><c:out value="${ adminTicketDTO.comment_flag }"/></td>
			</tr>
		</c:forEach>
    </tbody>
</table>
		<%//페이지네이션 HTML 생성
		String paginationHtml = paginationBuilder.build(request.getRequestURI());
		%>
		<nav aria-label="Page navigation"><%= paginationHtml %></nav>
    <div class="datatable-bottom" style="display:flex; align-items: center;">
		
	</div>
</div><!-- includeTable -->






</body>
</html>