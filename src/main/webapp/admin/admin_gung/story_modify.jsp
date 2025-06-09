<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");
  String idStr = request.getParameter("id");
  int storyId = Integer.parseInt(idStr);

  StoryService service = new StoryService();
  StoryDTO dto = service.getStoryById(storyId);

  FilePathService fps = new FilePathService();
  List<FilePathDTO> imgList = fps.getStoryImages("story", String.valueOf(storyId));
%>

<style>
  .image-box { border: 1px solid #ccc; padding: 15px; margin: 20px 0; background: #f8f9fa; border-radius: 6px; }
  .image-name { font-size: 15px; color: #2c3e50; margin-bottom: 5px; }
</style>

<div id="layoutSidenav_content">
<main>

<div class="container-fluid px-4 mt-4">
  <h2>이야기 수정</h2>

  <form action="story_modify_action.jsp" method="post" enctype="multipart/form-data">
    <input type="hidden" name="story_id" value="<%= dto.getStory_id() %>">
    <input type="hidden" name="gung_name" value="<%= dto.getGung_name() %>">

    <div class="mb-3">
      <label>궁 이름</label>
      <input type="text" class="form-control" value="<%= dto.getGung_name() %>" readonly>
    </div>

    <div class="mb-3">
      <label>제목</label>
      <input type="text" name="story_name" class="form-control" value="<%= dto.getStory_name() %>" required>
    </div>

    <div class="mb-3">
      <label>소개</label>
      <textarea name="story_info" class="form-control" rows="6"><%= dto.getStory_info() %></textarea>
    </div>

    <div class="image-box">
      <strong>📷 기존 이미지</strong><br>
      <%
        if (imgList != null && !imgList.isEmpty()) {
          for (FilePathDTO img : imgList) {
      %>
        <div class="form-check">
          <input type="checkbox" class="form-check-input" name="delete_img" value="<%= img.getImgName() %>">
          <label class="form-check-label image-name"><%= img.getImgName() %></label>
        </div>
      <%
          }
        } else {
      %>
        <span class="text-muted">등록된 이미지가 없습니다.</span>
      <%
        }
      %>
    </div>

    <div class="mb-3">
      <label>새 이미지 선택 (선택사항)</label>
      <input type="file" name="file1" class="form-control mb-1">
      <input type="file" name="file2" class="form-control mb-1">
      <input type="file" name="file3" class="form-control mb-1">
      <small class="text-muted">※ 최대 3장까지 업로드 가능</small>
    </div>

    <div class="text-center mt-4">
      <button type="submit" class="btn btn-primary">수정</button>
      <a href="story_detail.jsp?id=<%= dto.getStory_id() %>" class="btn btn-secondary">취소</a>
    </div>
  </form>
</div>
</main>
<%@ include file="/admin/common/footer.jsp" %>
</div>
