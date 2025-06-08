<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="fontawesome-i2svg-active fontawesome-i2svg-complete"><head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>관리자 - 고객센터 - 공지</title>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
        <link href="cs_common/styles.css" rel="stylesheet">
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
        form{
        display: inline;
        
        }
        div{
        display: inline;
        }
        
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
            width: 5%;  /* 첫 번째 열 너비 10% */
        }

        #datatablesSimple th:nth-child(2), 
        #datatablesSimple td:nth-child(2) {
            width: 10%;  /* 두 번째 열 너비 20% */
        }

        #datatablesSimple th:nth-child(3), 
        #datatablesSimple td:nth-child(3) {
            width: 50%;  /* 세 번째 열 너비 50% */
        }

        #datatablesSimple th:nth-child(4), 
        #datatablesSimple td:nth-child(4) {
            width: 20%;  /* 네 번째 열 너비 20% */
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
        <script src="cs_common/simple-datatables.js"></script> 
        <script src="cs_common/datatables-simple-demo.js"></script>
		
		
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

  // 삭제 버튼 클릭 시 체크된 번호 수집
  document.getElementById("deleteBtn").addEventListener("click", function () {
    const checkedBoxes = tableBody.querySelectorAll(".rowCheck:checked");

    if (checkedBoxes.length === 0) {
      alert("삭제할 공지사항을 선택하세요.");
      return;
    }

    const noticeNumList = Array.from(checkedBoxes).map(cb => {
      return cb.closest("tr").children[1].textContent.trim(); // 두 번째 칸이 번호
    });

    console.log("삭제할 notice_num 목록:", noticeNumList);
    
    alert(noticeNumList);
    
    // Ajax 요청
    $.ajax({
      url: "noticedelete_process.jsp",  // 서버로 데이터를 전송할 URL
      type: "POST",               // 요청 방식 (POST)
      data: {                     // 서버로 전송할 데이터
        noticeNumList: JSON.stringify(noticeNumList) // 배열을 JSON 문자열로 변환하여 전송
      },
      success: function(response) {
        // 성공 시 처리 (서버에서 반환한 응답을 사용할 수 있습니다)
        console.log("서버 응답:", response);

        if (response.status === "success") {
          alert("삭제가 완료되었습니다.");
          // 삭제 후 처리 (예: 테이블에서 삭제된 항목 제거)
          location.reload();
          
        } else {
          alert("삭제 실패: " + response.message);
        }
      },
      error: function(xhr, status, error) {
        // 실패 시 처리
        console.error("삭제 요청 중 오류 발생:", error);
        alert("삭제 중 오류가 발생했습니다.");
      }
    
    });
  });
  
  
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

<script>

function openNoticePopup(noticeNum) {
    const url = "notice_preview_popup.jsp?num=" + encodeURIComponent(noticeNum);
    const options = "width=1200,height=800,scrollbars=yes,resizable=yes";
    window.open(url, "noticePopup", options);
  }

</script>

<script>
$(document).ready(function() {
	  // 초기 설정
	  var startDateValue = $('#startDate').val();
	  $('#endDate').attr('min', startDateValue);

	  // startDate 값 변경 시 min 갱신
	  $('#startDate').on('input change', function() {
	    var newStartDate = $(this).val();
	    $('#endDate').attr('min', newStartDate);

	    // 이미 선택된 endDate가 min보다 이전이면 초기화
	    var currentEndDate = $('#endDate').val();
	    if (currentEndDate && currentEndDate < newStartDate) {
	      $('#endDate').val('');
	    }
	  });
	});
