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

    // 1. 임시 저장 디렉토리
    String tempPath = application.getRealPath("/temp");
    File tempDir = new File(tempPath);
    if (!tempDir.exists()) tempDir.mkdirs();

    MultipartRequest multi = new MultipartRequest(
        request,
        tempPath,
        maxSize,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    String storyName = multi.getParameter("story_name");
    String storyInfo = multi.getParameter("story_info");
    String gungIdStr = multi.getParameter("gung_id");
    String gungKorName = multi.getParameter("gung_name");

    int gungId = Integer.parseInt(gungIdStr);

    // 전각명 → 영문 폴더
    String storyFolder = "UnknownStory";
    if (storyName != null) {
        switch (storyName) {
            case "흥례문": storyFolder = "Heungnyemun"; break;
            case "광화문": storyFolder = "Gwanghwamun"; break;
            case "사정전": storyFolder = "Sajeongjeon"; break;
        }
    }

    // 궁 이름 → 영문 폴더
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

    // 스토리 등록
    StoryDTO dto = new StoryDTO();
    dto.setStory_name(storyName);
    dto.setStory_info(storyInfo);
    dto.setGung_id(gungId);

    StoryService service = new StoryService();
    int storyId = service.registerStory(dto);

    // 이미지 업로드
    FilePathService fps = new FilePathService();
    String[] uploadFields = {"file1", "file2", "file3"};
    for (String field : uploadFields) {
        String fileName = multi.getFilesystemName(field);

        if (fileName != null && !fileName.trim().isEmpty()) {
            File tempFile = new File(tempPath, fileName);
            if (tempFile.exists() && tempFile.length() > 0) {
                File finalFile = new File(uploadPath, fileName);
                tempFile.renameTo(finalFile);

                FilePathDTO imgDto = new FilePathDTO();
                imgDto.setPath(savePath + "/" + fileName);
                imgDto.setTargerType("story");
                imgDto.setTargerNumber(String.valueOf(storyId));
                imgDto.setImgName(fileName);
                fps.insertFilePath(imgDto);
            } else {
                tempFile.delete(); // 💥 빈 파일일 경우 삭제
            }
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
