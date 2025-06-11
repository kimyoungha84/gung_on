<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
request.setCharacterEncoding("UTF-8");
InquiryDTO iDTO = new InquiryDTO();

String numStr = request.getParameter("num");
int num = 0;
if (numStr != null && !numStr.isEmpty()) {
    try {
        num = Integer.parseInt(numStr);
    } catch (NumberFormatException e) {
        out.println("숫자로 변환할 수 없습니다: " + numStr);
    }
}


iDTO.setInquiry_num(num);
iDTO.setAnswer_status(true);
iDTO.setInquiry_answer(request.getParameter("answer_content"));
java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
iDTO.setInquiry_answerDate(now);

CsService css = new CsService();
boolean flag = css.modifyInquiry(iDTO);

if (flag) {
%>
<script>
    alert('1:1 문의 수정에 성공했습니다.');
    window.location.href = 'cs_inquiry_main.jsp';
</script>
<%
} else {
%>
<script>
    alert('1:1 문의 수정에 실패했습니다. 다시 시도해주세요.');
    window.location.href = 'cs_inquiry_main.jsp';
</script>
<%
}
%>

