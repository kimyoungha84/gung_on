<%@ page import="java.io.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="kr.co.gungon.course.CourseService" %>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("application/json; charset=UTF-8");
    JSONObject jsonResponse = new JSONObject();

    int maxSize = 10 * 1024 * 1024; // 10MB
    String encoding = "UTF-8";

    String baseUploadPathRelative = "/common/images/course";
    String tmpUploadRelative = baseUploadPathRelative + "/tmp";
    String tmpUploadAbsolute = application.getRealPath(tmpUploadRelative);

    File tmpDir = new File(tmpUploadAbsolute);
    if (!tmpDir.exists()) tmpDir.mkdirs();

    try {
        MultipartRequest multi = new MultipartRequest(
            request,
            tmpUploadAbsolute,
            maxSize,
            encoding,
            new DefaultFileRenamePolicy()
        );

        String gungIdStr = multi.getParameter("gung_id");

        if (gungIdStr == null || gungIdStr.trim().isEmpty()) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "궁 ID가 누락되었습니다.");
            response.getWriter().write(jsonResponse.toJSONString());
            return;
        }

        int gungId = Integer.parseInt(gungIdStr);
        String gungInitialFolder = "other";

        try {
            CourseService courseService = new CourseService();
            String gungName = courseService.getGungNameById(gungId);
            if (gungName != null) {
                switch (gungName) {
                    case "경복궁": gungInitialFolder = "gbg"; break;
                    case "창덕궁": gungInitialFolder = "cdg"; break;
                    case "덕수궁": gungInitialFolder = "dsg"; break;
                    case "창경궁": gungInitialFolder = "cgg"; break;
                    case "경희궁": gungInitialFolder = "ghg"; break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            gungInitialFolder = "other";
        }

        String targetRelative = baseUploadPathRelative + "/" + gungInitialFolder;
        String targetAbsolute = application.getRealPath(targetRelative);
        File targetDir = new File(targetAbsolute);
        if (!targetDir.exists()) targetDir.mkdirs();

        String savedFileName = multi.getFilesystemName("upload");
        String originalFileName = multi.getOriginalFileName("upload");
        File tmpFile = new File(tmpUploadAbsolute, savedFileName);

        // ⛔ 중복 파일명을 피해서 새 파일명 생성
        File finalFile = new File(targetAbsolute, savedFileName);
        String nameOnly = savedFileName;
        String ext = "";
        int dotIdx = savedFileName.lastIndexOf('.');
        if (dotIdx != -1) {
            nameOnly = savedFileName.substring(0, dotIdx);
            ext = savedFileName.substring(dotIdx);
        }

        int count = 1;
        while (finalFile.exists()) {
            finalFile = new File(targetAbsolute, nameOnly + "_" + count + ext);
            count++;
        }

        boolean moved = tmpFile.renameTo(finalFile);
        if (!moved) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "파일 이동 실패");
            response.getWriter().write(jsonResponse.toJSONString());
            return;
        }

        jsonResponse.put("status", "success");
        jsonResponse.put("message", "이미지 업로드 성공");
        jsonResponse.put("originalFileName", originalFileName);
        jsonResponse.put("savedFileName", finalFile.getName());
        jsonResponse.put("url", request.getContextPath() + targetRelative + "/" + finalFile.getName());
        jsonResponse.put("relativePath", targetRelative + "/" + finalFile.getName());

    } catch (Exception e) {
        e.printStackTrace();
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "서버 오류 발생");
    }

    response.getWriter().write(jsonResponse.toJSONString());
%>
