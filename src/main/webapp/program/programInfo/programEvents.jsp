<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import="kr.co.gungon.program.ProgramDAO" %>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

<%
  	String contextPath = request.getContextPath();

    String dateParam = request.getParameter("date");
    if (dateParam == null || dateParam.trim().isEmpty()) {
        out.print("<li>날짜가 올바르지 않습니다.</li>");
        return;
    }

    java.sql.Date date = java.sql.Date.valueOf(dateParam); // yyyy-MM-dd 형식

    ProgramDAO dao = ProgramDAO.getInstance();
    ArrayList<ProgramDTO> list = dao.selectProgramsByDate(date);

    if (list.isEmpty()) {
        out.print("<li>해당 날짜에 진행 중인 행사가 없습니다.</li>");
        
    } else {
    	FilePathService fps = new FilePathService();
        StringBuilder sb = new StringBuilder();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)", java.util.Locale.KOREAN);

        for (ProgramDTO dto : list) {
        	String imgFullPath = fps.getImageFullPath("program", String.valueOf(dto.getProgramId()));
            if (imgFullPath == null) {
                imgFullPath = contextPath + "/images/no-image.png"; // 대체 이미지 경로
            }

            sb.append("<div style='display:flex; margin-bottom:20px; width:500px;'>");

            sb.append("<img src='").append(imgFullPath)
            .append("' alt='").append(dto.getProgramName()).append(" 이미지")
            .append("' style=\"width:100px; height:auto; margin-right:20px; border-radius:8px;\">");

            sb.append("<div style='display:flex; flex-direction: column;'>");
            sb.append("<strong>")
              .append("[").append(dto.getProgramPlace()).append("] ")
              .append(dto.getProgramName()).append("</strong>");
            sb.append("<span>행사기간 : ")
              .append(sdf.format(dto.getStartDate())).append(" ~ ")
              .append(sdf.format(dto.getEndDate())).append("</span>");
            sb.append("<span>행사장소 : ").append(dto.getProgramPlace()).append("</span>");
            sb.append("<button class='detail-btn' type='button' onclick=\"location.href='")
            .append(contextPath).append("/test/programDetail/programDetail.jsp?programName=")
            .append(URLEncoder.encode(dto.getProgramName(), "UTF-8"))
            .append("'\">상세보기</button>");
            sb.append("</div></div>");
        }

        out.print(sb.toString());
    }
%>