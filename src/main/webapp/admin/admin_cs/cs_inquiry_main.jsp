<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.InquiryFilteringInfo"%>
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
        <title>관리자 - 고객센터 - 1:1문의</title>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
        <link href="cs_common/styles.css" rel="stylesheet">
<%
    request.setCharacterEncoding("UTF-8");

    InquiryFilteringInfo ifi = new InquiryFilteringInfo();
    CsService css = new CsService();

    // --- 검색 파라미터 받기 ---
    String searchTextParam = request.getParameter("searchText");
    String searchCategoryParam = null;
    String transParam = null;
    String answerStatusParam = request.getParameter("answerStatus");
    
    if(request.getParameter("searchCategory") != null ){
    	String tempParam = request.getParameter("searchCategory");
    	switch(tempParam){
    	case "content" : 
    			transParam = "content";
    			searchCategoryParam = "inquiry_content";
    			break;
    	case "userId" :
    			transParam = "userId";
				searchCategoryParam = "member_id";
				break;
    	}
    	
    }
    	
    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

    // 검색 버튼을 눌렀다면 (searchHid는 숨은 input)
    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "content".equals(categoryValue) ? "inquiry_content" : "member_id";
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
    
    
    Boolean answerStatus = null;
    if (answerStatusParam != null && !answerStatusParam.isEmpty()) {
        if ("true".equalsIgnoreCase(answerStatusParam) || "Y".equalsIgnoreCase(answerStatusParam)) {
            answerStatus = true;
        } else if ("false".equalsIgnoreCase(answerStatusParam) || "N".equalsIgnoreCase(answerStatusParam)) {
            answerStatus = false;
        }
    }

    // FilteringInfo 세팅
   
    ifi.setSearchText(searchTextParam);
    ifi.setSearchCategory(searchCategoryParam);
    ifi.setStartDate(startDate);
    ifi.setEndDate(endDate);
    ifi.setAnswerStatus(answerStatus);

    // --- 페이지네이션 처리 ---
    int pageSize = 10;
    int rowCounts = css.totalInquiryCount(ifi);

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
    
    if (answerStatusParam != null && !answerStatusParam.isEmpty()) {
        if (extraParams.length() > 0) extraParams.append("&");
        extraParams.append("answerStatus=").append(answerStatusParam);
    }

    // 페이지네이션 HTML 생성
    String paginationHtml = paginationBuilder.build(request.getRequestURI(), extraParams.toString());

    int currentPage = request.getParameter("currentPage") != null ? Integer.parseInt(request.getParameter("currentPage")) : 1;
    int startNum = (currentPage - 1) * pageSize + 1;
    int endNum = currentPage * pageSize;

    // 시작/끝번호 fi에 세팅
    ifi.setCurrentPage(currentPage);
    ifi.setStartNum(startNum);
    ifi.setEndNum(endNum);
    
	
    List<InquiryDTO> inquiryList = css.searchInquiry(ifi);

    // 페이지에 데이터 바인딩
    pageContext.setAttribute("inquiryList", inquiryList);
    pageContext.setAttribute("paginationHtml", paginationHtml);
    pageContext.setAttribute("ifi", ifi);
    pageContext.setAttribute("rowCounts", rowCounts);
    pageContext.setAttribute("currentPage", currentPage);
    pageContext.setAttribute("pageSize", pageSize);
