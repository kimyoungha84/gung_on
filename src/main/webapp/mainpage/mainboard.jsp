<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.item-link {
  display: inline-block;         /* block or inline-block 필수 */
  max-width: 400px;              /* 너비는 원하는 대로 지정 */
  white-space: nowrap;           /* 줄바꿈 없이 한 줄 */
  overflow: hidden;              /* 넘치는 텍스트 숨김 */
  text-overflow: ellipsis;       /* 말줄임표(...) 처리 */
  vertical-align: middle;        /* 정렬 보정 (선택 사항) */
}
</style>



<% request.setCharacterEncoding("UTF-8");

CsService css = new CsService();


//아이템 가져올범위 아이템은 날짜순으로 desc 다오에서 조회
int startNum = 1;
int endNum = 7;
FilteringInfo fi = new FilteringInfo();
fi.setStartNum(startNum);
fi.setEndNum(endNum);


//서비스로 아이템 가져오기
List<NoticeDTO> noticeList = css.searchNotice(fi);
request.setAttribute("noticeList", noticeList);

List<FaqDTO> faqList = css.searchFaq(fi);
request.setAttribute("faqList", faqList);


%>


  <div class="notice-faq-page">
    <div class="notice-faq-container">

      <!-- 공지사항 영역 -->
      <div class="notice-section">
        <div class="section-title">공지사항</div>
        <ul class="item-list">
          <!-- <li><a href="#" class="item-link">［행사］ 공정정책 공연 프로그램 운영</a><span class="item-date">2025.05.02</span></li>
          <li><a href="#" class="item-link">［설문조사］ 신규 지정일 기념일 명칭은?</a><span class="item-date">2025.05.01</span></li>
          <li><a href="#" class="item-link">경복궁 안전점검의 날 안내</a><span class="item-date">2025.05.01</span></li>
          <li><a href="#" class="item-link">2025년 5월 금농 제향 일정 안내</a><span class="item-date">2025.04.30</span></li>
          <li><a href="#" class="item-link">5월 덕수궁 광무수문장 교대의식 안내</a><span class="item-date">2025.04.30</span></li>
          <li><a href="#" class="item-link">2025년 경복궁 청화루 특별관람 안내</a><span class="item-date">2025.04.29</span></li>
          <li><a href="#" class="item-link">창경궁 전환 복구 완료 안내</a><span class="item-date">2025.04.28</span></li> -->
        <c:forEach var="nDTO" items="${ noticeList }" varStatus="i">
          <li><a href="/Gung_On/cs/notice_detail.jsp?num=${ nDTO.notice_num }" class="item-link">${ nDTO.notice_title }</a>
          <span class="item-date"><fmt:formatDate value="${ nDTO.notice_regDate }" pattern="yyyy-MM-dd"/></span></li>
		</c:forEach>
        </ul>
      </div>

      <!-- 자주 묻는 질문 영역 -->
      <div class="faq-section">
        <div class="section-title">자주묻는 질문</div>
        <ul class="item-list">
          <c:forEach var="fDTO" items="${ faqList }" varStatus="i">
          <li><a href="faq_main.jsp" class="item-link">${ fDTO.faq_title }</a>
          <span class="item-date"><fmt:formatDate value="${ fDTO.faq_regDate }" pattern="yyyy-MM-dd"/></span></li>
		</c:forEach>
        </ul>
      </div>

    </div>
  </div>

