<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
  window.addEventListener('DOMContentLoaded', () => {
    const elem = document.getElementById('panzoom-container');
    const panzoom = Panzoom(elem, {
      maxScale: 5,
      minScale: 0.5,
      step: 0.2
    });

    // 마우스 휠로 줌
    
    /* elem.parentElement.addEventListener('wheel', panzoom.zoomWithWheel); */

    // 버튼 이벤트
    document.getElementById('zoomInButton').addEventListener('click', () => panzoom.zoomIn());
    document.getElementById('zoomOutButton').addEventListener('click', () => panzoom.zoomOut());
    document.getElementById('resetButton').addEventListener('click', () => panzoom.reset());
  });
</script>


<script type="text/javascript">
</script><!-- [S] sub_con_wrap -->
<style type="text/css">
.f-custom-controls {
	position: absolute;
	border-radius: 4px;
	overflow: hidden;
	z-index: 1;
}

.f-custom-controls.top-right {
	right: 16px;
	top: 16px;
}

.f-custom-controls.bottom-right {
	right: 16px;
	bottom: 16px;
}

.f-custom-controls button {
	width: 32px;
	height: 32px;
	background: none;
	border: none;
	margin: 0;
	padding: 0;
	background: #222;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.f-custom-controls svg {
	pointer-events: none;
	width: 18px;
	height: 18px;
	stroke: #fff;
	stroke-width: 2;
}

.f-custom-controls button[disabled] svg {
	opacity: 0.7;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const tabLinks = document.querySelectorAll('.course_num_list .course_num_item');
    const tabContents = document.querySelectorAll('#photoDiv .tab_con'); 
    tabLinks.forEach(function(link) {
        link.addEventListener('click', function(event) {
            event.preventDefault();

            const targetTab = this.getAttribute('data-tab');

            tabLinks.forEach(function(item) {
                item.classList.remove('current');
            });
            this.classList.add('current');
            tabContents.forEach(function(content) {
                content.classList.remove('current');
            });

            const activeContent = document.querySelector('#photoDiv .tab_con.' + targetTab);
            if (activeContent) {
                activeContent.classList.add('current');
            }
        });
    });

});
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
	  const courseLinks = document.querySelectorAll('ul.list.course_info_list li.item a');
	  const dim = document.querySelector('.dim');
	  const popup = document.getElementById('pop_course01');
	  const tabLinks = popup ? popup.querySelectorAll('.tab_menu .item') : [];
	  const tabContents = popup ? popup.querySelectorAll('.tab_con') : [];

	  const swipers = {};

	  function initSwipers() {
	    if (popup && tabContents.length > 0) {
          tabContents.forEach(content => {
            const swiperEl = content.querySelector('.course_pop_slide');
            if (swiperEl && !swiperEl.swiper) {
              swipers[swiperEl.id] = new Swiper('#' + swiperEl.id, {
                direction: 'horizontal',
                loop: false,
                navigation: {
                  nextEl: '.swiper-button-next',
                  prevEl: '.swiper-button-prev',
                },
                slidesPerView: 'auto', // 'auto'로 변경 (컨텐츠 너비에 맞춤)
                spaceBetween: 15, // 간격 조정
                observer: true, // 부모 요소 변화 감지
                observeParents: true, // 부모의 부모 요소 변화 감지
              });
            }
          });
	    }
	  }

	  function openPopup(tabId) {
	    if (dim && popup) { // 팝업 요소가 존재할 때만 실행
          dim.style.display = 'block';
          popup.style.display = 'block';

          tabLinks.forEach(link => {
            const anchor = link.querySelector('a');
            if (anchor) {
              link.classList.toggle('current', anchor.getAttribute('data-tab') === tabId);
            }
          });

          tabContents.forEach(content => {
            content.classList.toggle('current', content.classList.contains(tabId));
            if (content.classList.contains(tabId)) {
              const swiperEl = content.querySelector('.course_pop_slide');
              if (swiperEl && swipers[swiperEl.id]) {
                swipers[swiperEl.id].update();
                swipers[swiperEl.id].slideTo(0, 0); // 첫 슬라이드로 이동
              }
            }
          });

	    }
	  }

	  function closePopup() {
	    if (dim && popup) { // 팝업 요소가 존재할 때만 실행
          dim.style.display = 'none';
          popup.style.display = 'none';
          Object.values(swipers).forEach(swiper => swiper.slideTo(0, 0));
	    }
	  }
	  courseLinks.forEach(link => {
	    link.addEventListener('click', e => {
	      e.preventDefault();
	      const tabNum = link.parentElement.getAttribute('data-num');
	      openPopup('cs' + tabNum); // 클릭된 data-num에 해당하는 tabId로 팝업 열기
	    });
	  });

	  if (dim) { // dim 요소가 있을 때만 이벤트 연결
          dim.addEventListener('click', e => {
              if (e.target === dim) {
                closePopup();
              }
          });
	  }

	  tabLinks.forEach(link => {
	    link.addEventListener('click', e => {
	      e.preventDefault();
	      const tabId = link.querySelector('a').getAttribute('data-tab');
	      openPopup(tabId); 
	    });
	  });

	  const closeBtn = popup ? popup.querySelector('.popup_close') : null; 
	  if (closeBtn) { 
	    closeBtn.addEventListener('click', e => {
	      e.preventDefault();
	      closePopup();
	    });
	  }

	  initSwipers();

    if (popup) { 
        const initialActiveContent = popup.querySelector('.tab_con.current');
        if (initialActiveContent) {
             const initialSwiperElement = initialActiveContent.querySelector('.course_pop_slide');
             if (initialSwiperElement && swipers[initialSwiperElement.id]) {
                  swipers[initialSwiperElement.id].update();
             }
        }
    }
});




