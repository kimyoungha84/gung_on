<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람코스</title>

  <link rel="stylesheet" type="text/css" href="/Gung_On/course/css/course_style.css" />
  <c:import url="/common/jsp/external_file.jsp"/>

<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

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
<script type="text/javascript" src="course_js/panzoom.min.js"></script>
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
            // -------------------------------------

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
	  // 팝업 요소가 존재할 때만 querySelectorAll 실행
	  const tabLinks = popup ? popup.querySelectorAll('.tab_menu .item') : [];
	  const tabContents = popup ? popup.querySelectorAll('.tab_con') : [];

	  // Swiper 인스턴스 저장용
	  const swipers = {};

	  // Swiper 초기화 함수 (팝업 내 모든 슬라이드)
	  function initSwipers() {
	    // 팝업 요소가 존재하고 콘텐츠들이 있을 때만 초기화 시도
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
                // 기타 필요한 옵션 추가
              });
            }
          });
	    }
	  }

	  // 팝업 열기 및 탭 활성화 함수
	  function openPopup(tabId) {
	    if (dim && popup) { // 팝업 요소가 존재할 때만 실행
          dim.style.display = 'block';
          popup.style.display = 'block';

          // 팝업 내부 탭 메뉴 활성화
          tabLinks.forEach(link => {
            // data-tab 속성을 가진 <a> 태그를 찾고 그 부모 li에 current 클래스 토글
            const anchor = link.querySelector('a');
            if (anchor) {
              link.classList.toggle('current', anchor.getAttribute('data-tab') === tabId);
            }
          });

          // 팝업 내부 탭 콘텐츠 표시
          tabContents.forEach(content => {
            // 해당 tabId 클래스를 가진 .tab_con 콘텐츠에 current 클래스 토글
            content.classList.toggle('current', content.classList.contains(tabId));
            // 활성화된 콘텐츠의 Swiper 업데이트
            if (content.classList.contains(tabId)) {
              const swiperEl = content.querySelector('.course_pop_slide');
              if (swiperEl && swipers[swiperEl.id]) {
                swipers[swiperEl.id].update();
                swipers[swiperEl.id].slideTo(0, 0); // 첫 슬라이드로 이동
              }
            }
          });

          // 모든 스와이퍼가 제대로 업데이트되었는지 확인 (선택 사항)
          // Object.values(swipers).forEach(swiper => swiper.update());
	    }
	  }

	  // 팝업 닫기 함수
	  function closePopup() {
	    if (dim && popup) { // 팝업 요소가 존재할 때만 실행
          dim.style.display = 'none';
          popup.style.display = 'none';
          // 팝업 닫힐 때 슬라이드 초기화 (첫 슬라이드로 이동)
          Object.values(swipers).forEach(swiper => swiper.slideTo(0, 0));
	    }
	  }

	  // --- 이벤트 리스너 연결 ---

	  // 1. 메인 코스 링크 클릭 이벤트
	  courseLinks.forEach(link => {
	    link.addEventListener('click', e => {
	      e.preventDefault();
	      const tabNum = link.parentElement.getAttribute('data-num');
	      openPopup('cs' + tabNum); // 클릭된 data-num에 해당하는 tabId로 팝업 열기
	    });
	  });

	  // 2. 팝업 배경 클릭 시 닫기
	  if (dim) { // dim 요소가 있을 때만 이벤트 연결
          dim.addEventListener('click', e => {
              if (e.target === dim) {
                closePopup();
              }
          });
	  }

	  // 3. 팝업 내 탭 메뉴 클릭 시 탭 전환
	  tabLinks.forEach(link => {
	    link.addEventListener('click', e => {
	      e.preventDefault();
	      const tabId = link.querySelector('a').getAttribute('data-tab');
	      openPopup(tabId); // 클릭된 팝업 탭 ID로 팝업 열기 (실제로는 내용만 전환)
	    });
	  });

	  // 4. 팝업 내 닫기 버튼 클릭 시 닫기
	  const closeBtn = popup ? popup.querySelector('.popup_close') : null; // 팝업 요소가 있을 때만 닫기 버튼 찾기
	  if (closeBtn) { // 닫기 버튼이 있을 때만 이벤트 연결
	    closeBtn.addEventListener('click', e => {
	      e.preventDefault();
	      closePopup();
	    });
	  }

	  // --- 초기화 실행 ---
	  // 페이지 로드 시 팝업 내부 Swiper 초기화 시도 (팝업이 숨겨져 있어도 observer 옵션이 도움)
	  initSwipers();

    // --- 페이지 로드 시 팝업 내부의 기본 탭 활성화 (선택 사항) ---
    // 만약 팝업이 열리기 전에도 팝업 내부에서 특정 탭이 'current' 클래스를 가지고 있다면,
    // 해당 내용을 미리 보이도록 CSS를 설정하고, 여기서 해당 스와이퍼를 업데이트 해줘야 합니다.
    // 예시: HTML에 <div class="tab_con cs0 current">...</div> 가 있다면, CSS에서 기본 보이도록 하고
    // 아래 코드를 추가하여 해당 Swiper를 초기 업데이트 해줍니다.
    if (popup) { // 팝업 요소가 있을 때만 실행
        const initialActiveContent = popup.querySelector('.tab_con.current');
        if (initialActiveContent) {
             const initialSwiperElement = initialActiveContent.querySelector('.course_pop_slide');
             // Swiper 인스턴스가 존재하고 초기화되었다면 업데이트 시도
             if (initialSwiperElement && swipers[initialSwiperElement.id]) {
                  swipers[initialSwiperElement.id].update();
             }
        }
    }
});
</script>



</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <jsp:include page="/course/course_cdg.jsp" />


  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
