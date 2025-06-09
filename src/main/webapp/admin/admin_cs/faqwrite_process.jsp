<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>

<%
request.setCharacterEncoding("UTF-8");
FaqDTO fDTO = new FaqDTO();
fDTO.setFaq_title(request.getParameter("title")); 

System.out.println(request.getParameter("title"));
fDTO.setFaq_content(request.getParameter("content"));

System.out.println(request.getParameter("content"));

CsService css = new CsService();
boolean flag = css.addFaq(fDTO);

if (flag) {
%>
<script>
    alert('FAQ 작성에 성공했습니다.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
} else {
%>
<script>
    alert('FAQ 작성에 실패했습니다. 다시 시도해주세요.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
}
%>
