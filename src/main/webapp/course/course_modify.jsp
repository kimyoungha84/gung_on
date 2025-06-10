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
<%-- JSON 처리를 위해 json-simple 라이브러리 필요 --%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>코스 수정</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Summernote CSS -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
  
  <!-- jQuery -->
  
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 

  <script>
    var jq = $.noConflict(); 
    console.log("jQuery noConflict 모드 활성화. jQuery 객체 이름: jq");
  </script>
  
  <!-- Summernote JS -->
  
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script> 


  <!-- 사용자 스타일 -->
	<link rel="stylesheet" type="text/css" href="/course/css/users_course_style.css" />
	<c:import url="/common/jsp/external_file.jsp"/>


  <style type="text/css">
    
    .container {
        max-width: 1200px;
        margin: 20px auto;
        padding: 0 15px;
    }
    .course-form-area {
        padding: 20px;
        border: 1px solid #eee;
        border-radius: 5px;
        background-color: #f9f9f9;
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        font-weight: bold;
        margin-bottom: 5px;
        display: block; 
    }
     .btn-group { 
         margin-top: 20px;
     }
     .btn-group .btn {
         margin-right: 10px; 
     }
      
     .note-editor {
         border: 1px solid #ccc !important; 
     }

     
     
    .note-editor .modal {
        position: fixed; 
        top: 50%; 
        left: 50%; 
        transform: translate(-50%, -50%); 
        z-index: 1050; 
        display: none; 
        overflow: auto; 
        max-height: 90%; 
    }

    
    .note-editor .modal-dialog {
        margin: 30px auto; 
        max-width: 500px; 
        width: 95%; 
    }

    
    .note-editor .modal-content {
        position: relative; 
        background-color: #fff;
        border: 1px solid rgba(0, 0, 0, .2);
        border-radius: 6px;
        box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
        background-clip: padding-box;
        outline: 0;
    }

    
    .note-editor .modal-header {
        padding: 15px;
        border-bottom: 1px solid #e5e5e5;
    }

    
    .note-editor .modal-body {
        position: relative;
        padding: 15px;
        overflow-y: auto; 
    }

    
    .note-editor .modal-footer {
        padding: 15px;
        border-top: 1px solid #e5e5e5;
        text-align: right; 
        display: flex; 
        justify-content: flex-end; 
        align-items: center; 
    }
    
    .note-editor .modal-footer .btn {
        margin-left: 5px; 
    }
    
    .note-editor .note-modal-form .form-group {
        margin-bottom: 15px;
    }
    
    .note-editor .modal-header .close {
         
    }

     
     .note-modal-footer { 
        padding: 15px;
        border-top: 1px solid #e5e5e5;
        text-align: right;
        display: flex;
        justify-content: flex-end;
        align-items: center;
     }
    .note-modal-footer .btn {
        margin-left: 5px;
    }


  </style>
</head>

