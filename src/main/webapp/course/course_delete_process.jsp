<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@page import="java.io.PrintWriter"%>

<%
    PrintWriter script = response.getWriter();
    response.setContentType("text/html; charset=UTF-8");

    MemberDTO mDTO = (MemberDTO)session.getAttribute("userData");
    if (mDTO == null) {
        script.println("<script>");
        script.println("alert('로그인이 필요합니다.');");
        script.println("window.location.href = '/member/login.jsp';"); 
        script.println("</script>");
        script.close();
        return; 
    }
    String loggedInMemberId = mDTO.getId(); // 로그인한 사용자의 ID

    String courseNumParam = request.getParameter("course_num");
    String gungIdStr = request.getParameter("gung_id"); // 추가: 궁 아이디 받기
    int courseNum = -1; // 기본값 설정
    int gungId = 0;

    if (gungIdStr != null && !gungIdStr.isEmpty()) {
        try {
            gungId = Integer.parseInt(gungIdStr);
            if (gungId < 1 || gungId > 5) {
                gungId = 0; // 유효하지 않으면 기본 0으로
            }
        } catch (NumberFormatException e) {
            gungId = 0;
        }
    }

    if (courseNumParam != null && !courseNumParam.isEmpty()) {
        try {
            courseNum = Integer.parseInt(courseNumParam);
             if (courseNum <= 0) {
                  script.println("<script>");
                  script.println("alert('유효하지 않은 코스 정보입니다.');");
                  script.println("window.history.back();"); 
                  script.println("</script>");
                  script.close();
                  return;
             }
        } catch (NumberFormatException e) {
            script.println("<script>");
            script.println("alert('유효하지 않은 코스 정보입니다.');");
            script.println("window.history.back();"); 
            script.println("</script>");
            e.printStackTrace();
            script.close();
            return;
        }
    } else {
         script.println("<script>");
         script.println("alert('코스 정보가 누락되었습니다.');");
         script.println("window.history.back();");
         script.println("</script>");
         script.close();
         return;
    }

    CourseService courseService = new CourseService();
    boolean isRemoved = false;
    try {
        isRemoved = courseService.removeCourse(courseNum, loggedInMemberId); 
    } catch (Exception e) {
        script.println("<script>");
        script.println("alert('코스 삭제 처리 중 오류 발생.');");
        script.println("window.history.back();");
        script.println("</script>");
        e.printStackTrace();
        script.close();
        return;
    }

    if (isRemoved) {
        script.println("<script>");
        script.println("alert('코스가 성공적으로 삭제되었습니다.');");
        if (gungId > 0) {
            // 궁 ID가 있으면 해당 궁 필터 화면으로 이동
            script.println("window.location.href = 'users_course.jsp?gung_id=" + gungId + "&mode=mycourses';");
        } else {
            // 궁 ID 없으면 기본 mycourses 모드로 이동
            script.println("window.location.href = 'users_course.jsp?mode=mycourses';");
        }
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('코스 삭제에 실패했습니다. 본인이 작성한 코스인지 확인해주세요.');");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close(); // 응답 완료
%>
