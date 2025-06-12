<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="kr.co.gungon.story.StoryService" %>
<%@ page import="kr.co.gungon.story.StoryDTO" %>
<%@ page import="kr.co.gungon.file.FilePathDTO" %>
<%@ page import="kr.co.gungon.file.FilePathService" %>

<%
request.setCharacterEncoding("UTF-8");

try {
    int maxSize = 10 * 1024 * 1024;

    // 1. 임시 업로드 경로 (먼저 파일 받고 옮긴다)
    String tempUploadPath = application.getRealPath("/common/images/gung/temp");
    File tempDir = new File(tempUploadPath);
    if (!tempDir.exists()) tempDir.mkdirs();

    // 2. MultipartRequest 생성 (임시 경로)
    MultipartRequest multi = new MultipartRequest(
        request,
        tempUploadPath,
        maxSize,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    // 3. 파라미터
    int storyId = Integer.parseInt(multi.getParameter("story_id"));
    String storyNameKor = multi.getParameter("story_name");
    String storyInfo = multi.getParameter("story_info");
    String gungKorName = multi.getParameter("gung_name");

    // 4. 서비스 불러오기
    StoryService service = new StoryService();
    FilePathService fps = new FilePathService();
    StoryDTO oldDto = service.getStoryById(storyId);

    // 5. 디렉토리명 변환
    String storyName = "UnknownStory";
    if (storyNameKor != null) {
        switch (storyNameKor) {
            case "흥례문": storyName = "Heungnyemun"; break;
            case "광화문": storyName = "Gwanghwamun"; break;
            case "사정전": storyName = "Sajeongjeon"; break;
        }
    }

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

    // 6. 최종 저장 경로
    String savePath = "/common/images/gung/" + gungFolder + "/" + storyName;
    String uploadPath = application.getRealPath(savePath);
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    // 7. 삭제 이미지 처리
    String[] deleteImgs = multi.getParameterValues("delete_img");
    boolean isImageDeleted = deleteImgs != null && deleteImgs.length > 0;
    if (isImageDeleted) {
        for (String imgName : deleteImgs) {
            FilePathDTO delDto = new FilePathDTO();
            delDto.setTargerType("story");
            delDto.setTargerNumber(String.valueOf(storyId));
            delDto.setImgName(imgName);
            fps.deleteFilePath(delDto);

            File imgFile = new File(uploadPath, imgName);
            if (imgFile.exists()) imgFile.delete();
        }
    }

    // 8. 새 이미지 업로드 및 이동 처리
    Enumeration files = multi.getFileNames();
    boolean isNewImageUploaded = false;
    while (files.hasMoreElements()) {
        String field = (String) files.nextElement();
        String fileName = multi.getFilesystemName(field);

        if (fileName != null && !fileName.trim().isEmpty()) {
            File tempFile = new File(tempUploadPath, fileName);
            File finalFile = new File(uploadPath, fileName);

            // 파일 이동
            if (tempFile.exists()) {
                tempFile.renameTo(finalFile);
                isNewImageUploaded = true;

                // DB 저장
                FilePathDTO imgDto = new FilePathDTO();
                imgDto.setPath(savePath + "/" + fileName);
                imgDto.setTargerType("story");
                imgDto.setTargerNumber(String.valueOf(storyId));
                imgDto.setImgName(fileName);
                fps.insertFilePath(imgDto);
            }
        }
    }

    // 9. 변경 여부 확인
    boolean isModified =
        !storyNameKor.equals(oldDto.getStory_name()) ||
        !storyInfo.equals(oldDto.getStory_info()) ||
        isNewImageUploaded || isImageDeleted;

    if (!isModified) {
        out.println("<script>alert('변경된 내용이 없습니다.'); history.back();</script>");
        return;
    }

    // 10. 스토리 업데이트
    StoryDTO dto = new StoryDTO();
    dto.setStory_id(storyId);
    dto.setStory_name(storyNameKor);
    dto.setStory_info(storyInfo);
    service.updateStory(dto);

    // 11. 성공 시 이동
    response.sendRedirect("story_detail.jsp?id=" + storyId);

} catch (Exception e) {
    e.printStackTrace();
    response.setContentType("text/html;charset=UTF-8");
    out.println("<script>alert('수정 중 오류 발생'); history.back();</script>");
}
%>
