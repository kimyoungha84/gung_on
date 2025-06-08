<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 된 사용자는 다시 로그인폼 접근 불가
    if (session.getAttribute("admin_id") != null) {
        response.sendRedirect("adminMain.jsp");
        return;
    }

    // 뒤로가기 캐시 방지
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 로그인</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f8f8;
        }
        .login-container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-box {
            background: #ffffff;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
        }
        .login-box img {
            width: 300px;
        }
        .login-box h2 {
            margin-bottom: 30px;
            font-weight: 600;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: none;
            border-bottom: 1px solid #ccc;
            background: transparent;
            font-size: 16px;
        }
        .login-box input:focus {
            outline: none;
            border-bottom: 2px solid #333;
        }
        .login-box button {
            width: 100%;
            padding: 12px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
        }
        .login-box button:hover {
            background-color: #333;
        }
        
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
            $('#login_form').submit(function () {
                if ($('#admin_id').val().trim() === '') {
                    alert('아이디를 입력하세요');
                    $('#admin_id').focus();
                    return false;
                }
                if ($('#admin_pass').val().trim() === '') {
                    alert('비밀번호를 입력하세요');
                    $('#admin_pass').focus();
                    return false;
                }
                return true;
            });
        });
    </script>
</head>
<body>
	<%
        String error = request.getParameter("error");
        String savedId = request.getParameter("admin_id") != null ? request.getParameter("admin_id") : "";
    %>

    <div class="login-container">
        <div class="login-box">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="궁온 로고">
            <h2>관리자 페이지</h2>
            
            <% if ("1".equals(error)) { %>
                <p class="error-message">아이디 또는 비밀번호가 일치하지 않습니다.</p>
            <% } %>
            
            
            <form id="login_form" method="post" action="adminLoginProcess.jsp">
                <input type="text" id="admin_id" name="admin_id" placeholder="관리자 아이디" autocomplete="off">
                <input type="password" id="admin_pass" name="admin_pass" placeholder="관리자 비밀번호" autocomplete="off">
                <button type="submit">로그인</button>
            </form>
        </div>
    </div>
</body>
</html>