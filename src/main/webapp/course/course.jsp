<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람코스</title>

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/course/css/course_style.css" />
  <c:import url="/common/jsp/external_file.jsp"/>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>


<script type="text/javascript">

  let selectElement = null; 
  let mainContentDiv = null;
  let dim = null;
  let popup = null; 
  const swipers = {}; 

  function openPopup(tabId) {
    if (!dim || !popup) {
        console.error('Popup or Dim element is null when trying to open popup.');
        return;
    }
    if (!tabId || !tabId.startsWith('cs')) {
         console.error('Invalid tabId provided to openPopup:', tabId);
         if (tabId === 'csundefined' || tabId === 'csnull') {
             tabId = 'cs0';
         } else {
            return; 
         }
    }

    dim.style.display = 'block';
    popup.style.display = 'block';

    const tabLinks = popup.querySelectorAll('.tab_menu .item');
    if (tabLinks.length > 0) {
         tabLinks.forEach(link => {
           link.classList.remove('current');
         });
    } else {
         console.warn('No tab links (.tab_menu .item) found in popup.');
    }

    const targetTabLink = popup.querySelector('.tab_menu .item a[data-tab="' + tabId + '"]');
    if (targetTabLink) {
        targetTabLink.closest('.item').classList.add('current'); 
    } else {
         console.warn(`Tab link for ${tabId} not found in popup.`);
         const defaultTabLink = popup.querySelector('.tab_menu .item a[data-tab="cs0"]');
         if (defaultTabLink) {
             defaultTabLink.closest('.item').classList.add('current');
             tabId = 'cs0'; 
         } else {
             console.error('Default tab cs0 not found either. No tab could be activated.');
             return; 
         }
    }


    const tabContents = popup.querySelectorAll('.tab_con');
     if (tabContents.length > 0) {
         tabContents.forEach(content => {
           content.classList.remove('current'); 
         });
     } else {
         console.warn('No tab contents (.tab_con) found in popup.');
     }

    const targetTabContents = popup.querySelectorAll('.tab_con.' + tabId);
    if (targetTabContents.length > 0) {
         targetTabContents.forEach(content => {
            content.classList.add('current'); 

             const swiperEl = content.querySelector('.course_pop_slide');
             if (swiperEl) {
                 if (swipers[swiperEl.id]) {
                     swipers[swiperEl.id].update();
                     swipers[swiperEl.id].slideTo(0, 0);
                 } else if (!swiperEl.swiper) {
                     try {
                        swipers[swiperEl.id] = new Swiper('#' + swiperEl.id, {
                           direction: 'horizontal',
                           loop: false,
                           navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
                           slidesPerView: 'auto',
                           spaceBetween: 15,
                           observer: true,
                           observeParents: true,
                        });
                        swipers[swiperEl.id].update();
                     } catch (e) {
                        console.error('Error initializing Swiper inside popup:', swiperEl.id, e);
                     }
                 } else if (swiperEl.swiper) {
                      swiperEl.swiper.update();
                      swiperEl.swiper.slideTo(0, 0);
                 } else {
                      console.log('Swiper element found but no instance:', swiperEl.id);
                 }
             } else {
                 console.log('No Swiper element (.course_pop_slide) found in active popup tab content.');
             }
           });
    } else {
        console.warn(`No tab contents (.tab_con.${tabId}) found in popup for tabId: ${tabId}.`);
    }

  }

  function closePopup() {
    if (!dim || !popup) {
        console.error('Popup or Dim element is null when trying to close popup.');
        return;
    }
    dim.style.display = 'none';
    popup.style.display = 'none';

  }

   function handlePopupTabChange(tabId) {
       openPopup(tabId);
   }
  function initializeContentElements(containerElement) {
      const panzoomElem = containerElement.querySelector('#panzoom-container');
       if (panzoomElem) {
         const panzoom = Panzoom(panzoomElem, { maxScale: 5, minScale: 0.5, step: 0.2 });
         const zoomInButton = containerElement.querySelector('#zoomInButton');
         const zoomOutButton = containerElement.querySelector('#zoomOutButton');
         const resetButton = containerElement.querySelector('#resetButton');
         if(zoomInButton) { zoomInButton.addEventListener('click', () => panzoom.zoomIn()); }
         if(zoomOutButton) { zoomOutButton.addEventListener('click', () => panzoom.zoomOut()); }
         if(resetButton) { resetButton.addEventListener('click', () => panzoom.reset()); }
       } else {
         console.log('Panzoom container (#panzoom-container) not found in loaded main content.');
       }

       const buildingTabLinks = containerElement.querySelectorAll('.course_num_list .course_num_item');
       const photoDiv = containerElement.querySelector('#photoDiv');
       const buildingTabContents = photoDiv ? photoDiv.querySelectorAll('.tab_con') : [];

       if (buildingTabLinks.length > 0 && buildingTabContents.length > 0) {
           buildingTabLinks.forEach(function(link) {
               link.addEventListener('click', function(event) {
                   event.preventDefault();
                   const targetTab = this.getAttribute('data-tab');
                   buildingTabLinks.forEach(item => item.classList.remove('current'));
                   this.classList.add('current');
                   buildingTabContents.forEach(content => content.classList.remove('current'));
                   const activeContent = containerElement.querySelector('#photoDiv .tab_con.' + targetTab);
                   if (activeContent) {
                       activeContent.classList.add('current');
                       const swiperEl = activeContent.querySelector('.course_slide');
                        if (swiperEl) {
                            if (swipers[swiperEl.id]) { console.log('Updating existing building Swiper:', swiperEl.id); swipers[swiperEl.id].update(); swipers[swiperEl.id].slideTo(0, 0); }
                            else if (!swiperEl.swiper) { console.log('Initializing building Swiper:', swiperEl.id); try { swipers[swiperEl.id] = new Swiper('#' + swiperEl.id, { direction: 'horizontal', loop: false, navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' }, slidesPerView: 1, spaceBetween: 0, observer: true, observeParents: true, }); swipers[swiperEl.id].update(); console.log('Building Swiper initialized and updated:', swiperEl.id); } catch (e) { console.error('Error initializing building Swiper:', swiperEl.id, e); } }
                            else if (swiperEl.swiper) { console.log('Updating building Swiper instance on element:', swiperEl.id); swiperEl.swiper.update(); swiperEl.swiper.slideTo(0, 0); }
                            else { console.log('Building Swiper element found but no instance:', swiperEl.id); }
                        } else { console.log('No Swiper element (.course_slide) found in active building tab content.'); }
                   } else { console.error('Active building tab content element not found:', '#photoDiv .tab_con.' + targetTab); }
               });
           });
            const initialActiveBuildingTabContent = photoDiv ? photoDiv.querySelector('.tab_con.current') : null;
            if (initialActiveBuildingTabContent) {
                const initialBuildingSwiperElement = initialActiveBuildingTabContent.querySelector('.course_slide');
                 if (initialBuildingSwiperElement) {
                       if (swipers[initialBuildingSwiperElement.id]) { console.log('Updating initial building Swiper (exists).'); swipers[initialBuildingSwiperElement.id].update(); swipers[initialBuildingSwiperElement.id].slideTo(0, 0); }
                       else if (initialBuildingSwiperElement.swiper) { console.log('Updating initial building Swiper (on element).'); initialBuildingSwiperElement.swiper.update(); initialBuildingSwiperElement.swiper.slideTo(0, 0); }
                       else { console.log('Initializing initial building Swiper:', initialBuildingSwiperElement.id); try { swipers[initialBuildingSwiperElement.id] = new Swiper('#' + initialBuildingSwiperElement.id, { direction: 'horizontal', loop: false, navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' }, slidesPerView: 1, spaceBetween: 0, observer: true, observeParents: true, }); swipers[initialBuildingSwiperElement.id].update(); console.log('Initial building Swiper initialized and updated.'); } catch (e) { console.error('Error initializing initial building Swiper:', initialBuildingSwiperElement.id, e); } }
                 } else { console.log('No Swiper element found in initial active building tab content.'); }
            } else { console.log('No initial active building tab content found.'); }
       } else {
           console.log('Building info tab elements (.course_num_list, #photoDiv .tab_con) not found in loaded main content.');
       }
  }

  
  function loadContent(selectedValue) {

      if (!mainContentDiv || !popup) {
           console.error('mainContentDiv or popup element not found! Cannot load content.');
           return;
      }

      if (!selectedValue) {
           mainContentDiv.innerHTML = '';
           selectElement = null;

            const popupBody = popup.querySelector('.popup_body');
            if (popupBody) {
                 popupBody.innerHTML = '';
            } else {
                 console.error('Popup body element (.popup_body) not found inside popup!');
            }
           return;
      }

      const targetJspPath = '${pageContext.request.contextPath}/course/' +'course_'+ selectedValue + '.jsp';

      fetch(targetJspPath)
          .then(response => {
              if (!response.ok) {
                  console.error('Network response for main content was not ok ' + response.statusText);
                  mainContentDiv.innerHTML = '<div>페이지 로드 실패: ' + response.statusText + ' (' + response.status + ')</div>';
                   selectElement = document.getElementById('main-content').querySelector('.sel_st');
                  if (selectElement) {
                       selectElement.removeEventListener('change', handleSelectChange);
                       selectElement.addEventListener('change', handleSelectChange);
                  }
                  return Promise.reject('메인 콘텐츠 로드 실패');
              }
              return response.text();
          })
          .then(html => {
              const tempDiv = document.createElement('div');
              tempDiv.innerHTML = html;
              const scriptsToExecute = Array.from(tempDiv.querySelectorAll('script'));
              scriptsToExecute.forEach(script => script.remove());
              const contentWithoutScripts = tempDiv.innerHTML;
              mainContentDiv.innerHTML = contentWithoutScripts;

               selectElement = mainContentDiv.querySelector('.sel_st');
               if (selectElement) {
                    selectElement.removeEventListener('change', handleSelectChange);
                    selectElement.addEventListener('change', handleSelectChange);
               } else {
                    console.warn('New select element (.sel_st) not found after main content replacement! Cannot set up listener.');
               }

              initializeContentElements(mainContentDiv);

              const popupContentJspPath = '${pageContext.request.contextPath}/course/popup_' + selectedValue + '.jsp';

               return fetch(popupContentJspPath);
          })
           .then(response => {
                if (!response.ok) {
                    console.error('Network response for popup content was not ok ' + response.statusText);
                    if (popup) {
                        const popupBody = popup.querySelector('.popup_body');
                        if (popupBody) {
                            popupBody.innerHTML = '<div>팝업 콘텐츠 로드 실패.</div>';
                        }
                    }
                    return Promise.resolve(null);
                }
                return response.text();
           })
           .then(popupHtml => {
               if (popupHtml !== null && popup) {
                   const popupBody = popup.querySelector('.popup_body');
                    if (popupBody) {
                       popupBody.innerHTML = popupHtml;

                    } else {
                        console.error('Popup body element (.popup_body) not found inside popup during content replacement!');
                    }
               }
           })
          .catch(error => {
              console.error('Overall fetch or processing error:', error);
          });
  }

  function handleSelectChange() {
      const selectedValue = this.value;
      loadContent(selectedValue);
  }

  document.addEventListener('DOMContentLoaded', function() {
    mainContentDiv = document.getElementById('main-content');
    dim = document.querySelector('.dim');
    popup = document.getElementById('pop_course01');
    if (!mainContentDiv) { console.error('Element with ID "main-content" not found! Cannot proceed.'); return; }
    if (!dim) console.warn('Dim element (.dim) not found. Popup dimming will not work.');
    if (!popup) console.warn('Popup element (#pop_course01) not found. Popup functionality will be limited.');

    if (dim) { dim.addEventListener('click', function(e) { if (e.target === dim) { closePopup(); } }); }
    if (popup) {
        const closeBtn = popup.querySelector('.popup_close');
        if (closeBtn) { closeBtn.addEventListener('click', function(e) { e.preventDefault(); closePopup(); }); } 

        const popupTabMenu = popup.querySelector('.tab_menu ul'); 
         popup.addEventListener('click', function(e) { 
             const targetLink = e.target.closest('.tab_menu .item a');
             if(targetLink) {
                 e.preventDefault();
                 const tabId = targetLink.getAttribute('data-tab');
                 handlePopupTabChange(tabId);
             }
         });

    } 

     if (mainContentDiv) {
        mainContentDiv.addEventListener('click', function(event) {
            const clickedCourseLink = event.target.closest('ul.list.course_info_list li.item a');
            if (clickedCourseLink) {
                 event.preventDefault();
                 const listItem = clickedCourseLink.closest('li.item');
                 const tabNum = listItem ? listItem.getAttribute('data-num') : null;
                 openPopup('cs' + tabNum);
            }
             const clickedDynamicButton = event.target.closest('.dynamic-button');
        });
     }

    selectElement = mainContentDiv.querySelector('.sel_st');
    if (selectElement) {
         selectElement.addEventListener('change', handleSelectChange);
         loadContent(selectElement.value);
    } else {
         console.error('Initial select element (.sel_st) not found in main-content! Cannot set up initial listener or load initial content.');
          if (mainContentDiv && mainContentDiv.innerHTML.trim() !== '') {
              initializeContentElements(mainContentDiv);
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
    display: flex;
    flex-direction: column; 
}

.f-custom-controls button {
	width: 32px;
	height: 32px;
	background: none;
	border: none;
	margin: 0;
	padding: 0;
	background: rgba(0, 0, 0, 0.5); 
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
    outline: none; 
    transition: background-color 0.2s ease;
}
.f-custom-controls button:hover {
    background: rgba(0, 0, 0, 0.7); 
}


.f-custom-controls svg {
	pointer-events: none; 
	width: 18px;
	height: 18px;
	stroke: #fff; 
	stroke-width: 2;
}
.f-custom-controls button img {
    display: block;
    width: 20px;
    height: 20px;
}


.f-custom-controls button[disabled] svg,
.f-custom-controls button[disabled] img {
	opacity: 0.5;
    cursor: not-allowed; 
}

.f-custom-controls button:not(:last-child) {
    border-bottom: 1px solid rgba(255, 255, 255, 0.3); 
}

.f-custom-controls.top-right {
	right: 16px;
	top: 16px;
}

.f-custom-controls.bottom-right {
	right: 16px;
	bottom: 16px;
}

.dim {
    position: fixed; 
    top: 0;
    left: 0;
    right: 0;
    bottom: 0; 
    background-color: rgba(0, 0, 0, 0.5); 
    z-index: 9998; 
    display: none; 
    backdrop-filter: blur(4px); 
    -webkit-backdrop-filter: blur(4px); 
}

#pop_course01.popup {
    position: fixed; 
    top: 50%; 
    left: 50%; 
    transform: translate(-50%, -50%); 
    z-index: 9999; 
    background-color: #fff;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); 
    max-width: 90%; 
    max-height: 90vh;
    overflow: hidden; 
    display: none; 
    width: 800px; 
    display: flex; 
    flex-direction: column;
}

#pop_course01 .popup_body {
    width: 100%; 
    height: 100%; 
    padding: 20px; 
    overflow-y: auto; 
    display: flex; 
    flex-direction: column;
    gap: 20px; 
}

#pop_course01 .popup_header {
    padding: 15px 20px;
    border-bottom: 1px solid #eee;
    font-size: 1.2em;
    font-weight: bold;
    color: #333;
}

#pop_course01 .tab_menu ul {
    list-style: none;
    padding: 0;
    margin: 0; 
    display: flex; 
    border-bottom: 2px solid #eee;
}

#pop_course01 .tab_menu li.item {
    margin-right: 15px;
    padding-bottom: 10px; /
    cursor: pointer;
    transition: color 0.3s ease, border-bottom-color 0.3s ease; 
}

#pop_course01 .tab_menu li.item a {
    text-decoration: none;
    color: #555;
    font-weight: 500;
    display: block; 
}

#pop_course01 .tab_menu li.item.current {
    border-bottom-color: #007bff; 
    margin-bottom: -2px;
}

#pop_course01 .tab_menu li.item.current a {
    color: #007bff;
}

#pop_course01 .tab_con_wrap {
     flex-grow: 1;
     position: relative; 
     width: 100%; 
     overflow: hidden; 
}

#pop_course01 .tab_con {
    display: none;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow-y: auto;
    box-sizing: border-box; 
    padding-right: 15px; 
}

#pop_course01 .tab_con.current {
    display: block; 
    position: static; 
}

