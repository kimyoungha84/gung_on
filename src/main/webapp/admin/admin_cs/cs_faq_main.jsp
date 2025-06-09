<%@page import="kr.co.gungon.cs.FaqDTO"%>
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
    			searchCategoryParam = "faq_title";
    			break;
    	case "content" :
    			transParam = "content";
				searchCategoryParam = "faq_content";
				break;
    	}
    	
    }
    	
    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

    // 검색 버튼을 눌렀다면 (searchHid는 숨은 input)
    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "title".equals(categoryValue) ? "faq_title" : "faq_content";
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
    int rowCounts = css.totalFaqCount(fi);

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

    List<FaqDTO> faqList = css.searchFaq(fi);

    // 페이지에 데이터 바인딩
    pageContext.setAttribute("faqList", faqList);
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
      alert("삭제할 FAQ를 선택하세요.");
      return;
    }

    const faqNumList = Array.from(checkedBoxes).map(cb => {
      return cb.closest("tr").children[1].textContent.trim(); // 두 번째 칸이 번호
    });
    
    const confirmDelete = confirm(`선택한 FAQ를 삭제하시겠습니까?`);
    if (!confirmDelete) return;

    console.log("삭제할 faq_num 목록:", faqNumList);
    
    // Ajax 요청
    $.ajax({
      url: "faqdelete_process.jsp",  // 서버로 데이터를 전송할 URL
      type: "POST",               // 요청 방식 (POST)
      data: {                     // 서버로 전송할 데이터
        faqNumList: JSON.stringify(faqNumList) // 배열을 JSON 문자열로 변환하여 전송
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

function openFaqPopup(faqNum) {
    const url = "faq_preview_popup.jsp?num=" + encodeURIComponent(faqNum);
    const options = "width=1200,height=800,scrollbars=yes,resizable=yes";
    window.open(url, "faqPopup", options);
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





<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">고객센터 관리</h2>
            <hr/>
			
            <!-- 여기부터 콘텐츠 영역 -->
            <div class="card m-3">
  <!-- <div class="card-header"> -->
  
    <!-- <ul class="nav nav-tabs card-header-tabs" role="tablist">
      <li class="nav-item" role="presentation">
        <a class="nav-link" data-bs-toggle="tab" href="#tab1" role="tab" aria-selected="false">공지사항</a>
      </li>
      <li class="nav-item" role="presentation">
        <a class="nav-link active" data-bs-toggle="tab" href="#tab2" role="tab" aria-selected="true" tabindex="-1">FAQ</a>
      </li>
      <li class="nav-item" role="presentation">
        <a class="nav-link" data-bs-toggle="tab" href="#tab3" role="tab" aria-selected="false" tabindex="-1">1:1문의</a>
      </li>
    </ul> -->
 <!--  </div> -->
  <div class="card-body">
  <h2>FAQ관리</h2>
   <!--  <div class="tab-content">
      <div class="tab-pane fade" id="tab1" role="tabpanel">
        <p>공지사항</p>
      </div>
      <div class="tab-pane fade show active" id="tab2" role="tabpanel">
        <p>FAQ</p>
      </div>
      <div class="tab-pane fade" id="tab3" role="tabpanel">
        <p>1:1문의</p>
      </div>
    </div> -->
    <div class="datatable-wrapper no-footer sortable searchable fixed-columns">
    
<div class="datatable-top" >

<form method="POST" id="searchInfoFrm" action="${pageContext.request.requestURI}">
<input type="date" id="startDate" name="startDate" value="${param.startDate != null ? param.startDate : ''}"/><span style="font-weight: bold;"> - </span>
<input type="date" id="endDate" name="endDate" value="${param.endDate != null ? param.endDate : ''}"/>
<input type="hidden" name="searchHid" value="true"/>
<div class="datatable-search" style="width: 300px; height : 69px; display: flex; align-items: center;  gap: 8px;" >
	<div class="dataTable-category-filter ms-2">
						        <select id="category" class="form-select form-select-sm w-auto" name="searchCategory">
						            <option value="title" ${'title' == param.searchCategory ? 'selected' : ''}>제목</option>
									<option value="content" ${'content' == param.searchCategory ? 'selected' : ''}>내용</option>
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
									    	<c:forEach var="fDTO" items="${ faqList }" varStatus="i">
											<tr>
											<td><input type="checkbox" name="rowCheck" class="rowCheck"></td> <!-- 개별 체크박스 -->
											<%-- <td><c:out value="${ totalCount - (fi.currentPage -1) * pageScale - i.index }"/></td> --%>
											<td><c:out value="${ fDTO.faq_num }"/></td>
											<td>
											  <a href="#" onclick="openFaqPopup(${fDTO.faq_num}); return false;">
											    <span><c:out value="${ fDTO.faq_title }"/></span>
											  </a>
											</td>
											<td><fmt:formatDate value="${ fDTO.faq_regDate }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
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
    <input type="button" style="width:80px; height: 40px;" class="btn btn-success" value="작성" id="writeBtn" onclick="location.href='cs_faq_write.jsp';"/>
    <input type="button" style="width:80px; height: 40px;" class="btn btn-info" value="삭제" id="deleteBtn"/>
    </div>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
</div></div>

</div>

</div>


    
    
    

   
                            
                               
                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script> -->
      <!--   <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script> -->
        <!-- <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script> -->
    
            <!-- 또는 직접 작성해도 됨 -->
        </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>


		
                        


