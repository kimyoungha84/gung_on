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
  <title>코스 등록</title>

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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/course/css/users_course_style.css" />
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

  
  <jsp:include page="${pageContext.request.contextPath}/common/jsp/header.jsp" />

  
  <main>
    <div class="container">
        

        <article class="content">
            <h1>코스 등록</h1>

            <%
               
               CourseService cs = new CourseService();
               List<GungDTO> gungList = null;
               try {
                   gungList = cs.getAllGungs(); 
               } catch (Exception e) { 
                   e.printStackTrace(); 
               }
               
               pageContext.setAttribute("gungList", gungList);

               
               String gungIdParam = request.getParameter("gung_id");
               int selectedGungId = -1; 

               if (gungIdParam != null && !gungIdParam.isEmpty()) {
                   try {
                       selectedGungId = Integer.parseInt(gungIdParam);
                   } catch (NumberFormatException e) {
                       
                   }
               }
               pageContext.setAttribute("selectedGungId", selectedGungId);

               MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
               boolean isLoggedIn = (mDTO != null);
               pageContext.setAttribute("isLoggedIn", isLoggedIn);
            %>

            <div class="course-form-area">
                <form id="courseWriteForm" action="course_write_process.jsp" method="post">
                    <div class="form-group">
                         <label for="gung_id_select">관람 궁 선택</label>
                         <select class="form-control sel_st" name="gung_id" id="gung_id_select" required> 
                            <c:if test="${not empty gungList}"> 
                                <c:forEach items="${gungList}" var="gung"> 
                                    <option value="${gung.gung_id}" 
                                            <c:if test="${selectedGungId == gung.gung_id}">selected</c:if>>
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
                         <input type="text" class="form-control" id="course_title" name="course_title" required>
                    </div>

                    <div class="form-group">
                         <label for="course_content">코스 내용</label>
                         
                         <textarea id="summernote" name="course_content"></textarea>
                    </div>

                    
                    
                    
                    <input type="hidden" name="uploadedImagesInfo" id="uploadedImagesInfo" value="[]">

                    <div class="btn-group">
                         <button type="submit" class="btn btn-primary">등록</button>
                         
                         <button type="button" class="btn btn-secondary" onclick="window.history.back()">취소</button>
                    </div>
                </form>
            </div>

        </article>

    </div> 
  </main>

  
  <jsp:include page="${pageContext.request.contextPath}/common/jsp/footer.jsp" />


  <script>
    
    var $j = jq; 

    
    let uploadedFiles = []; // 업로드된 이미지 정보들을 저장할 배열

    $(document).ready(function() {
    	
        $j('#summernote').summernote({ 
            height: 400, 
            lang: 'ko-KR', 
            placeholder: '코스 내용을 작성해주세요',
            callbacks: {
                
                onImageUpload: function(files) {
                    if (files.length > 0) {
                        const file = files[0];
                        
                        sendImage(file); 
                    }
                },
                 
                 onMediaDelete : function(target) { 
                     console.log('>>> DEBUG write.jsp: Image deleted from Summernote:', target);
                     const deletedImg = $j(target); 
                     const deletedImgSrc = deletedImg.attr('src'); 

                     uploadedFiles = uploadedFiles.filter(imgInfo => imgInfo.url !== deletedImgSrc);
                     console.log('>>> DEBUG write.jsp: Removed image from uploadedFiles. Current size:', uploadedFiles.length);
                     
                     $j('#uploadedImagesInfo').val(JSON.stringify(uploadedFiles));
                     console.log('>>> DEBUG write.jsp: Updated uploadedImagesInfo hidden field:', $j('#uploadedImagesInfo').val());
                 }
            } 
        }); 

         
        function sendImage(file) {
            const data = new FormData();
            data.append('upload', file); 

            const gungId = $j('#gung_id_select').val(); 
            if (gungId && gungId !== "") { 
                 data.append('gungId', gungId); 
                 console.log('>>> DEBUG write.jsp: Sending image upload request with gungId:', gungId);
            } else {
                 alert('이미지를 업로드하려면 먼저 궁을 선택해야 합니다.');
                 
                 $j('#summernote').summernote('editor.delete'); 
                 console.error('>>> ERROR write.jsp: Image upload blocked - No gungId selected.');
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
                dataType: 'json', 
                success: function(response) {
                    console.log('>>> DEBUG write.jsp: Image upload success response:', response);

                    if (response.status === 'success') {
                        const imageUrl = response.url; 
                        const relativePath = response.relativePath; 
                        const savedFileName = response.savedFileName; 
                        
                        const fileInfo = {
                            url: imageUrl, // Summernote에 삽입된 URL (이미지 삭제 시 비교용)
                            relativePath: relativePath, // DB 저장용 경로
                            savedFileName: savedFileName, // DB 저장용 파일명
                        };
                        uploadedFiles.push(fileInfo);
                        console.log('>>> DEBUG write.jsp: Added file info to uploadedFiles. Current size:', uploadedFiles.length);
                        
                        $j('#uploadedImagesInfo').val(JSON.stringify(uploadedFiles));
                        console.log('>>> DEBUG write.jsp: Updated uploadedImagesInfo hidden field:', $j('#uploadedImagesInfo').val());

                    } else {
                        alert('이미지 업로드 실패: ' + (response.message || '알 수 없는 오류'));
                        console.error('>>> ERROR write.jsp: Image upload failed response:', response);
                        
                        $j('#summernote').summernote('editor.delete'); 
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('이미지 업로드 중 오류 발생.');
                    console.error('>>> ERROR write.jsp: Image upload Ajax error:', textStatus, errorThrown, jqXHR.responseText, jqXHR.status, jqXHR.statusText);
                    
                    $j('#summernote').summernote('editor.delete');
                }
            }); 
        } 

    }); 
  </script>
</body>
</html>
