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

    // 임시경로 (필요 없음, 바로 업로드 경로 사용)
    String rootPath = application.getRealPath("/");

    // MultipartRequest 먼저 생성 (uploadPath는 후에 설정)
    MultipartRequest multi = new MultipartRequest(
        request,
        rootPath,  // 임시지만 사용 안함
        maxSize,
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    int storyId = Integer.parseInt(multi.getParameter("story_id"));
    String storyNameKor = multi.getParameter("story_name");     // ex: 흥례문
    String storyInfo = multi.getParameter("story_info");
    String gungKorName = multi.getParameter("gung_name");

    // 🔁 한글 전각명 → 영문 전각 디렉토리명
    String storyName = "UnknownStory";
    if (storyNameKor != null) {
        switch (storyNameKor) {
            case "흥례문":
                storyName = "Heungnyemun";
                break;
            case "광화문":
                storyName = "Gwanghwamun";
                break;
            case "사정전":
                storyName = "Sajeongjeon";
                break;
        }
    }

    // 🔁 궁 이름 → 영문 폴더
    String gungFolder = "etc";
    if (gungKorName != null) {
        switch (gungKorName) {
            case "경복궁":
                gungFolder = "gyeongbokgung";
                break;
            case "창덕궁":
                gungFolder = "changdeokgung";
                break;
            case "창경궁":
                gungFolder = "changgyeonggung";
                break;
            case "덕수궁":
                gungFolder = "deoksugung";
                break;
            case "경희궁":
                gungFolder = "gyeonghuigung";
                break;
        }
    }

    // ✅ 저장 경로 구성
    String savePath = "/common/images/gung/" + gungFolder + "/" + storyName;
    String uploadPath = application.getRealPath(savePath);
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    // ✅ DB에 저장할 경로는 webapp 기준으로
    String dbPath = "${pageContext.request.contextPath}" + savePath;

    FilePathService fps = new FilePathService();

    // ✅ 삭제 이미지 처리
    String[] deleteImgs = multi.getParameterValues("delete_img");
    if (deleteImgs != null) {
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

    // ✅ 새 이미지 업로드 처리
    Enumeration files = multi.getFileNames();
    while (files.hasMoreElements()) {
        String field = (String) files.nextElement();
        String fileName = multi.getFilesystemName(field);

        if (fileName != null && !fileName.trim().isEmpty()) {
            File uploadedFile = new File(rootPath + File.separator + fileName);  // 잘못된 경로가 아닐 경우
            File finalFile = new File(uploadPath, fileName);

            // 파일 복사
            try (InputStream in = new FileInputStream(uploadedFile);
                 OutputStream fout = new FileOutputStream(finalFile)) {
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) {
                    fout.write(buf, 0, len);
                }
            }

            // ✅ DB 저장
            FilePathDTO imgDto = new FilePathDTO();
            imgDto.setPath(savePath + "/" + fileName);  // path + filename
            imgDto.setTargerType("story");
            imgDto.setTargerNumber(String.valueOf(storyId));
            imgDto.setImgName(fileName);
            fps.insertFilePath(imgDto);
        }
    }

    // ✅ 이야기 본문 수정
    StoryDTO dto = new StoryDTO();
    dto.setStory_id(storyId);
    dto.setStory_name(storyNameKor);
    dto.setStory_info(storyInfo);

    StoryService service = new StoryService();
    service.updateStory(dto);

    response.sendRedirect("story_detail.jsp?id=" + storyId);

} catch (Exception e) {
    e.printStackTrace();
    response.setContentType("text/html;charset=UTF-8");
    out.println("<script>alert('수정 중 오류 발생'); history.back();</script>");
}
%>