#pop_course01 .course_list {
    list-style: none;
    padding: 0;
    margin: 0 0 20px 0; 
}

#pop_course01 .course_list .course_item {
    display: flex;
    align-items: center;
    margin-bottom: 8px; 
}

#pop_course01 .course_list .course_dot {
    width: 10px;
    height: 10px;
    background-color: #007bff; 
    margin-right: 10px;
    flex-shrink: 0;
}

#pop_course01 .course_list .course_txt {
    font-size: 1em;
    color: #333;
}


#pop_course01 .course_pop_slide.swiper {
    width: 100%; 
    overflow: hidden;
    margin-top: 20px;
    padding-bottom: 30px; 
    position: relative;
}

#pop_course01 .course_pop_slide .swiper-wrapper {
    display: flex; 
    box-sizing: content-box; 
}

#pop_course01 .course_pop_slide .swiper-slide {
    width: auto;
    margin-right: 15px;
    flex-shrink: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

#pop_course01 .course_pop_slide .img_wrap {
    width: 240px; 
    height: 160px; 
    overflow: hidden; 
    margin-bottom: 8px;
    background-color: #eee; 
    display: flex;
    justify-content: center;
    align-items: center;
}

#pop_course01 .course_pop_slide .img_wrap img {
    display: block;
    width: 100%; 
    height: 100%; 
    object-fit: cover; 
}

