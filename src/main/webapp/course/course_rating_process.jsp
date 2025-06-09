<%@page import="kr.co.gungon.course.CourseService"%>
<%@page import="kr.co.gungon.course.CourseDTO"%> <%-- 업데이트된 별점 정보를 가져오기 위해 DTO 사용 --%>
<%@page import="org.json.simple.JSONObject"%> <%-- JSON 응답을 위해 사용 --%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    // 응답 Content Type 설정
    response.setContentType("application/json; charset=UTF-8");
    JSONObject jsonResponse = new JSONObject(); // JSON 응답 객체

    // 요청 파라미터 가져오기 (코스 번호, 별점 값)
    String courseNumParam = request.getParameter("course_num");
    String ratingParam = request.getParameter("rating");

    int courseNum = -1;
    double rating = -1.0;

    // 파라미터 유효성 검사 및 변환
    if (courseNumParam != null && !courseNumParam.isEmpty()) {
        try {
            courseNum = Integer.parseInt(courseNumParam);
        } catch (NumberFormatException e) {
            System.err.println(">>> ERROR course_rating_process.jsp: Invalid course_num parameter: " + courseNumParam);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "유효하지 않은 코스 번호입니다.");
            response.getWriter().write(jsonResponse.toJSONString());
            return; // 처리 중단
        }
    } else {
        System.err.println(">>> ERROR course_rating_process.jsp: course_num parameter is missing.");
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "코스 번호가 누락되었습니다.");
        response.getWriter().write(jsonResponse.toJSONString());
        return; // 처리 중단
    }

    if (ratingParam != null && !ratingParam.isEmpty()) {
        try {
            rating = Double.parseDouble(ratingParam);
            // 별점 값 범위 유효성 검사 (CourseService에서도 하지만 여기서도 기본적인 검사)
            // 0.5 ~ 5.0 범위 체크
            if (rating < 0.5 || rating > 5.0) { 
                 System.err.println(">>> ERROR course_rating_process.jsp: Invalid rating value: " + ratingParam);
                 jsonResponse.put("status", "error");
                 jsonResponse.put("message", "유효하지 않은 별점 값입니다. (0.5 ~ 5.0)");
                 response.getWriter().write(jsonResponse.toJSONString());
                 return; // 처리 중단
            }
             // 0.5 단위 유효성 검사 (optional)
             if (rating * 2 % 1 != 0) { // 0.5 단위가 아니면 (예: 1.1, 2.3 등)
                 System.err.println(">>> ERROR course_rating_process.jsp: Rating value is not in 0.5 increments: " + ratingParam);
                 jsonResponse.put("status", "error");
                 jsonResponse.put("message", "별점은 0.5 단위로만 등록 가능합니다.");
                 response.getWriter().write(jsonResponse.toJSONString());
                 return; // 처리 중단
             }

        } catch (NumberFormatException e) {
            System.err.println(">>> ERROR course_rating_process.jsp: Invalid rating parameter: " + ratingParam);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "유효하지 않은 별점 형식입니다.");
            response.getWriter().write(jsonResponse.toJSONString());
            return; // 처리 중단
        }
    } else {
        System.err.println(">>> ERROR course_rating_process.jsp: rating parameter is missing.");
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "별점 값이 누락되었습니다.");
        response.getWriter().write(jsonResponse.toJSONString());
        return; // 처리 중단
    }

    // CourseService를 사용하여 별점 등록 처리
    CourseService courseService = new CourseService();
    boolean isRated = false;
    try {
        isRated = courseService.addCourseRating(courseNum, rating); // Service 메소드 호출
    } catch (Exception e) { 
        e.printStackTrace(); 
        System.err.println(">>> ERROR course_rating_process.jsp: Failed to add rating for course_num " + courseNum);
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "별점 등록 중 서버 오류 발생.");
        response.getWriter().write(jsonResponse.toJSONString());
        return; // 처리 중단
    }

    // 별점 등록 결과에 따른 응답 구성
    if (isRated) {
        jsonResponse.put("status", "success");
        jsonResponse.put("message", "별점 등록 성공");
        
        // *** 이 부분에 업데이트된 코스 상세 정보를 다시 조회하는 로직 추가 ***
        // 별점 등록 성공 후 해당 코스의 최신 상세 정보를 다시 가져옵니다.
        CourseDTO updatedCourse = null;
        try {
            updatedCourse = courseService.getCourseDetail(courseNum); // 코스 번호로 상세 정보 다시 조회
        } catch (Exception e) {
             // 다시 조회 중 오류 발생 시 로그 출력 (별점 등록 자체는 성공했으므로 에러 응답은 안 함)
             e.printStackTrace(); 
             System.err.println(">>> WARNING course_rating_process.jsp: Failed to retrieve updated course detail for course_num " + courseNum);
        }

        // 조회된 업데이트 정보가 있다면 JSON 응답에 추가
        if (updatedCourse != null) {
            // 최신 평균 별점과 참여자 수를 응답 JSON에 'newRating', 'newRatingCount'로 추가
            jsonResponse.put("newRating", updatedCourse.getCourse_Rating()); 
            jsonResponse.put("newRatingCount", updatedCourse.getCourse_Rating_Cnt()); 
        }
        // *** 업데이트된 정보 추가 로직 끝 ***

    } else {
        // Service 메소드가 false를 반환한 경우 (예: 코스 번호가 유효하지 않거나 다른 이유)
        jsonResponse.put("status", "failure");
        jsonResponse.put("message", "별점 등록 실패. 코스 번호를 확인하세요.");
        // Service 메소드에서 실패 원인에 대한 더 구체적인 정보를 반환한다면 message에 반영 가능
    }

    // 최종 JSON 응답 전송
    response.getWriter().write(jsonResponse.toJSONString());
%>
