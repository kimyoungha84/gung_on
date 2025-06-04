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
<!-- Panzoom JS -->
  <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>


<!-- 메인 페이지 전용 JavaScript -->
<script type="text/javascript">

  // 전역(또는 넓은 스코프)에서 접근 가능한 변수들 선언
  let selectElement = null;
  let mainContentDiv = null;
  let dim = null;
  let popup = null;
  const swipers = {}; // Swiper 인스턴스를 관리할 객체

  // 팝업 열기 함수 (전역 접근 가능)
  function openPopup(tabId) {
    console.log('openPopup called with tabId:', tabId);
    // dim과 popup 요소가 null이 아닌지 확인
    if (!dim || !popup) {
        console.error('Popup or Dim element is null when trying to open popup. Ensure they exist in the main HTML.');
        return;
    }
    // tabId가 유효한 형식인지 간단히 확인 (예: "cs1", "cs2" 등)
    if (!tabId || !tabId.startsWith('cs')) {
         console.error('Invalid tabId provided to openPopup:', tabId);
         return;
    }


    dim.style.display = 'block';
    popup.style.display = 'block';

    // 팝업 내 탭 링크들 업데이트
    const tabLinks = popup.querySelectorAll('.tab_menu .item');
     tabLinks.forEach(link => {
       const anchor = link.querySelector('a');
       if (anchor) {
         // data-tab 속성 값이 일치하는지 확인하여 current 클래스 토글
         link.classList.toggle('current', anchor.getAttribute('data-tab') === tabId);
       }
     });

    // 팝업 내 탭 콘텐츠들 업데이트 및 해당 Swiper 업데이트/초기화
    const tabContents = popup.querySelectorAll('.tab_con');
     tabContents.forEach(content => {
       // content의 클래스 목록에 tabId 값이 포함되어 있는지 확인하여 current 클래스 토글
       content.classList.toggle('current', content.classList.contains(tabId));
       if (content.classList.contains(tabId)) {
         const swiperEl = content.querySelector('.course_pop_slide');
         if (swiperEl) {
             // Swiper 인스턴스 관리 (swipers 객체 활용)
             if (swipers[swiperEl.id]) {
                 swipers[swiperEl.id].update();
                 swipers[swiperEl.id].slideTo(0, 0); // 첫 슬라이드로 이동
                 console.log('Updated existing Swiper in popup tab:', swiperEl.id);
             } else if (!swiperEl.swiper) { // swipers 객체에 없지만, 요소에 인스턴스가 직접 연결되지 않았다면 초기화 시도
                 console.log('Initializing Swiper inside popup:', swiperEl.id);
                 try {
                    // Fetch된 JSP에 있는 Swiper도 이 함수로 초기화될 수 있도록 설정은 여기서 통일
                    swipers[swiperEl.id] = new Swiper('#' + swiperEl.id, {
                       direction: 'horizontal', loop: false,
                       navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
                       slidesPerView: 'auto', spaceBetween: 15, observer: true, observeParents: true,
                    });
                    swipers[swiperEl.id].update();
                     console.log('Initialized and updated Swiper in popup tab:', swiperEl.id);
                 } catch (e) {
                    console.error('Error initializing Swiper inside popup:', swiperEl.id, e);
                 }
             } else if (swiperEl.swiper) { // 요소 자체에 인스턴스가 있다면 업데이트
                  swiperEl.swiper.update();
                  swiperEl.swiper.slideTo(0, 0);
                   console.log('Updated Swiper instance on element in popup tab:', swiperEl.id);
             } else {
                  console.log('Swiper element found but no instance in swipers or on element:', swiperEl.id);
             }
         } else {
             console.log('No Swiper element found in popup tab:', tabId);
         }
       }
     });

  }

  // 팝업 닫기 함수 (전역 접근 가능)
  function closePopup() {
    console.log('closePopup called');
    // dim과 popup 요소가 null이 아닌지 확인
    if (!dim || !popup) {
        console.error('Popup or Dim element is null when trying to close popup.');
        return;
    }
    dim.style.display = 'none';
    popup.style.display = 'none';
    // 팝업 닫을 때 모든 Swiper 슬라이드를 처음으로 되돌립니다.
    Object.values(swipers).forEach(swiper => {
        if (swiper && typeof swiper.slideTo === 'function') { // 유효한 Swiper 인스턴스인지 확인
            swiper.slideTo(0, 0);
        }
    });
     console.log('Popup closed and swipers reset to slide 0.');
  }

  // 팝업 내부 탭 변경 처리 함수 (openPopup 함수 내에서 로직 직접 수행하도록 수정)
  // 만약 팝업 내부 탭 클릭 이벤트 리스너에서 직접 호출한다면 필요합니다.
   function handlePopupTabChange(tabId) {
       console.log('handlePopupTabChange called with tabId:', tabId);
       if (popup) {
            // 팝업 내부 탭 전환 로직은 openPopup 함수가 이미 처리합니다.
            // 따라서 openPopup을 호출하여 팝업을 다시 열고 해당 탭으로 이동시키는 방식으로 재활용합니다.
            openPopup(tabId);
       } else {
           console.error('Popup element not found for handlePopupTabChange.');
       }
   }


   // 초기 페이지 로드 시 또는 특정 시점에 존재하는 모든 Swiper를 초기화하는 함수
   // 주로 팝업 내 Swiper 초기화에 사용 (메인 페이지에 팝업이 있다고 가정)
   function initSwipers() {
        console.log('initSwipers called');
        // popup 요소가 null이 아닌지 확인
        if (!popup) {
            console.log('Popup element not found for initSwipers.');
            return;
        }

        const swiperEls = popup.querySelectorAll('.course_pop_slide');
        if (swiperEls.length > 0) {
             console.log(`Found ${swiperEls.length} initial Swiper elements in popup.`);
            swiperEls.forEach(swiperEl => {
                 if (!swiperEl || swiperEl.id === '') {
                    console.warn('Skipping Swiper initialization due to missing element or ID:', swiperEl);
                    return; // 유효하지 않은 요소는 건너뛰기
                 }

                // 이미 초기화되었거나 swipers 객체에 있다면 건너뜁니다.
                if (swiperEl.swiper || swipers[swiperEl.id]) {
                     console.log('Initial Swiper already initialized or in swipers object, skipping initialization:', swiperEl.id);
                     // 이미 초기화된 Swiper라면 업데이트만 호출
                     const swiperInstance = swipers[swiperEl.id] || swiperEl.swiper;
                     if (swiperInstance) swiperInstance.update();
                     return;
                }

                // 아직 초기화되지 않았다면 초기화
                console.log('Initializing initial Swiper:', swiperEl.id);
                 try {
                   swipers[swiperEl.id] = new Swiper('#' + swiperEl.id, {
                      direction: 'horizontal', loop: false,
                      navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                      },
                      slidesPerView: 'auto',
                      spaceBetween: 15,
                      observer: true,
                      observeParents: true,
                   });
                    swipers[swiperEl.id].update(); // 초기화 후 업데이트
                     console.log('Initial Swiper initialized and updated:', swiperEl.id);
                } catch (e) {
                   console.error('Error initializing initial Swiper:', swiperEl.id, e);
                }
            });
        } else {
             console.log('No initial Swiper elements found in popup.');
        }
   }


  // 페이지의 모든 DOM 요소가 로드되고 파싱된 후 실행
  document.addEventListener('DOMContentLoaded', function() {
    console.log('--- Main DOMContentLoaded listener started ---');

    // 필요한 DOM 요소들을 가져와 전역 변수에 할당합니다.
    selectElement = document.querySelector('.sel_st');
    mainContentDiv = document.getElementById('main-content');
    dim = document.querySelector('.dim'); // 메인 페이지에 dim 요소가 있다면
    popup = document.getElementById('pop_course01'); // 메인 페이지에 팝업 요소가 있다면

    // 필수 요소가 있는지 확인
    if (!selectElement) {
        console.error('Element with class "sel_st" not found! Cannot proceed.');
        return; // 필수 요소 없으면 중단
    }
    if (!mainContentDiv) {
        console.error('Element with ID "main-content" not found! Cannot proceed.');
        return; // 필수 요소 없으면 중단
    }
    // dim, popup은 필수가 아닐 수도 있지만, 관련 기능 사용 시 필요
    if (!dim) console.log('Dim element (.dim) not found on initial load.');
    if (!popup) console.log('Popup element (#pop_course01) not found on initial load.');


    // 1. Panzoom 초기화 (초기 main-content 내부 요소에 적용)
    console.log('Initializing Panzoom...');
    // mainContentDiv가 null일 수 있으므로 체크
    if (mainContentDiv) {
        const panzoomElem = mainContentDiv.querySelector('#panzoom-container'); // mainContentDiv 안에서 찾기
         if (panzoomElem) {
           const panzoom = Panzoom(panzoomElem, {
             maxScale: 5, minScale: 0.5, step: 0.2
           });
            // 버튼 이벤트도 mainContentDiv 안에서 찾아서 연결
           const zoomInButton = mainContentDiv.querySelector('#zoomInButton');
           const zoomOutButton = mainContentDiv.querySelector('#zoomOutButton');
           const resetButton = mainContentDiv.querySelector('#resetButton');

           if(zoomInButton) zoomInButton.addEventListener('click', () => panzoom.zoomIn());
           if(zoomOutButton) zoomOutButton.addEventListener('click', () => panzoom.zoomOut());
           if(resetButton) resetButton.addEventListener('click', () => panzoom.reset());
           console.log('Panzoom initialized.');
         } else {
           console.log('Panzoom container (#panzoom-container) not found in initial main-content.');
         }
    }


    // 2. 초기 탭 기능 설정 (초기 main-content 내부 요소에 적용)
    console.log('Setting up initial tabs...');
     if (mainContentDiv) {
        const initialTabLinks = mainContentDiv.querySelectorAll('.course_num_list .course_num_item'); // mainContentDiv 안에서 찾기
        const initialTabContents = mainContentDiv.querySelectorAll('#photoDiv .tab_con'); // mainContentDiv 안에서 찾기

        if (initialTabLinks.length > 0 && initialTabContents.length > 0) {
            initialTabLinks.forEach(function(link) {
                link.addEventListener('click', function(event) {
                    event.preventDefault();
                    const targetTab = this.getAttribute('data-tab');

                    initialTabLinks.forEach(item => item.classList.remove('current'));
                    this.classList.add('current');
                    initialTabContents.forEach(content => content.classList.remove('current'));

                    const activeContent = mainContentDiv.querySelector('#photoDiv .tab_con.' + targetTab);
                    if (activeContent) {
                        activeContent.classList.add('current');
                        // 탭 전환 후 Swiper 업데이트 (swipers 객체는 전역)
                        const swiperEl = activeContent.querySelector('.course_pop_slide');
                        if (swiperEl && swipers[swiperEl.id]) { // swipers 객체에 인스턴스가 있다면
                             swipers[swiperEl.id].update();
                             swipers[swiperEl.id].slideTo(0, 0);
                        } else if (swiperEl && swiperEl.swiper) { // 요소 자체에 인스턴스가 있다면
                             swiperEl.swiper.update();
                             swiperEl.swiper.slideTo(0, 0);
                        }
                    }
                });
            });
            console.log('Initial tabs setup complete.');
        } else {
            console.log('Initial tab elements not found in main-content.');
        }
     }


    // 3. 팝업/Dim 닫기 이벤트 연결 (dim과 popup이 메인 페이지에 처음부터 존재한다는 가정 하에)
    console.log('Setting up initial popup close listeners...');
    if (dim) {
        dim.addEventListener('click', function(e) {
            if (e.target === dim) {
              closePopup(); // 전역 closePopup 함수 호출
            }
        });
         console.log('Dim click listener attached.');
    }
    if (popup) {
        const closeBtn = popup.querySelector('.popup_close');
        if (closeBtn) {
            closeBtn.addEventListener('click', function(e) {
                e.preventDefault();
                closePopup(); // 전역 closePopup 함수 호출
            });
            console.log('Popup close button listener attached.');
        }

        // 초기 로드 시 팝업 내 탭 링크 이벤트 연결 (팝업이 동적 로드되면 해당 스크립트에서 처리)
        const tabLinksInPopup = popup.querySelectorAll('.tab_menu .item');
         tabLinksInPopup.forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const tabId = this.querySelector('a').getAttribute('data-tab');
                // 팝업 내부 탭 전환 로직
                handlePopupTabChange(tabId); // 전역 handlePopupTabChange 함수 호출
            });
        });
         console.log('Popup internal tab listeners attached.');

        // 초기 로드 시 팝업 내 Swiper들 초기화
         initSwipers(); // 전역 initSwipers 함수 호출
         console.log('Initial popup Swipers initialized.');

         // 초기 로드 시 팝업 내 현재 활성 탭의 Swiper 업데이트
          const initialActiveContent = popup.querySelector('.tab_con.current');
           if (initialActiveContent) {
                const initialSwiperElement = initialActiveContent.querySelector('.course_pop_slide');
                if (initialSwiperElement && swipers[initialSwiperElement.id]) {
                     swipers[initialSwiperElement.id].update();
                } else if (initialSwiperElement && initialSwiperElement.swiper) {
                    initialSwiperElement.swiper.update();
                }
           }


    } else {
         console.log('Popup or Dim element not found for close listeners.');
    }


    // 4. mainContentDiv에 이벤트 위임 리스너 추가 (코스 링크 클릭 감지)
    // 동적으로 로드된 콘텐츠 내의 코스 링크(.course_info_list li.item a) 클릭 시
    // 이 리스너가 감지하여 전역 openPopup 함수를 호출합니다.
    console.log('Setting up event delegation listener on main-content...');
     // mainContentDiv가 null일 수 있으므로 체크
     if (mainContentDiv) {
        mainContentDiv.addEventListener('click', function(event) {
            // console.log('Click detected inside main-content');
            // console.log('Clicked element:', event.target);

            // 클릭된 요소 또는 가장 가까운 조상 요소가 'ul.list.course_info_list li.item a'에 해당하는지 확인
            // closest()는 event.target부터 시작하여 상위로 올라가며 첫 번째 일치하는 요소를 찾습니다.
            const clickedCourseLink = event.target.closest('ul.list.course_info_list li.item a');

            // 코스 링크 클릭 이벤트 처리 (이벤트 위임)
            if (clickedCourseLink) {
                 event.preventDefault(); // 링크의 기본 동작(페이지 이동) 방지
                 console.log('Course link clicked (via event delegation)!');
                 // 클릭된 링크의 부모 li 요소에서 data-num 속성 값을 가져옵니다.
                 // closest('li.item')를 사용하여 정확히 li.item 요소를 찾습니다.
                 const listItem = clickedCourseLink.closest('li.item');
                 // **주의**: data-num 속성은 li.item에 있어야 합니다!
                 const tabNum = listItem ? listItem.getAttribute('data-num') : null;

                 console.log('Fetched data-num:', tabNum); // data-num 값 확인 로그

                 // tabNum 값이 null이거나 빈 문자열이 아닌지 확인
                 if (tabNum !== null && tabNum !== undefined && tabNum !== '') {
                     console.log('Opening popup for tab:', 'cs' + tabNum);
                     openPopup('cs' + tabNum); // 전역 openPopup 함수 호출
                 } else {
                     console.warn('Clicked course link does not have a valid data-num attribute on its parent li.item. Or data-num is empty.', clickedCourseLink);
                     alert('코스 정보가 불완전하여 팝업을 열 수 없습니다. (data-num 속성 누락)');
                 }
            }

            // 다른 동적으로 로드된 요소에 대한 이벤트 처리도 이곳에 추가할 수 있습니다.
            // 예: 특정 버튼(.dynamic-button) 클릭 처리 등
             const clickedDynamicButton = event.target.closest('.dynamic-button');
             if (clickedDynamicButton && clickedDynamicButton !== clickedCourseLink) { // courseLink와 중복 방지
                 console.log('Dynamic button clicked!');
                 // 해당 버튼 클릭 시 동작...
             }
        });
         console.log('Event delegation listener on main-content attached.');
     }


    // 5. select 박스의 값이 변경될 때마다 실행될 이벤트 리스너 추가
    console.log('Setting up select change listener...');
     // selectElement가 null일 수 있으므로 체크
     if (selectElement && mainContentDiv) {
        selectElement.addEventListener('change', function() {
            console.log('Select value changed');
            const selectedValue = this.value;
            console.log('Selected value:', selectedValue);

            if (!selectedValue) {
                 console.log('No value selected, doing nothing.');
                 // 선택된 값이 없을 때 main-content를 비우거나 기본 상태로 되돌릴 수 있습니다.
                 mainContentDiv.innerHTML = ''; // 내용을 비웁니다.
                 // 또는 기본 콘텐츠를 다시 로드할 수 있습니다.
                 // fetchDefaultContent();
                 return;
            }

            const targetJspPath = '/Gung_On/course/' +'course_'+ selectedValue + '.jsp';
            console.log('Fetching:', targetJspPath);

            fetch(targetJspPath)
                .then(response => {
                    console.log('Fetch response received', response.status);
                    if (!response.ok) {
                        console.error('Network response was not ok ' + response.statusText);
                        return Promise.reject('페이지 로드 실패: ' + response.statusText + ' (' + response.status + ')');
                    }
                    return response.text();
                })
                .then(html => {
                    console.log('Fetch successful, processing HTML');
                    // --- HTML 내용에서 스크립트 추출 및 실행 로직 시작 ---

                    const tempDiv = document.createElement('div');
                    // 받아온 HTML 문자열을 임시 div에 삽입합니다.
                    // 이때, 브라우저는 스크립트 태그 안의 코드를 바로 실행하지 않습니다.
                    tempDiv.innerHTML = html;

                    // 임시 div에서 모든 <script> 요소를 찾습니다.
                    const scriptsToExecute = Array.from(tempDiv.querySelectorAll('script'));
                    console.log(`Found ${scriptsToExecute.length} script tag(s) in fetched content.`);

                    // 임시 div에서 스크립트 요소들을 제거하여 순수 HTML 내용만 남깁니다.
                    scriptsToExecute.forEach(script => script.remove());
                    const contentWithoutScripts = tempDiv.innerHTML; // 스크립트 태그가 제거된 HTML 내용

                    // mainContentDiv의 내용을 Fetch된 순수 HTML로 교체합니다.
                    // 이 과정에서 mainContentDiv의 모든 기존 자식 요소와 이벤트 리스너가 사라집니다.
                    // (단, mainContentDiv 자체에 걸린 이벤트 위임 리스너는 유지됩니다.)
                    mainContentDiv.innerHTML = contentWithoutScripts;
                    console.log('Content (without scripts) inserted into main-content');


                    // 추출해 둔 스크립트 요소를 순회하며 새로 생성하여 mainContentDiv 안에 추가합니다.
                    // DOM에 스크립트 요소를 추가하는 순간 브라우저가 해당 스크립트를 파싱하고 실행합니다.
                    scriptsToExecute.forEach((oldScript, index) => {
                        const newScript = document.createElement('script');

                        // 원본 스크립트의 속성(src, type 등)을 새 스크립트에 복사합니다.
                        Array.from(oldScript.attributes).forEach(attr => {
                             // type="module" 스크립트는 특별한 처리가 필요할 수 있습니다.
                             // 일반적인 스크립트인 경우 type="text/javascript" 속성을 복사합니다.
                             if (attr.name === 'type' && attr.value === 'module') {
                                 console.warn('Module script found. Ensure module scripts are handled correctly.');
                             }
                             newScript.setAttribute(attr.name, attr.value);
                        });

                        // 인라인 스크립트 내용이 있다면 textContent로 복사합니다.
                        if (oldScript.textContent) {
                            newScript.textContent = oldScript.textContent;
                            console.log(`Appended inline script ${index + 1}. Content preview: ${oldScript.textContent.substring(0, 50)}...`);
                        } else if (oldScript.src) {
                             // 외부 스크립트인 경우 src 속성으로 로딩합니다.
                             newScript.src = oldScript.src;
                             console.log(`Appended external script ${index + 1}: ${newScript.src}`);

                             // 외부 스크립트 로딩 완료/실패 시 로그 (디버깅용)
                              newScript.onload = function() { console.log('External script loaded successfully:', newScript.src); };
                              newScript.onerror = function() { console.error('Error loading external script:', newScript.src); };

                        } else {
                              // 내용도 src도 없는 빈 스크립트 태그는 건너뜁니다.
                              console.log(`Found an empty script tag ${index + 1}, skipping.`);
                              return;
                        }

                        // 새 스크립트 요소를 mainContentDiv의 자식으로 추가합니다.
                        // 이 시점에 스크립트 실행이 트리거됩니다.
                        mainContentDiv.appendChild(newScript);
                     });

                    // --- 스크ript 추출 및 실행 로직 끝 ---

                    console.log('Content and scripts processing completed.');

                    // Fetch 후, 새로 삽입된 콘텐츠의 스크립트들이 실행된 후에
                    // 필요한 추가 초기화 작업이 있다면 여기에 추가합니다.
                    // Fetch된 JSP 스크립트에서 Panzoom, 탭, Swiper 등을 초기화하도록 구현하는 것이 가장 좋습니다.
                    // 만약 Fetch된 JSP 스크립트에서 초기화 함수(예: initializeFetchedContent())를 정의하고,
                    // 메인 스크립트의 전역 swipers 객체 등을 활용하도록 구현했다면,
                    // 여기서 해당 함수를 호출하는 방식이 안정적일 수 있습니다.
                    // 예: if (typeof initializeFetchedContent === 'function') { initializeFetchedContent(); }

                    // 새로 삽입된 콘텐츠 내 Panzoom 재초기화 (만약 Panzoom 컨테이너가 이 JSP에 포함된다면)
                    // Fetch된 JSP 스크립트에서 Panzoom을 초기화하도록 변경하는 것을 권장하지만,
                    // 메인 스크립트에서 모든 경우를 처리하려면 여기서 다시 찾아서 초기화해야 합니다.
                    const newPanzoomElem = mainContentDiv.querySelector('#panzoom-container');
                    if (newPanzoomElem) {
                       const panzoom = Panzoom(newPanzoomElem, { maxScale: 5, minScale: 0.5, step: 0.2 });
                       // Panzoom 버튼 이벤트 리스너도 새로 연결해야 합니다.
                       const zoomInButton = mainContentDiv.querySelector('#zoomInButton');
                       const zoomOutButton = mainContentDiv.querySelector('#zoomOutButton');
                       const resetButton = mainContentDiv.querySelector('#resetButton');
                       if(zoomInButton) zoomInButton.addEventListener('click', () => panzoom.zoomIn());
                       if(zoomOutButton) zoomOutButton.addEventListener('click', () => panzoom.zoomOut());
                       if(resetButton) resetButton.addEventListener('click', () => panzoom.reset());
                       console.log('Panzoom re-initialized for new content.');
                    } else {
                        console.log('Panzoom container not found in new content.');
                    }

                    // Fetch된 콘텐츠 내 탭 기능 재초기화 (Fetch된 JSP 스크립트에서 처리하는 것이 가장 좋습니다)
                    // const newTabLinks = mainContentDiv.querySelectorAll('.course_num_list .course_num_item');
                    // const newTabContents = mainContentDiv.querySelectorAll('#photoDiv .tab_con');
                    // if (newTabLinks.length > 0 && newTabContents.length > 0) {
                    //    // 탭 이벤트 리스너 다시 연결 로직... (Fetch된 JSP 스크립트 내에서 처리 권장)
                    // }

                    // Fetch된 콘텐츠 내 Swiper 재초기화/업데이트 (Fetch된 JSP 스크립트에서 처리하는 것이 가장 좋습니다)
                    // const newSwiperEls = mainContentDiv.querySelectorAll('.swiper.course_pop_slide');
                    // newSwiperEls.forEach(swiperEl => { /* 초기화 또는 업데이트 로직 */ });


                 })
                 .catch(error => {
                     console.error('Fetch or processing error:', error);
                      // mainContentDiv가 존재하면 오류 메시지 표시
                      if (mainContentDiv) {
                           mainContentDiv.innerHTML = '<div>데이터를 가져오는 중 오류가 발생했습니다.</div>';
                      }
                     alert('콘텐츠 로드 중 오류가 발생했습니다. 콘솔을 확인하세요.');
                 });
         });
         console.log('Select change listener attached.');
     }


    console.log('--- Main DOMContentLoaded listener finished ---');
  }); // Main DOMContentLoaded 끝


  // 팝업 내부 탭 변경 처리 함수 (팝업 요소가 메인 페이지에 고정되어 있다면 유용)
   function handlePopupTabChange(tabId) {
       console.log('handlePopupTabChange called with tabId:', tabId);
       // popup 요소가 null이 아닌지 확인
       if (!popup) {
           console.error('Popup element not found for handlePopupTabChange.');
           return;
       }

       const tabLinks = popup.querySelectorAll('.tab_menu .item');
       const tabContents = popup.querySelectorAll('.tab_con');

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
            if (swiperEl) {
                // Swiper 인스턴스 관리 (swipers 객체 활용 또는 요소 자체의 .swiper 속성 사용)
                 if (typeof swipers !== 'undefined' && swipers[swiperEl.id]) {
                    swipers[swiperEl.id].update();
                    swipers[swiperEl.id].slideTo(0, 0);
                 } else if (swiperEl.swiper) {
                    swiperEl.swiper.update();
                    swiperEl.swiper.slideTo(0, 0);
                 } else {
                    console.log('Swiper found in active tab, but not initialized:', swiperEl.id);
                    // 필요하다면 여기서 Swiper를 초기화하고 swipers 객체에 추가
                    // initSwiperForElement(swiperEl); // 별도의 초기화 함수를 만든다면
                 }
            }
         }
       });
       console.log('Popup internal tab changed to:', tabId);
   }


