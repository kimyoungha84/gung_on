<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminId = (String) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect(request.getContextPath() + "/admin/adminLoginForm.jsp"); // ✅ 고친 부분
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>궁온 관리자 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <!-- 상단 네비게이션 -->
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/adminMain.jsp">
            <img src="${pageContext.request.contextPath}/img/logo.png" class="logo">
        </a>
    </nav>