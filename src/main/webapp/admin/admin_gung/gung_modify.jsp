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

        GungDTO newDto = new GungDTO();
        newDto.setGung_id(gungId);
        newDto.setGung_name(name);

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

    <form method="post" action="gung_modify_action.jsp" onsubmit="return validateForm()">
      <input type="hidden" name="gung_id" value="<%= dto.getGung_id() %>">

      <div class="mb-3">
        <label class="form-label">궁 이름</label>
        <input type="text" name="gung_name" class="form-control" readonly="readonly" value="<%= dto.getGung_name() %>" required>
      </div>

      <div class="mb-3">
        <label class="form-label">궁 설명</label>
        <textarea name="gung_info" class="form-control" rows="5" required><%= dto.getGung_info() %></textarea>
      </div>

      <div class="mb-3">
        <label class="form-label">궁 역사</label>
        <textarea name="gung_history" class="form-control" rows="7" ><%= dto.getGung_history() %></textarea>
      </div>

      <div class="text-center">
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="gung_detail.jsp?id=<%= dto.getGung_id() %>" class="btn btn-secondary">취소</a>
      </div>
<script>
  function validateForm() {
    const history = document.querySelector('textarea[name="gung_history"]').value.trim();

    if (history === "") {
      alert(
        "궁 역사 입력은 필수입니다.\n\n" +
        "※ 입력 가이드\n" +
        "- ':' (콜론)은 테이블 항목 구분용입니다.\n" +
        "- '/' (슬래시)는 줄바꿈 기호로 사용됩니다.\n\n" +
        "예시: 1395년(태조 4): 경복궁 창건 / 1592년(선조 25): 임진왜란으로 소실"
      );
      return false; // 제출 막기
    }

    return true; // 통과
  }
</script>
    </form>
  </div>
  </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>  
    </div>
