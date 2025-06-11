<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../config/site_config.jsp"%>
<%@ include file="/ticket/ticketAdmin/adminProcess/ticket_manage_detail_process.jsp" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- favicon 설정 -->
<link rel="icon shortcut"  href="/common/images/cs/gungOnFavicon.ico"/>



<link href="css/ticket_manage_detail_css.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>

<style>
.custom-table {
  max-width: 1000px;
  margin-left: auto;
  margin-right: auto;
  font-size: 14px;
}

.custom-table th,
.custom-table td {
  padding: 6px 12px;
  vertical-align: middle;
}

</style>


<script type="text/javascript">
$(function(){
	$("#resendBtn").click(function(){
		$.ajax({
			var param="bookingNum="+bookingNum+"&ageClassification="+ageClassification+"&numClassification="+numClassification;
			url:"/ticket/ticketAdmin/adminProcess/resendQR.jsp",
			type:"post",
			data: param,
			
			dataType:"html",
			error : function(xhr){
				console.log(xhr.status+" / "+xhr.statusText);
			},//error
			success: function(data){
				var result=$.trim(data);
			//와 ... 머리가 아예 안돌아가는데?...ㅎ....
				
			}//success
		});//ajax
		alert("전송완료");
	});//click
	
	
});//ready




</script>
<div id="layoutSidenav_content">
<main>
  <div class="container-fluid px-4">
           <h2 class="mt-4">예매 정보 상세</h2>
           <hr/>
<!-- <div class="entireWrap" > -->
<div class="card m-3 entireWrap"><!-- card m-3 start -->
<div class="card-body"><!-- card-body start -->
<h2>예매 목록</h2>

<div class="" id="tab1" role="tabpanel">

</div>



<div class="entireWrap">
    <br>
 <div style="display: flex; justify-content: space-between; align-items: center; max-width: 1000px; margin: 0 auto 12px auto; font-size: 15px;">
<div><span style="font-weight:bold;">예매 번호: <c:out value="${adminDTO.getBooking_num() }"/></span></div>
<div><span style="font-weight:bold;"> 결제일: <c:out value="${adminDTO.getPaymentTimeStamp() }"/></span></div>
<input type="hidden" class="bookingNum" value="${adminDTO.getBooking_num() }"/>
<input type="hidden" class="ageClassification" value="${ tDetailDTO.getAgeClassification()}"/>
<input type="hidden" class="numClassification" value="${ tDetailDTO.getNumClassification()} }"/>
</div>
      
    	<table class="table table-bordered table-hover text-center custom-table">
    	<thead class="table-light">
    		<tr style="background:#ECECEC">
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
	    	<td>${person}</td>
	    	<td>${paymentStr}원</td>
    	</tr>
    	</tbody>
    	
    	
    	</table>
    	
    	<br>
    	
      <table class="table table-bordered table-hover text-center custom-table">
	    <thead class="table-light">
        <tr>
        	<th></th>
            <th>연령구분</th>
            <th>입장시간</th>
            <th>입장 여부</th>
        </tr>
   	 	</thead>
    	<tbody>
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
</div>
<br><br>
<%@ include file="/admin/common/footer.jsp" %>
</div> <!--entireWrap --> 
</div> <!-- container-fluid -->
</main>

</div>
</body>
</html>