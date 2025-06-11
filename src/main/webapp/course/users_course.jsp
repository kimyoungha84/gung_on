<%@page import="kr.co.gungon.course.CourseDTO"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    <%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="kr.co.gungon.gung.GungDTO"%> 
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>사용자 추천 코스</title>
  <style type="text/css">
    .course-thumbnail {
        width: 50px; 
        height: auto; 
        margin-right: 10px; 
        vertical-align: middle; 
        border-radius: 5px;
    }
    .sel_st {
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 1rem;
        line-height: 1.5;
    }
    .action-buttons .btn {
        padding: 3px 8px;
        font-size: 0.8rem;
        margin-left: 5px;
    }
  </style>

  <!-- Swiper CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/course/css/users_course_style.css" />
	<c:import url="/common/jsp/external_file.jsp"/>

<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


</head>

<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <main>
    <div class="container">
        <div class="sidebar">
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course_time.jsp">관람시간</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course.jsp">관람코스</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/users_course.jsp" class="active" >사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>

	<article class="content">
        <h1>사용자 추천 코스</h1>
    
        <%
           CourseService cs = new CourseService();
           List<GungDTO> gungList = null;
           try {
               gungList = cs.getAllGungs(); 
           } catch (Exception e) { 
               e.printStackTrace(); 
           }//end catch
           
           pageContext.setAttribute("gungList", gungList);

           String gungIdParam = request.getParameter("gung_id");
           int selectedGungId = -1; 

           if (gungIdParam != null && !gungIdParam.isEmpty()) {
               try {
                   selectedGungId = Integer.parseInt(gungIdParam);
               } catch (NumberFormatException e) {
            	   e.printStackTrace();
               }//end catch
           }//end if
            
           int finalSelectedGungId = -1; 

           if (gungList != null && !gungList.isEmpty()) {
               boolean paramGungIdIsValidInList = false;
               if (selectedGungId != -1) { 
                   for (GungDTO gung : gungList) {
                       if (gung.getGung_id() == selectedGungId) {
                           paramGungIdIsValidInList = true;
                           break;
                       }//end if
                   }//end for
               }//end if

               if (paramGungIdIsValidInList) {
                   finalSelectedGungId = selectedGungId;
               } else {
                   finalSelectedGungId = gungList.get(0).getGung_id();
               }//end else
           }//end if
            pageContext.setAttribute("selectedGungId", finalSelectedGungId);

           String mode = request.getParameter("mode");
           boolean isMyCoursesMode = "mycourses".equals(mode);
           pageContext.setAttribute("isMyCoursesMode", isMyCoursesMode);

           CourseService courseService = new CourseService();
           List<CourseDTO> courseList = null;
           
           MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
           boolean isLoggedIn = (mDTO != null);
           pageContext.setAttribute("isLoggedIn", isLoggedIn);
           String loggedInMemberId = null;
           
           if(isLoggedIn) {
               loggedInMemberId = mDTO.getId();
               pageContext.setAttribute("loggedInMemberId", loggedInMemberId);
           }//end if

           if (isMyCoursesMode && isLoggedIn) {
               if (finalSelectedGungId != -1) {
                   try {
                        List<CourseDTO> allCoursesInGung = courseService.getCoursesByGungId(finalSelectedGungId);
                        if (allCoursesInGung != null) {
                             courseList = new ArrayList<>();
                            for (CourseDTO course : allCoursesInGung) {
                                if (course.getMember_Id().equals(loggedInMemberId)) {
                                    courseList.add(course);
                                }//end if
                            }//end for
                        } else {
                             courseList = new ArrayList<>(); // 빈 목록
                        }//end else

                   } catch (Exception e) {
                       e.printStackTrace();
                   }//end catch
               }//end catch


           } else {
               if (finalSelectedGungId != -1) {
                   try {
                       courseList = courseService.getCoursesByGungId(finalSelectedGungId);

                   } catch (Exception e) { 
                       e.printStackTrace(); 
                   }//end catch
               }//end if
           }//end else
           pageContext.setAttribute("courseList", courseList);
        %>

        <form id="gungSelectForm" action="users_course.jsp" method="get">
            <div class="sel_div">
                <select class="sel_st" name="gung_id" id="gung_id_select" 
                        onchange="updateFormActionAndSubmit(this.value)"> 
                   
                   <c:if test="${not empty gungList}"> 
                       
                       <c:forEach items="${gungList}" var="gung"> 
                            <option value="${gung.gung_id}" 
                                    <c:if test="${selectedGungId == gung.gung_id}">selected</c:if>>
                                ${gung.gung_name} 
                            </option>
                       </c:forEach>
                   </c:if>

                   <c:if test="${empty gungList}">
                        <option value="-1">궁 선택</option> 
                   </c:if>
                </select>
                 
                 <c:if test="${isMyCoursesMode}">
                     <input type="hidden" name="mode" value="mycourses">
                 </c:if>
            </div>
        </form>
    
    
    <c:if test="${isLoggedIn}"> 
        <div class="board-header">
             
             <button class="write-button btn btn-primary" onclick="goToCourseWrite()" 
                     <c:if test="${isMyCoursesMode}">disabled</c:if>> 
                     코스 등록
             </button>
            
            
            <c:choose>
                <c:when test="${isMyCoursesMode}">
                    <button class="modify-button btn btn-secondary" onclick="window.location.href='users_course.jsp?gung_id=${param.gung_id}'">전체 코스 보기</button>
                </c:when>
                <c:otherwise>
                    
                     <button class="modify-button btn btn-secondary" onclick="window.location.href='users_course.jsp?mode=mycourses&gung_id=${param.gung_id}'">코스 관리</button>
                </c:otherwise>
            </c:choose>
            
        </div>
    </c:if>    

    <table class="board-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <c:if test="${isMyCoursesMode && isLoggedIn}">
                    
                     <th>관리</th> 
                </c:if>
            </tr>
        </thead>
