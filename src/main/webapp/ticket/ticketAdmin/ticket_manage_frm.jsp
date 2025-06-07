<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@include file="../config/site_config.jsp"%>
<%@include file="adminProcess/ticket_manage_process.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="fontawesome-i2svg-active fontawesome-i2svg-complete">
<head>

<!-- favicon 설정 -->
<link rel="icon shortcut"  href="http://${defaultIP}/Gung_On/common/images/cs/gungOnFavicon.ico"/>

 <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <meta name="description" content="">
 <meta name="author" content="">
 <title>예매 관리</title>
 <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
 <link href="css/styles.css" rel="stylesheet">
        
      <style>
      
      
       #datatablesSimple {
          width: 100%;
          table-layout: fixed; /* 고정된 너비로 설정 */
      }

      #datatablesSimple th, #datatablesSimple td {
          text-align: left;
          padding: 8px;
      }

      /* 각 열에 대한 너비 설정 */
      #datatablesSimple th:nth-child(1), 
      #datatablesSimple td:nth-child(1) {
          width: 10%;  /* 첫 번째 열 너비 10% */
      }

      #datatablesSimple th:nth-child(2), 
      #datatablesSimple td:nth-child(2) {
          width: 10%;  /* 두 번째 열 너비 20% */
      }

      #datatablesSimple th:nth-child(3), 
      #datatablesSimple td:nth-child(3) {
          width: 10%;  /* 세 번째 열 너비 50% */
      }

      #datatablesSimple th:nth-child(4), 
      #datatablesSimple td:nth-child(4) {
          width: 10%;  /* 네 번째 열 너비 20% */
      }
      
      #datatablesSimple th:nth-child(5), 
      #datatablesSimple td:nth-child(5) {
          width: 10%;  /* 네 번째 열 너비 20% */
      }
      
      #datatablesSimple th:nth-child(6), 
      #datatablesSimple td:nth-child(6) {
          width: 10%;  /* 네 번째 열 너비 20% */
      }
   	
tr.selected-delete {
 		 background-color: #ffd6d6 !important; /* 삭제용 하이라이트 색상 */
	}
        
      
      .border-secondary{
			border-width: 3px !important;
      	background-color: #F8F9FA;
      	font-weight: bold;
      	margin-right: -2rem;
      
      }
		.card-hover:hover {
			background-color: #A0A0A0;
			border-color: #212511 !important;
}
.col-md-3{
	width: 120px;
	height : 80px;

}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="css/simple-datatables.js"></script> 
<script src="css/datatables-simple-demo.js"></script>

		
<script>
document.addEventListener("DOMContentLoaded", function () {
  // simple-datatables 초기화
  const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
    searchable: false,
    perPageSelect: false,
    paging: false
  });

  const tableBody = document.querySelector("#datatablesSimple tbody");
  const selectAll = document.getElementById("selectAll");

  // 전체 선택 체크박스
  if (selectAll) {
    selectAll.addEventListener("change", function () {
      const checked = this.checked;
      tableBody.querySelectorAll(".rowCheck").forEach(cb => {
        cb.checked = checked;
        cb.closest("tr").classList.toggle("selected-delete", checked);
      });
    });
  }

 // 개별 체크박스 클릭 시 삭제용 하이라이트 적용

 document.getElementById("searchBtn").addEventListener("click", function(e) {
 const form = document.getElementById("searchInfoFrm");
 let actionBase = form.getAttribute("action");

 const searchText = form.searchText.value.trim();
 const searchCategory = form.searchCategory.value
 const startDate = form.startDate.value.trim();
 const endDate = form.endDate.value.trim();

 const currentPage = 1;

 // query string 구성
 let queryParams = [];
 queryParams.push("currentPage=" + currentPage);

 if (searchText) {
     queryParams.push("searchText=" + encodeURIComponent(searchText));
 }

 if (searchCategory) {
     queryParams.push("searchCategory=" + encodeURIComponent(searchCategory));
 }

 if (startDate) {
     queryParams.push("startDate=" + encodeURIComponent(startDate));
 }


 const queryString = "?" + queryParams.join("&");

 // form action 변경 및 제출
 form.setAttribute("action", actionBase + queryString);
 form.submit();
}); //click

});
</script>



		
</head>
<body class="sb-nav-fixed">

<%


%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap 5 JS 필요 -->
<div id="layoutSidenav">
       
<!-- 카드 패널 시작 -->
<!-- 카드 패널 끝 -->
                        
<div class="card m-3">
  <div class="card-body">
    <div class="tab-content">
      <div class="tab-pane fade show active" id="tab1" role="tabpanel">
      <img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">  
      <span class="titlep">예매 관리</span>
    	
      </div>
  
    </div><!-- tab-content -->
<div class="datatable-wrapper no-footer sortable searchable fixed-columns">
    
<div class="datatable-top" >
<br>
<form method="POST" id="searchInfoFrm" action="${pageContext.request.requestURI}">
<input type="date" id="startDate" style="margin-left:10px;" name="startDate" value="${param.startDate != null ? param.startDate : ''}"/><span style="font-weight: bold;"></span>
<input type="hidden" name="searchHid" value="true"/>
<!-- <div class="datatable-search" style="width: 300px; height : 69px; display: flex; align-items: center;  gap: 8px;" > -->
<input class="datatable-input" placeholder="입력해주세요" type="search" style="margin-left:100px;" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="${param.searchText != null ? param.searchText : ''}">
<input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
    <!-- </div> -->
</form>
</div>
<div class="datatable-container">
<form id="frm" method="post">
<br><br>
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
			<tr>
			<td>${i.count }</td>
			<td><c:out value="${ adminTicketDTO.booking_num }"/></td>
			<td><c:out value="${ adminTicketDTO.member_name }"/></td>
			<td><c:out value="${ adminTicketDTO.member_id }"/></td>
			<td><c:out value="${ adminTicketDTO.total_person }"/></td>
			<td><c:out value="${ adminTicketDTO.phone_number}"/></td>
			<td><c:out value="${ adminTicketDTO.comment_flag }"/></td>
			</tr>
		</c:forEach>
		<%	
		//페이지네이션 HTML 생성
		String paginationHtml = paginationBuilder.build(request.getRequestURI());
		%>
		
    </tbody>
</table>
 </form>


</div><!-- datatable-container -->

<br>
<div class="datatable-bottom" style=" align-items: center;">
 <nav aria-label="Page navigation">
                        <%= paginationHtml %>
                    </nav>
</div><!-- datatable-bottom -->
 
</div><!-- datatable-wrapper -->

</div><!-- card-body -->

</div><!-- card -->

</div>
          
<footer class="py-4 bg-light mt-auto">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">Copyright © Your Website 2023</div>
            <div>
                <a href="#">Privacy Policy</a>
                ·
                <a href="#">Terms &amp; Conditions</a>
            </div>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>