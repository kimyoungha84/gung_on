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

    // 1. 로그인 상태 확인
    MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
    if (mDTO == null) {
        script.println("<script>alert('로그인이 필요합니다.');window.location.href = '${pageContext.request.contextPath}/member/login.jsp';</script>"); script.close();
        System.out.println(">>> DEBUG modify_process: User not logged in. Redirecting.");
        return; 
    }
    String loggedInMemberId = mDTO.getId(); 

    // 2. 폼 데이터 가져오기
    String courseNumParam = request.getParameter("course_num");
    String courseTitle = request.getParameter("course_title");
    String courseContent = request.getParameter("course_content"); // Summernote 에디터의 HTML 내용
    String gungIdStr = request.getParameter("gung_id");
    String deletedFileIdsStr = request.getParameter("deletedFileIds"); 
    String newUploadedImagesInfoJson = request.getParameter("newUploadedImagesInfo"); 


    System.out.println(">>> DEBUG modify_process: Received courseNumParam = " + courseNumParam);
    System.out.println(">>> DEBUG modify_process: Received courseTitle = " + courseTitle);
    // *** courseContent 디버깅 출력 강화 ***
    System.out.println(">>> DEBUG modify_process: Received courseContent length = " + (courseContent != null ? courseContent.length() : "null"));
    if (courseContent != null) {
        // 내용이 너무 길면 잘릴 수 있으므로 처음/끝 부분과 총 길이를 출력
        int maxLength = 500; // 출력할 최대 길이
        String displayContent = courseContent;
        if (courseContent.length() > maxLength) {
            displayContent = courseContent.substring(0, maxLength / 2) + "..." + courseContent.substring(courseContent.length() - maxLength / 2);
        }
        System.out.println(">>> DEBUG modify_process: Received courseContent (partial/full) = " + displayContent);
    } else {
         System.out.println(">>> DEBUG modify_process: Received courseContent = null");
    }


    System.out.println(">>> DEBUG modify_process: Received gungIdStr = " + gungIdStr);
    System.out.println(">>> DEBUG modify_process: Received deletedFileIdsStr = " + deletedFileIdsStr);
    System.out.println(">>> DEBUG modify_process: Received newUploadedImagesInfoJson = " + newUploadedImagesInfoJson);


    // 3. 코스 번호 및 궁 ID 유효성 검사 및 변환
    int courseNum = -1; 
    if (courseNumParam != null && !courseNumParam.isEmpty()) {
       try {
           courseNum = Integer.parseInt(courseNumParam);
       } catch (NumberFormatException e) {
           System.err.println(">>> ERROR modify_process: Invalid course_num param format: " + courseNumParam);
       }
    }
     if (courseNum <= 0) {
         script.println("<script>alert('유효하지 않은 코스 정보입니다.');window.history.back();</script>"); script.close();
          System.err.println(">>> ERROR modify_process: courseNum <= 0.");
         return;
     }

    int gungId = 0;
    if (gungIdStr != null && !gungIdStr.isEmpty()) {
        try {
            gungId = Integer.parseInt(gungIdStr);
             if (gungId < 1 || gungId > 5) { 
                  script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); script.close();
                   System.err.println(">>> ERROR modify_process: Invalid gungId range: " + gungId);
                  return;
             }
        } catch (NumberFormatException e) {
            script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); e.printStackTrace(); script.close();
             System.err.println(">>> ERROR modify_process: NumberFormatException for gungId: " + gungIdStr);
            return;
        }
    } else {
         script.println("<script>alert('궁 정보가 누락되었습니다.');window.history.back();</script>"); script.close();
          System.err.println(">>> ERROR modify_process: gungIdStr is null or empty.");
         return;
    }


    // 4. Service를 사용하여 기존 코스 정보 조회 및 작성자 일치 확인 (Optional here, Service will check)
    // Service 메소드 (modifyCourseWithImages) 내부에서 작성자 확인 로직을 포함하는 것이 좋음.
    CourseService courseService = new CourseService(); 
    CourseDTO existingCourse = null; 
    try {
         System.out.println(">>> DEBUG modify_process: Checking course ownership for modify for courseNum=" + courseNum + ", memberId=" + loggedInMemberId);
         
         existingCourse = courseService.getCourseDetail(courseNum); 
         if (existingCourse == null) {
              System.err.println(">>> ERROR modify_process: Course not found for modify.");
              script.println("<script>alert('코스를 찾을 수 없습니다.');window.history.back();</script>"); script.close();
              return;
         }
          // Service 메소드 내부에서 최종 작성자 일치 확인을 한다고 가정
          // if (!existingCourse.getMember_Id().equals(loggedInMemberId)) { ... } 

         System.out.println(">>> DEBUG modify_process: Course found. Ownership check will be done in Service.");

    } catch (Exception e) {
        e.printStackTrace();
         System.err.println(">>> ERROR modify_process: Exception during initial course check.");
         script.println("<script>alert('코스 정보 확인 중 오류 발생.');window.history.back();</script>"); script.close();
         return;
    }


    // 5. 삭제된 기존 이미지 ID 목록 파싱
    List<Integer> deletedFileIds = new ArrayList<>(); 
    if (deletedFileIdsStr != null && !deletedFileIdsStr.isEmpty()) {
        try {
            deletedFileIds = Arrays.stream(deletedFileIdsStr.split(","))
                                  .map(String::trim) 
                                  .filter(s -> !s.isEmpty()) 
                                  .map(Integer::parseInt) 
                                  .collect(Collectors.toList());
            System.out.println(">>> DEBUG modify_process: Parsed deletedFileIds = " + deletedFileIds);

        } catch (NumberFormatException e) {
            System.err.println(">>> ERROR modify_process: Invalid format for deletedFileIds: " + deletedFileIdsStr);
             script.println("<script>alert('삭제된 이미지 정보 형식이 올바르지 않습니다.');window.history.back();</script>"); e.printStackTrace(); script.close();
             return;
        }
    } else {
         System.out.println(">>> DEBUG modify_process: No deletedFileIds received.");
    }


    // 6. 새로 업로드된 이미지 정보 목록 파싱 (숨김 필드 값)
    List<FilePathDTO> newUploadedFileList = new ArrayList<>();
    if (newUploadedImagesInfoJson != null && !newUploadedImagesInfoJson.isEmpty() && !newUploadedImagesInfoJson.trim().equals("[]")) { 
         try {
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray) parser.parse(newUploadedImagesInfoJson);

            System.out.println(">>> DEBUG modify_process: Parsed newUploadedImagesInfoJson array size = " + jsonArray.size());

            for (Object obj : jsonArray) {
                if (!(obj instanceof JSONObject)) {
                    System.err.println(">>> ERROR modify_process: Unexpected object type in JSON array: " + obj.getClass().getName());
                    continue; 
                }
                
                JSONObject jsonObject = (JSONObject) obj;
                
                // course_modify.jsp JavaScript에서 저장한 정보 가져오기
                // Summernote JS가 "url", "relativePath", "savedFileName" 키로 저장했다고 가정
                Object imageUrlObj = jsonObject.get("url"); 
                Object savedFileNameObj = jsonObject.get("savedFileName"); 
                Object relativePathObj = jsonObject.get("relativePath"); 

                // 가져온 값을 String으로 변환
                String imageUrl = (imageUrlObj != null) ? imageUrlObj.toString() : null;
                String savedFileName = (savedFileNameObj != null) ? savedFileNameObj.toString() : null;
                String relativePath = (relativePathObj != null) ? relativePathObj.toString() : null;


                // *** 각 새로 업로드된 이미지 정보 디버깅 출력 (값 확인) ***
                System.out.println(">>> DEBUG modify_process: New Image JSON (after get) - url=" + imageUrl + ", savedFileName=" + savedFileName + ", relativePath=" + relativePath);

                // *** FilePathDTO 객체 생성 및 정보 설정 (확인) ***
                FilePathDTO fileDTO = new FilePathDTO();
                
                // DB에 저장할 정보 설정 (path와 imgName)
                // uploadImage.jsp가 반환한 relativePath와 savedFileName 사용
                if (relativePath != null && !relativePath.isEmpty()) {
                     fileDTO.setPath(relativePath); 
                     System.out.println(">>> DEBUG modify_process: New FilePathDTO path set to: " + relativePath);
                } else {
                     System.err.println(">>> WARNING modify_process: relativePath (from JSON) is null or empty! FilePathDTO path will be null.");
                }

                if (savedFileName != null && !savedFileName.isEmpty()) {
                    fileDTO.setImgName(savedFileName); 
                    System.out.println(">>> DEBUG modify_process: New FilePathDTO imgName set to: " + savedFileName);
                } else {
                     System.err.println(">>> WARNING modify_process: savedFileName (from JSON) is null or empty! FilePathDTO imgName will be null.");
                }

                // targetType, targerNumber는 Service 메소드에서 설정됨
                // fileDTO.setTargerType("course"); // Service에서 설정
                // fileDTO.setTargerNumber(String.valueOf(courseNum)); // Service에서 설정


                // *** FilePathDTO 설정 값 디버깅 출력 (Service로 넘기기 전) ***
                // targetType, targerNumber는 아직 설정 안됨.
                System.out.println(">>> DEBUG modify_process: New FilePathDTO created (before add to list) - path=" + fileDTO.getPath() + ", imgName=" + fileDTO.getImgName() + ", targetType=" + fileDTO.getTargerType() + ", targerNumber=" + fileDTO.getTargerNumber()); 

                // path와 imgName이 유효한 경우에만 목록에 추가 (DB 삽입 오류 방지)
                 if (fileDTO.getPath() != null && !fileDTO.getPath().isEmpty() && fileDTO.getImgName() != null && !fileDTO.getImgName().isEmpty()) {
                    newUploadedFileList.add(fileDTO); 
                    System.out.println(">>> DEBUG modify_process: Added FilePathDTO to newUploadedFileList.");
                 } else {
                     System.err.println(">>> WARNING modify_process: Skipping FilePathDTO addition to list due to null/empty path or imgName.");
                 }

            }
            System.out.println(">>> DEBUG modify_process: Total newUploadedFileList size = " + newUploadedFileList.size());


        } catch (org.json.simple.parser.ParseException e) {
            System.err.println(">>> ERROR modify_process: New uploaded images JSON parsing error!");
            e.printStackTrace();
             script.println("<script>alert('새로 업로드된 이미지 정보 파싱 오류.');window.history.back();</script>"); script.close();
            return;
        } catch (Exception e) {
            System.err.println(">>> ERROR modify_process: Unexpected Exception parsing new uploaded images info!");
            e.printStackTrace();
             script.println("<script>alert('새로 업로드된 이미지 정보 처리 중 오류 발생.');window.history.back();</script>"); script.close();
            return;
        }
    } else {
         System.out.println(">>> DEBUG modify_process: No new uploaded images info received or info is empty [].");
    }


    // 7. 수정할 CourseDTO 객체 생성 및 설정
    CourseDTO modifiedCourse = new CourseDTO();
    modifiedCourse.setCourse_Num(courseNum); 
    modifiedCourse.setMember_Id(loggedInMemberId); 
    modifiedCourse.setCourse_Title(courseTitle); 
    // *** Summernote 내용 설정 ***
    modifiedCourse.setCourse_Content(courseContent); 
    modifiedCourse.setGung_Id(gungId); 

    System.out.println(">>> DEBUG modify_process: Modified CourseDTO set - courseNum=" + modifiedCourse.getCourse_Num() + ", memberId=" + modifiedCourse.getMember_Id() + ", title=" + modifiedCourse.getCourse_Title() + ", gungId=" + modifiedCourse.getGung_Id() + ", content length=" + (modifiedCourse.getCourse_Content() != null ? modifiedCourse.getCourse_Content().length() : "null"));


    // 8. Service를 사용하여 코스 정보 수정 및 파일 정보 반영 (삭제/삽입)
    boolean isModified = false;
    try {
        System.out.println(">>> DEBUG modify_process: Calling CourseService.modifyCourseWithImages...");
        System.out.println(">>> DEBUG modify_process: Args - modifiedCourse courseNum=" + modifiedCourse.getCourse_Num() + ", newUploadedFileList size=" + newUploadedFileList.size() + ", deletedFileIds size=" + deletedFileIds.size() + ", memberId=" + loggedInMemberId);

        isModified = courseService.modifyCourseWithImages(modifiedCourse, newUploadedFileList, deletedFileIds, loggedInMemberId); 
        
        System.out.println(">>> DEBUG modify_process: CourseService.modifyCourseWithImages result = " + isModified);


    } catch (Exception e) {
        script.println("<script>alert('코스 수정 처리 중 오류 발생.');window.history.back();</script>");
        e.printStackTrace();
        script.close(); 
        return;
    }

    // 9. 수정 결과에 따른 메시지 및 페이지 이동
    if (isModified) {
        script.println("<script>");
        script.println("alert('코스가 성공적으로 수정되었습니다.');");
        script.println("window.location.href = 'users_course.jsp?mode=mycourses';"); 
        script.println("</script>");
        System.out.println(">>> DEBUG modify_process: Course modified successfully. Redirecting.");
    } else {
        script.println("<script>");
        script.println("alert('코스 수정에 실패했습니다. 본인이 작성한 코스인지 확인해주세요.');"); 
        script.println("window.history.back();");
        script.println("</script>");
        System.err.println(">>> ERROR modify_process: Course modification failed (Service returned false).");
    }
    script.close(); 
    System.out.println(">>> DEBUG modify_process: Exiting course_modify_process.jsp");

%>
