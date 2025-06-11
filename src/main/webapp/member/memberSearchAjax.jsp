<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.gungon.admin.AdminDAO" %>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.pagination.PaginationBuilder" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>

<%
    request.setCharacterEncoding("UTF-8");

    String keyfield = request.getParameter("keyfield");
    String keyword = request.getParameter("keyword");
    String currentPageStr = request.getParameter("currentPage");

    int currentPage = 1;
    try {
        if (currentPageStr != null && !currentPageStr.trim().equals("")) {
            currentPage = Integer.parseInt(currentPageStr);
        }
    } catch (Exception e) {
        currentPage = 1;
    }

    int pageSize = 5;
    AdminDAO dao = AdminDAO.getInstance();
    int rowCount = dao.getMemberCount(keyfield, keyword);

    PaginationBuilder pagination = new PaginationBuilder(request, pageSize, rowCount);
    int start = (pagination.getCurrentPage() - 1) * pageSize + 1;
    int end = pagination.getCurrentPage() * pageSize;

    List<MemberDTO> list = dao.getMemberList(keyfield, keyword, start, end);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    StringBuilder json = new StringBuilder();
    json.append("{");
    json.append("\"list\":[");

    for (int i = 0; i < list.size(); i++) {
        MemberDTO dto = list.get(i);
        String formattedDate = (dto.getInput_date() != null) ? sdf.format(dto.getInput_date()) : "";

        json.append("{");
        json.append("\"id\":\"").append(dto.getId() != null ? dto.getId() : "").append("\",");
        json.append("\"name\":\"").append(dto.getName() != null ? dto.getName() : "").append("\",");
        json.append("\"tel\":\"").append(dto.getTel() != null ? dto.getTel() : "").append("\",");
        json.append("\"useEmail\":\"").append(dto.getUseEmail() != null ? dto.getUseEmail() : "").append("\",");
        json.append("\"input_date\":\"").append(formattedDate).append("\",");
        json.append("\"flag\":\"").append(dto.getFlag() != null ? dto.getFlag() : "N").append("\"");
        json.append("}");
        if (i < list.size() - 1) {
            json.append(",");
        }
    }

    json.append("],");

    String pageHtml = pagination.build("memberList.jsp", "keyfield=" + keyfield + "&keyword=" + keyword);
    json.append("\"page\":\"").append(pageHtml.replace("\"", "\\\"")).append("\"");

    json.append("}");

    out.print(json.toString());
%>