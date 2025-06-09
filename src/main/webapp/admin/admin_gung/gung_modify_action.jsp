<%@ page import="kr.co.gungon.gung.GungService" %>
<%@ page import="kr.co.gungon.gung.GungDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  request.setCharacterEncoding("UTF-8");

  int gungId = Integer.parseInt(request.getParameter("gung_id"));
  String gungName = request.getParameter("gung_name");
  String gungInfo = request.getParameter("gung_info");
  String gungHistory = request.getParameter("gung_history");

  GungDTO dto = new GungDTO();
  dto.setGung_id(gungId);
  dto.setGung_name(gungName);
  dto.setGung_info(gungInfo);
  dto.setGung_history(gungHistory);

  GungService service = new GungService();
  boolean result = service.modifyGung(dto);

  if (result) {
    // 수정 성공
    response.sendRedirect("gung_list.jsp"); // 수정 후 목록으로 이동
  } else {
    // 실패 처리
    out.println("<script>alert('수정 실패'); history.back();</script>");
  }
%>
