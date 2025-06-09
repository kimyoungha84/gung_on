<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
request.setCharacterEncoding("UTF-8");
FaqDTO fDTO = new FaqDTO();

String numStr = request.getParameter("num");
int num = 0;
if (numStr != null && !numStr.isEmpty()) {
    try {
        num = Integer.parseInt(numStr);
    } catch (NumberFormatException e) {
        out.println("숫자로 변환할 수 없습니다: " + numStr);
    }
}

fDTO.setFaq_num(num);
fDTO.setFaq_title(request.getParameter("title"));
fDTO.setFaq_content(request.getParameter("content"));

CsService css = new CsService();
boolean flag = css.modifyFaq(fDTO);

if (flag) {
%>
<script>
    alert('FAQ 수정에 성공했습니다.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
} else {
%>
<script>
    alert('FAQ 수정에 실패했습니다. 다시 시도해주세요.');
    window.location.href = 'cs_faq_main.jsp';
</script>
<%
}
%>
