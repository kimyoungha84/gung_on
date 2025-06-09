<%@page import="kr.co.gungon.course.CourseDTO"%>
<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>코스 상세 보기</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <!-- 사용자 스타일 -->
<<<<<<< HEAD
  <link rel="stylesheet" href="/course/css/users_course_style.css" />
=======
  <link rel="stylesheet" href="${pageContext.request.contextPath}/course/css/users_course_style.css" />
  <%-- external_file.jsp (필요시 주석 해제 및 경로 수정) --%>
  <%-- <c:import url="/common/jsp/external_file.jsp"/> --%> 
>>>>>>> 380e24bde21b4a74612c37e073be0c77486fb31e

  <style>
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
    }

    .course-content img {
      max-width: 100%;
      height: auto;
      margin: 15px 0; /* 이미지 위아래 간격 */
      border: 1px solid #ddd;
      padding: 5px;
      box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
      margin-left: auto; /* 중앙 정렬 */
      margin-right: auto; /* 중앙 정렬 */
    }
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
    .wrap { 
        height: 100vh;
        min-height: 400px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        gap: 32px;
    }


    .rating {
        float: none;
        width: 200px;
        display: flex;
    }

    .rating__input {
        display: none;
    }

    .rating__label { 
        width: 20px; 
        overflow: hidden;
        cursor: pointer;
        display: block;
        float: left;
    }

    .rating__label .star-icon {
        width: 20px;
        height: 40px;
        display: block;
        position: relative;
        left: 0;
<<<<<<< HEAD
        background-image: url('/course/course_img/ico-star-empty.svg'); /* 빈 별 이미지 경로 */
=======
        background-image: url('${pageContext.request.contextPath}/course/course_img/ico-star-empty.svg'); /* 빈 별 이미지 경로 */
>>>>>>> 380e24bde21b4a74612c37e073be0c77486fb31e
        background-repeat: no-repeat;
        background-size: 40px;
      
    }
    .rating__label .star-icon.filled {
<<<<<<< HEAD
        background-image: url('/course/course_img/ico-star-full.svg'); /* 꽉 찬 별 이미지 경로 */
=======
        background-image: url('${pageContext.request.contextPath}/course/course_img/ico-star-full.svg'); /* 꽉 찬 별 이미지 경로 */
        /* background-position: left; /* LTR 기준 채워진 별 위치 (필요시 명시) */
>>>>>>> 380e24bde21b4a74612c37e073be0c77486fb31e
    }


    .rating__label--full .star-icon { 
        background-position: right; 
    }

    .rating__label--half .star-icon {
        background-position: left;
    }

    .rating.readonly .star-icon {
        opacity: 0.7;
        cursor: default;
    }

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
                작성일: <fmt:formatDate value="${courseDetail.course_Reg_Date}" pattern="yyyy-MM-dd HH:mm" />
              </div>
            </div>

            <div class="course-content">
              <c:out value="${courseDetail.course_Content}" escapeXml="false" />
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
    const rateWrap = document.querySelector('.rating');
    let stars; 

    $(document).ready(function() {
        if (rateWrap) {
            stars = rateWrap.querySelectorAll('.star-icon'); // .rating 안에 star-icon들 다시 선택

            checkedRate(); 

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

             rateWrap.addEventListener('mouseout', () => {
                 checkedRate(); 
             });

             rateWrap.addEventListener('click', (event) => {
                 const targetInput = event.target;
                 if (targetInput.classList.contains('rating__input')) { 
                 }
             });
        } 

        $('#submitRatingBtn').click(function () {
          const selectedRating = $('input[name="rating"]:checked').val(); 
          const courseNum = $('#detailCourseNum').val();

          if (!selectedRating) {
            alert('별점을 선택해주세요.');
            return;
          }
          if (!courseNum || courseNum === "-1") {
              alert('코스 정보를 찾을 수 없습니다.');
              return;
          }

            $.ajax({
                url: 'course_rating_process.jsp',
                type: 'POST',
                data: {
                    course_num: courseNum,
                    rating: selectedRating,
                },
                dataType: 'json',
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
