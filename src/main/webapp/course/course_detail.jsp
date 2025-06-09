<%@page import="kr.co.gungon.course.CourseDTO"%>
<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- HTML 엔티티 디코딩을 위한 라이브러리 임포트 (필요시 주석 해제 및 라이브러리 추가) --%>
<%-- import org.apache.commons.text.StringEscapeUtils; --%> 

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>코스 상세 보기</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- jQuery -->
  <%-- Velog 예시에서 jQuery 사용하므로 포함 --%>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <!-- 사용자 스타일 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/course/css/users_course_style.css" />
  <%-- external_file.jsp (필요시 주석 해제 및 경로 수정) --%>
  <%-- <c:import url="/common/jsp/external_file.jsp"/> --%> 

  <style>
    /* 기본 레이아웃 */
    .container {
      max-width: 1200px;
      margin: 20px auto;
      padding: 0 15px;
    }

    .course-detail-header {
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
    }

    .course-detail-header h1 {
      font-size: 2em;
      margin-bottom: 10px;
    }

    .course-info {
      font-size: 0.9em;
      color: #666;
      margin-bottom: 15px;
    }

    .course-content {
      margin-top: 20px;
      line-height: 1.6;
      /* Summernote 내용이 잘 보이도록 필요한 추가 스타일 */
    }

    /* Summernote 내용 내 이미지 스타일 */
    .course-content img {
      max-width: 100%;
      height: auto;
      margin: 15px 0; /* 이미지 위아래 간격 */
      border: 1px solid #ddd;
      padding: 5px;
      box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
      display: block; /* 블록 요소로 만들어 텍스트와 분리 */
      margin-left: auto; /* 중앙 정렬 */
      margin-right: auto; /* 중앙 정렬 */
    }
    /* Summernote 내용 내 테이블 스타일 (예시) */
     .course-content table {
         border-collapse: collapse;
         width: 100%;
         margin: 15px 0;
     }
     .course-content th, .course-content td {
         border: 1px solid #ddd;
         padding: 8px;
         text-align: left;
     }
     .course-content th {
         background-color: #f2f2f2;
     }


    /* 별점 영역 */
    .rating-area {
      margin-top: 40px;
      padding-top: 20px;
      border-top: 1px solid #eee;
    }

    .rating-area h2 {
      font-weight: bold;
      font-size: 1.5rem;
      margin-bottom: 10px;
    }

    .current-rating {
      font-size: 1rem;
      color: #555;
      margin-bottom: 15px;
    }

    .rating-input {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .rating-input p {
      margin: 0;
      font-size: 1rem;
      color: #333;
      white-space: nowrap;
    }

    /* ====== 별점 UI - 요청받은 CSS 그대로 적용 ====== */
    /* Velog 예시 CSS를 그대로 사용합니다. */
    /* SCSS 문법은 일반 CSS로 해석하여 적용합니다. */
    /* 이미지 경로는 프로젝트 경로에 맞게 수정이 필요할 수 있습니다. */
    .wrap { /* 이 클래스는 course_detail.jsp HTML 구조에는 없지만, 스타일 자체는 유지 */
        height: 100vh;
        min-height: 400px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        gap: 32px;
    }

    /* h1 스타일은 이미 위에 정의되어 있습니다. 필요시 통합 */
    /* h1 {
        font-size: 40px;
        font-weight: 600;
    } */

    .rating {
        float: none; /* 기존 float: none 유지 */
        width: 200px; /* 너비 유지 */
        display: flex; /* flex 유지 */
         /* course_detail.jsp의 rating-input flex 컨테이너 안에 있으므로 이 display: flex는 중복될 수 있음 */
         /* 필요시 rating-input의 flex 설정을 따르도록 조정 */
    }

    .rating__input { /* &__input */
        display: none; /* 숨김 */
    }

    .rating__label { /* &__label */
        width: 20px; /* 라벨 너비 */
        overflow: hidden; /* 넘치는 내용 숨김 */
        cursor: pointer; /* 커서 */
        display: block; /* 블록 요소 */
        float: left; /* 왼쪽으로 띄우기 */
    }

    .rating__label .star-icon { /* &__label .star-icon */
        width: 20px; /* 아이콘 너비 */
        height: 40px; /* 아이콘 높이 (이미지 2배 높이) */
        display: block;
        position: relative;
        left: 0;
        background-image: url('${pageContext.request.contextPath}/course/course_img/ico-star-empty.svg'); /* 빈 별 이미지 경로 */
        background-repeat: no-repeat;
        background-size: 40px; /* 배경 이미지 크기 (아이콘 너비의 2배) */
      
        /* &.filled */
        /* .rating__label .star-icon.filled */
        /* JavaScript로 이 클래스를 토글하여 채워진 이미지 표시 */
    }
    .rating__label .star-icon.filled {
        background-image: url('${pageContext.request.contextPath}/course/course_img/ico-star-full.svg'); /* 꽉 찬 별 이미지 경로 */
        /* background-position: left; /* LTR 기준 채워진 별 위치 (필요시 명시) */
    }


    .rating__label--full .star-icon { /* &__label--full .star-icon */
        background-position: right; /* 꽉 찬 별 이미지 중 오른쪽 절반 표시 */
    }

    .rating__label--half .star-icon { /* &__label--half .star-icon */
        background-position: left; /* 꽉 찬 별 이미지 중 왼쪽 절반 표시 */
    }

    /* &.readonly */
    /* .rating.readonly .star-icon */
    .rating.readonly .star-icon {
        opacity: 0.7;
        cursor: default;
    }
    /* ====== 요청받은 CSS 그대로 적용 종료 ====== */

    /* 별점 등록 버튼 */
    #submitRatingBtn {
      background-color: #007bff;
      border: none;
      color: white;
      padding: 8px 16px;
      font-size: 1rem;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color .2s;
    }

    #submitRatingBtn:hover {
      background-color: #0056b3;
    }

    /* 별점 등록 메시지 */
    #ratingMessage {
      margin-top: 10px;
      color: green;
      font-weight: bold;
    }

    /* 목록으로 돌아가기 버튼 */
    .btn-back {
      margin-top: 30px;
    }
  </style>
