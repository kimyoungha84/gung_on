<%@page import="kr.co.gungon.course.CourseDTO"%>
<%@page import="kr.co.gungon.course.CourseService"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String courseNumParam = request.getParameter("courseNum");
    int courseNum = (courseNumParam != null) ? Integer.parseInt(courseNumParam) : 0;

    CourseService courseService = new CourseService();
    CourseDTO course = courseService.getCourseDetail(courseNum);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코스 상세보기</title>
    <link rel="stylesheet" href="/css/common.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .wrapper {
            box-sizing: border-box;
            width: 100%;
            height: 100%;
            padding: 20px;
            overflow: auto;
        }

        .course-detail {
            max-width: 800px;
            margin: auto;
        }

        .course-title {
            font-size: 24px;
            font-weight: bold;
        }

        .course-meta {
            color: gray;
            margin-bottom: 20px;
        }

        .course-content {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 30px;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            float: right;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }
        
        
        .course-content img {
    max-width: 100%;
    height: auto;
    display: block;
    margin: 10px auto;
}
    </style>
</head>
<body>
<div class="wrapper">
    <form method="post" action="admin_course_delete.jsp" onsubmit="return confirm('정말 삭제하시겠습니까?');">
        <input type="hidden" name="courseNum" value="<%= course.getCourse_Num() %>">
        <button type="submit" class="delete-btn">삭제</button>
    </form>
    <div class="course-detail">
        <div class="course-title"><%= course.getCourse_Title() %></div>
        <div class="course-meta">작성자: <%= course.getMember_Id() %></div>
        <div class="course-content">
            <%= course.getCourse_Content() %>
        </div>
    </div>
</div>
</body>
</html>