</script>

<style type="text/css">
.f-custom-controls {
	position: absolute;
	border-radius: 4px;
	overflow: hidden;
	z-index: 1;
}

.f-custom-controls.top-right {
	right: 16px;
	top: 16px;
}

.f-custom-controls.bottom-right {
	right: 16px;
	bottom: 16px;
}

.f-custom-controls button {
	width: 32px;
	height: 32px;
	background: none;
	border: none;
	margin: 0;
	padding: 0;
	background: #222;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.f-custom-controls svg {
	pointer-events: none;
	width: 18px;
	height: 18px;
	stroke: #fff;
	stroke-width: 2;
}

.f-custom-controls button[disabled] svg {
	opacity: 0.7;
}
</style>

    
    <!-- 사이드바와 콘텐츠를 감싸는 container div -->
    <div class="container">
        <div class="sidebar">
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="/Gung_On/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="/Gung_On/course/course_time.jsp">관람시간</a></li>
                    <li><a href="/Gung_On/course/course.jsp" class="active">관람코스</a></li>
                    <li><a href="/Gung_On/course/users_course.jsp">사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>
        	<article class="content">
            <h1>관람코스</h1>
        


<!-- [S] sub_con_section -->
<div class="sub_con_section">
	<div class="tab_con_wrap">
		<div class="tab_con current">
			<!-- [S] course_tab_wrap -->
					<div class="course_tab_wrap">
						<!-- [S] 코스안내 -->
						<div class="left course_pop_con">
							<span class="course_tit"><img src="course_img/ic_loca.jpg" alt=""> 코스안내</span>
								<ul class="list course_info_list">
									<li class="item">
											<a href="#;" data-num="0"><span class="inn">🚶시간 별  코스</span></a>
										</li>
									</ul>
							</div>
						<select class="sel_st">
           			<option value="gbg" >경복궁</option>
            		<option value="cdg" selected="selected">창덕궁</option>
            		<option value="dsg">덕수궁</option>
            		<option value="cgg">창경궁</option>
            		<option value="ghg">경희궁</option>
             </select>
             
             
             
					</div>
					<div class="course_map_wrap" id="course_map_wrap">
						<div class="course_map_fix">
							<div class="amenities_wrap">
									<ul>
										<li><a href=""><em><img src="course_img/icon_1.svg" alt=""></em><span>안내</span></a></li>
										<li><a href=""><em><img src="course_img/icon_2.svg" alt=""></em><span>매표소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_3.svg" alt=""></em><span>음성안내기 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_4.svg" alt=""></em><span>휠체어 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_5.svg" alt=""></em><span>유모차 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_6.svg" alt=""></em><span>주차장</span></a></li>
										<li><a href=""><em><img src="course_img/icon_7.svg" alt=""></em><span>기념품점</span></a></li>
										<li><a href=""><em><img src="course_img/icon_8.svg" alt=""></em><span>물품보관함</span></a></li>
										<li><a href=""><em><img src="course_img/icon_9.svg" alt=""></em><span>수유실</span></a></li>
										<li><a href=""><em><img src="course_img/icon_10.svg" alt=""></em><span>자판기</span></a></li>
										<li><a href=""><em><img src="course_img/icon_11.svg" alt=""></em><span>휠체어리프트</span></a></li>
										<li><a href=""><em><img src="course_img/icon_12.svg" alt=""></em><span>화장실</span></a></li>
										<li><a href=""><em><img src="course_img/icon_13.svg" alt=""></em><span>구급약</span></a></li>
										<li><a href=""><em><img src="course_img/icon_14.svg" alt=""></em><span>심장제세동기</span></a></li>
									</ul>
								</div>
						</div>
						<div class="tab_con_wrap">
							<div class="tab_con map_info current">
								<div class="hidden gubunNm">전체</div>
								<div class="f-custom-controls top-right">
										<button id="zoomInButton" class="zoomIn" data-panzoom-action="zoomIn" title="확대">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M12 5v14M5 12h14"></path>
								            </svg>
										</button>
										<button id="zoomOutButton" class="zoomOut" data-panzoom-action="zoomOut" title="축소">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M5 12h14"></path>
								            </svg>
										</button>
										<button id="resetButton" class="zoomReset" data-panzoom-action="zoomReset" data-panzoom-change="{" angle":="" 90}"="" title="초기화">
											<img src="course_img/ic_refresh.png" width="20px">
										</button>
									</div>
								<div class="course_map" style="overflow: hidden; user-select: none; touch-action: none; width: 900px;">
									<div class="zoomable" id="panzoom-container" style="cursor: move; user-select: none; touch-action: none; transform-origin: 50% 50%; transition: none; transform: scale(1) translate(0px, 0px);">
										<img data-id="1" class="map_content" src="course_img/gbg_img/gbg_map_all.png" alt="전체 맵" draggable="true">
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- [E] course_map_wrap -->

					<!-- [S] course_info -->
						<div class="course_info box_wrap">
							<img src="course_img/ic_info.png" alt=""> 번호를 클릭하시면 아래 화면에서 시설사진을 볼 수 있습니다.
						</div>

						<ul class="course_num_list tab_menu">
							<li class="child_tab_menu course_num_item tab_link current cm1" data-num="1" data-tab="cm1">
									<a href="#;"><span class="num">1</span>근정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;"><span class="num">2</span>사정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;"><span class="num">3</span>수정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;"><span class="num">4</span>경회루</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;"><span class="num">5</span>강녕전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;"><span class="num">6</span>교태전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm7" data-num="7" data-tab="cm7">
									<a href="#;"><span class="num">7</span>동궁</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm8" data-num="8" data-tab="cm8">
									<a href="#;"><span class="num">8</span>소주방</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm9" data-num="9" data-tab="cm9">
									<a href="#;"><span class="num">9</span>자경전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm10" data-num="10" data-tab="cm10">
									<a href="#;"><span class="num">10</span>흥복전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm11" data-num="11" data-tab="cm11">
									<a href="#;"><span class="num">11</span>향원정</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm12" data-num="12" data-tab="cm12">
									<a href="#;"><span class="num">12</span>건청궁</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm13" data-num="13" data-tab="cm13">
									<a href="#;"><span class="num">13</span>집옥재</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm14" data-num="14" data-tab="cm14">
									<a href="#;"><span class="num">14</span>태원전</a>
								</li>
							</ul>
						<!-- [E] course_num_list -->
					<div id="photoDiv">


