<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람규칙</title>

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/course/css/course_rule_style.css" />
  <c:import url="/common/jsp/external_file.jsp"/>

<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <main>

    
    <!-- 사이드바와 콘텐츠를 감싸는 container div -->
    <!-- sub-header와 container 사이에 margin-top 또는 sub-header에 margin-bottom으로 간격 조절 -->
    <div class="container">
        <div class="sidebar">
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/course/course_rule.jsp" class="active">관람규칙</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course_time.jsp">관람시간</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course.jsp">관람코스</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/users_course.jsp">사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>

        <article class="content">
            <h1>관람규칙</h1>

            <!-- 기존 rule-intro p 태그는 삭제합니다. -->

            <!-- sub_con_section 내용을 content 영역 안으로 이동 -->
            <div class="sub_con_section">
                 <div class="box_wrap ">
                      <div class="txt_wrap">
                           <div class="txt_section_tit">관람규칙</div> 관람하시면서 꼭 준수해 주셔야 할 사항입니다<br> 모두에게 기분좋은 관람이 될 수 있도록 협조하여 주시기 바랍니다
                       </div>
                       <img src="${pageContext.request.contextPath}/course/course_rule_img/course_rule.jpg" alt="관람규칙 아이콘">
                 </div>
             </div>
            <!-- sub_con_section 이동 끝 -->


            <div class="quick-links">
                <a href="#section1">제1장 총칙</a>
                <a href="#section2">제2장 공개</a>
                <a href="#section3">제3장 안내해설 등 서비스</a>
                <a href="#section4">제4장 매·수표</a>
                <a href="#section5">제5장 촬영</a>
                <a href="#section6">제6장 장소사용허가</a>
                <a href="#section7">제7장 기타</a>
            </div>
			<br>
            <br>


            <section id="section1" class="section_fix">
                <h2>제1장 총칙</h2>
                <h3>제1조(목적)</h3>
                <div class="box_st">
                <p>
                    이 규정은「문화유산의 보존 및 활용에 관한 법률」제48조 및 제49조, 「자연유산의 보존 및 활용에 관한 법률」제23에 따라 4대궁·종묘관리소, 세종대왕유적관리소 및 조선왕릉지구관리소(이하 “궁능유적기관”이라 한다)의 공개, 관람, 안내해설, 촬영 및 장소사용허가 등에 관한 사항을 규정함을 목적으로 한다.
                </p>
                </div>
                <br>
                <h3>제2조(정의)</h3>
                <div class="box_st">
                <ul> 
				<li style="font-size: 18px; font-weight: bold;">이 규정에서 사용하는 용어의 정의는 다음과 같다.</li>
				</ul>
				<ul> 
				<li class="sec_li">1. “일반공개”란 일일 공개시간 중 공개지역을 개방하는 것을 말한다.</li> 
				<li class="sec_li">2. “특별공개”란 국가유산&nbsp;보호 및 관람객 안전사고 예방 등을 위해 관람인원, 관람시간 등을 정하여 공개 또는 비공개의 특정지역을 개방하는 것을 말한다.</li> 
				<li class="sec_li">3. “공개제한”이란 국가유산의 훼손 방지 및 관람자의 안전과 국가 원수 방문 등의 주요 행사를 위하여 관람객 및 공개시간을 제한하여 지역, 전각의 전부 또는 일부를 비공개하는 것을 말한다.</li> 
				<li class="sec_li">4. “일반관람”이란 일일공개시간 중 공개지역을 관람하는 것을 말한다.</li> 
				<li class="sec_li">5. “특별관람”이란 국가유산&nbsp;보호 및 관람객 안전사고 예방 등을 위해 관람인원, 관람시간 등을 정하여 공개 또는 비공개의 특정 지역을 관람하는 것을 말한다.</li> 
				<li class="sec_li">6. “일반관람요금”이란 일반관람에 필요한 요금을 말한다.</li> 
				<li class="sec_li">7. “특별관람요금”이란 특별관람에 필요한 요금을 말한다.</li> 
				<li class="sec_li">8. “촬영”이란 국가유산&nbsp;구역 내에서 카메라 등을 사용하여 전각, 풍경, 인물 등을 사진이나 동영상을 찍는 것을 말한다.</li> 
				<li class="sec_li">9. “장소사용”이란 관람 목적 외에 행사, 회의, 수학(학술연구, 수업) 등의 사유로 특정 구역을 점유하여 사용하는 것을 말한다.</li> 
				</ul>
                </div>
            </section>
            <br>

            <section id="section2" class="section_fix">
                <h2>제2장 공개</h2>
                <h3>제3조(공개)</h3>
                <ul class="box_st"> 
				<li class="sec_li">1. 궁능유적본부장은 국가유의 보존․관리에 지장이 없는 한 제3조의2항의 규정에 따른 비공개일을 제외하고는 모든 궁능유적기관을 공개한다.</li> 
				<li class="sec_li">2. 제3조의2에도 불구하고 궁능유적본부장이 특별히 필요하다고 인정하는 경우에는 궁능유적기관을 공개할 수 있다.</li> 
				<li class="sec_li">3. 제3조의2제1항에 따른 비공개일이「관공서의 공휴일에 관한 규정」제2조 및 제3조에 따른 공휴일 및 대체공휴일과 겹치는 경우에는 공개한다. 다만, 궁능유적본부장이 특별히 필요하다고 인정하는 경우에는 공개하지 않을 수 있다.</li> 
				</ul>
				<br>
				<h3>제3조의2(비공개)</h3>
				<div class="box_st">
				<p>❗궁능유적기관의 비공개일은 다음의 각 호와 같다.</p>
				<ul>
				<li class="sec_li">1. 매주 월요일 : 창덕궁관리소, 창경궁관리소, 덕수궁관리소, 세종대왕유적관리소, 조선왕릉지구관리소</li>
				<li class="sec_li">2. 매주 화요일 : 경복궁관리소, 종묘관리소</li>
				</ul>
				<p>❗제3조제3항 전단의 규정에 따라 궁능유적기관을 공개한 때에는 공개한 공휴일 다음의 첫 번째 비공휴일을 비공개일로 한다.<p>
				</div>
				
                <h3>제4조(공개시간)</h3>
                <ul class="box_st">
                <li class="sec_li">궁능유적기관의 일일 공개시간은 09시~18시를 원칙으로 하되 6월~8월에는 18시 30분, 11월~1월에는 17시 30분까지로 한다.<br>
                다만, 궁능유적기관의 장이 궁능유적기관의 특성에 맞게 일일 공개시간을 탄력적으로 변경하여 운영할 수 있다.</li>
                <li class="sec_li">공개제한 시간은 일일 공개시간 외의 시간을 말한다.</li>
                </ul>
                
                <h3>제5조(공개제한 등)</h3>
                <ul class="box_st">
                <li class="sec_li">1. 궁능유적본부장은 제3조제1항에도 불구하고 국가유산의 훼손 방지 및 관람자의 안전과 국가원수 방문 등의 주요행사를 위하여 필요한 경우 공개를 제한할 수 있다.</li>
				<li class="sec_li">2. 궁능유적기관의 장은 지진, 태풍, 폭우, 폭설 등 천재지변이나 폭염, 미세먼지 등 기상이변, 관람객의 건강과 안전에 영향을 미칠 수 있는 사유가 발생한 경우 또는 국가유 수리·보수 등 부득이한 사유가 있는 때에는 궁능유적본부장의 승인을 얻어 전부 또는 일부에 대하여 일정 기간 공개를 중지할 수 있다. 다만, 사전에 승인을 받을 시간적 여유가 없는 긴급한 경우에는 사전조치 후 궁능유적본부장에게 보고하여야 한다.</li>
				<li class="sec_li">3. 궁능유적기관의 장은 제1항 또는 제2항의 규정에 따라 공개를 제한 또는 중지하고자 하는 때에는 관람객이 잘 볼 수 있는 곳에 공개제한 또는 중지의 사유 및 기간 등을 게시하여야 한다.</li>
				<li class="sec_li">4. 궁능유적기관의 장은 궁능유적본부장의 승인을 얻어 일반공개와는 관람요금, 관람지역 등을 달리하는 특별공개를 별도로 실시할 수 있다.</li>
                </ul>
            </section>
            
            <br>
            
             <section id="section3" class="section_fix">
                <h2>제3장 안내해설 등 서비스</h2>
                <h3>제13조(서비스의 제공)</h3>
                <ul class="box_st">
				<li class="sec_li">1. 궁능유적기관의 장은 관람객에게 안내해설, 체험, 공연 및 강연 등의 서비스를 제공할 수 있다.</li>        
				<li class="sec_li">2. 제공하는 서비스의 종류와 내용은 각 궁능유적기관의 장이 정하며, 필요할 경우 서비스 제공을 위해 필요한 비용의 전부 혹은 일부를 참가자로부터 징수할 수 있다.</li>        
				<li class="sec_li">3. 서비스 제공을 위해 부가적으로 제공하는 안내해설 보조 장비의 대여나 상품 등의 판매에 대하여 그 비용의 전부 혹은 일부를 참가자로부터 징수할 수 있다.</li>        
                </ul>
				<h3>제14조(안내근무)</h3>
				<ul class="box_st">
				<li class="sec_li">1. 안내해설사는 근무 중에 지정된 복장과 명찰을 착용하여 친절한 자세로 안내해설하여야 한다.</li>
				<li class="sec_li">2. 안내해설사는 관람객이 이해하기 쉽도록 정확하고 객관적으로 설명하여야 한다.</li>
				<li class="sec_li">3. 안내해설사는 지정된 안내실을 근무 정 위치로 하고 현장안내를 하는 시간 외에는 안내실을 무단이탈하여서는 아니 된다.</li>
				<li class="sec_li">4. 안내해설사는 근무종료 시 별지 제5호서식의 안내일지를 궁능유적기관의 사정에 맞게 작성하여 소속 궁능유적기관의 장에게 보고하여야 한다.</li>
				<li class="sec_li">5. 안내해설사에게 사고가 발생한 경우 궁능유적기관의 장은 즉시 대리근무자를 배치하여야 한다.</li>
				<li class="sec_li">6. 제3항부터 제5항에서 정한 사항 이외 근무에 관한 사항은 궁능유적기관의 장의 지시에 따라 처리하여야 한다.</li>
				</ul>
				<h3>제15조 (관광통역안내사의 역사․국가유산 교육 등)</h3>	
				<ul class="box_st">
				<li class="sec_li">1. 궁능유적본부장은 4대궁․종묘 및 조선왕릉의 올바른 역사와 가치를 알리고 「관광진흥법」 제38조에 의한 관광통역안내사의 자질을 향상하기 위하여 역사․국가유산 교육을 실시할 수 있다.</li>
				<li class="sec_li">2. 제1항에 따른 역사․국가유산 교육은 한국관광공사와 협의하여 실시할 수 있다.</li>
				<li class="sec_li">3. 한국관광공사는 제1항에 따른 역사․국가유 교육을 이수한 관광통역안내사에 대하여 이수증을 발급한다.</li>
				
				</ul>
				
            </section>
            
            <br>
            <br>
            
             <section id="section4" class="section_fix">
                <h2>제4장 매·수표</h2>
                <h3>제16조(매·수표원의 자세)</h3>
                <p class="box_st">매·수표원은 지정된 복장과 명찰을 착용하여 신속하고 친절한 자세로 매·수표하여야 한다.</p>
                
                <h3>제17조(매표근무)</h3>
                <ul class="box_st">
                <li class="sec_li">1. 매표시간은 제4조의 공개시간 및 관람소요시간 등을 고려하여 정한다.</li>
                <li class="sec_li">2. 매표원은 매표시간 이전에 수입금출납공무원으로부터 일련번호 순위에 따른 관람권과 환전금을 인수받아 지정된 매표소에서 전산발매시스템을 이용하여 일련번호 순으로 발매하여야 한다.</li>
                <li class="sec_li">3. 매표원은 근무시간 중 매표소를 무단이탈하여서는 아니 되며, 해당 궁능유적기관의 장․수입금출납공무원․감사 및 점검에 임하는 공무원 이외의 자는 매표소 출입을 일절 금지하여야 한다.</li>
                <li class="sec_li">4. 매표소에 출입하는 모든자는 사적인 현금을 소지하고 출입할 수 없다.</li>
                <li class="sec_li">5. 매표원은 매표종료 후 별지 제6호서식의 관람권 출납·판매일지를 작성하여 수입금출납공무원의 확인을 받은 후 수입금출납공무원에게 환전금, 잔여관람권, 환불관람권, 손실관람권 및 현금, 기타 결제수단전표, 전자매표 데이터 등을 확인한 후 인계하여야 한다. 다만, 관람권 출납․판매일지의 작성은 전산발매시스템에서 작성․출력된 서류로 갈음할 수 있다.</li>
                <li class="sec_li">6. 매표근무에 따른 세부사항은 궁능유적기관의 장의 지시에 따라 처리하여야 한다.</li>
                <li class="sec_li"></li>
                </ul>
                
                <h3>제18조(책임)</h3>
                <p class="box_st">매표 중에 일어나는 매표와 관련되는 사고는 먼저 당해 매표원이, 다음으로 당해 업무 감독공무원이 책임을 진다.</p>
                <h3>제19조(수표근무)</h3>
            	<ul class="box_st">
            	<li class="sec_li">1. 수표원은 근무 중 정 위치에서 무단이탈하여서는 아니된다.</li>
            	<li class="sec_li">2. 수표원은 관람권의 이상 유무를 확인한 후 절취하여 관람권 부표는 즉시 수표함에 투입하고 관람권은 관람객에게 주어야 한다. 다만 모바일관람권과 QR코드를 이용한 전자검표를 하는 경우는 제외한다.</li>
            	<li class="sec_li">3. 수표원은 어떠한 경우에도 현금을 수령하고 관람객을 입장시킬 수 없다.</li>
            	<li class="sec_li">4. 수표원은 근무종료 시 별지 제7호서식의 수표근무일지를 궁능유적기관의 사정에 맞게 작성하여 궁능유적기관의 장에게 근무상황을 보고하여야 한다. 다만, 수표근무일지 중 관람인원은 전산발매시스템에서 작성·출력된 서류로 갈음할 수 있다.</li>
            	<li class="sec_li">5. 기타 수표근무에 따른 구체적인 사항은 궁능유적기관의 장의 지시에 따라 처리하여야 한다.</li>
				</ul>
            </section>
            
            <br>
            <br>
            
             <section id="section5" class="section_fix">
                <h2>제5장 촬영</h2>
                <h3>제22조(촬영허가)</h3>
                <p class="box_st">궁능유적기관 내에서 촬영을 하려고 하는 자는 궁능유적본부장의 허가를 받아야 한다.</p>
                <h3>제23조(촬영의 구분)</h3>
                <p class="box_st">촬영은 신청자가 촬영을 하고자 하는 목적이나 촬영 결과물로 이윤을 추구하는 상업용 촬영과 이윤을 추구하지 않는 비상업용 촬영으로 구분한다.</p>
            	<h3>제24조(촬영허가 절차 등)</h3>
            	<ul class="box_st">
            	<li class="sec_li">1. 촬영을 하려고 하는 자는 별표3의 촬영요금표에 따라 촬영신청 가능기간 중 별지 제8호서식의 촬영허가 신청서를 해당 궁능유적기관의 장에게 제출하여야 한다.</li>
            	<li class="sec_li">2. 궁능유적기관의 장은 별표4의 촬영허가 가이드라인에 따라 촬영허가여부를 결정한다.</li>
            	<li class="sec_li">3. 궁능유적기관의 장은 제2항에 따라 허가를 하려고 하는 때에는 촬영일 1일 전까지 별지 제9호서식의 촬영허가서를 신청자에게 내주어야 한다.</li>
            	<li class="sec_li">4. 제2항에도 불구하고 국가유산 보존·관리에 중대한 영향을 끼치는 촬영으로 판단되는 경우에는 문화유산위원회 궁능유산분과위원회의 심의를 거쳐 촬영허가 여부를 결정한다.</li>
            	</ul>
            	<h3>제25조(촬영허가 신청방법)</h3>
            	<p class="box_st">촬영허가 신청자는 별지 제8호서식의 촬영허가신청서와 구비서류를 갖추어 국가유산청 고객지원센터누리집 또는 방문, 우편, 팩스 등의 방법으로 촬영허가를 신청할 수 있다. 다만, 긴급사항을 보도하기 위한 취재촬영은 제24조 규정에 의한 허가절차를 생략할 수 있다.</p>
            	<h3>제26조(촬영허가의 예외)</h3>
            	<ul class="box_st">
            	<li class="sec_li">1. 관람객 기념용 촬영은 제22조 및 제25조 규정에 따라 촬영허가를 받은 것으로 본다.</li>
            	<li class="sec_li">2. 특정 의상이나 소품 등을 활용하는 관람객 기념용 촬영은 다른 관람객의 관람에 불편을 주거나 해당 국가유산의 역사성을 훼손할 우려가 있으므로 위와 같은 촬영을 하고자 하는 자는 제1항에도 불구하고 제24조에 따라 해당 궁능유적기관의 장에게 촬영허가를 신청하여야 한다. 다만, 결혼사진 촬영은 덕수궁과 창경궁에 한하며 해당 궁능유적기관의 장에게 촬영허가를 신청하여야 한다.</li>
            	<li class="sec_li">3. 국가유산청장 또는 궁능유적본부장이 주최·주관하는 행사 및 국가원수 방문과 연례적인 정부 주최 주요행사(기념일 행사 등)는 제22조 및 제24조에 따라 촬영허가를 받은 것으로 본다.</li>
            	</ul>
            	<h3>제27조(촬영허가 준수사항)</h3>
            	<div class="box_st">
				<p style="font-size: 18px; font-weight: bold;">촬영허가를 받은 자는 촬영을 함에 있어 다음 각 호의 허가 조건을 준수하여야 한다.</p>            	
            	<ul>
            	<li class="sec_li">1. 제24조제2항의 규정에 따른 별표4의 촬영허가 가이드라인</li>
            	<li class="sec_li">2. 국가유산 보존 및 관리, 관람객 관람보호 등을 위하여 해당 궁능유적기관의 장이 필요하다고 인정한 사항</li>
            	

            	</ul>
            	</div>


            </section>
            
            <br>
            <br>
            
             <section id="section6" class="section_fix">
                <h2>제6장 장소사용허가</h2>
                <h3>제31조(장소사용허가)</h3>
                <p class="box_st">궁능유적기관 안에서 장소를 사용하려고 하는 자는 궁능유적본부장의 허가를 받아야 한다.</p>
                <h3>제32조(장소사용허가 절차 등)</h3>
                <ul class="box_st">
            	<li class="sec_li">1. 장소사용을 하려고 하는 자는 별표6의 장소사용요금표에 따라 장소사용신청 가능기간 중 별지 제10호서식의 장소사용허가 신청서를 해당 궁능유적기관의 장에게 제출하여야 한다.</li>
            	<li class="sec_li">2. 궁능유적기관의 장은 별표7의 장소사용허가 가이드라인에 따라 장소사용허가 여부를 결정한다.</li>
            	<li class="sec_li">3. 궁능유적기관의 장은 제2항에 따라 허가를 하려고 하는 때에는 장소사용일 5일 전까지 별지 제11호서식의 장소사용허가서를 신청자에게 내주어야 한다.</li>
            	<li class="sec_li">4. 제2항에도 불구하고 국가유산 보존·관리에 중대한 영향을 끼치는 장소사용으로 판단되는 경우에는 문화유산위원회 궁능유산분과위원회의 심의를 거쳐 장소사용허가 여부를 결정한다.</li>
                </ul>
                <h3>제33조(장소사용허가 신청 방법)</h3>
                <p class="box_st">장소사용신청자는 별지 제10호의 장소사용허가 신청서를 갖추어 국가유산청 고객지원센터 누리집 또는 방문, 우편, 팩스 등의 방법으로 장소사용허가를 신청할 수 있다.</p>
            	<h3>제34조(장소사용허가의 예외)</h3>
            	<p class="box_st">국가유산청장 또는 궁능유적본부장이 주최·주관하는 행사 및 국가원수 방문과 연례적인 정부 주최 주요행사(기념일 행사 등)는 제31조 및 제32조에 따라 장소사용 허가를 받은 것으로 본다.</p>
            	<h3>제35조(장소사용허가 준수사항)</h3>
            	<div class="box_st">
            	<p style="font-size: 18px; font-weight: bold;">장소사용 허가를 받은 자는 장소사용을 함에 있어 다음 각 호의 허가조건을 준수하여야 한다.</p>
            	<ul>
            	<li class="sec_li">1. 제32조제2항의 규정에 따른 별표7의 장소사용 허가 가이드라인</li>
            	<li class="sec_li">2. 국가유산 보호 및 안전관리 등을 위하여 해당 궁능유적기관의 장이 필요하다고 인정한 사항</li>
            	</ul>
            	</div>
            	<h3>제36조(장소사용허가 취소 등)</h3>
            	<ul class="box_st">
            	<li style="font-size: 18px; font-weight: bold;">❗궁능유적본부장은 다음 각 호의 어느 하나에 해당하는 경우에는 장소사용을 중지하거나 허가를 취소할 수 있다.</li>
            	<li class="sec_li" style="padding-left: 30px; padding-bottom: 5px; ">1. 제35조의 장소사용허가 준수사항을 위반한 경우</li>
            	<li class="sec_li" style="padding-left: 30px; padding-bottom: 5px; ">2. 허가내용 이외의 다른 목적으로 사용할 경우</li>
            	<li class="sec_li" style="padding-left: 30px; padding-bottom: 5px; ">3. 허가받은 자가 자신의 사정에 의하여 허가받은 기간 내에 장소사용을 할 수 없는 경우</li>
            	<li class="sec_li" style="padding-left: 30px; padding-bottom: 5px; ">4. 천재지변, 긴급상황 등으로 인하여 부득이하게 장소사용을 할 수 없다고 궁능유적본부장이 인정할 때</li>
            	<li style="font-size: 18px; font-weight: bold;">❗궁능유적본부장은 제1항에 따라 장소사용을 중지시키거나 허가를 취소할 경우 다음 각 호에 따라 장소사용 요금의 전부 또는 일부를 반환하거나 장소사용일을 연기할 수 있다. 단 제1항 제1호 및 제2호의 사유로 인한 장소사용의 중지나 취소는 해당하지 않는다.</li>
            	<li class="sec_li">1. 장소사용 전 허가를 취소할 경우 수납한 금액의 전체를 반환</li>
            	<li class="sec_li">2. 장소사용 전 허가한 시간의 일부를 취소할 경우 별표6의 장소사용요금표에 따라 금액을 산정하여 반환</li>
            	<li class="sec_li">3. 장소사용허가를 받은 자가 장소사용 중 허가받은 시간의 일부를 취소할 경우 납부한 요금을 반환하지 않음. 다만, 제1항제4호의 사유로 취소할 경우, 별표6의 장소사용 요금표에 따라 반환 금액을 산정하여 반환</li>
            	
            	</ul>
            </section>

            
            <br>
            <br>
            
             <section id="section7" class="section_fix">
                <h2>제7장 기타</h2>
                <p class="box_st">「훈령․예규 등의 발령 및 관리에 관한 규정」에 따라 이 훈령에 대하여 2019년 7월 1일 기준으로 매3년이 되는 시점(매 3년째의 6월 30일까지를 말한다)마다 그 타당성을 검토하여 개선 등의 조치를 하여야 한다.</p>
            </section>


        </article>
    </div> <!-- .container 닫는 태그 -->


  </main>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
