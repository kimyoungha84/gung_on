<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<%
  GungService gungService = new GungService();
  List<GungDTO> gungList = gungService.selectAllGung(); // 궁 목록 가져오기
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>이야기 등록</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
  <h2 class="mb-4">궁 이야기 등록</h2>

<form action="story_register_action.jsp" method="post" enctype="multipart/form-data">
    <!-- 제목 입력 -->
    <div class="mb-3">
      <label for="story_name" class="form-label">전각 이름</label>
      <input type="text" class="form-control" id="story_name" name="story_name" required>
    </div>

    <!-- 궁 선택 -->
    <div class="mb-3">
      <label for="gung_id" class="form-label">해당 궁 선택</label>
      <select class="form-select" id="gung_id" name="gung_id" required>
        <option value="">궁을 선택하세요</option>
        <%
          for (GungDTO g : gungList) {
        %>
          <option value="<%= g.getGung_id() %>"><%= g.getGung_name() %></option>
        <%
          }
        %>
      </select>
    </div>

    <!-- 소개 입력 -->
    <div class="mb-3">
      <label for="story_info" class="form-label">이야기 소개</label>
      <textarea class="form-control" id="story_info" name="story_info" rows="6" placeholder="이야기 소개를 입력하세요" required></textarea>
    </div>

    <!-- 이미지 업로드 -->
    <div class="mb-3">
      <label for="story_images" class="form-label">사진 등록 (여러 장 가능)</label>
      <input type="file" class="form-control" id="story_images" name="story_images" multiple accept="image/*">
    </div>

    <!-- 제출 버튼 -->
    <button type="submit" class="btn btn-primary">등록</button>
    <a href="story_list.jsp" class="btn btn-secondary">취소</a>
  </form>
</body>
</html>
