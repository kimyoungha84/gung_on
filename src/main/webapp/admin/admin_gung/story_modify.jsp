<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String idStr = request.getParameter("id");
  int storyId = Integer.parseInt(idStr);
  StoryService service = new StoryService();
  StoryDTO dto = service.getStoryById(storyId);  // 이 메서드도 service/dao에 추가해야 함
%>

<h2>이야기 수정</h2>
<form action="story_modify_action.jsp" method="post" enctype="multipart/form-data">
  <input type="hidden" name="story_id" value="<%= dto.getStory_id() %>">
  <div>
    <label>제목</label>
    <input type="text" name="story_name" value="<%= dto.getStory_name() %>">
  </div>
  <div>
    <label>소개</label>
    <textarea name="story_info"><%= dto.getStory_info() %></textarea>
  </div>
  <!-- 파일 수정 영역 추가 가능 -->
  <button type="submit">수정</button>
</form>
