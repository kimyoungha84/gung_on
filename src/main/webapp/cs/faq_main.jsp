<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<% request.setCharacterEncoding("UTF-8"); 
request.setAttribute("currentMenu", "faq");
%>

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
    	

    // 검색 버튼을 눌렀다면 (searchHid는 숨은 input)
    if (request.getParameter("searchHid") != null) {
        String categoryValue = request.getParameter("searchCategory");
        searchCategoryParam = "category_title".equals(categoryValue) ? "faq_title" : "faq_content";
        transParam = "category_title".equals(categoryValue) ? "title" : "content";
        searchTextParam = request.getParameter("searchText").trim();
    }


    // FilteringInfo 세팅
    fi.setSearchText(searchTextParam);
    fi.setSearchCategory(searchCategoryParam);

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



<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - FAQ</title>
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/common.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/reset.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/layout.css" />
  

  <style>
    /* 이미지 정중앙 고정 및 반투명 처리 */
    .background-image {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0.15;
      z-index: -1;
      width: 850px; /* 필요에 따라 조절 */
      height: auto;
    }
   .lnb_wrap {
  	/* position: fixed; */
  	position: absolute;
  	top: 300px; /* 상단에서 거리 조절 */
  	left: 65px;
  	width: 300px; /* 원하는 너비 */
  	z-index: 1000; /* 다른 요소보다 위로 오도록 */
	}

  </style>
  
  
  
  
</head>

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <div class="mb-4" style="width: 1000px; margin: 150px auto 0 auto;">
   <h2 style="font-size: 35px; font-weight: bold;">자주묻는 질문</h2><br>

<script type="text/javascript">
</script><!-- [S] sub_con_wrap -->
						<div class="sub_con_wrap pt0" id="sub_con_wrap">
							


<!-- Empty Layout -->
<script type="text/javascript">

//열린 FAQ 항목을 추적할 변수
let openItem = null;

// 클릭된 FAQ 항목에 대해 답변을 보이거나 숨기는 함수
function toggleAnswer(element, event) {
    event.preventDefault(); // 페이지 리로드 방지

    var parentItem = element.closest('.q_item'); // 클릭한 항목의 부모 <li> 요소

    // 이미 열린 항목이 있고, 그 항목이 현재 클릭된 항목이 아니면 닫기
    if (openItem && openItem !== parentItem) {
        openItem.classList.remove('open');
    }

    // 현재 클릭된 항목을 'open' 상태로 토글
    parentItem.classList.toggle('open');

    // 열린 항목을 추적
    openItem = parentItem.classList.contains('open') ? parentItem : null;
}


</script>

<!-- [S] sub_con_section -->
<div class="sub_con_section">
	<!-- //ucfaq1_wrap -->
	<!-- [S] condition_wrap -->
	<div class="condition_wrap">
		<div class="left">
			<div class="count_wrap">전체: <fmt:formatNumber value="${rowCounts}" pattern="#.###"/>건</div>
		</div>
		<div class="right">
			<form id="searchInfoFrm" method="GET" action="${pageContext.request.requestURI}">
			<input type="hidden" name="searchHid" value="true"/>
			<div class="right">
				<div class="sch_condition_wrap">
					<select name="searchCategory" id="schFld" title="구분">
						<option value="category_title" ${param.searchCategory == 'category_title' ? 'selected' : ''}>제목</option>
						<option value="category_content" ${param.searchCategory == 'category_content' ? 'selected' : ''}>내용</option>
		            </select>
					<input type="text" name="searchText" id="searchText" value="${param.searchText != null ? param.searchText : ''}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요.">
					<button type="submit" id="searchBtn" class="">검색</button>
				</div>
			</div>
			</form>
			</div>
		</div>
	<!-- [E] condition_wrap -->

	<div class="txt_section_tit">FAQ</div>
	<div class="bd_wrap">
		<ul class="q_list">
			<!-- <li class="q_item open">
					<div class="q_box">
						<a href="#" class="box_inn ic_q" onclick="fn_increment('qna','20231218113029485809',this);" title="답변 열기">
							<span class="ic">Q</span>
							<span class="txt">
								<div class="tit_txt">조선왕릉 중 일부를 공개하지 않는 이유</div>
							</span>
						</a>
					</div>
					<div class="a_box">
						<div class="box_inn ic_a_yes">
							<span class="ic">A</span>
							<span class="txt">
								조선왕릉 중 일부를 공개제한 하는 것은 국가유산&nbsp;보존과 훼손 방지를 위해서이며, 구체적인 사유는 다음과 같습니다.<br>
 - 사유지 내에 있어서 상시 관람을 위한 진입 공간이 확보되지 않았거나, 주변의 장애물 등으로 인하여 접근이 어려운 경우<br>
 - 고건물, 석조물, 전통 조경물, 관람 시설물, 소방 시설물의 수리 혹은 복원공사가 전면적이고 장기간 시행되어 관람 환경에 영향을 미칠 경우<br>
 - 관리 면적이 좁아서 관람 환경을 마련할 수 없는 경우<br> - 자연 생태 환경(동물, 식생, 수문, 토양 등) 보존을 위해 필요한 경우 등</span>
						</div>
					</div>
				</li>
			<li class="q_item">
					<div class="q_box">
						<a href="#" class="box_inn ic_q" onclick="" title="답변 열기">
							<span class="ic">Q</span>
							<span class="txt">
								<div class="tit_txt">입장권을 미리 사두면, 입장 시간이 지나도 입장이 가능한가요?</div>
							</span>
						</a>
					</div>
					<div class="a_box">
						<div class="box_inn ic_a_yes">
							<span class="ic">A</span>
							<span class="txt">
								입장권을 소지하고 있더라도, 입장 시간이 지난 후에는 입장 및 환불이 불가합니다.</span>
						</div>
					</div>
				</li> -->
				
				<c:forEach var="fDTO" items="${ faqList }" varStatus="i">
				<li class="q_item">
				    <div class="q_box">
				        <a href="#" class="box_inn ic_q" onclick="toggleAnswer(this, event);" title="답변 열기">
				            <span class="ic">Q</span>
				            <span class="txt">
				                <div class="tit_txt">${ fDTO.faq_title }</div>
				            </span>
				        </a>
				    </div>
				    <div class="a_box">
				        <div class="box_inn ic_a_yes">
				            <span class="ic">A</span>
				            <span class="txt" id="answer-1"></span>${ fDTO.faq_content }
				        </div>
				    </div>
				</li>
				</c:forEach>
				
				
			</ul>
	</div>

	<!-- [S] paging_wrap -->
	<div class="paging_wrap flex flex_jc mt40">
		<div class="paging">
		
			<%= paginationHtml %>
			</div>
	</div>
	<!-- [E] paging_wrap -->
<!-- //paginate -->
</div>
<!-- [E] sub_con_section -->
							</div>
						<!-- [E] sub_con_wrap -->
					</div>
					



<%@ include file="side.jsp" %>




  <br>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
