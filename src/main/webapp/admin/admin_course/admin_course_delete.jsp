<%@ page import="kr.co.gungon.course.CourseService" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String courseNumParam = request.getParameter("courseNum");
    int courseNum = -1;
    if (courseNumParam != null) {
        try {
            courseNum = Integer.parseInt(courseNumParam);
        } catch (NumberFormatException e) {
            courseNum = -1;
        }
    }

    CourseService cs = new CourseService();
    boolean success = false;
    boolean fileSuccess = false;
    String message = "";

    if (courseNum != -1) {
        try {
            kr.co.gungon.course.CourseDTO course = cs.getCourseDetail(courseNum);
            if (course != null) {
                fileSuccess = cs.removeAllCourseImages(courseNum);
                success = cs.removeCourse(courseNum);
            } else {
                message = "코스를 찾을 수 없습니다.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "서버 오류가 발생했습니다.";
        }
    } else {
        message = "잘못된 요청입니다.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코스 삭제 결과</title>
    <script>
        alert("<%= (success && fileSuccess) ? "코스가 성공적으로 삭제되었습니다." : "삭제 실패: " + message %>");
        window.close(); // 팝업 닫기
        // 부모창 새로고침 (선택사항)
        if (window.opener) {
            window.opener.location.reload();
        }
    </script>
</head>
<body></body>
</html>
