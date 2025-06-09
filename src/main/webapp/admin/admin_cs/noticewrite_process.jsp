<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>

<%
request.setCharacterEncoding("UTF-8");
NoticeDTO nDTO = new NoticeDTO();
nDTO.setNotice_title(request.getParameter("title")); 

System.out.println(request.getParameter("title"));
nDTO.setNotice_content(request.getParameter("content"));

System.out.println(request.getParameter("content"));

CsService css = new CsService();
boolean flag = css.addNotice(nDTO);

if (flag) {
%>
<script>
    alert('공지사항 등록에 성공했습니다.');
    window.location.href = 'cs_notice_main.jsp';
</script>
<%
} else {
%>
<script>
    alert('공지사항 등록에 실패했습니다. 다시 시도해주세요.');
    window.location.href = 'cs_notice_main.jsp';
</script>
<%
}
%>