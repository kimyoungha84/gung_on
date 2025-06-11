<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="kr.co.gungon.course.CourseDTO"%>
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



<%
    request.setCharacterEncoding("UTF-8");

    FilteringInfo fi = new FilteringInfo();
    CourseService cs = new CourseService();

    String searchTextParam = request.getParameter("searchText");
    String searchCategoryParam = null;
    String transParam = null;

    if (request.getParameter("searchCategory") != null) {
        String tempParam = request.getParameter("searchCategory");

        switch (tempParam) {
            case "title":
                transParam = "title";
                searchCategoryParam = "course_title";
                break;
            case "content":
                transParam = "content";
                searchCategoryParam = "course_content";
                break;
            case "member_id":
                transParam = "member_id";
                searchCategoryParam = "member_id";
                break;
        }
    }

    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

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

    fi.setSearchText(searchTextParam);
    fi.setSearchCategory(searchCategoryParam);
    fi.setStartDate(startDate);
    fi.setEndDate(endDate);

    int pageSize = 10;
    int rowCounts = cs.totalCourseCount(fi);

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

    // 시작/끝번호 fi에 세팅
    fi.setStartNum(startNum);
    fi.setEndNum(endNum);

    List<GungDTO> gungList = null;
    try {
        gungList = cs.getAllGungs(); 
    } catch (Exception e) { 
        e.printStackTrace(); 
    }//end catch
    
    pageContext.setAttribute("gungList", gungList);

    String gungIdParam = request.getParameter("gung_id");
    int selectedGungId = -1; 

    if (gungIdParam != null && !gungIdParam.isEmpty()) {
        try {
            selectedGungId = Integer.parseInt(gungIdParam);
        } catch (NumberFormatException e) {
     	   e.printStackTrace();
        }//end catch
    }//end if
     
    int finalSelectedGungId = -1; 

    if (gungList != null && !gungList.isEmpty()) {
        boolean paramGungIdIsValidInList = false;
        if (selectedGungId != -1) { 
            for (GungDTO gung : gungList) {
                if (gung.getGung_id() == selectedGungId) {
                    paramGungIdIsValidInList = true;
                    break;
                }//end if
            }//end for
        }//end if

        if (paramGungIdIsValidInList) {
            finalSelectedGungId = selectedGungId;
        } else {
            finalSelectedGungId = gungList.get(0).getGung_id();
        }//end else
    }//end if
     pageContext.setAttribute("selectedGungId", finalSelectedGungId);
     
    List<CourseDTO> courseList = null;
    
    if (finalSelectedGungId != -1) {
        try {
            // 검색어가 없으면 필터링 없이 목록 조회
            if ((fi.getSearchText() == null || fi.getSearchText().isEmpty()) &&
                (fi.getStartDate() == null && fi.getEndDate() == null) &&
                (fi.getSearchCategory() == null || fi.getSearchCategory().isEmpty())) {

                courseList = cs.getCoursesByGungId(finalSelectedGungId);

            } else { 
                // 검색어 있으면 필터링된 목록 조회
                courseList = cs.getFilteredCoursesByGungId(finalSelectedGungId, fi);
            }

            if (courseList == null) {
                courseList = new ArrayList<>();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    	 
    FilteringInfo filteringInfo = (FilteringInfo) request.getAttribute("filteringInfo");

    // 페이지에 데이터 바인딩
    pageContext.setAttribute("courseList", courseList);
    pageContext.setAttribute("paginationHtml", paginationHtml);
    pageContext.setAttribute("fi", fi);
    pageContext.setAttribute("rowCounts", rowCounts);
    pageContext.setAttribute("currentPage", currentPage);
    pageContext.setAttribute("pageSize", pageSize);
%>
        
        <style>
        
        
        .sel_st{
  		line-height: normal;  /* line-height 초기화 */
  		padding: .6em .3em;  /* 여백과 높이 결정 */
  		border: 0;
  		box-shadow: rgba(14, 63, 126, 0.06) 0px 0px 0px 1px, rgba(42, 51, 70, 0.03) 0px 1px 1px -0.5px, rgba(42, 51, 70, 0.04) 0px 2px 2px -1px, rgba(42, 51, 70, 0.04) 0px 3px 3px -1.5px, rgba(42, 51, 70, 0.03) 0px 5px 5px -2.5px, rgba(42, 51, 70, 0.03) 0px 10px 10px -5px, rgba(42, 51, 70, 0.03) 0px 24px 24px -8px;
		margin-bottom: 15px;
		}
        
		#datatablesSimple th:nth-child(2), 
		#datatablesSimple td:nth-child(2) {
    		width: 50%;  /* 두 번째 열: 제목 (넓게) */
		}

		#datatablesSimple th:nth-child(3), 
		#datatablesSimple td:nth-child(3) {
    		width: 10%;  /* 세 번째 열: 작성자 (좁게) */
		}
		        
     	/* 제목 a태그 스타일 제거 */
		#datatablesSimple td:nth-child(2) a {
    		text-decoration: none; /* 밑줄 제거 */
  		  color: inherit;         /* 파란색 제거 */
    		font-weight: normal;
   		 cursor: pointer;
   		 transition: all 0.2s;
		}

		/* hover 시 효과 */
		#datatablesSimple td:nth-child(2) a:hover {
 		   color: #007bff;         /* 파란색 */
 		   font-weight: bold;
  		  text-decoration: none;
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
		.card-body{
  		
  		min-width: 1600px; 
  		
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



 document.getElementById("searchBtn").addEventListener("click", function(e) {
	    const form = document.getElementById("searchInfoFrm");
	    let actionBase = form.getAttribute("action");

	    // ? 있으면 쿼리 제거
	    if(actionBase.indexOf("?") !== -1) {
	        actionBase = actionBase.split("?")[0];
	    }

	    const searchText = form.searchText.value.trim();
	    const searchCategory = form.searchCategory.value;
	    const startDate = form.startDate.value.trim();
	    const endDate = form.endDate.value.trim();
	    const gungId = document.getElementById("gung_id_select").value;

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

	    if (gungId) {
	        queryParams.push("gung_id=" + encodeURIComponent(gungId));
	    }

	    const queryString = "?" + queryParams.join("&");
	    form.setAttribute("action", actionBase + queryString);
	    form.submit();
	});



});
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