</script>


<!-- [S] sub_con_wrap -->
<style type="text/css">
/* 스타일은 그대로 유지 */
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


</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <div id="main-content">
      <%-- 초기 로드 시 포함될 콘텐츠 (예: course_cdg.jsp) --%>
      <jsp:include page="/course/course_gbg.jsp" />
  </div>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />

  <%-- 팝업 요소와 Dim 요소는 main-content 밖에 있어야 DOM 교체 시 사라지지 않습니다. --%>
  <%-- 이 요소들은 페이지 로드 시 한 번만 로드되고, 메인 스크립트에서 관리합니다. --%>
  <div class="dim" style="display: none;"></div>
  <div id="pop_course01" class="popup" style="display: none;">
      <%-- 팝업 내용 --%>
       <div class="popup_wrap">
           <div class="popup_header">
               <h3>코스 상세</h3>
               <a href="#" class="popup_close">닫기</a>
           </div>
           <div class="popup_body">
               <%-- 팝업 내부 탭 메뉴 (일반적으로 고정) --%>
               <div class="tab_menu">
                   <ul>
                       <li class="item current"><a href="#;" data-tab="cs1">탭1</a></li>
                       <li class="item"><a href="#;" data-tab="cs2">탭2</a></li>
                       <%-- 다른 탭 항목들 --%>
                   </ul>
               </div>
               <%-- 팝업 내부 탭 콘텐츠 (Fetch된 JSP의 코스 정보에 따라 내용이 바뀔 수 있지만, 구조는 메인에 정의) --%>
               <div class="tab_con current cs1">
                   <%-- 탭1 내용 (Swiper 등) --%>
                   <div class="swiper course_pop_slide" id="swiper-cs1"> <%-- Swiper ID는 고유해야 합니다. --%>
                       <div class="swiper-wrapper">
                           <div class="swiper-slide">Slide 1</div>
                           <div class="swiper-slide">Slide 2</div>
                           <%-- ... --%>
                       </div>
                       <div class="swiper-button-next"></div>
                       <div class="swiper-button-prev"></div>
                   </div>
               </div>
                <div class="tab_con cs2">
                   <%-- 탭2 내용 (Swiper 등) --%>
                   <div class="swiper course_pop_slide" id="swiper-cs2"> <%-- Swiper ID는 고유해야 합니다. --%>
                       <div class="swiper-wrapper">
                           <div class="swiper-slide">Slide A</div>
                           <div class="swiper-slide">Slide B</div>
                           <%-- ... --%>
                       </div>
                       <div class="swiper-button-next"></div>
                       <div class="swiper-button-prev"></div>
                   </div>
               </div>
               <%-- 다른 탭 콘텐츠 추가 가능 --%>
           </div>
       </div>
  </div>


<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
