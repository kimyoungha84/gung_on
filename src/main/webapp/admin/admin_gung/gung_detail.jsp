<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>
<%@ page language="java" %>


<%
  request.setCharacterEncoding("UTF-8");

  String idParam = request.getParameter("id");
  int gungId = 0;
  GungDTO dto = null;

  if (idParam != null) {
      try {
          gungId = Integer.parseInt(idParam);
          GungService service = new GungService();
          dto = service.selectGungById(gungId); // 서비스 메서드 필요
      } catch (Exception e) {
          e.printStackTrace();
      }
  }
%>
<div id="layoutSidenav_content">


<main>

<div class="container-fluid px-4 mt-4">
  <h2 class="mb-4">궁 상세보기</h2>

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
      <th>요약 내용</th>
      <td><%= dto.getGung_info().replaceAll("<[^>]*>", "") %></td>
    </tr>
    <tr>
      <th>역사</th>
      <td><pre style="white-space: pre-wrap;"><%= dto.getGung_history() %></pre></td>
    </tr>
    <tr>
      <th>등록일</th>
      <td><%= dto.getGung_reg_date() %></td>
    </tr>
        </thead>
  </table>

  <!-- ✅ 버튼 영역 -->
  <div class="mt-4">
    <a href="gung_tab.jsp" class="btn btn-secondary">목록으로</a>
    <a href="gung_modify.jsp?id=<%= dto.getGung_id() %>" class="btn btn-warning">수정</a>
    <a href="gung_delete.jsp?id=<%= dto.getGung_id() %>" class="btn btn-danger"
       onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
  </div>
  <%
    } else {
  %>
    <div class="alert alert-danger">해당 궁 정보를 찾을 수 없습니다.</div>
    <a href="gung_tab.jsp" class="btn btn-secondary">돌아가기</a>
  <%
    }
  %>
  </div>
  </main>
</div>
<%@ include file="/admin/common/footer.jsp" %>
