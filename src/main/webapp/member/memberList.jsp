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

<h2>회원 목록</h2>
<table border="1" cellpadding="10" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>IP</th>
            <th>가입일</th>
            <th>상태</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <%
            for(MemberDTO dto : memberList){
        %>
        <tr>
            <td><%= dto.getId() %></td>
            <td><%= dto.getName() %></td>
            <td><%= dto.getTel() %></td>
            <td><%= dto.getUseEmail() %></td>
            <td><%= dto.getIp() %></td>
            <td><%= dto.getInput_date() %></td>
            <td>
                <%= "Y".equals(dto.getFlag()) ? "탈퇴" : "정상" %>
            </td>
            <td>
                <form action="memberDetail.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= dto.getId() %>">
                    <input type="submit" value="상세">
                </form>
                <form action="memberDelete.jsp" method="post" style="display:inline;" onsubmit="return confirm('정말 탈퇴 처리하시겠습니까?');">
                    <input type="hidden" name="id" value="<%= dto.getId() %>">
                    <input type="submit" value="삭제">
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>