<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

    <main>
<div id="layoutSidenav_content">
        <div class="container-fluid px-4">
            <h2 class="mt-4">코스 관리</h2>
            <hr/>
                        
<div class="card m-3">
  <!-- <div class="card-header">
  </div> -->
  
  <div class="card-body">
  <h2>사용자 추천 코스 관리</h2>
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
						        <select id="category" class="form-select form-select-sm w-auto" name="searchCategory" style="display: inline;">
    									<option value="title" ${'title' == param.searchCategory ? 'selected' : ''}>제목</option>
    									<option value="content" ${'content' == param.searchCategory ? 'selected' : ''}>내용</option>
    									<option value="member_id" ${'member_id' == param.searchCategory ? 'selected' : ''}>작성자</option> <!-- 추가 -->
								</select>
						 </div>
						    
						    
						    
	<input style="width: 300px;" class="datatable-input" placeholder="입력해주세요" type="search" title="Search within table" aria-controls="datatablesSimple" name="searchText" value="${param.searchText != null ? param.searchText : ''}">
    <input type="button" id="searchBtn" value="검색" class="btn btn-success"/>
        </div>
</form>
</div>

<form method="GET" action="course_main.jsp" style="display: flex; justify-content: flex-end; margin-top: 10px;">
<select class="sel_st" name="gung_id" id="gung_id_select" 
                        onchange="this.form.submit()"> 
                   
                   <c:if test="${not empty gungList}"> 
                       
                       <c:forEach items="${gungList}" var="gung"> 
                            <option value="${gung.gung_id}" 
                                    <c:if test="${selectedGungId == gung.gung_id}">selected</c:if>>
                                ${gung.gung_name} 
                            </option>
                       </c:forEach>
                   </c:if>

                   <c:if test="${empty gungList}">
                        <option value="-1">궁 선택</option> 
                   </c:if>
                </select>
</form>



<div class="datatable-container">
<form id="frm" method="post">
                     <table id="datatablesSimple" class="table table-striped">
									    <thead>
									        <tr>
									            <th>번호</th>
									            <th>제목</th>
									            <th>작성자</th>
									            <th>등록일</th>
									        </tr>
									    </thead>
									    <tfoot>
									        <tr>
									            <th>번호</th>
									            <th>제목</th>
									            <th>작성자</th>
									            <th>등록일</th>
									        </tr>
									    </tfoot>
									    <tbody>
									    	<c:forEach var="cDTO" items="${courseList}" varStatus="i">
    											<tr>
      												<td>${i.count}</td> <!-- 번호 계산 -->
    											    <td>
    											    	<a href="admin_course_detail.jsp?courseNum=${cDTO.course_Num}" class="course-detail-link" onclick="window.open(this.href, 'detail', 'width=850,height=600'); return false;">${cDTO.course_Title}</a>
    											    </td>
    											    <td>${cDTO.member_Id}</td>
    											    <td><fmt:formatDate value="${cDTO.course_Reg_Date}" pattern="yyyy-MM-dd"/></td>
    											</tr>
											</c:forEach>
									    </tbody>
									</table>
                               		 </form>
                                
                                

</div>
<div class="datatable-bottom" style="display: flex; align-items: center;">
 <%= paginationHtml %>
    <div style= "margin-left: auto;">
    </div>
    <nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
</div></div>

</div>


</div>
    
    
    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    
</div>

<%@ include file="/admin/common/footer.jsp" %>
  </div>
  </main>
		
    
    
    
    
    
    

    
    
                   