<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page import="java.util.List" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
  GungService gungService = new GungService();
  List<GungDTO> gungList = gungService.selectAllGung(); // 궁 목록 가져오기
%>

<div id="layoutSidenav_content">
<main>
  <div class="container-fluid px-4">
  <h2 class="mt-4">궁 관리</h2>
  <hr/>
  
  <div class="card m-3">
  <div class="card-body">
  <h2>이야기 등록</h2>
  </div>

<form action="story_register_action.jsp" method="post" enctype="multipart/form-data">
    <!-- 제목 입력 -->
    <div class="mb-3">
      <label for="story_name" class="form-label">전각 이름</label>
      <input type="text" class="form-control" id="story_name" name="story_name" required>
    </div>

    <!-- 궁 선택 -->
    <div class="mb-3">
      <label for="gung_id" class="form-label">해당 궁 선택</label>
      <select class="form-select" id="gung_id" name="gung_id" required onchange="setGungName()">
        <option value="">궁을 선택하세요</option>
        <%
          for (GungDTO g : gungList) {
        %>
          <option value="<%= g.getGung_id() %>"><%= g.getGung_name() %></option>
        <%
          }
        %>
      </select>
      <!-- 선택된 궁 이름을 숨겨서 전송 -->
      <input type="hidden" id="gung_name" name="gung_name">
    </div>

    <!-- 소개 입력 -->
    <div class="mb-3">
      <label for="story_info" class="form-label">이야기 소개</label>
      <textarea class="form-control" id="story_info" name="story_info" rows="6" placeholder="이야기 소개를 입력하세요" required></textarea>
    </div>

    <!-- 이미지 업로드 -->
    <div class="mb-3">
      <label class="form-label">사진 등록 (최대 3장)</label>
      <input type="file" class="form-control mb-1" name="file1" accept="image/*">
      <input type="file" class="form-control mb-1" name="file2" accept="image/*">
      <input type="file" class="form-control mb-1" name="file3" accept="image/*">
    </div>

    <!-- 제출 버튼 -->
    <button type="submit" class="btn btn-primary">등록</button>
    <a href="story_list.jsp" class="btn btn-secondary">취소</a>
</form>

  </div>
  </div>
</main>
<%@ include file="/admin/common/footer.jsp" %>
</div>

<!-- 🔁 선택된 궁 이름을 hidden input에 넣는 JS -->
<script>
  function setGungName() {
    const select = document.getElementById("gung_id");
    const selectedText = select.options[select.selectedIndex].text;
    document.getElementById("gung_name").value = selectedText;
  }
</script>
