<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String relativePath = request.getParameter("relativePath");
    if (relativePath != null && !relativePath.isEmpty()) {
        String realPath = application.getRealPath(relativePath);
        File file = new File(realPath);
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"fail\", \"message\":\"파일 삭제 실패\"}");
            }
        } else {
            out.print("{\"status\":\"fail\", \"message\":\"파일 존재하지 않음\"}");
        }
    } else {
        out.print("{\"status\":\"fail\", \"message\":\"삭제 경로 누락\"}");
    }
%>
