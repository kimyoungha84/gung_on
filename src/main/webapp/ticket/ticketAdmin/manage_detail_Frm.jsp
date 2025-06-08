<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../config/site_config.jsp"%>
<%@ include file="adminProcess/ticket_manage_detail_process.jsp" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>
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
<!-- 부트스트랩  CDN -->    
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/> -->


</head>
<body>
<div class="entireWrap" >
<div class="" id="tab1" role="tabpanel">
<img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">
<span class="titlep" style="font-weight:bold; font-size:35px">예매 정보 상세</span>
</div>

<div>
<span style="font-weight:bold; font-size:25px">예매 번호</span><span style="font-size:20px;margin-left:10px;"><c:out value="${adminDTO.getBooking_num() }"/></span><span style="font-weight:bold; font-size:25px; margin-left:20px;"> 결제일</span><span style="font-size:20px;margin-left:10px"><c:out value="${adminDTO.getPaymentTimeStamp() }"/></span>
<input type="hidden" class="bookingNum" value="${adminDTO.getBooking_num() }"/>
</div>

<div class="entireWrap">
    <br>
    	<table class="table-bordered" style="font-size: 20px; text-align: center; border: 1px solid #9398A2; width:1200px">
    	<thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
    		<tr style="background:#ECECEC">
	    		<th>행사 이름</th>
	    		<th>행사 시간</th>
	    		<th>해설 언어</th>
	    		<th>인원</th>
	    		<th>결제 금액</th>
    		</tr>
    	</thead>
    	<tbody class="border-start border-end" style="height:90px">
    	<tr >
	    	<td>${programName }</td>
	    	<td>${adminDTO.getReserve_date()} ${startTime}</td>
	    	<td>${adminDTO.getComment_flag() }</td>
	    	<td>${person }</td>
	    	<td>${adminDTO.getPayment()}원</td>
    	</tr>
    	</tbody>
    	
    	
    	</table>
    	
    	<br>
    	
        <table class="table-bordered" style=" font-size: 20px; text-align: center; border: 1px solid #9398A2; width:1200px ">
	    <thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
        <tr style="background:#ECECEC">
        	<th></th>
            <th  style="height:80px;">연령구분</th>
            <th style="height:80px;">입장시간</th>
            <th style="height:80px;">입장 여부</th>
        </tr>
   	 	</thead>
    	<tbody class="border-start border-end" style="height:90px">
    		<%int cnt=1; %>
	    	<c:forEach var="tDetailDTO" items="${adminDTO.getCompanies()}" varStatus="i">
				<tr>
				<td><%=cnt %></td>
				<td><c:out value="${ tDetailDTO.getAgeClassification()}  ${ tDetailDTO.getNumClassification()}"/></td>
				<td><c:out value="${ tDetailDTO.getEntryTime() }"/></td>
				<td><c:out value="${ tDetailDTO.getEntryStatus() }"/></td>
			
				</tr>
				<% cnt++;%>
			</c:forEach>
			    </tbody>
			</table>
		


</div>
<br><br>
<%@ include file="/admin/common/footer.jsp" %>
</div><!--entireWrap -->
    



</body>
</html>