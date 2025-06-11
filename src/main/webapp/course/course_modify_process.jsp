<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="kr.co.gungon.course.CourseDTO"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Arrays"%> 
<%@page import="java.util.stream.Collectors"%> 
<%@page import="java.io.File"%>


<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<% request.setCharacterEncoding("UTF-8"); %>

<% 
    PrintWriter script = response.getWriter();
    response.setContentType("text/html; charset=UTF-8");

    System.out.println(">>> DEBUG modify_process: Entering course_modify_process.jsp");

    MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
    if (mDTO == null) {
        script.println("<script>alert('로그인이 필요합니다.');window.location.href = '/member/login.jsp';</script>"); script.close();
        System.out.println(">>> DEBUG modify_process: User not logged in. Redirecting.");
        return; 
    }
    String loggedInMemberId = mDTO.getId(); 

    String courseNumParam = request.getParameter("course_num");
    String courseTitle = request.getParameter("course_title");
    String courseContent = request.getParameter("course_content"); // Summernote 에디터의 HTML 내용
    String gungIdStr = request.getParameter("gung_id");
    String deletedFileIdsStr = request.getParameter("deletedFileIds"); 
    String newUploadedImagesInfoJson = request.getParameter("newUploadedImagesInfo"); 


    if (courseContent != null) {
        int maxLength = 500; // 출력할 최대 길이
        String displayContent = courseContent;
        if (courseContent.length() > maxLength) {
            displayContent = courseContent.substring(0, maxLength / 2) + "..." + courseContent.substring(courseContent.length() - maxLength / 2);
        }
    } 

    int courseNum = -1; 
    if (courseNumParam != null && !courseNumParam.isEmpty()) {
       try {
           courseNum = Integer.parseInt(courseNumParam);
       } catch (NumberFormatException e) {
    	   e.printStackTrace();
       }
    }
     if (courseNum <= 0) {
         script.println("<script>alert('유효하지 않은 코스 정보입니다.');window.history.back();</script>"); script.close();
         return;
     }

    int gungId = 0;
    if (gungIdStr != null && !gungIdStr.isEmpty()) {
        try {
            gungId = Integer.parseInt(gungIdStr);
             if (gungId < 1 || gungId > 5) { 
                  script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); script.close();
                  return;
             }
        } catch (NumberFormatException e) {
            script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); e.printStackTrace(); script.close();
            return;
        }
    } else {
         script.println("<script>alert('궁 정보가 누락되었습니다.');window.history.back();</script>"); script.close();
         return;
    }


    CourseService courseService = new CourseService(); 
    CourseDTO existingCourse = null; 
    try {
         existingCourse = courseService.getCourseDetail(courseNum); 
         if (existingCourse == null) {
              script.println("<script>alert('코스를 찾을 수 없습니다.');window.history.back();</script>"); script.close();
              return;
         }

    } catch (Exception e) {
        e.printStackTrace();
         script.println("<script>alert('코스 정보 확인 중 오류 발생.');window.history.back();</script>"); script.close();
         return;
    }

    List<Integer> deletedFileIds = new ArrayList<>(); 
    if (deletedFileIdsStr != null && !deletedFileIdsStr.isEmpty()) {
        try {
            deletedFileIds = Arrays.stream(deletedFileIdsStr.split(","))
                                  .map(String::trim) 
                                  .filter(s -> !s.isEmpty()) 
                                  .map(Integer::parseInt) 
                                  .collect(Collectors.toList());

        } catch (NumberFormatException e) {
             script.println("<script>alert('삭제된 이미지 정보 형식이 올바르지 않습니다.');window.history.back();</script>"); e.printStackTrace(); script.close();
             return;
        }
    } 

    List<FilePathDTO> newUploadedFileList = new ArrayList<>();
    if (newUploadedImagesInfoJson != null && !newUploadedImagesInfoJson.isEmpty() && !newUploadedImagesInfoJson.trim().equals("[]")) { 
         try {
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray) parser.parse(newUploadedImagesInfoJson);

            for (Object obj : jsonArray) {
                if (!(obj instanceof JSONObject)) {
                    continue; 
                }
                
                JSONObject jsonObject = (JSONObject) obj;
                
                Object imageUrlObj = jsonObject.get("url"); 
                Object savedFileNameObj = jsonObject.get("savedFileName"); 
                Object relativePathObj = jsonObject.get("relativePath"); 

                String imageUrl = (imageUrlObj != null) ? imageUrlObj.toString() : null;
                String savedFileName = (savedFileNameObj != null) ? savedFileNameObj.toString() : null;
                String relativePath = (relativePathObj != null) ? relativePathObj.toString() : null;


                FilePathDTO fileDTO = new FilePathDTO();
                
                if (relativePath != null && !relativePath.isEmpty()) {
                     fileDTO.setPath(relativePath); 
                } 

                if (savedFileName != null && !savedFileName.isEmpty()) {
                    fileDTO.setImgName(savedFileName); 
                } 

                System.out.println(">>> DEBUG modify_process: New FilePathDTO created (before add to list) - path=" + fileDTO.getPath() + ", imgName=" + fileDTO.getImgName() + ", targetType=" + fileDTO.getTargerType() + ", targerNumber=" + fileDTO.getTargerNumber()); 

                 if (fileDTO.getPath() != null && !fileDTO.getPath().isEmpty() && fileDTO.getImgName() != null && !fileDTO.getImgName().isEmpty()) {
                    newUploadedFileList.add(fileDTO); 
                 } 
            }

        } catch (org.json.simple.parser.ParseException e) {
            e.printStackTrace();
             script.println("<script>alert('새로 업로드된 이미지 정보 파싱 오류.');window.history.back();</script>"); script.close();
            return;
        } catch (Exception e) {
            e.printStackTrace();
             script.println("<script>alert('새로 업로드된 이미지 정보 처리 중 오류 발생.');window.history.back();</script>"); script.close();
            return;
        }
    } 

    CourseDTO modifiedCourse = new CourseDTO();
    modifiedCourse.setCourse_Num(courseNum); 
    modifiedCourse.setMember_Id(loggedInMemberId); 
    modifiedCourse.setCourse_Title(courseTitle); 
    modifiedCourse.setCourse_Content(courseContent); 
    modifiedCourse.setGung_Id(gungId); 

    boolean isModified = false;
    try {
        isModified = courseService.modifyCourseWithImages(modifiedCourse, newUploadedFileList, deletedFileIds, loggedInMemberId); 

    } catch (Exception e) {
        script.println("<script>alert('코스 수정 처리 중 오류 발생.');window.history.back();</script>");
        e.printStackTrace();
        script.close(); 
        return;
    }

    if (isModified) {
        script.println("<script>");
        script.println("alert('코스가 성공적으로 수정되었습니다.');");
        script.println("window.location.href = 'users_course.jsp?gung_id=" + gungId + "&mode=mycourses';"); 
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('코스 수정에 실패했습니다. 본인이 작성한 코스인지 확인해주세요.');"); 
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close(); 
%>
