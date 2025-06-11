<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="kr.co.gungon.story.StoryDTO" %>
<%@ page import="kr.co.gungon.story.StoryService" %>
<%@ page import="kr.co.gungon.file.FilePathDTO" %>
<%@ page import="kr.co.gungon.file.FilePathService" %>

<%
request.setCharacterEncoding("UTF-8");

try {
    int maxSize = 10 * 1024 * 1024;
    String rootPath = application.getRealPath("/");

    MultipartRequest multi = new MultipartRequest(
        request,
        rootPath,
        maxSize,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    String storyName = multi.getParameter("story_name");
    String storyInfo = multi.getParameter("story_info");
    String gungIdStr = multi.getParameter("gung_id");
    String gungKorName = multi.getParameter("gung_name"); // 이미지 저장 경로 구성용

    System.out.println(">> 받은 gungId = " + gungIdStr);

    int gungId = 0;
    try {
        gungId = Integer.parseInt(gungIdStr);
    } catch (NumberFormatException e) {
        out.println("<script>alert('궁 ID가 잘못되었습니다.'); history.back();</script>");
        return;
    }

    // 🔁 전각명 → 영문 디렉토리
    String storyFolder = "UnknownStory";
    if (storyName != null) {
        switch (storyName) {
            case "흥례문": storyFolder = "Heungnyemun"; break;
            case "광화문": storyFolder = "Gwanghwamun"; break;
            case "사정전": storyFolder = "Sajeongjeon"; break;
        }
    }

    // 🔁 궁 이름 → 영문 폴더
    String gungFolder = "etc";
    if (gungKorName != null) {
        switch (gungKorName) {
            case "경복궁": gungFolder = "gyeongbokgung"; break;
            case "창덕궁": gungFolder = "changdeokgung"; break;
            case "창경궁": gungFolder = "changgyeonggung"; break;
            case "덕수궁": gungFolder = "deoksugung"; break;
            case "경희궁": gungFolder = "gyeonghuigung"; break;
        }
    }

    String savePath = "/common/images/gung/" + gungFolder + "/" + storyFolder;
    String uploadPath = application.getRealPath(savePath);
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    // ✅ 스토리 등록
    StoryDTO dto = new StoryDTO();
    dto.setStory_name(storyName);
    dto.setStory_info(storyInfo);
    dto.setGung_id(gungId);

    StoryService service = new StoryService();
    int storyId = service.registerStory(dto); // 등록 성공 시 ID 반환

    // ✅ 이미지 업로드 처리
    FilePathService fps = new FilePathService();
    Enumeration files = multi.getFileNames();
    while (files.hasMoreElements()) {
        String field = (String) files.nextElement();
        String fileName = multi.getFilesystemName(field);

        if (fileName != null && !fileName.trim().isEmpty()) {
            File uploadedFile = new File(rootPath + File.separator + fileName);
            File finalFile = new File(uploadPath, fileName);

            try (InputStream in = new FileInputStream(uploadedFile);
                 OutputStream fout = new FileOutputStream(finalFile)) {
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) {
                    fout.write(buf, 0, len);
                }
            }

            FilePathDTO imgDto = new FilePathDTO();
            imgDto.setPath(savePath + "/" + fileName);
            imgDto.setTargerType("story");
            imgDto.setTargerNumber(String.valueOf(storyId));
            imgDto.setImgName(fileName);
            fps.insertFilePath(imgDto);
        }
    }

%>
    <script>
        alert("스토리가 등록되었습니다.");
        location.href = "story_list.jsp";
    </script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
    <script>
        alert("스토리 등록 중 오류가 발생했습니다.");
        history.back();
    </script>
<%
}
%>
