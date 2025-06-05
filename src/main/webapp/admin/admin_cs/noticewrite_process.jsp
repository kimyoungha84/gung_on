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
    // 작성 성공 시 리다이렉트
    response.sendRedirect("cs_notice_main.jsp");
} else {
    // 작성 실패 시 팝업 띄우고 리다이렉트
    out.println("<script type='text/javascript'>");
    out.println("alert('공지사항 작성에 실패했습니다. 다시 시도해주세요.');");
    out.println("window.location.href = 'cs_notice_main.jsp';");
    out.println("</script>");
}
%>
