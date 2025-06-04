<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>로그인</title>
    <c:import url="/common/jsp/external_file.jsp"/>
    <link rel="stylesheet" href="/Gung_On/common/css/common.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    window.onload = function() {
        document.getElementById("floatingInput").addEventListener("keyup", enter);
        document.getElementById("floatingPassword").addEventListener("keyup", enter);
        document.getElementById("btnLogin").addEventListener("click", chkNull);
    }

    function enter(evt) {
        if (evt.which == 13 || evt.keyCode == 13) {
            chkNull();
        }
    }

    function chkNull() {
        var obj = document.loginFrm;
        var id = obj.id.value.trim();
        var pass = obj.pass.value.trim();

        if (id === "") {
            obj.id.focus();
            return;
        }
        if (pass === "") {
            obj.pass.focus();
            return;
        }

        loginProcess(id, pass);
    }

    function loginProcess(id, pass) {
        var param = { id: id, pass: pass };
        $.ajax({
            url: "login_process.jsp",
            type: "POST",
            data: param,
            dataType: "json",
            success: function(jsonObj) {
                if (jsonObj.loginResult) {
                	if(jsonObj.loginFlag){
                		alert("탈퇴한 회원입니다.");
                		return;
                	}
                    location.href = "/Gung_On/mainpage/mainpage.jsp"; // 로그인 성공 시 이동할 페이지
                } else {
                	alert("아이디나 비밀번호를 확인해주세요.");
                }//end else
            },
            error: function(xhr) {
                alert("로그인 작업 실패\n잠시 후 다시 시도해 주세요.");
                console.log("오류 상태:", xhr.status);
            }
        });
    }
    </script>
</head>
<body class="login">
 <jsp:include page="/common/jsp/header.jsp"/>

<div class="login-container">
    <h2>로그인</h2>
    <form name="loginFrm"> 
        <input type="text" id="floatingInput" name="id" placeholder="아이디" required><br>
        <input type="password" id="floatingPassword" name="pass" placeholder="비밀번호" required><br>
        <button type="button" id="btnLogin">로그인</button>
    </form>


    <div class="link-container">
        <div class="link-box">
            <a href="/Gung_On/mypage/searchAccount.jsp" style="margin-right: 20px;">아이디/비밀번호 찾기</a>
            <span class="divider"></span>
            <a href="/Gung_On/signup/sign_up.jsp" style="margin-left: 10px;">회원가입</a>
        </div>
    </div>
</div>

 <jsp:include page="/common/jsp/footer.jsp"/>
</body>
</html>
