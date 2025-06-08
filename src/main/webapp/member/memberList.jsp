<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    String deleted = request.getParameter("deleted");
    if ("1".equals(deleted)) {
%>
<script>alert("회원이 탈퇴 처리되었습니다.");</script>
<%
    }
    MemberDAO mDAO = MemberDAO.getInstance();
    List<MemberDTO> memberList = mDAO.selectAllMemberAdmin();
%>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4 mt-4">
            <h2>회원 목록</h2>
            <hr/>
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
                        String rowStyle = isDeleted ? "color:gray; cursor:default;" : "cursor:pointer;";
                        String link = request.getContextPath() + "/member/memberDetail.jsp?id=" + dto.getId();
                %>
                    <tr
  						 class="<%= isDeleted ? "disabled" : "" %>"
   						 style="<%= rowStyle %>"
    					<%= !isDeleted ? "onclick=\"location.href='" + link + "'\"" : "" %>>
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
    </main>
<%@ include file="/admin/common/footer.jsp" %>

<script>
    document.querySelectorAll("tr.disabled").forEach(function(row) {
        row.addEventListener("click", function() {
            alert("탈퇴한 회원은 조회가 불가능합니다.");
        });
    });
</script>