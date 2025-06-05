<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); 
	request.setAttribute("currentMenu", "notice");
%>


 <%
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
    	
    // 검색 버튼을 눌렀다면 (searchHid는 숨은 input)
    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "category_title".equals(categoryValue) ? "notice_title" : "notice_content";
        transParam = "category_title".equals(categoryValue) ? "title" : "content";
        searchTextParam = request.getParameter("searchText").trim();
    }


    // FilteringInfo 세팅
    fi.setSearchText(searchTextParam);
    fi.setSearchCategory(searchCategoryParam);

    // --- 페이지네이션 처리 ---
    int pageSize = 12;
    int rowCounts = css.totalNoticeCount(fi);

    PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);

    // 검색 파라미터 유지용 쿼리스트링
    StringBuilder extraParams = new StringBuilder();
    if (searchCategoryParam != null && !searchCategoryParam.isEmpty()) {
        if (extraParams.length() > 0) extraParams.append("&");
        extraParams.append("searchCategory=").append(transParam);
    }
    if (searchTextParam != null && !searchTextParam.isEmpty()) {
        extraParams.append("searchText=").append(java.net.URLEncoder.encode(searchTextParam, "UTF-8"));
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
<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 공지사항 - 목록</title>
  <link rel="stylesheet" type="text/css" href="cs_notice.css" />
  

  <style>
    /* 이미지 정중앙 고정 및 반투명 처리 */

  </style>
  
<script type="text/javascript">
window.onpageshow = function(event) {
    if (event.persisted) {
        // 페이지가 캐시로 로드되었을 경우 새로고침
        window.location.reload();
    }
};

</script> 
  
  
  
</head>

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="main" style="width: 1000px; margin: 150px auto 0 auto;">
   <h2 style="font-size: 35px; font-weight: bold;">공지사항</h2><br>
   
   
   <div class="sub_con_wrap pt0" id="sub_con_wrap">
   
   <div id="tabDiv" style="" class="tabDiv">
		<div class="reservation_tab2 sub_tab">
	</div>
	<div class="swiper-button-next noti_next"></div>
	<div class="swiper-button-prev noti_prev"></div></div><!-- [E] reservation_tab -->
 <div class="sub_con_section">
	<!-- [S] condition_wrap -->
	<div class="condition_wrap">
		<div class="left">
			<div class="count_wrap">전체: <fmt:formatNumber value="${rowCounts}" pattern="#.###"/>건</div>
		</div>
		<form id="searchInfoFrm" method="GET" action="${pageContext.request.requestURI}">
			<input type="hidden" name="searchHid" value="true"/>
			<div class="right">
				<div class="sch_condition_wrap">
					<select name="searchCategory" id="schFld" title="구분">
						<option value="category_title" ${param.searchCategory == 'category_title' ? 'selected' : ''}>제목</option>
						<option value="category_content" ${param.searchCategory == 'category_content' ? 'selected' : ''}>내용</option>
		            </select>
					<input type="text" name="searchText" id="searchText" 
       				value="${param.searchText != null ? param.searchText : ''}" 
       				title="검색어를 입력해주세요" 
      				placeholder="검색어를 입력해주세요.">
					<button type="submit" id="searchBtn" class="">검색</button>
				</div>
			</div>
		</form>
	</div>
	<!-- [E] condition_wrap -->
	<div class="wrap">
		<table class="table bd_table th_c txt_s m_layout">
			<caption></caption>
			<colgroup>
				  <col style="width: 8%" class="m_none"/>
   				  <col style="width: 60%"/>
    			  <col style="width: 15%"/>
    			  <col style="width: 8%" class="m_none"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="m_none">번호</th>
					<th scope="col">제목</th>
					<th scope="col">등록일</th>
					<th scope="col" class="m_none">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!-- <tr class="notice_tr">
      				<td class="m_none"><span class="notice">공지</span></td>
      				<td class="tit">
        			<a href="#;" id="noticeItem" class="ellipsis txt_line1" onclick="fn_goView('20250509162600580200')" title="창경궁 문정전 일부 관람 제한 공지(5.9.일)">
         			 창경궁 문정전 일부 관람 제한 공지(5.9.일)
        			</a>
      				</td>
				    <td class="info first">2025-05-09</td>
				    <td class="m_none">227</td>
    				</tr> -->
				
				
				<!-- <tr>
					<td class="m_none">3021</td>
					<td class="tit">
					<a href="#;" class="ellipsis txt_line1" onclick="fn_goView('20250428143807067874')" title="창경궁 전화 불통 안내(4.28.월) ">
					창경궁 전화 불통 안내(4.28.월) </a>
					</td>
					<td class="info first">2025-04-28</td>
					<td class="m_none">125</td>
				</tr> -->
				
				<c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
					<tr>
					<%-- <td><c:out value="${ totalCount - (fi.currentPage -1) * pageScale - i.index }"/></td> --%>
					<td class="m_none">${ rowCounts - (currentPage - 1) * pageSize - i.index }</td>
					<td class="tit">
					<a href="notice_detail.jsp?num=${ nDTO.notice_num }" class="ellipsis txt_line1" title="${nDTO.notice_title} ">
					${nDTO.notice_title }</a>
					</td>
					<td class="info first"><fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd "/></td>
					<td class="m_none">${ nDTO.notice_views }</td>
					</tr>
				</c:forEach>
				
				
				
				
				</tbody>
		</table>
		</div>
</div>

</div>

<div class="paging_wrap flex flex_jc mt40">
		<div class="paging">
		<%= paginationHtml %>
		
			</div>
	</div>
	</div>
	<!-- [E] paging_wrap -->



<%@ include file="side.jsp" %>

  <br>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
