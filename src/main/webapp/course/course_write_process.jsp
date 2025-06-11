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

    // 1. 로그인 상태 확인
    MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");

    if (mDTO == null) {
        script.println("<script>alert('로그인이 필요합니다.');window.location.href = '/member/login.jsp';</script>");
        script.close();
        return;
    }

    String id = mDTO.getId();

    String courseTitle = request.getParameter("course_title");
    String courseContent = request.getParameter("course_content"); 
    String gungIdStr = request.getParameter("gung_id");
    String uploadedImagesInfoJson = request.getParameter("newUploadedImagesInfo"); 

    if (courseContent != null) {
        int maxLength = 500;
        String displayContent = courseContent;
        if (courseContent.length() > maxLength) {
            displayContent = courseContent.substring(0, maxLength / 2) + "..." + courseContent.substring(courseContent.length() - maxLength / 2);
        }
    }

    int gungId = 0;
    if (gungIdStr != null && !gungIdStr.isEmpty()) {
        try {
            gungId = Integer.parseInt(gungIdStr);
            if (gungId < 1 || gungId > 5) {
                script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>");
                script.close();
                return;
            }
        } catch (NumberFormatException e) {
            script.println("<script>alert('유효하지 않은 궁 정보입니다.');window.history.back();</script>");
            e.printStackTrace();
            script.close();
            return;
        }
    } else {
        script.println("<script>alert('궁을 선택해주세요.');window.history.back();</script>");
        script.close();
        return;
    }

    CourseDTO course = new CourseDTO();
    course.setMember_Id(id);
    course.setCourse_Title(courseTitle);
    course.setCourse_Content(courseContent); // Summernote 내용 설정
    course.setGung_Id(gungId);

    List<FilePathDTO> uploadedFileList = new ArrayList<>();
    if (uploadedImagesInfoJson != null && !uploadedImagesInfoJson.isEmpty() && !uploadedImagesInfoJson.trim().equals("[]")) {
        try {
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray) parser.parse(uploadedImagesInfoJson);

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

                if (fileDTO.getPath() != null && !fileDTO.getPath().isEmpty() && fileDTO.getImgName() != null && !fileDTO.getImgName().isEmpty()) {
                    uploadedFileList.add(fileDTO);
                }
            }
        } catch (org.json.simple.parser.ParseException e) {
            script.println("<script>alert('이미지 정보 파싱 오류.');window.history.back();</script>");
            e.printStackTrace();
            script.close();
            return;
        } catch (Exception e) {
            script.println("<script>alert('이미지 정보 처리 중 오류 발생.');window.history.back();</script>");
            e.printStackTrace();
            script.close();
            return;
        }
    }

    CourseService courseService = new CourseService();
    boolean isAdded = false;
    try {
        isAdded = courseService.addCourseWithImages(course, uploadedFileList, id);
    } catch (Exception e) {
        script.println("<script>alert('코스 등록 처리 중 오류 발생.');window.history.back();</script>");
        e.printStackTrace();
        script.close();
        return;
    }

    if (isAdded) {
        script.println("<script>");
        script.println("alert('코스가 성공적으로 등록되었습니다.');");
        script.println("window.location.href = 'users_course.jsp?gung_id=" + gungId + "';"); // 여기에 gung_id 쿼리 파라미터 포함
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('코스 등록에 실패했습니다. 다시 시도해주세요.');");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close();
%>
