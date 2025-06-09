<%@ page import="java.io.File" %>
<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String imagePath = request.getParameter("imagePath");

    try {
        if (imagePath == null || imagePath.trim().equals("")) {
            out.print("{\"status\":\"error\",\"message\":\"imagePath 파라미터가 없습니다.\"}");
            return;
        }

        String realPath = application.getRealPath("/" + imagePath);
        File file = new File(realPath);

        if (file.exists()) {
            if (file.delete()) {
                out.print("{\"status\":\"success\",\"message\":\"삭제 성공\"}");
            } else {
                out.print("{\"status\":\"error\",\"message\":\"삭제 실패 (file.delete() false)\"}");
            }
        } else {
            out.print("{\"status\":\"error\",\"message\":\"파일이 존재하지 않음\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"status\":\"error\",\"message\":\"서버 예외: " + e.getMessage() + "\"}");
    }
%>
