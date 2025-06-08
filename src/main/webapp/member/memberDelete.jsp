<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="kr.co.gungon.member.MemberDTO" %>
<%@ page import="kr.co.gungon.member.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");

    MemberDTO dto = new MemberDTO();
    dto.setId(id);

    MemberDAO dao = MemberDAO.getInstance();
    try {
        dao.deleteMember(dto);  // 내부적으로 member_flag = 'Y' 처리
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("fail");
    }
%>