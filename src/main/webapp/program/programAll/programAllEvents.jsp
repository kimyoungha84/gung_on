<%@page import="kr.co.gungon.file.FilePathService"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="kr.co.gungon.program.ProgramDAO"%>
<%@page import="kr.co.gungon.program.ProgramDTO"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String contextPath = request.getContextPath();
%>

<%
    String programPlace = request.getParameter("programPlace");
    if (programPlace == null || programPlace.trim().isEmpty()) {
        out.print("<li>행사 장소가 올바르지 않습니다.</li>");
        return;
    }

    ProgramDAO dao = ProgramDAO.getInstance();
    List<ProgramDTO> list = dao.selectProgramsByProgramPlace(programPlace);

    if (list.isEmpty()) {
        out.print("<li>현재 진행 중인 행사가 없습니다.</li>");
    } else {
    	FilePathService fps = new FilePathService();
        StringBuilder sb = new StringBuilder();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)", java.util.Locale.KOREAN);

        for (ProgramDTO dto : list) {
        	String imgFullPath = fps.getImageFullPath("program", String.valueOf(dto.getProgramId()));
            if (imgFullPath == null) {
                imgFullPath = contextPath + "/images/no-image.png"; // 대체 이미지 경로
            }

            sb.append("<div class='event-card' onclick=\"location.href='")
            .append(contextPath).append("/program/programAll/programAllDetail.jsp?programName=")
            .append(URLEncoder.encode(dto.getProgramName(), "UTF-8"))
            .append("'\" style='cursor:pointer;'>");

            if (imgFullPath != null && !imgFullPath.isEmpty()) {
                sb.append("<div class='event-image'><img src='")
                  .append(contextPath + imgFullPath)
                  .append("' alt='행사 이미지' /></div>");
            }

            sb.append("<div class='event-info'>");
            sb.append("<h4><strong>[").append(dto.getProgramPlace()).append("]</strong> ").append(dto.getProgramName()).append("</h4>");
            sb.append("<p><strong>행사장소:</strong> ").append(dto.getProgramPlace()).append("</p>");
            sb.append("<p><strong>행사기간:</strong> ").append(sdf.format(dto.getStartDate())).append(" ~ ").append(sdf.format(dto.getEndDate())).append("</p>");
            sb.append("<p><strong>행사시간:</strong> ")
              .append(dto.getOpenTime().toLocalDateTime().toLocalTime().toString().substring(0, 5))
              .append(" ~ ")
              .append(dto.getCloseTime().toLocalDateTime().toLocalTime().toString().substring(0, 5))
              .append("</p>");
            sb.append("</div></div>");
        }

        out.print(sb.toString());
    }
%>