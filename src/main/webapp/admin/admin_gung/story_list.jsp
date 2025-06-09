<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  request.setCharacterEncoding("UTF-8");
  String keyword = request.getParameter("keyword");
  StoryService service = new StoryService();
  List<StoryDTO> storyList = null;

  if (keyword != null && !keyword.trim().isEmpty()) {
      storyList = service.searchStoryByKeyword(keyword.trim());
  } else {
      storyList = service.selectAllStory();
  }
%>


<div class="container mt-4">

  <!-- ✅ 검색 폼 -->
  <form method="get" action="story_list.jsp" class="row mb-3">
    <div class="col-md-4">
      <input type="text" name="keyword" class="form-control" placeholder="제목 검색" value="<%= keyword != null ? keyword : "" %>">
    </div>
    <div class="col-md-2">
      <button type="submit" class="btn btn-outline-primary">검색</button>
    </div>
    <div class="col-md-6 text-end">
      <button onclick="location.href='story_register.jsp'" type="button" class="btn btn-primary">+ 이야기 등록</button>
    </div>
  </form>

  <!-- ✅ 이야기 목록 테이블 -->
  <table class="table table-bordered table-hover">
    <thead class="table-light">
      <tr>
        <th>No.</th>
        <th>궁 이름</th>
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
        <td><%= dto.getGung_name() %></td>
        <td><%= dto.getStory_name() %></td>
        <td><%= dto.getStory_reg_date() %></td>
      </tr>
      <%
        }
        if (storyList.size() == 0) {
      %>
      <tr>
        <td colspan="4" class="text-center">검색 결과가 없습니다.</td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>

</div>
