<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.file.FilePathDTO" %>
<%@page import="kr.co.gungon.file.FilePathService" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");

  String idStr = request.getParameter("id");
  int storyId = 0;
  StoryDTO dto = null;
  List<FilePathDTO> imgList = null;

  if (idStr != null) {
      try {
          storyId = Integer.parseInt(idStr);
          StoryService service = new StoryService();
          dto = service.getStoryById(storyId);

          // 이미지 리스트 가져오기
          FilePathService fps = new FilePathService();
          imgList = fps.getStoryImages("story", String.valueOf(storyId));

      } catch (Exception e) {
          e.printStackTrace();
      }
  }
%>

<div id="layoutSidenav_content">
<main>


<div class="container-fluid px-4 mt-4">
  <h2 class="mb-4">이야기 상세보기</h2>

  <%
    if (dto != null) {
  %>
  <table class="table table-bordered table-hover">
  <thead class="table-light">
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
      <td style="white-space: pre-wrap;"><%= dto.getStory_info() %></td>
    </tr>
    <tr>
      <th>등록일</th>
      <td><%= dto.getStory_reg_date() %></td>
    </tr>
    <tr>
      <th>이미지</th>
      <td>
        <%
          if (imgList != null && !imgList.isEmpty()) {
              for (FilePathDTO img : imgList) {
        %>
                <%= img.getImgName() %><br>
        <%
              }
          } else {
        %>
              이미지가 없습니다.
        <%
          }
        %>
      </td>
    </tr>
    </thead>
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
    <div class="alert alert-danger">해당 이야기 정보를 찾을 수 없습니다.</div>
    <a href="story_list.jsp" class="btn btn-secondary">돌아가기</a>
  <%
    }
  %>
</div>
</main>
<%@ include file="/admin/common/footer.jsp" %>
</div>
