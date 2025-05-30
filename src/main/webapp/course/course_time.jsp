<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람시간</title>

  <link rel="stylesheet" type="text/css" href="/Gung_On/course/css/course_time_style.css" />
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
                    <li><a href="/Gung_On/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="/Gung_On/course/course_time.jsp" class="active">관람시간</a></li>
                    <li><a href="/Gung_On/course/course.jsp">관람코스</a></li>
                    <li><a href="/Gung_On/course/users_course.jsp"  >사용자 추천 코스</a></li>
                </ul>
            </nav>
            <!-- 추가적인 사이드바 요소가 있다면 여기에 포함 -->
        </div>

        <article class="content">
            <h1>관람시간</h1>

            <!-- 정기휴일 섹션 -->
            <section>
                <h2>정기휴일</h2>
                <div class="holiday-section">
                    <div class="holiday-card">
                        <img src="/Gung_On/course/course_time_img/mon.png" alt="월요일" class="img_wrap">
                        <strong>월요일</strong>
                        <p>창덕궁, 덕수궁, 창경궁, 경희궁</p>
                    </div>
                    <div class="holiday-card">
                        <img src="/Gung_On/course/course_time_img/tue.png" alt="화요일" class="img_wrap">
                        <strong>화요일</strong>
                        <p>경복궁</p>
                    </div>
                    <br>
                </div>
                     <p class="note">※ 단, 정기휴일이 공휴일 및 대체공휴일과 겹칠 경우에는 개방하며, 그 다음의 첫 번째 비공휴일이 정기휴일</p>
            </section>
