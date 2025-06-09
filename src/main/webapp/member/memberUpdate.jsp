<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String tel = request.getParameter("tel");
    String emailId = request.getParameter("emailId");
    String emailDomain = request.getParameter("emailDomain");
    String fullEmail = emailId + "@" + emailDomain;

    MemberDTO dto = new MemberDTO();
    dto.setId(id);
    dto.setName(name);
    dto.setTel(tel);
    dto.setUseEmail(fullEmail);

    MemberDAO dao = MemberDAO.getInstance();
    try {
        dao.updateMemberInfo(dto);
        response.sendRedirect("memberDetail.jsp?id=" + URLEncoder.encode(id, "UTF-8") + "&success=1");
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("회원 정보 수정에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>