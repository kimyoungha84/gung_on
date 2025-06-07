<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ include file="../config/site_config.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="fontawesome-i2svg-active fontawesome-i2svg-complete"><head>
<!-- favicon 설정 -->
<link rel="icon shortcut"  href="http://${defaultIP}/Gung_On/common/images/cs/gungOnFavicon.ico"/>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>상세 예매 관리</title>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
<link href="css/styles.css" rel="stylesheet">
<%
    request.setCharacterEncoding("UTF-8");

    FilteringInfo fi = new FilteringInfo();
    CsService css = new CsService();

    // --- 검색 파라미터 받기 ---
    String searchTextParam = request.getParameter("searchText");
    String searchCategoryParam = null;
    String transParam = null;
    if(request.getParameter("searchCategory") != null ){
    	String tempParam = request.getParameter("searchCategory");
    	switch(tempParam){
    	case "title" : 
    			transParam = "title";
    			searchCategoryParam = "notice_title";
    			break;
    	case "content" :
    			transParam = "content";
				searchCategoryParam = "notice_content";
				break;
    	}
    	
    }
    	
    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

    // 검색 버튼을 눌렀다면 (searchHid는 숨은 input)
    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "title".equals(categoryValue) ? "notice_title" : "notice_content";
        transParam = categoryValue;
        searchTextParam = request.getParameter("searchText").trim();
    }

    // 날짜 파싱
    Date startDate = null, endDate = null;
    try {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if (startDateParam != null && !startDateParam.isEmpty()) {
            startDate = new Date(df.parse(startDateParam).getTime());
        }
        if (endDateParam != null && !endDateParam.isEmpty()) {
            endDate = new Date(df.parse(endDateParam).getTime());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // FilteringInfo 세팅
    fi.setSearchText(searchTextParam);
    fi.setSearchCategory(searchCategoryParam);
    fi.setStartDate(startDate);
    fi.setEndDate(endDate);

    // --- 페이지네이션 처리 ---
    int pageSize = 10;
    int rowCounts = css.totalNoticeCount(fi);

    PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);

    // 검색 파라미터 유지용 쿼리스트링
    StringBuilder extraParams = new StringBuilder();
    if (searchTextParam != null && !searchTextParam.isEmpty()) {
        extraParams.append("searchText=").append(java.net.URLEncoder.encode(searchTextParam, "UTF-8"));
    }
    if (searchCategoryParam != null && !searchCategoryParam.isEmpty()) {
        if (extraParams.length() > 0) extraParams.append("&");
        extraParams.append("searchCategory=").append(transParam);
    }
    if (startDateParam != null && !startDateParam.isEmpty()) {
        if (extraParams.length() > 0) extraParams.append("&");
        extraParams.append("startDate=").append(startDateParam);
    }
    if (endDateParam != null && !endDateParam.isEmpty()) {
        if (extraParams.length() > 0) extraParams.append("&");
        extraParams.append("endDate=").append(endDateParam);
    }

    // 페이지네이션 HTML 생성
    String paginationHtml = paginationBuilder.build(request.getRequestURI(), extraParams.toString());

    int currentPage = paginationBuilder.getCurrentPage();
    int startNum = (currentPage - 1) * pageSize + 1;
    int endNum = currentPage * pageSize;

    // 시작/끝번호 fi에 세팅
    fi.setStartNum(startNum);
    fi.setEndNum(endNum);

    List<NoticeDTO> noticeList = css.searchNotice(fi);

    // 페이지에 데이터 바인딩
    pageContext.setAttribute("noticeList", noticeList);
    pageContext.setAttribute("paginationHtml", paginationHtml);
    pageContext.setAttribute("fi", fi);
    pageContext.setAttribute("rowCounts", rowCounts);
    pageContext.setAttribute("currentPage", currentPage);
    pageContext.setAttribute("pageSize", pageSize);
%>
        
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
 if (tableBody) {
  tableBody.addEventListener("change", function (e) {
    if (!e.target.classList.contains("rowCheck")) return;

    const row = e.target.closest("tr");
    row.classList.toggle("selected-delete", e.target.checked);

    // 전체 체크박스 상태 업데이트
    const all = tableBody.querySelectorAll(".rowCheck").length;
    const checked = tableBody.querySelectorAll(".rowCheck:checked").length;
    selectAll.checked = all === checked;
  });
}

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

	    if (endDate) {
	        queryParams.push("endDate=" + encodeURIComponent(endDate));
	    }

	    const queryString = "?" + queryParams.join("&");

	    // form action 변경 및 제출
	    form.setAttribute("action", actionBase + queryString);
	    form.submit();
	}); 

});
</script>




		
    </head>
    <body class="sb-nav-fixed">
    
    
    
    
    
    

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap 5 JS 필요 -->
    
    
        <div id="layoutSidenav">
                        
<div class="card m-3">
  <div class="card-body">
    <div class="tab-content">
      <div class="tab-pane fade show active" id="tab1" role="tabpanel">
       <img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">
        <span class="titlep">상세 예매</span>
      </div>
    </div>
    
    
    
    <div>
    <br><br>
    	<table  class="table table-striped datatable-table datatable-container">
    	<thead class="">
    		<tr>
	    		<th>행사 이름</th>
	    		<th>예매 일자</th>
	    		<th>해설 언어</th>
	    		<th>인원</th>
	    		<th>결제 금액</th>
    		</tr>
    	</thead>
    	<tbody>
    	<tr >
	    	<td>대인1</td>
	    	<td>2025-05-05 11:00</td>
	    	<td>한국어</td>
	    	<td>대인 3명</td>
	    	<td>15,000원</td>
    	</tr>
    	</tbody>
    	
    	
    	</table>
    
    
    </div>
    
    <br><br><br><br><br><br><br>
    
    <div class="datatable-wrapper no-footer sortable searchable fixed-columns">
    

<div class="datatable-container">
<form id="frm" method="post">
            <table id="datatablesSimple" class="table table-striped">
    <thead>
        <tr>
            <th  style="height:80px;">연령구분</th>
            <th style="height:80px;">입장시간</th>
            <th style="height:80px;">입장 여부</th>
            <th data-sortable="false"><input type="checkbox" id="selectAll"></th> <!-- 전체 선택용 체크박스 -->
        </tr>
    </thead>
    <tbody>
    	<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
		<tr>
		<%-- <td><c:out value="${ totalCount - (fi.currentPage -1) * pageScale - i.index }"/></td> --%>
		<td><c:out value="${ nDTO.notice_num }"/></td>
		<td>
		    <span><c:out value="${ nDTO.notice_title }"/></span>
		</td>
		<td><fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		<td><input type="checkbox" name="rowCheck" class="rowCheck"></td> <!-- 개별 체크박스 -->
	
		</tr>
		</c:forEach>
        <!-- <tr>
            <td><input type="checkbox" name="rowCheck" class="rowCheck"></td> 개별 체크박스
            <td>Tiger Nixon</td>
            <td>System Architect</td>
            <td>Edinburgh</td>
        </tr> -->
    </tbody>
</table>
</form>

</div>
<div class="datatable-bottom" style="display: flex; align-items: center;">
</div><!-- datatable-bottom -->
 <%= paginationHtml %>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>


</div><!-- datatable-wrapper -->

</div>

</div>


    
    
</div>    <!-- layoutSidenav -->  
                            
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
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script> -->
      <!--   <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script> -->
        <!-- <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script> -->
    

</body>
</html>