<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>


<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    String success = request.getParameter("success");
    if ("1".equals(success)) {
%>
    <script>alert("회원 정보가 수정되었습니다.");</script>
<%
    }

    String memberId = request.getParameter("id");
    MemberDAO dao = MemberDAO.getInstance();
    MemberDTO dto = dao.selectOneMember(memberId);

    String email = dto.getUseEmail();
    String emailId = "";
    String emailDomain = "";
    
    if ("Y".equals(dto.getFlag())) {
    	%>
    	    <script>
    	        alert("비정상적인 접근입니다.");
    	        location.href = "<%= request.getContextPath() %>/member/memberList.jsp";
    	    </script>
    	<%
    	        return;
    	    }
    
    if (email != null && email.contains("@")) {
        emailId = email.substring(0, email.indexOf("@"));
        emailDomain = email.substring(email.indexOf("@") + 1);
    }
%>

<div id="layoutSidenav_content">
<main>
    <div class="container-fluid">
        <h2 class="mt-4">회원 관리</h2>
        <hr/>
        
        <div class="card m-3"><!-- card m-3 start -->
        <div class="card-body"><!-- card-body start -->
        <h2>회원 상세</h2>
        
        <form id="updateForm" method="post" action="<%= request.getContextPath() %>/member/memberUpdate.jsp">
            <input type="hidden" name="id" value="<%= dto.getId() %>">

            <table class="table table-bordered">
                <tr><th>아이디</th><td><%= dto.getId() %></td></tr>
                <tr><th>이름</th><td><input type="text" name="name" value="<%= dto.getName() %>" required></td></tr>
                <tr><th>전화번호</th><td><input type="text" name="tel" id="tel" value="<%= dto.getTel() %>" maxlength="13" required></td></tr>
                <tr><th>이메일</th>
                    <td>
                        <input type="text" name="emailId" value="<%= emailId %>"> @
                        <input type="text" name="emailDomain" value="<%= emailDomain %>">
                    </td>
                </tr>
                <tr><th>IP</th><td><%= dto.getIp() %></td></tr>
                <tr><th>가입일</th><td><%= dto.getInput_date() %></td></tr>
                <tr><th>탈퇴여부</th><td><%= "Y".equals(dto.getFlag()) ? "탈퇴" : "정상" %></td></tr>
            </table>

            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                <div style="flex: 1;"></div>
                <div style="flex: 1; text-align: center;">
                    <button type="submit" class="btn btn-primary">수정</button>
                    <a href="<%= request.getContextPath() %>/member/memberList.jsp" class="btn btn-secondary">목록으로</a>
                </div>
                <div style="flex: 1; text-align: right;">
                    <button type="submit" formaction="<%= request.getContextPath() %>/member/memberDelete.jsp" class="btn btn-danger"
                        onclick="return confirm('정말로 이 회원을 탈퇴 처리하시겠습니까?')">회원탈퇴</button>
                </div>
            </div>
        </form>
    </div>
    </div><!-- card-body end -->
     </div><!-- card m-3 end -->
</main>
<%@ include file="/admin/common/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 전화번호 하이픈 자동 삽입
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

    // 폼 유효성 검사
    document.getElementById("updateForm").addEventListener("submit", function (e) {
        const name = document.querySelector("input[name='name']").value.trim();
        const tel = document.querySelector("input[name='tel']").value.trim();
        const emailId = document.querySelector("input[name='emailId']").value.trim();
        const emailDomain = document.querySelector("input[name='emailDomain']").value.trim();
        const email = emailId + "@" + emailDomain;

        if (name === "") {
            alert("이름을 입력하세요.");
            e.preventDefault();
            return;
        }

        const telPattern = /^010-\d{3,4}-\d{4}$/;
        if (!telPattern.test(tel)) {
            alert("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678");
            e.preventDefault();
            return;
        }

        const emailPattern = /^[\w\.-]+@[\w\.-]+\.\w+$/;
        if (!emailPattern.test(email)) {
            alert("이메일 형식이 올바르지 않습니다.");
            e.preventDefault();
            return;
        }
    });
</script>