<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    GungService service = new GungService();
    GungDTO dto = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int gungId = Integer.parseInt(request.getParameter("gung_id"));
        String name = request.getParameter("gung_name");
        String infoText = request.getParameter("gung_info_textonly").trim();
        String historyText = request.getParameter("gung_history_textonly").trim();

        GungDTO original = service.selectGungById(gungId);

        // HTML 템플릿 구조 유지하면서 텍스트만 교체
        String updatedInfoHtml = original.getGung_info().replaceAll(
            "(?s)(<div class=\\\"txt_wrap\\\">).*?(</div>)", "$1" + infoText + "$2");

        String updatedHistoryHtml = original.getGung_history().replaceAll(
            "(?s)(<div class=\\\"wrap\\\">).*?(</div>)", "$1" + historyText + "$2");

        GungDTO newDto = new GungDTO();
        newDto.setGung_id(gungId);
        newDto.setGung_name(name);
        newDto.setGung_info(updatedInfoHtml);
        newDto.setGung_history(updatedHistoryHtml);

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
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
%>
            <script>alert('잘못된 접근입니다.'); history.back();</script>
<%
            return;
        }
        int gungId = Integer.parseInt(idParam);
        dto = service.selectGungById(gungId);
    }
%>

<div id="layoutSidenav_content">

<main >

  <div class="container-fluid px-4 mt-4">
    <h2 class="mt-4">궁 관리</h2>
    <hr/>
    
     <div class="card m-3">
  <div class="card-body">
  <h2>궁 정보 수정</h2>
  </div>

    <form method="post" action="gung_modify_action.jsp">
      <input type="hidden" name="gung_id" value="<%= dto.getGung_id() %>">

      <div class="mb-3">
        <label class="form-label">궁 이름</label>
        <input type="text" name="gung_name" class="form-control" value="<%= dto.getGung_name() %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">궁 설명</label>
        <textarea name="gung_info" class="form-control" rows="5" required><%= dto.getGung_info() %></textarea>
      </div>

      <div class="mb-3">
        <label class="form-label">궁 역사</label>
        <textarea name="gung_history" class="form-control" rows="7" required><%= dto.getGung_history() %></textarea>
      </div>

      <div class="text-center">
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="gung_detail.jsp?id=<%= dto.getGung_id() %>" class="btn btn-secondary">취소</a>
      </div>
    </form>
  </div>
  </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>  
    </div>