<body class="main">

  
  <jsp:include page="/common/jsp/header.jsp" />

  
  <main>
    <div class="container">
        

        <article class="content">
            <h1>코스 수정</h1>

            <%
               
               String courseNumParam = request.getParameter("course_num");
               int courseNum = -1; 

               
               System.out.println(">>> DEBUG modify.jsp: Received courseNumParam = " + courseNumParam);

               
               if (courseNumParam != null && !courseNumParam.isEmpty()) {
                   try {
                       courseNum = Integer.parseInt(courseNumParam);
                        if (courseNum <= 0) {
                           
                           out.println("<script>alert('유효하지 않은 코스 번호입니다.'); window.history.back();</script>");
                           return;
                       }
                   } catch (NumberFormatException e) {
                       
                       out.println("<script>alert('유효하지 않은 코스 번호 형식입니다.'); window.history.back();</script>");
                       e.printStackTrace();
                       return;
                   }
               } else {
                    
                   out.println("<script>alert('수정할 코스 정보가 누락되었습니다.'); window.history.back();</script>");
                   return;
               }

               
               System.out.println(">>> DEBUG modify.jsp: Process modify for courseNum = " + courseNum);


               
               MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
               if (mDTO == null) {
                   out.println("<script>alert('로그인이 필요합니다.'); window.location.href = '/member/login.jsp';</script>");
                   return; 
               }
               String loggedInMemberId = mDTO.getId();
               System.out.println(">>> DEBUG modify.jsp: User logged in: " + loggedInMemberId);


               
               CourseService courseService = new CourseService();
               CourseDTO courseDetail = null;
               List<FilePathDTO> existingImages = null; 

               try {
                   
                   System.out.println(">>> DEBUG modify.jsp: Calling CourseService.getCourseDetail for courseNum=" + courseNum);
                   courseDetail = courseService.getCourseDetail(courseNum);
                    System.out.println(">>> DEBUG modify.jsp: CourseService.getCourseDetail result = " + (courseDetail != null ? "Found" : "Not Found"));

                   
                    if (courseDetail != null) {
                       System.out.println(">>> DEBUG modify.jsp: Calling CourseService.getCourseImages for courseNum=" + courseNum);
                       existingImages = courseService.getCourseImages(courseNum);
                        System.out.println(">>> DEBUG modify.jsp: CourseService.getCourseImages result size = " + (existingImages != null ? existingImages.size() : "null"));
                    }


               } catch (Exception e) { 
                   e.printStackTrace(); 
                   System.err.println(">>> ERROR modify.jsp: Failed to load course detail or images for courseNum=" + courseNum);
                   out.println("<script>alert('코스 정보를 불러오는데 실패했습니다.'); window.history.back();</script>");
                   return;
               }

               
               if (courseDetail == null) {
                   out.println("<script>alert('코스를 찾을 수 없습니다.'); window.history.back();</script>");
                   return;
               }

               if (!courseDetail.getMember_Id().equals(loggedInMemberId)) {
                   
                   out.println("<script>alert('본인이 작성한 코스만 수정할 수 있습니다.'); window.history.back();</script>");
                   return;
               }
                System.out.println(">>> DEBUG modify.jsp: Course found and ownership confirmed. Title=" + courseDetail.getCourse_Title());


               
               List<GungDTO> gungList = null;
               try {
                   gungList = courseService.getAllGungs(); 
                    System.out.println(">>> DEBUG modify.jsp: Loaded gungList size = " + (gungList != null ? gungList.size() : "null"));
               } catch (Exception e) { 
                   e.printStackTrace(); 
                   System.err.println(">>> ERROR modify.jsp: Failed to load gung list for form.");
                   
               }


               
               pageContext.setAttribute("courseDetail", courseDetail);
               pageContext.setAttribute("gungList", gungList);
               
               if (existingImages != null && !existingImages.isEmpty()) {
                    JSONArray existingImagesJsonArray = new JSONArray();
                    for (FilePathDTO file : existingImages) {
                        JSONObject fileJson = new JSONObject();
                        
                        
                        fileJson.put("url", request.getContextPath() + file.getPath()); 
                        fileJson.put("relativePath", file.getPath()); 
                        fileJson.put("savedFileName", file.getImgName()); 
                        fileJson.put("propertyId", file.getPropertyId()); 
                        existingImagesJsonArray.add(fileJson);
                    }
                     
                     pageContext.setAttribute("existingImagesJson", existingImagesJsonArray.toJSONString());
                     System.out.println(">>> DEBUG modify.jsp: existingImagesJson = " + existingImagesJsonArray.toJSONString());

               } else {
                    pageContext.setAttribute("existingImagesJson", "[]"); 
                     System.out.println(">>> DEBUG modify.jsp: No existing images found, existingImagesJson = []");
               }


            %>


            <div class="course-form-area">
                 <form id="courseModifyForm" action="course_modify_process.jsp" method="post">
                    <input type="hidden" name="course_num" value="${courseDetail.course_Num}">
                     <input type="hidden" name="deletedFileIds" id="deletedFileIds" value=""> 
                     <input type="hidden" name="newUploadedImagesInfo" id="newUploadedImagesInfo" value="[]"> 

                    <div class="form-group">
                         <label for="gung_id_select">관람 궁 선택</label>
                         <select class="form-control sel_st" name="gung_id" id="gung_id_select"> 
                            <c:if test="${not empty gungList}"> 
                                <c:forEach items="${gungList}" var="gung"> 
                                    <option value="${gung.gung_id}" 
                                            <c:if test="${courseDetail.gung_Id == gung.gung_id}">selected</c:if>> 
                                        ${gung.gung_name} 
                                    </option>
                                </c:forEach>
                            </c:if>
                             <c:if test="${empty gungList}">
                                  <option value="">궁 목록을 불러올 수 없습니다.</option> 
                             </c:if>
                         </select>
                    </div>

                    <div class="form-group">
                         <label for="course_title">코스 제목</label>
                         <input type="text" class="form-control" id="course_title" name="course_title" 
                                value="${courseDetail.course_Title}" required>
                    </div>

                    <div class="form-group">
                         <label for="course_content">코스 내용</label>
                         
                         <textarea id="summernote" name="course_content">${courseDetail.course_Content}</textarea>
                    </div>


                    <div class="btn-group">
                         <button type="submit" class="btn btn-primary">수정 완료</button>
                         
                         <button type="button" class="btn btn-secondary" onclick="window.location.href='users_course.jsp?mode=mycourses'">취소</button> 
                    </div>
                 </form>
            </div>

        </article>

    </div> 
  </main>

  
  <jsp:include page="/common/jsp/footer.jsp" />


  <script>
    var $j = jq; 

    let newlyUploadedFiles = [];

    $(document).ready(function() {
        $j('#summernote').summernote({ 
            height: 400, 
            lang: 'ko-KR', 
            placeholder: '코스 내용을 작성해주세요',
            callbacks: {
                onImageUpload: function(files) {
                    console.log('>>> DEBUG modify.jsp: onImageUpload callback fired. Files:', files);
                    if (files.length > 0) {
                        const file = files[0];
                        sendImage(file); 
                    }
                },


                 onMediaDelete : function(target) { 
                     console.log('>>> DEBUG modify.jsp: onMediaDelete callback fired. Target:', target);
                     const deletedImg = $j(target); 
                     const deletedImgSrc = deletedImg.attr('src'); 
                     const deletedPropertyId = deletedImg.attr('data-property-id'); 

                     if (deletedPropertyId) {
                          console.log('>>> DEBUG modify.jsp: Detected deletion of existing image with propertyId:', deletedPropertyId);
                          let deletedFileIds = $j('#deletedFileIds').val() ? $j('#deletedFileIds').val().split(',') : []; 
                          
                          if (!deletedFileIds.includes(String(deletedPropertyId))) {
                              deletedFileIds.push(String(deletedPropertyId));
                              $j('#deletedFileIds').val(deletedFileIds.join(','));
                              console.log('>>> DEBUG modify.jsp: Added propertyId ' + deletedPropertyId + ' to deletedFileIds. Current list:', $j('#deletedFileIds').val());
                          }
                     } else {
                          console.log('>>> DEBUG modify.jsp: Detected deletion of potentially new image with src:', deletedImgSrc);
                          newlyUploadedFiles = newlyUploadedFiles.filter(imgInfo => imgInfo.url !== deletedImgSrc);
                          console.log('>>> DEBUG modify.jsp: Removed image from newlyUploadedFiles. Current size:', newlyUploadedFiles.length);
                          $j('#newUploadedImagesInfo').val(JSON.stringify(newlyUploadedFiles));
                          console.log('>>> DEBUG modify.jsp: Updated newUploadedImagesInfo hidden field:', $j('#newUploadedImagesInfo').val());
                     }

                 } 
            } 
        }); 

        function sendImage(file) {
            const data = new FormData();
            data.append('upload', file); 

            const gungId = $j('#gung_id_select').val(); 
            if (gungId && gungId !== "" && gungId !== "-1") { 
                 data.append('gungId', gungId); 
                 console.log('>>> DEBUG modify.jsp: Sending image upload request with gungId:', gungId);
            } else {
                 alert('이미지를 업로드하려면 먼저 궁을 선택해야 합니다.');
                 $j('#summernote').summernote('editor.delete'); // 방금 삽입된 미리보기 이미지 제거
                 console.error('>>> ERROR modify.jsp: Image upload blocked - No valid gungId selected.');
                 return; 
            }

            const uploadUrl = 'uploadImage.jsp'; 

            $j.ajax({
                url: uploadUrl,
                type: 'POST',
                data: data,
                cache: false,
                contentType: false, 
                processData: false, 
                dataType: 'json', // 서버 응답 타입을 JSON으로 기대
                success: function(response) {
                    console.log('>>> DEBUG modify.jsp: Image upload success response:', response);

                    if (response.status === 'success') {
                        const imageUrl = response.url; 
                        const relativePath = response.relativePath; 
                        const savedFileName = response.savedFileName; 

                        const newImageInfo = {
                            url: imageUrl, 
                            relativePath: relativePath, 
                            savedFileName: savedFileName, 
                        };
                        newlyUploadedFiles.push(newImageInfo);
                        console.log('>>> DEBUG modify.jsp: Added new image info to newlyUploadedFiles. Current size:', newlyUploadedFiles.length);
                        $j('#newUploadedImagesInfo').val(JSON.stringify(newlyUploadedFiles));
                        console.log('>>> DEBUG modify.jsp: Updated newUploadedImagesInfo hidden field:', $j('#newUploadedImagesInfo').val());

                    } else {
                        alert('이미지 업로드 실패: ' + (response.message || '알 수 없는 오류'));
                        console.error('>>> ERROR modify.jsp: Image upload failed response:', response);
                        $j('#summernote').summernote('editor.delete'); // 실패 시 미리보기 이미지 제거
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('이미지 업로드 중 오류 발생.');
                    console.error('>>> ERROR modify.jsp: Image upload Ajax error:', textStatus, errorThrown, jqXHR.responseText, jqXHR.status, jqXHR.statusText);
                    $j('#summernote').summernote('editor.delete'); // 오류 시 미리보기 이미지 제거
                }
            }); 
        } 

        const existingImagesJson = $j('#existingImagesJson').val();

        if (existingImagesJson && existingImagesJson !== "[]") {
             try {
                 const existingImages = JSON.parse(existingImagesJson);
                 if (existingImages && existingImages.length > 0) {
                     existingImages.forEach(function(img) {
                         if (img.url) {
                             const imgNode = $j('<img>').attr('src', img.url).attr('data-property-id', img.propertyId).attr('data-original-name', img.originalFileName).attr('data-saved-name', img.savedFileName).attr('data-relative-path', img.relativePath); 
                             $j('#summernote').summernote('insertNode', imgNode[0]); 
                             console.log('>>> DEBUG modify.jsp: Inserted existing image to editor with propertyId:', img.propertyId, 'url:', img.url);
                         }
                     });
                 }
             } catch (e) {
                 console.error('>>> ERROR modify.jsp: Failed to parse existing images JSON or insert existing images.', e);
                 alert('기존 이미지 로드 중 오류 발생.');
             }
        }

    }); // $(document).ready 끝
  </script>

</body>
</html>