</head>

<body class="main">
  <jsp:include page="${pageContext.request.contextPath}/common/jsp/header.jsp" />

  <main>
    <div class="container">
      <article class="content">
        <%
          int courseNum = -1;
          String courseNumParam = request.getParameter("course_num");
          if (courseNumParam != null && !courseNumParam.isEmpty()) {
            try {
              courseNum = Integer.parseInt(courseNumParam);
            } catch (NumberFormatException e) {
               System.err.println(">>> ERROR course_detail.jsp: Invalid course_num parameter: " + courseNumParam);
            }
          }

          CourseDTO courseDetail = null;
          if (courseNum != -1) {
            CourseService courseService = new CourseService();
            try {
              courseDetail = courseService.getCourseDetail(courseNum);
              
              // 코스 내용 HTML 엔티티 디코딩 시도 (필요시 주석 해제 및 라이브러리 추가)
              // if (courseDetail != null && courseDetail.getCourse_Content() != null) {
              //    String decodedContent = StringEscapeUtils.unescapeHtml4(courseDetail.getCourse_Content());
              //    courseDetail.setCourse_Content(decodedContent);
              // }

            } catch (Exception e) {
              e.printStackTrace();
              System.err.println(">>> ERROR course_detail.jsp: Failed to load course detail for course_num " + courseNum);
            }
          }
          pageContext.setAttribute("courseDetail", courseDetail);
          pageContext.setAttribute("courseNum", courseNum);
        %>

        <c:choose>
          <c:when test="${courseDetail == null}">
            <h2>코스를 찾을 수 없습니다.</h2>
            <p>요청하신 코스 정보를 불러오는데 실패했습니다.</p>
            <button class="btn btn-secondary mt-3" onclick="window.location.href='users_course.jsp'">목록으로 돌아가기</button>
          </c:when>
          <c:otherwise>
            <div class="course-detail-header">
              <h1>${courseDetail.course_Title}</h1>
              <div class="course-info">
                작성자: ${courseDetail.member_Id} |
                작성일: <fmt:formatDate value="${courseDetail.course_Reg_Date}" pattern="yyyy-MM-dd HH:mm" /> |
                현재 별점: ${courseDetail.course_Rating} (${courseDetail.course_Rating_Cnt}명 참여)
              </div>
            </div>

            <div class="course-content">
              <%-- 코스 내용 HTML 렌더링 (태그가 그대로 보이면 DB에 이스케이프되어 저장되었을 가능성) --%>
              <c:out value="${courseDetail.course_Content}" escapeXml="false" />
              <%-- 만약 c:out으로 안되면 스크립트릿으로 직접 출력 (XSS 주의 필요) --%>
              <%-- <%= courseDetail != null ? courseDetail.getCourse_Content() : "" %> --%>
            </div>

            <div class="rating-area">
              <h2>별점 등록</h2>
              <input type="hidden" id="detailCourseNum" value="${courseNum}" />

              <div class="current-rating">
                 평균 별점: <span id="displayCurrentRating">${courseDetail.course_Rating}</span>
                (<span id="displayRatingCount">${courseDetail.course_Rating_Cnt}</span>명 참여)
              </div>

              <div class="rating-input">
                <p>이 코스는 어떠셨나요? 별점을 남겨주세요.</p>

                <%-- ====== 별점 UI (HTML - 요청받은 코드 그대로 적용) ====== --%>
                 <!-- 요청받은 HTML 구조를 그대로 사용합니다. -->
                <div class="rating">
                    <label class="rating__label rating__label--half" for="starhalf">
                        <input type="radio" id="starhalf" class="rating__input" name="rating" value="0.5">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--full" for="star1">
                        <input type="radio" id="star1" class="rating__input" name="rating" value="1.0">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--half" for="star1half">
                        <input type="radio" id="star1half" class="rating__input" name="rating" value="1.5">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--full" for="star2">
                        <input type="radio" id="star2" class="rating__input" name="rating" value="2.0">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--half" for="star2half">
                        <input type="radio" id="star2half" class="rating__input" name="rating" value="2.5">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--full" for="star3">
                        <input type="radio" id="star3" class="rating__input" name="rating" value="3.0">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--half" for="star3half">
                        <input type="radio" id="star3half" class="rating__input" name="rating" value="3.5">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--full" for="star4">
                        <input type="radio" id="star4" class="rating__input" name="rating" value="4.0">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--half" for="star4half">
                        <input type="radio" id="star4half" class="rating__input" name="rating" value="4.5">
                        <span class="star-icon"></span>
                    </label>
                    <label class="rating__label rating__label--full" for="star5">
                        <input type="radio" id="star5" class="rating__input" name="rating" value="5.0">
                        <span class="star-icon"></span>
                    </label>
                </div>
                <%-- ====== 요청받은 HTML 그대로 적용 종료 ====== --%>

                <button id="submitRatingBtn" class="btn btn-primary ml-2">별점 등록</button>
              </div>

              <div id="ratingMessage" class="mt-2"></div>
            </div>

            <div class="mt-4">
              <button class="btn btn-secondary" onclick="window.location.href='users_course.jsp'">목록으로 돌아가기</button>
            </div>
          </c:otherwise>
        </c:choose>
      </article>
    </div>
  </main>

  <jsp:include page="${pageContext.request.contextPath}/common/jsp/footer.jsp" />

 <script>
    // ====== 별점 UI - 요청받은 JavaScript 그대로 적용 (Velog 참고) ======
    const rateWrap = document.querySelector('.rating'); // .rating 컨테이너 선택
    let stars; // stars 변수는 이벤트 리스너 안에서 동적으로 업데이트

    // 페이지 로드 후 별점 UI 초기화 및 이벤트 리스너 설정
    $(document).ready(function() {
        // .rating 요소가 있을 때만 초기화 및 이벤트 설정
        if (rateWrap) {
            stars = rateWrap.querySelectorAll('.star-icon'); // .rating 안에 star-icon들 다시 선택

            // 초기 별점 표시 (checked 속성에 따라)
            checkedRate(); 

            // 마우스 호버 이벤트 처리 (Velog 예시 기반 - 이벤트 위임)
            // 마우스 호버 시 별 모양을 채우는 기능 유지
            rateWrap.addEventListener('mouseover', (event) => {
                const target = event.target;
                if (target.classList.contains('star-icon') || target.classList.contains('rating__label')) {
                    const hoveredLabel = target.closest('.rating__label'); 
                    if (hoveredLabel) { 
                        const index = Array.from(rateWrap.querySelectorAll('.rating__label')).indexOf(hoveredLabel);
                        initStars(); 
                        filledRate(index); 
                    }
                }
            });

            // 마우스가 별점 영역을 벗어났을 때 (Velog 예시 기반)
             // 마우스가 벗어나면 선택된 별점 상태로 돌아가는 기능 유지
             rateWrap.addEventListener('mouseout', () => {
                 checkedRate(); 
             });

             // 라디오 버튼 클릭 시 (Velog 예시 기반 - 별 모양 변경만 수행)
             // 클릭 시 별 모양 변경만 담당하고, 등록은 버튼 클릭 시 수행
             rateWrap.addEventListener('click', (event) => {
                 const targetInput = event.target;
                 if (targetInput.classList.contains('rating__input')) { 
                     // 클릭 시 별점 상태는 checkedRate()에 의해 반영됨
                     // Ajax 호출 코드는 여기서 제거
                 }
             });
        } 

        // ====== 별점 등록 버튼 클릭 이벤트 (Ajax 호출) ======
        // "별점 등록" 버튼 클릭 시 별점 등록 Ajax 호출
        $('#submitRatingBtn').click(function () {
          // 선택된 라디오 버튼의 value 가져오기
          const selectedRating = $('input[name="rating"]:checked').val(); 
          const courseNum = $('#detailCourseNum').val();

          // 별점이 선택되지 않았거나 코스 번호가 없을 경우
          if (!selectedRating) {
            alert('별점을 선택해주세요.');
            return;
          }
          if (!courseNum || courseNum === "-1") { // courseNum 유효성 추가 체크
              alert('코스 정보를 찾을 수 없습니다.');
              return;
          }

           // 별점 등록 처리 페이지 또는 URL로 Ajax 요청
           // selectedRating 값이 비어 있지 않을 때만 요청 (value가 설정되었다면 항상 true)
            $.ajax({
                url: 'course_rating_process.jsp', // 실제 별점 처리 경로
                type: 'POST',
                data: {
                    course_num: courseNum,
                    rating: selectedRating,
                },
                dataType: 'json', // 응답 타입 JSON 기대
                success: function (response) {
                    if (response.status === 'success') {
                        $('#ratingMessage').text('별점이 성공적으로 등록되었습니다.');
                        if (response.newRating !== undefined) {
                            $('#displayCurrentRating').text(parseFloat(response.newRating).toFixed(1));
                        }
                        if (response.newRatingCount !== undefined) {
                            $('#displayRatingCount').text(response.newRatingCount);
                        }
                        $('input[name="rating"]').prop('checked', false);
                        checkedRate(); 

                    } else {
                         alert('별점 등록에 실패했습니다: ' + (response.message || '알 수 없는 오류'));
                         $('#ratingMessage').text('별점 등록 실패: ' + (response.message || '알 수 없는 오류'));
                         $('input[name="rating"]').prop('checked', false);
                         checkedRate(); 
                     }
                },
                 error: function (jqXHR, textStatus, errorThrown) {
                     console.error('별점 등록 Ajax 오류:', textStatus, errorThrown, jqXHR.responseText);
                     alert('별점 등록 중 오류가 발생했습니다.');
                     $('#ratingMessage').text('별점 등록 중 오류 발생');
                     $('input[name="rating"]').prop('checked', false);
                     checkedRate(); 
                 },
            }); 

        }); 

    }); 


    function filledRate(index) {
        if (!stars || stars.length === 0) return; 

        for (let i = 0; i <= index; i++) {
             if (i < stars.length) {
                 stars[i].classList.add('filled');
             }
         }
    }

    function checkedRate() {
         if (!stars || stars.length === 0) return; 

         const checkedRadio = document.querySelector('.rating input[type="radio"]:checked');
         initStars(); 

         if (checkedRadio) {
              const checkedLabel = checkedRadio.parentElement; 
              const checkedIndex = Array.from(rateWrap.querySelectorAll('.rating__label')).indexOf(checkedLabel);

             for (let i = 0; i <= checkedIndex; i++) {
                 if (i < stars.length) {
                     stars[i].classList.add('filled');
                 }
             }
         }
    }

    function initStars() {
        if (!stars || stars.length === 0) return; 
        for (let i = 0; i < stars.length; i++) {
            stars[i].classList.remove('filled');
        }
    }

  </script>
</body>
</html>
