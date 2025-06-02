<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>이야기 상세보기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .story-img {
      max-width: 400px;
      height: auto;
      border-radius: 10px;
      border: 1px solid #ccc;
      margin-bottom: 10px;
    }
  </style>
</head>
<body class="p-4">

<%
  request.setCharacterEncoding("UTF-8");

  String idParam = request.getParameter("id");
  int storyId = 0;
  StoryDTO dto = null;

  if (idParam != null) {
      try {
          storyId = Integer.parseInt(idParam);
          StoryService service = new StoryService();
          dto = service.getStoryById(storyId); // 기존에 만든 getStoryById 사용
      } catch (Exception e) {
          e.printStackTrace();
      }
  }
%>

<div class="container">
  <h2 class="mb-4">이야기 상세보기</h2>

  <%
    if (dto != null) {
  %>
  <table class="table table-bordered">
    <tr>
      <th style="width: 20%;">궁 이름</th>
      <td><%= dto.getGung_name() %></td>
    </tr>
    <tr>
      <th>전각 이름</th>
      <td><%= dto.getStory_name() %></td>
    </tr>
    <tr>
      <th>소개</th>
      <td><pre style="white-space: pre-wrap;"><%= dto.getStory_info() %></pre></td>
    </tr>
    <tr>
      <th>등록일</th>
      <td><%= dto.getStory_reg_date() %></td>
    </tr>
    <tr>
      <th>이미지</th>
      <td>
        <%
          List<String> images = dto.getImageList();
          if (images != null && !images.isEmpty()) {
            for (String img : images) {
        %>
          <img src="<%= img %>" alt="이야기 이미지" class="story-img">
        <%
            }
          } else {
        %>
          <span class="text-muted">이미지가 없습니다.</span>
        <%
          }
        %>
      </td>
    </tr>
  </table>

  <!-- ✅ 버튼 영역 -->
  <div class="mt-4">
    <a href="story_list.jsp" class="btn btn-secondary">목록으로</a>
    <a href="story_modify.jsp?id=<%= dto.getStory_id() %>" class="btn btn-warning">수정</a>
    <a href="story_delete.jsp?id=<%= dto.getStory_id() %>" class="btn btn-danger"
       onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
  </div>
  <%
    } else {
  %>
    <div class="alert alert-danger">해당 이야기를 찾을 수 없습니다.</div>
    <a href="story_list.jsp" class="btn btn-secondary">돌아가기</a>
  <%
    }
  %>
</div>

</body>
</html>
