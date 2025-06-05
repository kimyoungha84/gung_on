<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.InquiryFilteringInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<% request.setCharacterEncoding("UTF-8"); 
   request.setAttribute("currentMenu", "inquiry");
   
	   
%>


 <%
 if( session.getAttribute("userData") != null ){
    InquiryFilteringInfo ifi = new InquiryFilteringInfo();
    CsService css = new CsService();

    	
    
    
    String userId = ((MemberDTO)session.getAttribute("userData")).getId();
	
    // --- 페이지네이션 처리 ---
    int pageSize = 5;
    int rowCounts = css.totalUserInquiries(userId);

    PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);


    // 페이지네이션 HTML 생성
    String paginationHtml = paginationBuilder.build(request.getRequestURI());

    int currentPage = paginationBuilder.getCurrentPage();
    int startNum = (currentPage - 1) * pageSize + 1;
    int endNum = currentPage * pageSize;

    // 시작/끝번호 fi에 세팅
    ifi.setStartNum(startNum);
    ifi.setEndNum(endNum);

    List<InquiryDTO> inquiryList = css.searchUserInquiries(ifi, userId);

    // 페이지에 데이터 바인딩
    pageContext.setAttribute("paginationHtml", paginationHtml);
    pageContext.setAttribute("inquiryList", inquiryList);
    pageContext.setAttribute("paginationHtml", paginationHtml);
    pageContext.setAttribute("ifi", ifi);
    pageContext.setAttribute("rowCounts", rowCounts);
    pageContext.setAttribute("currentPage", currentPage);
    pageContext.setAttribute("pageSize", pageSize);
 }
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 1:1문의 - 나의문의</title>
  <link rel="stylesheet" type="text/css" href="cs_notice.css" />
  

  <style>

  </style>
  
<script type="text/javascript">


</script> 
<script>
function redirectToLoginPage() {
    // 현재 페이지의 URL을 가져와서 redirectUrl 파라미터로 추가
    const currentUrl = window.location.href;
    window.location.href = "/Gung_On/login/login.jsp?redirectUrl=" + encodeURIComponent(currentUrl);
}
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
   <h2 style="font-size: 35px; font-weight: bold;">나의 1:1문의</h2><br>
   
   
   <div class="sub_con_wrap pt0" id="sub_con_wrap">
   
   <div id="tabDiv" style="" class="tabDiv">
		<div class="reservation_tab2 sub_tab">
	</div>
	<div class="swiper-button-next noti_next"></div>
	<div class="swiper-button-prev noti_prev"></div></div><!-- [E] reservation_tab -->
 <div class="sub_con_section">
	<!-- [S] condition_wrap -->
	<c:if test="${not empty userData}">
	<div class="condition_wrap">
		<div class="left">
			<div class="count_wrap">전체: <fmt:formatNumber value="${rowCounts}" pattern="#.###"/>건</div>
		</div>
		<%-- <form id="searchInfoFrm" method="GET" action="${pageContext.request.requestURI}">
			<input type="hidden" name="searchHid" value="true"/>
			<div class="right">
				<div class="sch_condition_wrap">
					<select name="searchCategory" id="schFld" title="구분">
						<option value="category_title">제목</option>
						<option value="category_content">내용</option>
		            </select>
					<input type="text" name="searchText" id="searchText" value="" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요.">
					<button type="submit" id="searchBtn" class="">검색</button>
				</div>
			</div>
		</form> --%>
	</div>
	</c:if>
	<!-- [E] condition_wrap -->
	<div class="wrap">
		<c:choose>
		<c:when test="${not empty userData}">
		
		<table class="table bd_table th_c txt_s m_layout">
			<caption></caption>
			<colgroup>
				  <col style="width: 8%" class="m_none"/>
   				  <col style="width: 60%"/>
    			  <col style="width: 8%" class="m_none"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="m_none">등록일</th>
					<th scope="col">문의 내용</th>
					<th scope="col" class="m_none">처리상태</th>
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
    <!-- 데이터가 있을 경우 -->
			<c:choose>
			    <c:when test="${not empty inquiryList}">
			        <c:forEach var="iDTO" items="${inquiryList}" varStatus="i">
			            <tr>
			                <td class="m_none">
			                    <fmt:formatDate value="${iDTO.inquiry_regDate}" pattern="yyyy-MM-dd " />
			                </td>
			                <td class="tit">
			                    <a href="notice_detail.jsp?num=${iDTO.inquiry_num}" class="ellipsis txt_line1" title="${iDTO.inquiry_content}">
			                        ${iDTO.inquiry_content}
			                    </a>
			                </td>
			                <td class="m_none">
			                    ${iDTO.answer_status ? '답변완료' : '처리중'}
			                </td>
			            </tr>
			        </c:forEach>
			    </c:when>
			    
			    <c:otherwise>
			        <tr>
			            <td colspan="3" style="text-align:center; padding:20px; font-size:24px; font-weight:bold;">
			                <div style="display: flex; justify-content: center; align-items: center; height: 200px; font-size:24px; font-weight:bold;">
			                    문의 내용이 존재하지 않습니다.
			                </div>
			            </td>
			        </tr>
			    </c:otherwise>
			</c:choose>
			
				</tbody>
		</table>
		</c:when>
		
		  <c:otherwise>
<div class="sub_con_wrap pt0" style="display: flex; justify-content: center; align-items: flex-start; height: 100vh; padding-top: 50px;">
    <div class="warning" style="width: 800px; height: 500px; display: flex; flex-direction: column; justify-content: flex-start; align-items: center; text-align: center;">
        <h2 style="font-size: 30px; margin: 0; color: #191D1F">해당 서비스는 로그인이 필요합니다.</h2>
        <!-- 로그인버튼 클릭 시 로그인페이지로 이동 (미구현) -->
        <input type="button" onclick="redirectToLoginPage()" value="로그인하러가기" id="loginBtn" style="width: 200px; height: 70px; color:white; background-color: #323247; font-size: 20px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease, color 0.3s ease; margin-top: 40px;" />
    </div>  
</div>



    </c:otherwise>
</c:choose>
			
			
			
			
			 
			 
			
			

				
				
				
				
		</div>
</div>

</div>

<c:if test="${not empty userData}">
<div class="paging_wrap flex flex_jc mt40" style="background-color: #e5e5e5; margin-top: 10px; height: 120px; border-bottom: solid 2px #333; position: relative; justify-content: center;">
    <div class="paging">
        <%= pageContext.getAttribute("paginationHtml") %>
    </div>
    <button type="button" id="registerBtn" style="width:100px; height:40px; background-color: #323247; color: white; font-size: 14px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease, color 0.3s ease; 
        position: absolute; top: 20px; right: 20px; ">
        문의등록
    </button>
    
    <script>
    document.getElementById('registerBtn').addEventListener('click', function () {
        window.location.href = 'inquiry_write.jsp'; // 이동할 JSP 경로
    });
	</script>
	
</div>
</c:if>

	</div>

	<!-- [E] paging_wrap -->



<%@ include file="side.jsp" %>

  <br>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