#pop_course01 .course_pop_slide .txt_wrap {
    font-size: 0.9em;
    color: #555;
    text-align: center;
}

#pop_course01 .top {
    display: flex;
     gap: 20px; 
}

#pop_course01 .top .right.half {
     flex-grow: 1; 
}

#pop_course01 .popup_body {
    width: 100%; 
    height: 100%; 
    padding: 20px; 
    overflow-y: auto; 
    display: flex;
    flex-direction: column;
    gap: 20px; 
}

#pop_course01 .course_pop_slide.swiper .swiper-scrollbar-drag {
    height: 100%;
    width: 100%;
    position: relative;
    background: rgba(0, 0, 0, 0.5);
    left: 0;
    top: 0;
}

#pop_course01 .course_pop_slide.swiper .swiper-scrollbar {
    position: absolute;
    bottom: 0; 
    left: 0; 
    width: 100%; 
    height: 5px; 
    background: rgba(0, 0, 0, 0.1); 
}
</style>

</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문: 콘텐츠가 동적으로 로드될 영역 -->
  <div id="main-content">
      <jsp:include page="/course/course_gbg.jsp" />
  </div>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />

  <div class="dim" style="display: none;"></div>
  <div id="pop_course01" class="popup" style="display: none;">
        <div class="popup_body">
        </div>
  </div>


</body>
</html>
  