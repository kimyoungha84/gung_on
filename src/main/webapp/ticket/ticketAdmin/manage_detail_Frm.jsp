<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../config/site_config.jsp"%>
<%@ include file="adminProcess/ticket_manage_detail_process.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- favicon 설정 -->
<link rel="icon shortcut"  href="http://${defaultIP}/Gung_On/common/images/cs/gungOnFavicon.ico"/>
<link href="css/ticket_manage_detail_css.css" rel="stylesheet">


<meta charset="UTF-8">
<title>상세 예매 관리</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>

<div class="tab-pane fade show active" id="tab1" role="tabpanel">
<img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">
<span class="titlep">예매 정보 상세</span>
</div>

<div>
<span>예매 번호</span><span style="width:100px"><c:out value="${adminDTO.getBooking_num() }"/></span><span> 결제일</span><span><c:out value="${adminDTO.getPaymentTimeStamp() }"/></span>
</div>

<div>
    <br><br>
    	<table  class="table table-striped datatable-table datatable-container">
    	<thead class="">
    		<tr>
	    		<th>행사 이름</th>
	    		<th>행사 시간</th>
	    		<th>해설 언어</th>
	    		<th>인원</th>
	    		<th>결제 금액</th>
    		</tr>
    	</thead>
    	<tbody>
    	<tr >
	    	<td>${programName }</td>
	    	<td>${adminDTO.getReserve_date()} ${startTime}</td>
	    	<td>${adminDTO.getComment_flag() }</td>
	    	<td>${person }</td>
	    	<td>${adminDTO.getPayment()}원</td>
    	</tr>
    	</tbody>
    	
    	
    	</table>
    	
        <table id="datatablesSimple" class="table table-striped">
	    <thead>
        <tr>
            <th  style="height:80px;">연령구분</th>
            <th style="height:80px;">입장시간</th>
            <th style="height:80px;">입장 여부</th>
        </tr>
   	 	</thead>
    	<tbody>
	    	<c:forEach var="tDetailDTO" items="${adminDTO.getCompanies()}" varStatus="i">
				<tr>
				<td><c:out value="${ tDetailDTO.getAgeClassification()}  ${ tDetailDTO.getNumClassification()}"/></td>
				<td><c:out value="${ tDetailDTO.getEntryTime() }"/></td>
				<td><c:out value="${ tDetailDTO.getEntryStatus() }"/></td>
			
				</tr>
			</c:forEach>
    </tbody>
</table>


</div>
    



</body>
</html>