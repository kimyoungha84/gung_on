<%@page import="kr.co.gungon.member.MemberDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>

<%
request.setCharacterEncoding("UTF-8");
InquiryDTO iDTO = new InquiryDTO();
iDTO.setInquiry_content(request.getParameter("inquiryContent")); 

String userId = ((MemberDTO)session.getAttribute("userData")).getId();

iDTO.setMember_id(userId);

CsService css = new CsService();
boolean flag = css.addInquiry(iDTO);

if (flag) {
    // 작성 성공 시 리다이렉트
    response.sendRedirect("myinquiry.jsp");
} else {
    // 작성 실패 시 팝업 띄우고 리다이렉트
    out.println("<script type='text/javascript'>");
    out.println("alert('1:1문의 작성에 실패했습니다. 다시 시도해주세요.');");
    out.println("window.location.href = 'myinquiry.jsp';");
    out.println("</script>");
}
%>
