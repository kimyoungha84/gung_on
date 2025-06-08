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
    dto.setUseEmail(fullEmail); // DTO의 useEmail 필드에 전체 이메일 세팅

    MemberDAO dao = MemberDAO.getInstance();
    try {
        dao.updateMemberInfo(dto); // 이름, 전화번호, 이메일을 모두 업데이트하는 DAO 메서드
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("fail");
    }
%>