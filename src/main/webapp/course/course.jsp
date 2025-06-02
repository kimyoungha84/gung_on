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



</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
    <div id="main-content">
  <jsp:include page="/course/course_cdg.jsp" />
	</div>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
  
  
<script>
document.addEventListener('DOMContentLoaded', function() {
    // select 박스 요소를 가져옵니다. 클래스명이 sel_st이므로 해당 클래스로 선택합니다.
    const selectElement = document.querySelector('.sel_st');
    const mainContentDiv = document.getElementById('main-content');

    // (이벤트 위임을 사용하실 경우 이전에 설명드린 document 레벨 리스너는 유지하시면 좋습니다.)
    // document.addEventListener('click', function(event) { ... });

    // select 박스의 값이 변경될 때마다 실행될 이벤트 리스너를 추가합니다.
    selectElement.addEventListener('change', function() {
        // 선택된 option의 value 값을 가져옵니다.
        const selectedValue = this.value;
        // 가져올 JSP 파일의 경로를 생성합니다.
        const targetJspPath = '/Gung_On/course/' +'course_'+ selectedValue + '.jsp';

        // AJAX 요청을 보냅니다. (fetch API 사용)
        fetch(targetJspPath)
            .then(response => {
                if (!response.ok) {
                    console.error('Network response was not ok ' + response.statusText);
                    return Promise.reject('페이지 로드 실패: ' + response.statusText);
                }
                return response.text();
            })
            .then(html => {
                // --- HTML 내용에서 스크립트 추출 및 실행 로직 시작 ---

                // 1. 임시 DOM 요소를 만들어 가져온 HTML 문자열을 파싱합니다.
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = html;

                // 2. 파싱된 HTML에서 모든 <script> 요소를 찾습니다.
                const scriptsToExecute = Array.from(tempDiv.querySelectorAll('script'));

                // 3. <script> 요소는 mainContentDiv.innerHTML에 삽입하면 실행되지 않으므로,
                //    원본 HTML에서는 제거하고 HTML 내용만 가져옵니다.
                scriptsToExecute.forEach(script => script.remove());
                const contentWithoutScripts = tempDiv.innerHTML;

                // 4. 스크립트가 제거된 HTML 내용을 #main-content div 안에 삽입하여 교체합니다.
                mainContentDiv.innerHTML = contentWithoutScripts;

                // 5. 추출해 둔 스크립트 요소를 순회하며 새로 생성하여 실행합니다.
                scriptsToExecute.forEach(oldScript => {
                    const newScript = document.createElement('script');

                    // 원본 스크립트의 속성(src, type 등)을 새 스크립트에 복사합니다.
                    Array.from(oldScript.attributes).forEach(attr => {
                        newScript.setAttribute(attr.name, attr.value);
                    });

                    // 인라인 스크립트 내용이 있다면 복사합니다.
                    if (oldScript.textContent) {
                        newScript.textContent = oldScript.textContent;
                    }

                    // 새 스크립트 요소를 DOM에 추가합니다. (mainContentDiv 안에 추가하는 것이 일반적입니다)
                    // DOM에 추가되는 순간 스크립트가 실행됩니다.
                    mainContentDiv.appendChild(newScript);
                });

                // --- 스크립트 추출 및 실행 로직 끝 ---

            })
            .catch(error => {
                console.error('Fetch error:', error);
                mainContentDiv.innerHTML = '<div>데이터를 가져오는 중 오류가 발생했습니다.</div>';
                alert('콘텐츠 로드 중 오류가 발생했습니다.');
            });
    });
});
</script>

<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