<!-- Empty Layout -->
<!-- [S] course_num_con -->
<div class="tab_con_wrap course_slide_wrap">
		<div class="tab_con cm1 current" data-tab="cm1">
				<h3 class="txt_section_tit vcPartTitle">
								근정전</h3>
                        <div class="hidden">
					근정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal swiper-backface-hidden course_slide0">
					<div class="swiper-wrapper" id="swiper-wrapper-67eeb24bcfc6c0910" aria-live="polite">
						<div class="swiper-slide swiper-slide-active swiper-slide-next" data-seq="8" role="group" aria-label="1 / 1" data-swiper-slide-index="0" style="width: 100%">
								<img src="course_img/gbg_img/Geunjeongjeon.jpg" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p class="0" style="margin-right: 0px; margin-left: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; text-align: justify;"><span style="color: rgb(19, 19, 19);">근정전(勤政殿)은 경복궁의 정전으로 왕의 즉위식, 신하들의 하례, 외국 사신의 접견, 궁중연회 등 중요한 국가행사를 치르던 곳이다. 근정전은&nbsp;궁궐 내에서도 가장 규모가 크고 격식을 갖춘 건물로 면적도 가장 넓게 차지하고 있다.&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">근정전 앞마당</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">은 다른 궁궐의 정전과 같이 박석이 깔려있고</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">,&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">중앙에는 삼도</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">(</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">三道</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">)</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">를 두어 궁궐의 격식을 갖추었으며 조정에는 </span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">품계석을 놓았다</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">.</span></p>
