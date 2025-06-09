<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    int storyId = Integer.parseInt(request.getParameter("id"));
    StoryService service = new StoryService();

    boolean result = service.deleteStory(storyId);

    if (result) {
%>
        <script>
            alert("스토리가 삭제되었습니다.");
            location.href = "story_list.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("스토리 삭제에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>
