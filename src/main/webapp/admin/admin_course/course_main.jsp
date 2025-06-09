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
        <title>사용자 추천 코스 관리</title>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
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

    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "title".equals(categoryValue) ? "notice_title" : "notice_content";
        transParam = categoryValue;
        searchTextParam = request.getParameter("searchText").trim();
    }

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

    fi.setSearchText(searchTextParam);
    fi.setSearchCategory(searchCategoryParam);
    fi.setStartDate(startDate);
    fi.setEndDate(endDate);

    int pageSize = 10;
    int rowCounts = css.totalNoticeCount(fi);

    PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);

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

    String paginationHtml = paginationBuilder.build(request.getRequestURI(), extraParams.toString());

    int currentPage = paginationBuilder.getCurrentPage();
    int startNum = (currentPage - 1) * pageSize + 1;
    int endNum = currentPage * pageSize;

    fi.setStartNum(startNum);
    fi.setEndNum(endNum);

    List<NoticeDTO> noticeList = css.searchNotice(fi);

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
            table-layout: fixed; 
        }

        #datatablesSimple th, #datatablesSimple td {
            text-align: left;
            padding: 8px;
        }

        #datatablesSimple th:nth-child(1), 
        #datatablesSimple td:nth-child(1) {
            width: 5%;
        }

        #datatablesSimple th:nth-child(2), 
        #datatablesSimple td:nth-child(2) {
            width: 10%; 
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
		
<script>
document.addEventListener("DOMContentLoaded", function () {
  const dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
    searchable: false,
    perPageSelect: false,
    paging: false
  });

  const tableBody = document.querySelector("#datatablesSimple tbody");
  const selectAll = document.getElementById("selectAll");

  if (selectAll) {
    selectAll.addEventListener("change", function () {
      const checked = this.checked;
      tableBody.querySelectorAll(".rowCheck").forEach(cb => {
        cb.checked = checked;
        cb.closest("tr").classList.toggle("selected-delete", checked);
      });
    });
  }

 if (tableBody) {
  tableBody.addEventListener("change", function (e) {
    if (!e.target.classList.contains("rowCheck")) return;

    const row = e.target.closest("tr");
    row.classList.toggle("selected-delete", e.target.checked);

    const all = tableBody.querySelectorAll(".rowCheck").length;
    const checked = tableBody.querySelectorAll(".rowCheck:checked").length;
    selectAll.checked = all === checked;
  });
}

  document.getElementById("deleteBtn").addEventListener("click", function () {
    const checkedBoxes = tableBody.querySelectorAll(".rowCheck:checked");

    if (checkedBoxes.length === 0) {
      alert("삭제할 공지사항을 선택하세요.");
      return;
    }

    const noticeNumList = Array.from(checkedBoxes).map(cb => {
      return cb.closest("tr").children[1].textContent.trim(); 
    });

    console.log("삭제할 notice_num 목록:", noticeNumList);
    
    alert(noticeNumList);
    
    $.ajax({
      url: "noticedelete_process.jsp",  
      type: "POST",              
      data: {                 
        noticeNumList: JSON.stringify(noticeNumList)
      },
      success: function(response) {
        console.log("서버 응답:", response);

        if (response.status === "success") {
          alert("삭제가 완료되었습니다.");
          location.reload();
          
        } else {
          alert("삭제 실패: " + response.message);
        }
      },
      error: function(xhr, status, error) {
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
	  var startDateValue = $('#startDate').val();
	  $('#endDate').attr('min', startDateValue);

	  $('#startDate').on('input change', function() {
	    var newStartDate = $(this).val();
	    $('#endDate').attr('min', newStartDate);

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
    
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                    	<div style="display: flex; align-items: center;">
   						 	<img src="/Gung_On/common/images/mainpage/header_icon.png" style="/* width: 120px; height: 100px; */  margin-right: 10px; ">
    						<h1 class="mt-4">사용자 추천 코스 관리</h1>
						</div>
                        
             <div class="sel_div" style="display: block;">
            <select class="sel_st">
           		<option value="gbg" selected="selected">경복궁</option>
            	<option value="cdg" >창덕궁</option>
            	<option value="dsg">덕수궁</option>
            	<option value="cgg">창경궁</option>
            	<option value="ghg">경희궁</option>
            </select>
            </div>
<div class="card m-3">
  <div class="card-body">
    <div class="datatable-wrapper no-footer sortable searchable fixed-columns">
<div class="datatable-top" >

<form method="POST" id="searchInfoFrm" action="${pageContext.request.requestURI}">
<input type="date" id="startDate" name="startDate" value="${param.startDate != null ? param.startDate : ''}"/><span style="font-weight: bold;"> - </span>
<input type="date" id="endDate" name="endDate" value="${param.endDate != null ? param.endDate : ''}"/>
<input type="hidden" name="searchHid" value="true"/>
						        <select id="category" class="form-select form-select-sm w-auto" name="searchCategory" style="display: inline;">
						            <option value="title" ${'title' == param.searchCategory ? 'selected' : ''}>제목</option>
									<option value="content" ${'content' == param.searchCategory ? 'selected' : ''}>내용</option>
						        </select>
						    
	<input class="datatable-input" placeholder="입력해주세요" type="search" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="${param.searchText != null ? param.searchText : ''}">
    <input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
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
									            <th>작성자</th>
									            <th>등록일</th>
									        </tr>
									    </thead>
									    <tfoot>
									        <tr>
									            <th></th> 
									            <th>번호</th>
									            <th>제목</th>
									            <th>작성자</th>
									            <th>등록일</th>
									        </tr>
									    </tfoot>
									    <tbody>
									    	<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
											<tr>
											<td><input type="checkbox" name="rowCheck" class="rowCheck"></td> <!-- 개별 체크박스 -->
											<td><c:out value="${ nDTO.notice_num }"/></td>
											<td>
											  <a href="#" onclick="openNoticePopup(${nDTO.notice_num}); return false;">
											    <span><c:out value="${ nDTO.notice_title }"/></span>
											  </a>
											</td>
											<td><fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
											</tr>
											</c:forEach>
									    </tbody>
									</table>
                                </form>

</div>
<div class="datatable-bottom" style="display: flex; align-items: center;">
 <%= paginationHtml %>
    <div style= "margin-left: auto;">
    <input type="button" style="width:80px; height: 40px;" class="btn btn-info" value="삭제" id="deleteBtn"/>
    </div>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
</div></div>

</div>
</div>
</div>
    </main>
  </div>
                
</body>
</html>