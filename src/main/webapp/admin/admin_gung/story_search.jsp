<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  request.setCharacterEncoding("UTF-8");
  String title = request.getParameter("title");

  StoryService service = new StoryService();
  List<StoryDTO> storyList = service.searchStoryByTitle(title); // 제목 검색
%>

<h5 class="mt-3">[<%= title %>] 검색 결과</h5>

<table class="table table-bordered table-hover mt-2">
  <thead class="table-light">
    <tr>
      <th>No.</th>
      <th>제목</th>
      <th>등록일</th>
    </tr>
  </thead>
  <tbody>
    <%
      int no = 1;
      for (StoryDTO dto : storyList) {
    %>
    <tr onclick="location.href='story_detail.jsp?id=<%= dto.getStory_id() %>'" style="cursor:pointer;">
      <td><%= no++ %></td>
      <td><%= dto.getStory_name() %></td>
      <td><%= dto.getStory_reg_date() %></td>
    </tr>
    <%
      }
      if (storyList.size() == 0) {
    %>
    <tr>
      <td colspan="3" class="text-center">검색 결과가 없습니다.</td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
