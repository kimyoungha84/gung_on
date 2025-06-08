<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");

    MemberDTO dto = new MemberDTO();
    dto.setId(id);

    MemberDAO dao = MemberDAO.getInstance();
    try {
        dao.deleteMember(dto); 
        response.sendRedirect("memberList.jsp?deleted=1");
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("회원 탈퇴 처리에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>