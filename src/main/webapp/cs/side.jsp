<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
<style>
 .lnb_wrap {
  	/* position: fixed; */
  	position: absolute;
  	top: 200px; /* 상단에서 거리 조절 */
  	left: 40px;
  	width: 300px; /* 원하는 너비 */
  	z-index: 0; /* 다른 요소보다 위로 오도록 */
	}
	.lnb_tit{width: 100%;height: 85px;display: flex;flex-wrap: wrap;align-items: center;justify-content: center;text-align: center; font-size: 1.5rem;background: #131313; color: #fff;}
.lnb_depth2_wrap{ border: 1px solid #ddd; margin-bottom: 40px; padding: 20px;}
.lnb_depth2_item{ width: 100%;}
.lnb_depth2_item > a{width: 100%; font-size: 1.125rem; font-weight: 400; padding: 15px 0; position: relative;}
.lnb_depth2_item > a::before{width: 100%; height: 1px; background: #ddd; position: absolute; bottom: 0; left: 0;
content: '';}

.lnb_depth2_item.active > a, .lnb_depth2_item.current > a, .lnb_depth2_item > a:hover {
    font-weight: 600;
}

.lnb_depth2_item > a {
    width: 100%;
    font-size: 1.125rem;
    font-weight: 400;
    padding: 15px 0;
    position: relative;
}


	



</style>  
    
<div class="lnb_wrap" >
	<div class="lnb_wrap current">


<!-- Empty Layout -->

<div class="lnb_tit">고객센터</div>			
<ul class="lnb_depth2_wrap">
	<li class="lnb_depth2_item <%= "notice".equals(request.getAttribute("currentMenu")) ? "current" : "" %>">
		<a href="notice_main.jsp">공지사항</a>
	</li>
	<li class="lnb_depth2_item <%= "faq".equals(request.getAttribute("currentMenu")) ? "current" : "" %>">
		<a href="faq_main.jsp">자주묻는 질문</a>
	</li>
	<li class="lnb_depth2_item <%= "inquiry".equals(request.getAttribute("currentMenu")) ? "current" : "" %>">
		<a href="myinquiry.jsp">1:1문의</a>
	</li>
</ul>

<!-- //Empty Layout --></div>

						<!-- [E] 관람안내 -->
						<!--
						<div class="left_info_wrap sub_reservation_info">
							<div class="left_info_tit">관람안내</div>
							<div class="left_info_time">
								<div class="left_info_sub_tit">관람시간</div>
								<div class="time">09:00~18:30</div>
								<div class="small">*입장마감 17:30</div>
							</div>
							<div class="left_info_closed_day">
								<div class="left_info_sub_tit">휴관일</div>
								<div class="closed_day">매주 화요일</div>
								<div class="small">* 단, 정기휴일이 공휴일 및 대체공휴 일과 겹칠경우에는 개방하며, 그 다음날 정기휴일 (영월 장릉은 정기휴일 없음)</div>
							</div>
						</div>
						-->
						<!--  -->
					</div>
    