</script>

		
    </head>
    <body class="sb-nav-fixed">
    
    
    
    
    
    

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap 5 JS 필요 -->
    
    
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">관리자페이지</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><svg class="svg-inline--fa fa-bars" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="bars" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 78.3 14.3 64 32 64H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H416c17.7 0 32 14.3 32 32z"></path></svg><!-- <i class="fas fa-bars"></i> Font Awesome fontawesome.com --></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch">
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><svg class="svg-inline--fa fa-magnifying-glass" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="magnifying-glass" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"></path></svg><!-- <i class="fas fa-search"></i> Font Awesome fontawesome.com --></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><svg class="svg-inline--fa fa-user fa-fw" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"></path></svg><!-- <i class="fas fa-user fa-fw"></i> Font Awesome fontawesome.com --></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="dashboard.jsp">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-gauge-high" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="gauge-high" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zM288 96a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zM256 416c35.3 0 64-28.7 64-64c0-17.4-6.9-33.1-18.1-44.6L366 161.7c5.3-12.1-.2-26.3-12.3-31.6s-26.3 .2-31.6 12.3L257.9 288c-.6 0-1.3 0-1.9 0c-35.3 0-64 28.7-64 64s28.7 64 64 64zM176 144a32 32 0 1 0 -64 0 32 32 0 1 0 64 0zM96 288a32 32 0 1 0 0-64 32 32 0 1 0 0 64zm352-32a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"></path></svg><!-- <i class="fas fa-tachometer-alt"></i> Font Awesome fontawesome.com --></div>
                                대시보드
                            </a>
                            <div class="sb-sidenav-menu-heading">인사이트</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-table-columns" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="table-columns" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 60.7 28.7 32 64 32H448c35.3 0 64 28.7 64 64V416c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V96zm64 64V416H224V160H64zm384 0H288V416H448V160z"></path></svg><!-- <i class="fas fa-columns"></i> Font Awesome fontawesome.com --></div>
                                통계
                                <div class="sb-sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="layout-static.html">Static Navigation</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-book-open" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="book-open" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" data-fa-i2svg=""><path fill="currentColor" d="M249.6 471.5c10.8 3.8 22.4-4.1 22.4-15.5V78.6c0-4.2-1.6-8.4-5-11C247.4 52 202.4 32 144 32C93.5 32 46.3 45.3 18.1 56.1C6.8 60.5 0 71.7 0 83.8V454.1c0 11.9 12.8 20.2 24.1 16.5C55.6 460.1 105.5 448 144 448c33.9 0 79 14 105.6 23.5zm76.8 0C353 462 398.1 448 432 448c38.5 0 88.4 12.1 119.9 22.6c11.3 3.8 24.1-4.6 24.1-16.5V83.8c0-12.1-6.8-23.3-18.1-27.6C529.7 45.3 482.5 32 432 32c-58.4 0-103.4 20-123 35.6c-3.3 2.6-5 6.8-5 11V456c0 11.4 11.7 19.3 22.4 15.5z"></path></svg><!-- <i class="fas fa-book-open"></i> Font Awesome fontawesome.com --></div>
                                Pages
                                <div class="sb-sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">관리</div>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                궁 관리
                            </a>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                행사 관리
                            </a>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                예약 관리
                            </a>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                관람 관리
                            </a>
                            <a class="nav-link" href="charts.html">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                회원 관리
                            </a>
                            <a class="nav-link" href="#void">
                                <div class="sb-nav-link-icon"><svg class="svg-inline--fa fa-chart-area" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chart-area" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm96 288H448c17.7 0 32-14.3 32-32V251.8c0-7.6-2.7-15-7.7-20.8l-65.8-76.8c-12.1-14.2-33.7-15-46.9-1.8l-21 21c-10 10-26.4 9.2-35.4-1.6l-39.2-47c-12.6-15.1-35.7-15.4-48.7-.6L135.9 215c-5.1 5.8-7.9 13.3-7.9 21.1v84c0 17.7 14.3 32 32 32z"></path></svg><!-- <i class="fas fa-chart-area"></i> Font Awesome fontawesome.com --></div>
                                고객센터 관리
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">홍길동 관리자님</div>
                        여기에는 로그아웃 버튼이 들어갈 예정입니다.
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                    	<div style="display: flex; align-items: center;">
   						 	<img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">
    						<h1 class="mt-4">고객센터 관리</h1>
						</div>

                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">궁온 관리자페이지</li>
                        </ol>
                        <!-- 카드 패널 시작 -->
<!-- 카드 패널 끝 -->
                        
