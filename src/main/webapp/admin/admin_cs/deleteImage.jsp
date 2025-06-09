<%@ page import="java.io.*, java.net.URLDecoder" %>
<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. 파라미터 받기
    String filePath = request.getParameter("filePath");

    // 2. 파라미터 검증
    if (filePath == null || !filePath.contains("/upload/")) {
        out.println("잘못된 요청: filePath 파라미터가 없거나 유효하지 않습니다.");
        return;
    }

    // 3. URL 디코딩 및 공백 제거
    filePath = URLDecoder.decode(filePath, "UTF-8").trim();

    // 4. 실제 물리 경로로 변환
    String realPath = application.getRealPath(filePath);
    out.println("요청된 filePath: " + filePath);
    out.println("실제 삭제 경로: " + realPath);

    // 5. 파일 삭제 로직
    File file = new File(realPath);
    if (file.exists()) {
        if (file.delete()) {
            out.println("파일 삭제 성공");
        } else {
            out.println("파일 삭제 실패 (파일이 사용 중이거나 권한 문제일 수 있습니다)");
        }
    } else {
        out.println("파일이 존재하지 않습니다.");
    }
%>