<section>
                <h2>일반관람시간</h2>
    <table>
      <thead>
        <tr class="tr_property thead_tr_property">
          <th class="th_property">문화재</th>
          <th class="th_property">3~5월 / 9~10월</th>
          <th class="th_property">6~8월 / 11~2월</th>
          <th class="th_property">비고</th>
        </tr>
      </thead>
      <tbody>
        <tr class="tr_property">
          <td class="td_property">경복궁</td>
          <td class="td_property">09:00~18:00<br>(입장마감 17:00)</td>
          <td class="td_property">09:00~17:00<br>(입장마감 16:00)</td>
          <td class="highlight td_property">화요일 휴무</td>
        </tr>
        <tr class="tr_property">
          <td class="td_property">창덕궁</td>
          <td class="td_property">09:00~18:00<br>(입장마감 17:00)</td>
          <td class="td_property">09:00~17:30<br>(입장마감 16:30)</td>
          <td class="highlight td_property">월요일 휴무</td>
        </tr>
        <tr class="tr_property">
          <td class="td_property">창경궁</td>
          <td class="td_property">09:00~18:00<br>(입장마감 17:30)</td>
          <td class="td_property"> 09:00~17:30<br>(입장마감 17:00)</td>
          <td class="highlight td_property">월요일 휴무</td>
        </tr>
        <tr class="tr_property">
          <td class="td_property">덕수궁</td>
          <td class="td_property">09:00~21:00<br>(입장마감 20:00)</td>
          <td class="td_property">09:00~21:00<br>(입장1마감 20:00)</td>
          <td class="highlight td_property">월요일 휴무</td>
        </tr>
      </tbody>
    </table>
    
        <table>
      <thead>
        <tr class="tr_property thead_tr_property">
          <th class="th_property">문화재</th>
          <th class="th_property" style="width: 480px;">관람시간</th>
          <th class="th_property">비고</th>
        </tr>
      </thead>
      <tbody>
        <tr class="tr_property">
          <td class="td_property">경희궁</td>
          <td class="td_property" >09:00~18:00<br>(입장마감 17:30)</td>
          <td class="highlight td_property">화요일 휴무</td>
        </tr>
      </tbody>
    </table>

    <table>
      <thead>
        <tr class="tr_property thead_tr_property">
          <th class="th_property">문화재</th>
          <th class="th_property">구분</th>
          <th class="th_property">운영시간</th>
          <th class="th_property">비고</th>
        </tr>
      </thead>
      <tbody>
        <tr class="tr_property">
          <td rowspan="2" class="td_property">경복궁</td>
          <td class="td_property">야간개장</td>
          <td class="td_property">19:00~21:30 (입장마감 20:30)</td>
          <td class="td_property">기간 제한 있음</td>
        </tr>
        <tr class="tr_property">
          <td class="td_property">휴궁일</td>
          <td class="td_property">화요일</td>
          <td class="td_property"></td>
        </tr>
        <tr class="tr_property">
          <td colspan="4" class="highlight td_property">※ 상기 일정은 사정에 따라 변경될 수 있습니다.</td>
        </tr>
      </tbody>
    </table>
  </section>
  
    
	<section>
                <h2>특별관람시간</h2>
	<table>
	<thead> 
	<tr class="tr_property thead_tr_property">
	<th class="th_property">문화재</th>
	<th class="th_property" colspan="2">구분</th>
	<th class="th_property">관람시간</th>
	<th class="th_property">비고</th>
	</tr> 
	</thead>
	<tbody >
	<tr class="tr_property">
	<td rowspan="7" class="td_property">창덕궁 후원관람</td>
	<td rowspan="2" class="td_property">한국어</td>
	<td class="td_property">11월~2월</td>
	<td class="td_property">10:00 11:00 12:00 13:00 14:00 15:00</td>
	<td rowspan="7" class="td_property">언어권별<br>
 	입장 제한 <br>
 	1회당 100명 <br> (인터넷 예매 50명 + 현장발매 50명)</td>
	</tr>
	<tr  class="tr_property">
	<td class="td_property">3월~10월</td>
	<td class="td_property">10:00 11:00 12:00 13:00 14:00 15:00 16:00</td>
	</tr>
	<tr class="tr_property">
	<td rowspan="2" class="td_property">영어</td>
	<td class="td_property">12월~2월</td>
	<td class="td_property">10:30 11:30 14:30</td>
	</tr>
	<tr>
	<td class="td_property">3월~11월</td>
	<td class="td_property">10:30 11:30 14:30 15:30</td>
	</tr>
	<tr class="tr_property">
	<td class="td_property">일본어</td>
	<td class="td_property">1월~12월</td>
	<td class="td_property">13:30<br> (매주 수,금,일요일 운영)</td>
	</tr>
	<tr class="tr_property">
	<td class="td_property" style="height: 186px;">중국어</td>
	<td class="td_property">1월~12월</td>
	<td class="td_property" style="height: 186px;">12:30<br> (매주 화,목,토요일 운영)</td>
	</tr>
	<tr class="tr_property">
	<td class="td_property" colspan="4" style="text-align: left;"> - 후원은 입장시간과 정원이 정해져 있는 제한관람으로 입장시간 준수.<br> - 후원 외국인 관람 시간 내국인 입장 불가<br> (단, 외국인 동반자가 있는 경우 내국인 최대 2명까지 입장 가능) </td>
	</tr>
	</tbody>
	</table>
	
	<div><strong>※ 특별관람은 기관 사정에 따라 변동될 수 있으니 자세한 사항은&nbsp;공지사항을 참고하시기 바랍니다.</strong></div>
	</section>
	
	
	<section>
                <h2>창경궁 기간별 야간개방구역 이동시간 및 대온실 내부개방 일정</h2>
	<table>
	<thead> 
	<tr class="tr_property thead_tr_property">
	<th class="th_property" style="width: 300px;">구분/월별</th>
	<th class="th_property" style="width: 250px;">11월~1월</th>
	<th class="th_property" style="width: 200px;">2월</th>
	<th class="th_property" style="width: 250px;">3월~5월/9월~10월</th>
	<th class="th_property" style="width: 250px;">6월~8월</th>
	</tr> 
	</thead>
	<tbody >
	<tr class="tr_property">
	<td class="td_property">야간개방구역 이동시간</td>
	<td class="td_property">17시30분</td>
	<td class="td_property">17시30분</td>
	<td class="td_property">18시	</td>
	<td class="td_property">18시30분<br>
	</tr>
	<tr class="tr_property">
	<td rowspan="3" class="td_property">대온실 내부</td>
	<td class="td_property">11월(개방)<br>12월~1월<br>(18시부터 비개방)</td>
	<td class="td_property">18시부터 비개방</td>
	<td class="td_property">개방</td>
	<td class="td_property">개방</td>
	</tr>
	</tbody>
	</table>
	
	<div><strong>※ 야간개방지역은 홍화문, 명정전, 통명전, 춘당지, 대온실 권역이며, 기간별 이동시간에 따라 주간개방구역에 계신 분들께서는 야간개방구역으로 이동하여야 합니다. 또한, 대온실 내부도 식물 보호를 위하여 위와 같이 야간에는 기간별 제한 개방을 운영하고 있으니 이점 양해 부탁드립니다.</strong></div>
	</section>
	
	</article>
    </div> <!-- .container 닫는 태그 -->
	


  </main>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
