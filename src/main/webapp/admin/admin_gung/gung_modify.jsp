<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  request.setCharacterEncoding("UTF-8");
  GungService service = new GungService();
  GungDTO dto = null;

  if ("POST".equals(request.getMethod())) {
      int gungId = Integer.parseInt(request.getParameter("gung_id"));
      String name = request.getParameter("gung_name");
      String infoText = request.getParameter("gung_info_textonly").trim();
      String historyText = request.getParameter("gung_history_textonly").trim();
      String img = request.getParameter("gung_img");

      GungDTO original = service.selectGungById(gungId);

      // ✅ 텍스트만 치환 (HTML 구조 안에서 텍스트만 대체)
      String updatedInfoHtml = original.getGung_info().replaceAll(
          "(?s)(<div class=\\\"txt_wrap\\\">).*?(</div>)", "$1" + infoText + "$2");

      String updatedHistoryHtml = original.getGung_history().replaceAll(
          "(?s)(<div class=\\\"wrap\\\">).*?(</div>)", "$1" + historyText + "$2");

      GungDTO newDto = new GungDTO();
      newDto.setGung_id(gungId);
      newDto.setGung_name(name);
      newDto.setGung_info(updatedInfoHtml);
      newDto.setGung_history(updatedHistoryHtml);
      newDto.setGung_img(img);

      boolean success = service.modifyGung(newDto);

      if (success) {
          response.sendRedirect("gung_detail.jsp?id=" + gungId);
          return;
      } else {
%>
          <script>alert('수정 실패'); history.back();</script>
<%
      }
  } else {
      int gungId = Integer.parseInt(request.getParameter("id"));
      dto = service.selectGungById(gungId);
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>궁 정보 수정</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
<div class="container">
  <h2 class="mb-4">궁 정보 수정</h2>

  <form method="post" action="gung_modify.jsp">
    <input type="hidden" name="gung_id" value="<%= dto.getGung_id() %>">

    <div class="mb-3">
      <label class="form-label">궁 이름</label>
      <input type="text" name="gung_name" class="form-control" value="<%= dto.getGung_name() %>">
    </div>

    <div class="mb-3">
      <label class="form-label">요약 내용</label>
      <textarea name="gung_info_textonly" class="form-control" rows="6"><%= dto.getGung_info() != null ? dto.getGung_info().replaceAll("(?s)<div class=\\\"txt_wrap\\\">(.*?)</div>", "$1").replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ").trim() : "" %></textarea>
    </div>

    <div class="mb-3">
      <label class="form-label">역사</label>
      <textarea name="gung_history_textonly" class="form-control" rows="10"><%= dto.getGung_history() != null ? dto.getGung_history().replaceAll("(?s)<div class=\\\"wrap\\\">(.*?)</div>", "$1").replaceAll("<[^>]*>", "").replaceAll("&nbsp;", " ").trim() : "" %></textarea>
    </div>

    <div class="mb-3">
      <label class="form-label">이미지 경로</label>
      <input type="text" name="gung_img" class="form-control" value="<%= dto.getGung_img() %>">
    </div>

    <button type="submit" class="btn btn-primary">수정 완료</button>
    <a href="gung_detail.jsp?id=<%= dto.getGung_id() %>" class="btn btn-secondary">취소</a>
  </form>
</div>
</body>
</html>