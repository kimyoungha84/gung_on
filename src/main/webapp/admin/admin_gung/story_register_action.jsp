<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="kr.co.gungon.story.StoryDTO" %>
<%@ page import="kr.co.gungon.story.StoryService" %>

<%
    request.setCharacterEncoding("UTF-8");

    String storyName = request.getParameter("story_name");
    String storyInfo = request.getParameter("story_info");
    String gungIdStr = request.getParameter("gung_id");

    System.out.println(">> 받은 gungId = " + gungIdStr);

    int gungId = 0;
    try {
        gungId = Integer.parseInt(gungIdStr);
    } catch (NumberFormatException e) {
        out.println("<script>alert('궁 ID가 잘못되었습니다.'); history.back();</script>");
        return;
    }

    StoryDTO dto = new StoryDTO();
    dto.setStory_name(storyName);
    dto.setStory_info(storyInfo);
    dto.setGung_id(gungId);

    StoryService service = new StoryService();
    try {
        int storyId = service.registerStory(dto); // 등록 성공 시 ID 반환
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