<div></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm2" data-tab="cm2">
				<h3 class="txt_section_tit vcPartTitle">
								사정전</h3>
                        <div class="hidden">
					사정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide1">
					<div class="swiper-wrapper" id="swiper-wrapper-a6d6a2d54fb10ce80" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Sajeongjeon.jpg" data-key="4801" alt="사정전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">사정전(思政殿)은 왕이 신하들과 함께 일상 업무를 보던 공식 집무실인 편전(便殿)이다. 이곳에서 매일 아침 업무 보고와 회의, 경연 들이 이루어졌다.&nbsp;사정전 좌우에는 만춘전(萬春殿)과 천추전(千秋殿)은 사정전의 부속건물로 사정전에 없는 온돌시설이 갖추어져 있어 사계절로 이용이 가능하였던 것으로 보인다.</div>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm3" data-tab="cm3">
				<h3 class="txt_section_tit vcPartTitle">
								수정전</h3>
                        <div class="hidden">
					수정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide2">
					<div class="swiper-wrapper" id="swiper-wrapper-ca5a3110917a17996" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Sujeongjeon.jpg" data-key="4801" alt="수정전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">수정전(修政殿)은 고종 대 편전으로 사용했던 건물이다.&nbsp;경복궁 창건 당시에는 없었으나 고종 대 경복궁을 다시 지을 때 지은 건물이다.&nbsp;1894년(고종 31) 갑오개혁 때 군국기무처가 들어섰고, 이후 의정부(議政府)가 내각(內閣)으로 바뀌면서 내각의 청사로 사용되었다.&nbsp;특히 조선 초기 수정전 일대에는 세종 대에 훈민정음 창제의 산실인 집현전이 있었다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm4" data-tab="cm4">
				<h3 class="txt_section_tit vcPartTitle">
								경회루</h3>
                        <div class="hidden">
					경회루</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide3">
					<div class="swiper-wrapper" id="swiper-wrapper-f8f5d86da2107883e" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Gyeonghoeru.jpg" data-key="4801" alt="경희루">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="text-align: justify;">경회루(慶會樓)는 경복궁 침전영역 서쪽에 위치한 연못 안에 조성된 누각으로,&nbsp;왕이 신하들과 규모가 큰 연회를 열거나 외국 사신을 접대하던 곳이다.&nbsp;</span><span style="text-align: justify;">경회루의 1층은 48개(둥근 기둥과 네모난 기둥 각 24개)의 높은 돌기둥들만 세웠으며, 2층에 마루를 깔아 연회장으로 이용했다. 추녀마루에는 우리나라 건물 가운데 가장 많은 11개의 잡상(雜像)이 있다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm5" data-tab="cm5">
				<h3 class="txt_section_tit vcPartTitle">
								강녕전</h3>
                        <div class="hidden">
					강녕전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide4">
					<div class="swiper-wrapper" id="swiper-wrapper-d015deff431101621" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Gangnyeongjeon.jpg" data-key="4801" alt="강녕전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">강녕전(康寧殿)은 교태전과 함께 왕과 왕비가 일상생활을 하던&nbsp;침전이다. 강녕전은 왕의 침전으로,&nbsp;왕은 이곳에서 독서와 휴식 등 일상생활뿐 아니라 신하들과 은밀한 정무를 보기도 하였다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">건물 앞에는 넓은 월대가 있고, 지붕 위에 용마루가 없는 건물이다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">지금의 강녕전은 1995년에 복원하였다.&nbsp;</span><span style="color: rgb(19, 19, 19);">강녕전 주변으로는 경성전(慶成殿), 연생전(延生殿), 응지당(膺祉堂), 연길당(延吉堂) 등 강녕전 부속건물이 있다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm6" data-tab="cm6">
				<h3 class="txt_section_tit vcPartTitle">
								교태전</h3>
                        <div class="hidden">
					교태전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide5">
					<div class="swiper-wrapper" id="swiper-wrapper-c9d47e86ea7d11e4" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Gyotaejeon.jpg" data-key="4801" alt="교태전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">교태전(交泰殿)은 강녕전과 함께 왕과 왕비가 일상생활을 하던 침전이자,&nbsp;왕비의 생활공간이다. 교태전은 궁궐의 가장 가운데에 위치하고 있어, 왕비의 생활공간이기 때문에 중궁전이라고도 부른다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">강녕전과 마찬가지로 지붕 위에 용마루가 없고 내부 모습은 비슷하나, 건물 앞에 월대는 없다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">지금의 교태전은 1995년에 복원한 것이다.&nbsp;</span><span style="color: rgb(19, 19, 19);">교태전 뒤로는 아미산(峨嵋山)이라는 왕비를 위한 후원을 조성하였다.</span><span style="color: rgb(19, 19, 19);">&nbsp;</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm7" data-tab="cm7">
				<h3 class="txt_section_tit vcPartTitle">
								동궁</h3>
                        <div class="hidden">
					동궁</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide6">
					<div class="swiper-wrapper" id="swiper-wrapper-a09e7151aff9e25a" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Donggung.jpg" data-key="4801" alt="동궁">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">동궁(東宮) 영역은 왕세자와 왕세자빈의 교육공간이자 생활공간으로 궁궐의 동쪽에 있어 동궁, 또는 세자궁이라고 부른다.&nbsp;현재 동궁 영역에는 왕세자와 왕세자빈의 생활공간인 자선당(資善堂)과 왕세자의 교육과 정무를 보던 비현각(丕顯閣), 그리고 동궁의 정당(正堂)인 계조당(繼照堂)이 있다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">자선당과 비현각은 1999년에, 계조당은 2023년에 복원하였다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm8" data-tab="cm8">
				<h3 class="txt_section_tit vcPartTitle">
								소주방</h3>
                        <div class="hidden">
					소주방</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide7">
					<div class="swiper-wrapper" id="swiper-wrapper-2468e9326aa5af72" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Sojuroom.jpg" data-key="4801" alt="소주방">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p class="0" style="text-align: justify;">소주방<span lang="EN-US" style="letter-spacing: 0pt;">(</span><span style="letter-spacing: 0pt;">燒廚房</span><span lang="EN-US" style="letter-spacing: 0pt;">)</span>은 왕의 수라와 궁중의 잔치 음식 등을 준비하던 궁중 부엌이다<span lang="EN-US" style="letter-spacing: 0pt;">. </span>이곳은 왕의 수라를 만들던 내소주방(內燒廚房)<span lang="EN-US" style="letter-spacing: 0pt;">, </span>궁중 잔치나 고사 음식을 차리던 외소주방(外燒廚房)<span lang="EN-US" style="letter-spacing: 0pt;">, </span>그리고 간식<span lang="EN-US" style="letter-spacing: 0pt;">, </span>죽<span lang="EN-US" style="letter-spacing: 0pt;">, </span>과일<span lang="EN-US" style="letter-spacing: 0pt;">, </span>떡 등을 차리던 생물방<span lang="EN-US" style="letter-spacing: 0pt;">(</span><span style="letter-spacing: 0pt;">生物房</span><span lang="EN-US" style="letter-spacing: 0pt;">) </span>세 구역으로 나뉘어 있다<span lang="EN-US" style="letter-spacing: 0pt;">. </span>현재의 소주방은 <span lang="EN-US" style="letter-spacing: 0pt;">2015</span>년에 복원한 것이다<span lang="EN-US" style="letter-spacing: 0pt;">.</span></p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm9" data-tab="cm9">
				<h3 class="txt_section_tit vcPartTitle">
								자경전</h3>
                        <div class="hidden">
					자경전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide8">
					<div class="swiper-wrapper" id="swiper-wrapper-bf86705c767e302f" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Jagyeongjeon.jpg" data-key="4801" alt="자경전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="margin-right: 0px; margin-left: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; text-align: justify;"><span style="color: rgb(19, 19, 19);">자경전(慈慶殿)은 1867년(고종 4) 경복궁을 다시 지을 때 신정황후 조씨(24대 헌종의 어머니이자 26대 고종의 양어머니, 대한제국 선포 후 황후로 추존됨)를 위해 지은 건물이다. 그러나 지은 지 얼마 지나지 않아 화재로 소실된 것을 1888년(고종 25)에 다시 지어 지금까지 남아 있는 건물이다. 자경전 주변으로는 복안당(福安堂)과 청연루(淸讌樓), 협경당(協慶堂) 등 부속건물을 따로 두었는데 모두 연결되어 있다.&nbsp;</span></p>
