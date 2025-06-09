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
%>
<script>
    alert('문의 등록에 성공했습니다.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
} else {
%>
<script>
    alert('문의 등록에 실패했습니다. 다시 시도해주세요.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
}
%>