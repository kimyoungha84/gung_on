<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%@ page import="java.util.List" %>

<%
    String adminId = (String)session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("adminLoginForm.jsp");
        return;
    }

    MemberDAO mDAO = MemberDAO.getInstance();
    List<MemberDTO> memberList = mDAO.selectAllMember();
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $(".clickable-row").click(function() {
            var memberId = $(this).data("id");
            // 상세 페이지를 content 영역에 로드
            $("#content").load("<%= request.getContextPath() %>/member/memberDetail.jsp?id=" + encodeURIComponent(memberId));
        });
    });
    
    $(".clickable-row").click(function() {
        if ($(this).hasClass("disabled")) {
            alert("탈퇴된 회원입니다.");
            return;
        }
        var memberId = $(this).data("id");
        $("#content").load("<%= request.getContextPath() %>/member/memberDetail.jsp?id=" + encodeURIComponent(memberId));
    });
    
</script>

<div class="container mt-4">
<h2>회원 목록</h2>
<table class="table table-bordered table-hover">
    <thead class="table-light">
    <tr>
        <th>이름</th>
        <th>아이디</th>
        <th>전화번호</th>
        <th>이메일</th>
        <th>가입일</th>
        <th>탈퇴여부</th>
    </tr>
</thead>
<tbody>
<%
    for(MemberDTO dto : memberList){
        boolean isDeleted = "Y".equals(dto.getFlag());
%>
    <tr class="clickable-row <%= isDeleted ? "disabled" : "" %>" data-id="<%= dto.getId() %>" style="<%= isDeleted ? "color:gray; cursor:default;" : "" %>">
        <td><%= dto.getName() %></td>
        <td><%= dto.getId() %></td>
        <td><%= dto.getTel() %></td>
        <td><%= dto.getUseEmail() %></td>
        <td><%= dto.getInput_date() %></td>
        <td><%= isDeleted ? "탈퇴" : "정상" %></td>
    </tr>
<%
    }
%>
</tbody>
</table>
</div>