<div></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm10" data-tab="cm10">
				<h3 class="txt_section_tit vcPartTitle">
								흥복전</h3>
                        <div class="hidden">
					흥복전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide9">
					<div class="swiper-wrapper" id="swiper-wrapper-10cc60da46684433" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Hingbokjeon.jpg" data-key="4801" alt="흥복전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p>흥복전(興福殿)은 고종 대 경복궁을 다시 지을 때 처음 지어졌다.&nbsp;이곳은 고종 연간에 독일, 일본, 이탈리아, 프랑스 등 외국 사신을 접견했다는 기록이 있다.&nbsp;<span style="color: rgb(19, 19, 19); text-align: justify;">이후 신정황후 조씨(24대 헌종의 어머니이자 26대 고종의 양어머니, 대한제국 선포 후 황후로 추존됨)가 세상을 떠난 곳이기도 하다.&nbsp;</span>흥복전은 일제강점기 때 철거되었다가 2020년에 복원하였다.</p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm11" data-tab="cm11">
				<h3 class="txt_section_tit vcPartTitle">
								향원정</h3>
                        <div class="hidden">
					향원정</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide10">
					<div class="swiper-wrapper" id="swiper-wrapper-fee1d5bcba1836a4" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Hyangwonjeong.jpg" data-key="4801" alt="향원정">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">향원정(香遠亭)은 1873년(고종 10) 고종이 건청궁을 지을 때 그 앞에 연못(향원지)을 파서 연못 가운데 섬을 만들고 2층의 육모지붕의 형태로 지었다. 향원정을 가기 위해 지은 다리는 ‘향기에 취한다’라는 뜻에 취향교(醉香橋)라고 불렀다. 2017년부터 2020년까지 향원정 보수공사 때 취향교는 원래의 자리로 복원하였다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm12" data-tab="cm12">
				<h3 class="txt_section_tit vcPartTitle">
								건청궁</h3>
                        <div class="hidden">
					건청궁</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide11">
					<div class="swiper-wrapper" id="swiper-wrapper-d21421a9c092caff" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Geoncheonggung.jpg" data-key="4801" alt="건천궁">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;">건청궁(乾淸宮)은 1873년(고종 10)에 왕과 왕비의 생활공간으로 지어진 궁 안의 궁이다.&nbsp;건청궁의 왕의 생활공간인 장안당(長安堂)과 왕비의 생활공간인 곤녕합(坤寧閤) 등으로 구성되어 있는데, 장안당과 곤녕합은 복도로 이어져 있다. 이곳에서 고종과 명성황후는 10년 정도 생활하였다. 2007년에 지금의 모습으로 복원하였다.</p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm13" data-tab="cm13">
				<h3 class="txt_section_tit vcPartTitle">
								집옥재</h3>
                        <div class="hidden">
					집옥재</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide12">
					<div class="swiper-wrapper" id="swiper-wrapper-210e8ccbff66caffc" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Jibokjae.jpg" data-key="4801" alt="집옥재">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">집옥재(集玉齋)는 1891년(고종 28) 창덕궁 함녕전의 별당이었던 집옥재와 협길당 등을 건청궁 서쪽으로 옮겨지은 것으로, 고종의 서재와 외국 사신을 접견하던 장소로 사용되었다.&nbsp;<span style="color: rgb(19, 19, 19); text-align: justify;">집옥재를 중심으로 왼쪽에 팔우정(八隅亭), 오른쪽에 협길당(協吉堂)이 있다.&nbsp;</span>집옥재는 경복궁의 전각 중 유일하게 현판이 세로형으로 되어있다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm14" data-tab="cm14">
				<h3 class="txt_section_tit vcPartTitle">
								태원전</h3>
                        <div class="hidden">
					태원전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide13">
					<div class="swiper-wrapper" id="swiper-wrapper-9103267edc6b8618c" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="course_img/gbg_img/Taewonjeon.jpg" data-key="4801" alt="태원전">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">태원전(泰元殿)은 태조의 어진을 모셨고, 이후에는&nbsp;빈전(殯殿, 왕과 왕비가 세상을 떠난 후 발인하기 전까지 재궁(관)을 모셔둔 건물)으로 사용되었다.&nbsp;태원전 주변에는 부속 건물인 문경전(文慶殿)과 공묵재(恭默齋), 영사재(永思齋) 등 의례용 건물이 있다. 태원전은&nbsp;2006년에 현재 모습으로 복원하였다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		</div>
	<!-- [E] course_num_con -->