<div class="card m-3">
  <div class="card-header">
    <ul class="nav nav-tabs card-header-tabs" role="tablist">
      <li class="nav-item" role="presentation">
        <a class="nav-link active" data-bs-toggle="tab" href="cs_notice_main.jsp" role="tab" aria-selected="true">공지사항</a>
      </li>
      <li class="nav-item" role="presentation">
        <a class="nav-link" data-bs-toggle="tab" href="cs_faq_main.jsp" role="tab" aria-selected="false" tabindex="-1">FAQ</a>
      </li>
      <li class="nav-item" role="presentation">
        <a class="nav-link" data-bs-toggle="tab" href="#tab3" role="tab" aria-selected="false" tabindex="-1">1:1문의</a>
      </li>
    </ul>
  </div>
  <div class="card-body">
    <div class="tab-content">
      <div class="tab-pane fade show active" id="tab1" role="tabpanel">
        <p>공지사항</p>
      </div>
      <div class="tab-pane fade" id="tab2" role="tabpanel">
        <p>FAQ</p>
      </div>
      <div class="tab-pane fade" id="tab3" role="tabpanel">
        <p>1:1문의</p>
      </div>
    </div>
    <div class="datatable-wrapper no-footer sortable searchable fixed-columns">
    
<div class="datatable-top" >

<form method="POST" id="searchInfoFrm" action="${pageContext.request.requestURI}">
<input type="date" id="startDate" name="startDate" value="${param.startDate != null ? param.startDate : ''}"/><span style="font-weight: bold;"> - </span>
<input type="date" id="endDate" name="endDate" value="${param.endDate != null ? param.endDate : ''}"/>
<input type="hidden" name="searchHid" value="true"/>
<!-- <div class="datatable-search" style="width: 300px; height : 69px; display: flex; align-items: center;  gap: 8px;" > -->
	<!-- <div class="dataTable-category-filter ms-2"> -->
						        <select id="category" class="form-select form-select-sm w-auto" name="searchCategory" style="display: inline;">
						            <option value="title" ${'title' == param.searchCategory ? 'selected' : ''}>제목</option>
									<option value="content" ${'content' == param.searchCategory ? 'selected' : ''}>내용</option>
						        </select>
						 <!--    </div> -->
						    
						    
						    
	<input class="datatable-input" placeholder="입력해주세요" type="search" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="${param.searchText != null ? param.searchText : ''}">
    <input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
        <!-- </div> -->
</form>
        
</div>
<div class="datatable-container">
<form id="frm" method="post">
                     <table id="datatablesSimple" class="table table-striped">
									    <thead>
									        <tr>
									            <th data-sortable="false"><input type="checkbox" id="selectAll"></th> <!-- 전체 선택용 체크박스 -->
									            <th>번호</th>
									            <th>제목</th>
									            <th>등록일</th>
									        </tr>
									    </thead>
									    <tfoot>
									        <tr>
									            <th></th> <!-- 체크박스 열에는 라벨 없음 -->
									            <th>번호</th>
									            <th>제목</th>
									            <th>등록일</th>
									        </tr>
									    </tfoot>
									    <tbody>
									    	<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
											<tr>
											<td><input type="checkbox" name="rowCheck" class="rowCheck"></td> <!-- 개별 체크박스 -->
											<%-- <td><c:out value="${ totalCount - (fi.currentPage -1) * pageScale - i.index }"/></td> --%>
											<td><c:out value="${ nDTO.notice_num }"/></td>
											<td>
											  <a href="#" onclick="openNoticePopup(${nDTO.notice_num}); return false;">
											    <span><c:out value="${ nDTO.notice_title }"/></span>
											  </a>
											</td>
											<td><fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
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
<%-- <%@ include file="customPagination.jsp" %> --%>

</div>
<div class="datatable-bottom" style="display: flex; align-items: center;">
 <%= paginationHtml %>
    <div style= "margin-left: auto;">
    <input type="button" style="width:80px; height: 40px;" class="btn btn-success" value="작성" id="writeBtn" onclick="location.href='cs_notice_write.jsp';"/>
    <input type="button" style="width:80px; height: 40px;" class="btn btn-info" value="삭제" id="deleteBtn"/>
    </div>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
</div></div>

</div>

</div>

</div>
    
    
    
  </div>
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
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script> -->
      <!--   <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script> -->
        <!-- <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script> -->
    

</body>
</html>