<tbody>
        <c:choose>
            <c:when test="${empty courseList}">
                <tr>
                    
                    <td colspan="${isMyCoursesMode && isLoggedIn ? '5' : '4'}" style="text-align: center;">등록된 코스가 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach items="${courseList}" var="course" varStatus="status">
                <c:set var="currentCourse" value="${course}" scope="page" />
                    <tr>
                        <td>${status.count}</td>
                        
                        <td>
                            <%
                            CourseDTO currentCourse = (CourseDTO) pageContext.getAttribute("currentCourse");
                            int currentCourseNum = currentCourse.getCourse_Num();

                                CourseService currentCourseService = new CourseService(); 
                                List<FilePathDTO> imageList = null;
                                try {
                                    imageList = currentCourseService.getCourseImages(currentCourseNum);
                                } catch (Exception e) { 
                                    e.printStackTrace(); 
                                }//end catch

                                if (imageList != null && !imageList.isEmpty()) {
                                    FilePathDTO thumbnailFile = imageList.get(0);
                                    String thumbnailPath = thumbnailFile.getPath();

                                     String thumbnailUrl = request.getContextPath() + thumbnailPath;


                                    %>
                                    <img src="<%= thumbnailUrl %>" class="course-thumbnail" alt="썸네일 이미지">

                                    <%
                                }//end if
                            %>
                            
                            <a href="course_detail.jsp?course_num=${course.course_Num}&gung_id=${param.gung_id}" class="course-title-link">
                                ${course.course_Title} 
                            </a>
                        </td>

                        <td>${course.member_Id}</td>
                        <td><fmt:formatDate value="${course.course_Reg_Date}" pattern="yyyy-MM-dd HH:mm"/></td>
                        
                        <c:if test="${isMyCoursesMode && isLoggedIn}">
    						<td class="action-buttons">
        						<button class="btn btn-sm btn-primary" 
                				onclick="window.location.href='course_modify.jsp?course_num=${course.course_Num}&gung_id=${selectedGungId}&mode=mycourses'">수정</button>

        						<button class="btn btn-sm btn-danger" 
                				onclick="if(confirm('정말로 삭제하시겠습니까?')) { 
                    			window.location.href='course_delete_process.jsp?course_num=${course.course_Num}&gung_id=${selectedGungId}&mode=mycourses'; }">삭제</button>
    						</td>
						</c:if>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
      </tbody>
    </table>
			
    </article>
           
    </div> 

  </main>

<script>
    
    function updateFormActionAndSubmit(selectedGungId) {
        const form = document.getElementById('gungSelectForm');
        const urlParams = new URLSearchParams(window.location.search);
        const currentMode = urlParams.get('mode');

        let modeInput = form.querySelector('input[name="mode"]');
        if (!modeInput && currentMode === 'mycourses') {
             
             modeInput = document.createElement('input');
             modeInput.type = 'hidden';
             modeInput.name = 'mode';
             modeInput.value = 'mycourses';
             form.appendChild(modeInput);
        } else if (modeInput && currentMode !== 'mycourses') {
             
             modeInput.remove();
        }//else if

        form.submit(); 
    }//updateFormActionAndSubmit


    function goToCourseWrite() {
        const selectedGungId = document.getElementById('gung_id_select').value;
        
        if (selectedGungId && selectedGungId !== "" && selectedGungId !== "-1") { 
            location.href = 'course_write.jsp?gung_id=' + encodeURIComponent(selectedGungId);
        } else {
            alert("코스를 등록할 궁을 선택해주세요.");
        }//end else
    }//goToCourseWrite

    
</script>

  
  <jsp:include page="/common/jsp/footer.jsp" />

</body>
</html>
