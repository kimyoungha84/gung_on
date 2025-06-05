<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.NoticeDTO"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%
request.setCharacterEncoding("UTF-8");
NoticeDTO nDTO = new NoticeDTO();

String numStr = request.getParameter("num");
int num = 0;
if (numStr != null && !numStr.isEmpty()) {
    try {
        num = Integer.parseInt(numStr);
    } catch (NumberFormatException e) {
        out.println("숫자로 변환할 수 없습니다: " + numStr);
    }
}

nDTO.setNotice_num(num);
nDTO.setNotice_title(request.getParameter("title"));
nDTO.setNotice_content(request.getParameter("content"));

CsService css = new CsService();
boolean flag = css.modifyNotice(nDTO);

if (flag) {
    // 수정 성공 시 리다이렉트
    response.sendRedirect("cs_notice_main.jsp");
} else {
    // 수정 실패 시 팝업 띄우고 리다이렉트
    out.println("<script type='text/javascript'>");
    out.println("alert('공지사항 수정에 실패했습니다. 다시 시도해주세요.');");
    out.println("window.location.href = 'cs_notice_main.jsp';");
    out.println("</script>");
}
%>
