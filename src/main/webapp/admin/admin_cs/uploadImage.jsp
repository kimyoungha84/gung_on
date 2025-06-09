<%@ page import="java.io.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>
<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 업로드 디렉토리 경로
    String savePath = application.getRealPath("/upload");

    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 디렉토리가 없으면 생성
    }

    int maxSize = 10 * 1024 * 1024; // 10MB
    String encoding = "UTF-8";

    try {
        MultipartRequest multi = new MultipartRequest(
            request,
            savePath,
            maxSize,
            encoding,
            new DefaultFileRenamePolicy()
        );

        String fileName = multi.getFilesystemName("upload"); // 업로드된 파일 input의 name 속성

        if (fileName != null) {
            String imageUrl = request.getContextPath() + "/upload/" + fileName;
            out.print(imageUrl); // summernote는 이 URL을 img src로 사용
        } else {
            out.print("파일 업로드 실패: 파일명이 null입니다.");
        }
    } catch (Exception e) {
        out.print("파일 업로드 오류: " + e.getMessage());
    }
%>
