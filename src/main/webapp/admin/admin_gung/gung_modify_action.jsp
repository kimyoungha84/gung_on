<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.gungon.gung.GungService" %>
<%@ page import="kr.co.gungon.gung.GungDTO" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");

  int gungId = Integer.parseInt(request.getParameter("gung_id"));
  String gungName = request.getParameter("gung_name");
  String gungInfo = request.getParameter("gung_info");
  String gungHistory = request.getParameter("gung_history");

  GungService service = new GungService();
  GungDTO original = service.selectGungById(gungId); // 기존 데이터 조회

  // 변경 여부 확인
  boolean noChange =
      original.getGung_name().equals(gungName) &&
      original.getGung_info().equals(gungInfo) &&
      original.getGung_history().equals(gungHistory);

  if (noChange) {
%>
    <script>
      alert('변경된 내용이 없습니다.');
      history.back();
    </script>
<%
    return;
  }

  // 변경된 경우만 수정 처리
  GungDTO dto = new GungDTO();
  dto.setGung_id(gungId);
  dto.setGung_name(gungName);
  dto.setGung_info(gungInfo);
  dto.setGung_history(gungHistory);

  boolean result = service.modifyGung(dto);

  if (result) {
%>
    <script>
      alert('수정이 완료되었습니다.');
      location.href = 'gung_detail.jsp?id=<%= gungId %>';
    </script>
<%
  } else {
%>
    <script>
      alert('수정 실패');
      history.back();
    </script>
<%
  }
%>
