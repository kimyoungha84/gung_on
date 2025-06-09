<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page import="java.util.List" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>
<%
  GungService service = new GungService();
  List<GungDTO> gungList = service.selectAllGung();
  
  
%>




<div id="layoutSidenav_content">
<main>

  <div class="container-fluid px-4">
  <h1>궁 관리</h1>
  <hr/>
  
  <div class="card m-3">
  <div class="card-body">
  <h2>궁 목록</h2>
  
  
  <table class="table table-bordered table-hover">
    <thead class="table-light">
      <tr>
        <th>No.</th>
        <th>궁 이름</th>
        <th>요약 내용</th>
        <th>수정일</th>
      </tr>
    </thead>
    <tbody>
      <%
        int no = 1;
        for (GungDTO dto : gungList) {
          String html = dto.getGung_info(); // DB에 저장된 HTML 포함 문자열
          String plain = html.replaceAll("<[^>]*>", ""); // 태그 제거

          // 요약 텍스트 생성
          String preview = plain;
          int dotIndex = plain.indexOf(".");

          if (dotIndex != -1) {
              preview = plain.substring(0, dotIndex + 1) + " ...";
          } else if (plain.length() > 50) {
              preview = plain.substring(0, 50) + " ...";
          }
      %>
      <tr onclick="location.href='gung_detail.jsp?id=<%= dto.getGung_id() %>'">
        <td><%= no++ %></td>
        <td><%= dto.getGung_name() %></td>
        <td><%= preview %></td>
        <td><%= dto.getGung_reg_date() %></td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>
  <button class="register-btn"onclick="location.href='${pageContext.request.contextPath}/admin/admin_gung/gung_insert.jsp'">등록</button>
</div>
<!-- 페이지네이션 표시 -->
   <div>
   
   </div>
</div>
</div>
</main>
<%@ include file="/admin/common/footer.jsp" %>
</div>


