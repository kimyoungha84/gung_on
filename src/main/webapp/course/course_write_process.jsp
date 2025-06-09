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


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<% request.setCharacterEncoding("UTF-8"); %>

<% 
    PrintWriter script = response.getWriter();
    response.setContentType("text/html; charset=UTF-8");

    System.out.println(">>> DEBUG process: Entering course_write_process.jsp (Final Version)");

    // 1. 로그인 상태 확인
    MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");

    if (mDTO == null) {
        script.println("<script>alert('로그인이 필요합니다.');window.location.href = '/Gung_On/member/login.jsp';</script>"); script.close();
        System.out.println(">>> DEBUG process: User not logged in. Redirecting.");
        return; 
    }

    String id = mDTO.getId();

    // 2. 폼 데이터 가져오기
    String courseTitle = request.getParameter("course_title");
    String courseContent = request.getParameter("course_content"); // Summernote 에디터의 HTML 내용
    String gungIdStr = request.getParameter("gung_id");
    String uploadedImagesInfoJson = request.getParameter("uploadedImagesInfo"); // Summernote 숨김 필드 값

    // 요청 파라미터 값 디버깅 출력
    if (courseContent != null) {
         int maxLength = 500; 
        String displayContent = courseContent;
        if (courseContent.length() > maxLength) {
            displayContent = courseContent.substring(0, maxLength / 2) + "..." + courseContent.substring(courseContent.length() - maxLength / 2);
        }
        System.out.println(">>> DEBUG process: Received courseContent (partial/full) = " + displayContent);
    } else {
         System.out.println(">>> DEBUG process: Received courseContent = null");
    }

    System.out.println(">>> DEBUG process: Received gungIdStr = " + gungIdStr);
    System.out.println(">>> DEBUG process: Received uploadedImagesInfoJson = " + uploadedImagesInfoJson);


    int gungId = 0;
    if (gungIdStr != null && !gungIdStr.isEmpty()) {
        try {
            gungId = Integer.parseInt(gungIdStr);
             if (gungId < 1 || gungId > 5) { 
                  script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); script.close();
                   System.err.println(">>> ERROR process: Invalid gungId range: " + gungId);
                  return;
             }
        } catch (NumberFormatException e) {
            script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>"); e.printStackTrace(); script.close();
             System.err.println(">>> ERROR process: NumberFormatException for gungId: " + gungIdStr);
            return;
        }
    } else {
     script.println("<script>alert('궁을 선택해주세요.');window.history.back();</script>"); script.close();
      System.err.println(">>> ERROR process: gungIdStr is null or empty.");
     return;
    }

    // 4. CourseDTO 객체 생성 및 설정
    CourseDTO course = new CourseDTO();
    course.setMember_Id(id);
    course.setCourse_Title(courseTitle);
    course.setCourse_Content(courseContent); // Summernote 내용 설정
    course.setGung_Id(gungId);

    System.out.println(">>> DEBUG process: CourseDTO set - memberId=" + course.getMember_Id() + ", title=" + course.getCourse_Title() + ", gungId=" + course.getGung_Id() + ", content length=" + (course.getCourse_Content() != null ? course.getCourse_Content().length() : "null"));


    // 5. 이미지 정보 목록 파싱 및 FilePathDTO 객체 생성
    List<FilePathDTO> uploadedFileList = new ArrayList<>();
    // uploadedImagesInfoJson이 null이 아니고 비어있지 않으며 "[]" 문자열도 아닐 때만 파싱 시도
    if (uploadedImagesInfoJson != null && !uploadedImagesInfoJson.isEmpty() && !uploadedImagesInfoJson.trim().equals("[]")) { 
        try {
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray) parser.parse(uploadedImagesInfoJson);

            System.out.println(">>> DEBUG process: Parsed JSON array size = " + jsonArray.size());

            for (Object obj : jsonArray) {
                if (!(obj instanceof JSONObject)) {
                    System.err.println(">>> ERROR process: Unexpected object type in JSON array: " + obj.getClass().getName());
                    continue; // 올바른 형태가 아니면 건너뛰기
                }
                
                JSONObject jsonObject = (JSONObject) obj;
                
                Object imageUrlObj = jsonObject.get("url"); 
                Object savedFileNameObj = jsonObject.get("savedFileName"); // uploadImage.jsp가 반환한 키 이름
                Object relativePathObj = jsonObject.get("relativePath"); // uploadImage.jsp가 반환한 키 이름


                String imageUrl = (imageUrlObj != null) ? imageUrlObj.toString() : null;
                String savedFileName = (savedFileNameObj != null) ? savedFileNameObj.toString() : null;
                String relativePath = (relativePathObj != null) ? relativePathObj.toString() : null;


                System.out.println(">>> DEBUG process: Image JSON (after get) - url=" + imageUrl + ", savedFileName=" + savedFileName + ", relativePath=" + relativePath);

                FilePathDTO fileDTO = new FilePathDTO();
                
                if (relativePath != null && !relativePath.isEmpty()) {
                     fileDTO.setPath(relativePath); 
                     System.out.println(">>> DEBUG process: FilePathDTO path set to: " + relativePath);
                } else {
                     System.err.println(">>> WARNING process: relativePath (from JSON) is null or empty! FilePathDTO path will be null.");
                }

                // imgName 필드에 uploadImage.jsp에서 반환한 savedFileName 값 설정 (DB 저장 파일명)
                if (savedFileName != null && !savedFileName.isEmpty()) {
                    fileDTO.setImgName(savedFileName); 
                    System.out.println(">>> DEBUG process: FilePathDTO imgName set to: " + savedFileName);
                } else {
                     System.err.println(">>> WARNING process: savedFileName (from JSON) is null or empty! FilePathDTO imgName will be null.");
                }

                System.out.println(">>> DEBUG process: FilePathDTO created (before add to list) - path=" + fileDTO.getPath() + ", imgName=" + fileDTO.getImgName() + ", targetType=" + fileDTO.getTargerType() + ", targerNumber=" + fileDTO.getTargerNumber()); 

                 if (fileDTO.getPath() != null && !fileDTO.getPath().isEmpty() && fileDTO.getImgName() != null && !fileDTO.getImgName().isEmpty()) {
                    uploadedFileList.add(fileDTO); 
                    System.out.println(">>> DEBUG process: Added FilePathDTO to uploadedFileList.");
                 } else {
                     System.err.println(">>> WARNING process: Skipping FilePathDTO addition to list due to null/empty path or imgName.");
                 }

            }
            System.out.println(">>> DEBUG process: uploadedFileList size after loop = " + uploadedFileList.size());


        } catch (org.json.simple.parser.ParseException e) {
            script.println("<script>alert('이미지 정보 파싱 오류.');window.history.back();</script>"); e.printStackTrace(); script.close(); 
             System.err.println(">>> ERROR process: JSON parsing error for uploadedImagesInfoJson!");
            return;
        } catch (Exception e) {
            script.println("<script>alert('이미지 정보 처리 중 오류 발생.');window.history.back();</script>"); e.printStackTrace(); script.close();
            System.err.println(">>> ERROR process: Unexpected Exception during image info processing!");
            return;
        }
    } else {
         System.out.println(">>> DEBUG process: No uploaded images info received or info is empty [].");
    }

    // 6. Service를 사용하여 코스 정보 및 파일 정보 반영
    CourseService courseService = new CourseService();
    boolean isAdded = false;
    try {
        System.out.println(">>> DEBUG process: Calling CourseService.addCourseWithImages...");
        System.out.println(">>> DEBUG process: Args - course title=" + (course != null ? course.getCourse_Title() : "null") + ", uploadedFileList size=" + uploadedFileList.size() + ", memberId=" + id);

        isAdded = courseService.addCourseWithImages(course, uploadedFileList, id); 
        
        System.out.println(">>> DEBUG process: CourseService.addCourseWithImages result = " + isAdded);

    } catch (Exception e) {
        script.println("<script>alert('코스 등록 처리 중 오류 발생.');window.history.back();</script>");
        e.printStackTrace();
        script.close(); 
        System.err.println(">>> ERROR process: Exception during CourseService.addCourseWithImages call!");
        return;
    }

    // 7. 등록 결과에 따른 메시지 및 페이지 이동
    if (isAdded) {
        script.println("<script>");
        script.println("alert('코스가 성공적으로 등록되었습니다.');");
        script.println("window.location.href = 'users_course.jsp';"); // 등록 후 코스 목록 페이지로 이동 (필터링 없이)
        script.println("</script>");
         System.out.println(">>> DEBUG process: Course added successfully. Redirecting.");
    } else {
        script.println("<script>");
        script.println("alert('코스 등록에 실패했습니다. 다시 시도해주세요.');"); 
        script.println("window.history.back();");
        script.println("</script>");
        System.err.println(">>> ERROR process: Course registration failed (Service returned false).");
    }
    script.close(); 
    System.out.println(">>> DEBUG process: Exiting course_write_process.jsp");

%>
