<%@page import="java.util.List" %>
<%@page import="kr.co.gungon.story.StoryDTO" %>
<%@page import="kr.co.gungon.story.StoryService" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String idStr = request.getParameter("id");
  int storyId = Integer.parseInt(idStr);
  StoryService service = new StoryService();
  StoryDTO dto = service.getStoryById(storyId); // 이야기 데이터
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

  <div>
    <label>기존 이미지</label><br>
  </div>

  <div>
    <label>새 이미지 선택 (선택사항)</label>
    <input type="file" name="new_images" multiple>
    <p style="font-size: 0.9em; color: gray;">※ 여러 이미지 선택 가능</p>
  </div>

  <button type="submit">수정</button>
</form>
