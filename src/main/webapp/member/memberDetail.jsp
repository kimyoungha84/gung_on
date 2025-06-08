<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%
    String adminId = (String)session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("../adminLoginForm.jsp");
        return;
    }

    String memberId = request.getParameter("id");
    MemberDAO dao = MemberDAO.getInstance();
    MemberDTO dto = dao.selectOneMember(memberId);

    String email = dto.getUseEmail();
    String emailId = "";
    String emailDomain = "";
    if (email != null && email.contains("@")) {
        emailId = email.substring(0, email.indexOf("@"));
        emailDomain = email.substring(email.indexOf("@") + 1);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    function loadPage(url) {
        $("#content").load(url);  
    }
    
        $(function () {
            $('#tel').on('input', function () {
                let raw = $(this).val().replace(/[^0-9]/g, '');
                let formatted = '';
                if (raw.length <= 3) {
                    formatted = raw;
                } else if (raw.length <= 7) {
                    formatted = raw.slice(0, 3) + '-' + raw.slice(3);
                } else {
                    formatted = raw.slice(0, 3) + '-' + raw.slice(3, 7) + '-' + raw.slice(7);
                }
                $(this).val(formatted);
            });

            $("#updateForm").submit(function (e) {
                e.preventDefault();

                const tel = $("input[name=tel]").val();
                const emailId = $("input[name=emailId]").val().trim();
                const emailDomain = $("input[name=emailDomain]").val().trim();
                const email = emailId + "@" + emailDomain;
                const memberId = $("input[name=id]").val();

                // 전화번호 유효성 검사
                const telPattern = /^010-\d{3,4}-\d{4}$/;
                if (!telPattern.test(tel)) {
                    alert("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678");
                    return;
                }

                // 이메일 유효성 검사
                const emailPattern = /^[\w\.-]+@[\w\.-]+\.\w+$/;
                if (!emailPattern.test(email)) {
                    alert("이메일 형식이 올바르지 않습니다.");
                    return;
                }

                const formData = $(this).serialize();

                $.post("<%= request.getContextPath() %>/member/memberUpdate.jsp", formData, function (result) {
                    if (result.trim() === "success") {
                        alert("회원 정보가 수정되었습니다.");
                        loadPage("<%= request.getContextPath() %>/member/memberDetail.jsp?id=" + encodeURIComponent(memberId));
                    } else {
                        alert("수정에 실패했습니다.");
                    }
                });
            });
        });
        
     // 회원탈퇴 처리
        $("#btnDelete").click(function () {
            if (!confirm("정말로 이 회원을 탈퇴 처리하시겠습니까?")) return;

            const memberId = $("input[name=id]").val();

            $.post("<%= request.getContextPath() %>/member/memberDelete.jsp", { id: memberId }, function (result) {
                if (result.trim() === "success") {
                    alert("회원이 탈퇴 처리되었습니다.");
                    loadPage("<%= request.getContextPath() %>/member/memberList.jsp");
                } else {
                    alert("탈퇴 처리에 실패했습니다.");
                }
            });
        });
        
    </script>
</head>
<body>
<div class="container mt-4">
<h2>회원 상세정보 수정</h2>
<form id="updateForm" method="post">
    <input type="hidden" name="id" value="<%= dto.getId() %>">

    <table class="table table-bordered">
        <tr><th>아이디</th><td><%= dto.getId() %></td></tr>
        <tr><th>이름</th><td><input type="text" name="name" value="<%= dto.getName() %>" required></td></tr>
        <tr><th>전화번호</th><td><input type="text" name="tel" id="tel" value="<%= dto.getTel() %>" maxlength="13" required></td></tr>
        <tr><th>이메일</th>
            <td>
                <input type="text" name="emailId" value="<%= emailId %>" > @
                <input type="text" name="emailDomain" value="<%= emailDomain %>" >
            </td>
        </tr>
        <tr><th>IP</th><td><%= dto.getIp() %></td></tr>
        <tr><th>가입일</th><td><%= dto.getInput_date() %></td></tr>
        <tr><th>탈퇴여부</th><td><%= "Y".equals(dto.getFlag()) ? "탈퇴" : "정상" %></td></tr>
    </table>
<div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
    <!-- 왼쪽: 빈 공간 -->
    <div style="flex: 1;"></div>

    <!-- 가운데: 수정 + 목록 버튼 -->
    <div style="flex: 1; text-align: center;">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary"
            onclick="loadPage('<%= request.getContextPath() %>/member/memberList.jsp')">목록으로</button>
    </div>

    <!-- 오른쪽: 회원탈퇴 버튼 -->
    <div style="flex: 1; text-align: right;">
        <button type="button" class="btn btn-danger" id="btnDelete">회원탈퇴</button>
    </div>
</div>
</form>
</div>
</body>
</html>
