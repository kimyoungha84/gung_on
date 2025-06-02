<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String storyName = request.getParameter("story_name");
    String storyInfo = request.getParameter("story_info");
    int gungId = Integer.parseInt(request.getParameter("gung_id"));

    // DTO 생성
    StoryDTO dto = new StoryDTO();
    dto.setStory_name(storyName);
    dto.setStory_info(storyInfo);
    dto.setGung_id(gungId);

    StoryService service = new StoryService();
    int storyId = service.registerStory(dto);

    // 이미지 저장 처리
    String uploadPath = application.getRealPath("/upload/story");
    File dir = new File(uploadPath);
    if (!dir.exists()) dir.mkdirs();

    Collection<Part> parts = request.getParts();
    for (Part part : parts) {
        if (part.getName().equals("story_images") && part.getSize() > 0) {
            String originName = part.getSubmittedFileName();
            String savedName = System.currentTimeMillis() + "_" + originName;
            part.write(uploadPath + File.separator + savedName);

            // DB에 경로 저장
            service.saveStoryImage(storyId, "/upload/story/" + savedName, originName);
        }
    }

    response.sendRedirect("story_list.jsp");
%>
