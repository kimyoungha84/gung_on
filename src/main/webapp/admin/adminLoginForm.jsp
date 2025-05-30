<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 로그인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#login_form').submit(function() {
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
                return true; // 꼭 명시적으로 true 반환
            });
        });
    </script>
</head>
<body>
    <h2>관리자 로그인</h2>
    <form id="login_form" method="post" action="adminLoginProcess.jsp">
        <label for="admin_id">아이디:</label>
        <input type="text" id="admin_id" name="admin_id"><br>

        <label for="admin_pass">비밀번호:</label>
        <input type="password" id="admin_pass" name="admin_pass"><br>

        <button type="submit" class="loginBtn" id="login_btn">로그인</button>
    </form>
</body>
</html>