%>
        
        <style>
        
        .form-select, .datatable-selector {
    display: block;
    width: 100%;
    padding: 0.375rem 2.25rem 0.375rem 0.75rem;
    -moz-padding-start: calc(0.75rem - 3px);
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-image: url(data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e);
    background-repeat: no-repeat;
    background-position: right 0.75rem center;
    background-size: 16px 12px;
    border: 1px solid #ced4da;
    border-radius: 0.375rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
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
            width: 10%;  /* 네 번째 열 너비 20% */
        }
        
          #datatablesSimple th:nth-child(5), 
        #datatablesSimple td:nth-child(5) {
            width: 15%;  /* 다섯 번째 열 너비 20% */
        }
     	
          #datatablesSimple th:nth-child(6), 
        #datatablesSimple td:nth-child(6) {
            width: 10%;  /* 다섯 번째 열 너비 20% */
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
		
		table#datatablesSimple th {
   		 	vertical-align: middle !important;
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
	      alert("삭제할 FAQ를 선택하세요.");
	      return;
	    }

	    const inquiryNumList = Array.from(checkedBoxes).map(cb => {
	      return cb.closest("tr").children[1].textContent.trim(); // 두 번째 칸이 번호
	    });

	    console.log("삭제할 inquiry_num 목록:", inquiryNumList);
	    
	    // Ajax 요청
	    $.ajax({
	      url: "inquirydelete_process.jsp",  // 서버로 데이터를 전송할 URL
	      type: "POST",               // 요청 방식 (POST)
	      data: {                     // 서버로 전송할 데이터
	        inquiryNumList: JSON.stringify(inquiryNumList) // 배열을 JSON 문자열로 변환하여 전송
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
	    
	  });/* delete */
	  
	    function formatDate(dateString) {
	    	  if (!dateString) return "";

	    	  const date = new Date(dateString);
	    	  if (isNaN(date)) return "";

	    	  const year = date.getFullYear();
	    	  const month = String(date.getMonth() + 1).padStart(2, "0");
	    	  const day = String(date.getDate()).padStart(2, "0");

	    	  let hours = date.getHours();
	    	  const minutes = String(date.getMinutes()).padStart(2, "0");
	    	  const seconds = String(date.getSeconds()).padStart(2, "0");

	    	  const ampm = hours >= 12 ? "오후" : "오전";
	    	  hours = hours % 12 || 12;

	    	  return year + "-" + month + "-" + day + " " + ampm + " " +
	          String(hours).padStart(2, "0") + ":" + minutes + ":" + seconds;

	    	}

	    
	    $('#statusFilter').change(function () {
	    	const answerStatus = $(this).val();
	    	let searchText = "<%=ifi.getSearchText()%>";
	    	let searchCategory = "<%=ifi.getSearchCategory()%>";
	    	let startDate = "<%=ifi.getStartDate()%>";
	    	let endDate = "<%=ifi.getEndDate()%>";
	    	const currentPage = "1";
	    	const pageSize = "<%=pageSize%>";

	    	// 'null'이 들어있는지 확인하고 빈 문자열로 처리
	    	searchText = (searchText === "null") ? "" : searchText;
	    	searchCategory = (searchCategory === "null") ? "" : searchCategory;
	    	startDate = (startDate === "null") ? "" : startDate;
	    	endDate = (endDate === "null") ? "" : endDate;

		  
	      $.ajax({
	        url: 'inquiry_filter_ajax.jsp',
	        type: 'POST',
	        dataType: 'json',
	        data: { answerStatus: answerStatus,
	        		searchText: searchText,
	        		searchCategory: searchCategory,
	        		startDate: startDate,
	        		endDate: endDate,
	        		currentPage: currentPage,
	        		pageSize: pageSize
	        },
	        success: function (data) {
	            const tbody = document.querySelector('#datatablesSimple tbody');
	            tbody.innerHTML = ''; // 기존 데이터 초기화

	            const list = data.list;

	            if (list.length === 0) {
	                tbody.innerHTML = '<tr><td colspan="6">결과가 없습니다.</td></tr>';
	            } else {
	                list.forEach(dto => {
	                    const statusText = dto.answer_status ? "답변완료" : "답변대기";
	                    const formattedDate = formatDate(dto.inquiry_regDate);

	                    const row = '<tr>' +
	                        '<td><input type="checkbox" name="rowCheck" class="rowCheck"></td>' +
	                        '<td>' + dto.inquiry_num + '</td>' +
	                        '<td><a href="cs_inquiry_detail.jsp?num=' + dto.inquiry_num + '">' +
	                        '<span>' + dto.inquiry_content + '</span></a></td>' +
	                        '<td>' + dto.member_id + '</td>' +
	                        '<td>' + formattedDate + '</td>' +
	                        '<td>' + statusText + '</td>' +
	                        '</tr>';
	                    tbody.insertAdjacentHTML('beforeend', row);
	                });
	            }

	            // ✅ paginationHtml 삽입
	             const oldPagination = document.querySelector('.pagination-wrapper');
			    if (oldPagination) oldPagination.remove();
			
			    
			    // ✅ 새 pagination 추가 (첫 번째 항목에만 있음)
			    if (data.paginationHtml) {
			        const wrapper = document.createElement('div');
			        wrapper.innerHTML = data.paginationHtml;
			        const datatableBottom = document.querySelector('.datatable-bottom');
			        datatableBottom.insertBefore(wrapper, datatableBottom.firstChild);
			    }
				
				    dataTable.refresh(); // 필요 시 simple-datatables 새로고침
	        	},
	          error: function (xhr, status, error) {
	            alert("데이터를 불러오는 중 오류 발생: " + error);
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
		    queryParams.push("currentpage="${pageContext.request.contextPath} + currentPage);

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

<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">고객센터 관리</h2>
            <hr/>

            <!-- 여기부터 콘텐츠 영역 -->
            
            <div class="card m-3">
  <!-- <div class="card-header">
  </div> -->
  <div class="card-body">
  <h2>1:1 문의관리</h2>
    <div class="tab-content">
    </div>
    <div class="datatable-wrapper no-footer sortable searchable fixed-columns">
    
<div class="datatable-top" >

<form method="POST" id="searchInfoFrm" action="${pageContext.request.requestURI}">
<input type="date" id="startDate" name="startDate" value="${param.startDate != null ? param.startDate : ''}"/><span style="font-weight: bold;"> - </span>
<input type="date" id="endDate" name="endDate" value="${param.endDate != null ? param.endDate : ''}"/>
<input type="hidden" name="searchHid" value="true"/>
<div class="datatable-search" style="width: 300px; height : 69px; display: flex; align-items: center;  gap: 8px;" >
	<div class="dataTable-category-filter ms-2">
						        <select id="category" class="form-select form-select-sm w-auto" name="searchCategory">
						            <option value="content" ${'content' == param.searchCategory ? 'selected' : ''}>내용</option>
									<option value="userId" ${'userId' == param.searchCategory ? 'selected' : ''}>작성자ID</option>
						        </select>
						    </div>
						    
						    
						    
						    
	<input class="datatable-input" placeholder="입력해주세요" type="search" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="${param.searchText != null ? param.searchText : ''}">
    <input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
        </div>
</form>
        
</div>
<div class="datatable-container">
<form id="frm" method="post">
                     <table id="datatablesSimple" class="table table-striped">
									    <thead>
									        <tr>
									            <th data-sortable="false"><input type="checkbox" id="selectAll"></th> <!-- 전체 선택용 체크박스 -->
									            <th>문의번호</th>
									            <th>문의내용</th>
									            <th>작성자ID</th>
									            <th>등록일</th>
									             <th data-sortable="false">
											            <select id="statusFilter" class="form-select form-select-sm" style="font-size: 15px; padding: 2px 6px;" >
											                <option value="ALL" ${'content' == param.answerStatus ? 'selected' : ''}>전체</option>
											                <option value="Y" ${'Y' == param.answerStatus ? 'selected' : ''}>답변완료</option>
											                <option value="N" ${'N' == param.answerStatus ? 'selected' : ''}>답변대기</option>
											            </select>
											     </th>
									        </tr>
									    </thead>
									    <tfoot>
									        <tr>
									            <th></th> <!-- 체크박스 열에는 라벨 없음 -->
									            <th>문의번호</th>
									            <th>문의내용</th>
									            <th>작성자ID</th>
									            <th>등록일</th>
									            <th>처리상태</th>
									        </tr>
									    </tfoot>
									    <tbody id="inquiryTableBody">
									    	<c:forEach var="iDTO" items="${ inquiryList }" varStatus="i">
											<tr>
											<td><input type="checkbox" name="rowCheck" class="rowCheck"></td> <!-- 개별 체크박스 -->
											<%-- <td><c:out value="${ totalCount - (fi.currentPage -1) * pageScale - i.index }"/></td> --%>
											<td><c:out value="${ iDTO.inquiry_num }"/></td>
											<td>
											  <a href="cs_inquiry_detail.jsp?num=${ iDTO.inquiry_num }">
											    <span><c:out value="${ iDTO.inquiry_content }"/></span>
											  </a>
											</td>
											<td><c:out value="${ iDTO.member_id }"/></td>
											<td><fmt:formatDate value="${ iDTO.inquiry_regDate }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
											<td><c:out value="${ iDTO.answer_status == true ? '답변완료' : '답변대기' }"/></td>
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
    <input type="button" style="width:80px; height: 40px;" class="btn btn-info" value="삭제" id="deleteBtn"/>
    </div>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
</div></div>

</div>

</div>
    
    
    
                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
            
        </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>





		
                        

    