<script type="text/javascript">
</script>
					</div>
				</div>
	</div>
</div>

<div class="dim">
	<div class="layer_popup pop_type02 pop_course" id="pop_course01">
		<div class="popup_body">
			<div class="course_pop_con">
				<ul class="list tab_menu">
					<li class="item tab_link">
							<a href="#;" data-tab="cs0">
								<span class="inn">🚶40분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" data-tab="cs1">
								<span class="inn">🚶60분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" data-tab="cs2">
								<span class="inn">🚶90분 코스</span>
							</a>
						</li>
					</ul>
			</div>
			<div class="top">
				<div class="right half">
					<div class="tab_con_wrap">
						<div class="tab_con cs0 current">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											</ol>
									</div>
								<div class="tab_con cs1">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">교태전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">강녕전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">자경전</div>
												</li>
											</ol>
									</div>
								<div class="tab_con cs2">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">강녕전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">교태전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">자경전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">향원정</div>
												</li>
											</ol>
									</div>
								</div>
				</div>
			</div>
			<div class="btm tab_con_wrap">
				<div class="tab_con cs0 current">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide0">
								<div class="swiper-wrapper" id="swiper-wrapper-cebdd16b24e348c2" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Heungnyemun.png" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Yeongjegyo.png" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Geunjeongjeon.png" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Sajeongjeon.png" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Sujeongjeon.png" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/40min/Gyeonghoeru.png" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
					<div class="tab_con cs1">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide1">
								<div class="swiper-wrapper" id="swiper-wrapper-9fb21bb2585d148a" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Heungnyemun.png" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Yeongjegyo.png" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Geunjeongjeon.png" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Sujeongjeon.png" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Gyotaejeon.png" alt="교태전">
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Gangnyeongjeon.png" alt="강녕전">
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Sajeongjeon.png" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Gyeonghoeru.png" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/60min/Jagyeongjeon.png" alt="자경전">
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
					<div class="tab_con cs2">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide2">
								<div class="swiper-wrapper" id="swiper-wrapper-79ca49fd16ebf06e" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Heungnyemun.png" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Yeongjegyo.png" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Geunjeongjeon.png" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Sujeongjeon.png" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Gyeonghoeru.png" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Sajeongjeon.png" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Gangnyeongjeon.png" alt="강녕전">
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Gyotaejeon.png" alt="교태전">
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Jagyeongjeon.png" alt="자경전">
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="course_img/gbg_img/90min/Hyangwonjeong.png" alt="향원정">
											</div>
											<div class="txt_wrap">향원정</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
			</div>
		</div>
	</div>
</div>


</article>
    </div> <!-- .container 닫는 태그 -->


