<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    int gungId = Integer.parseInt(request.getParameter("id"));
    GungService service = new GungService();

    boolean result = service.deleteGung(gungId);

    if (result) {
%>
        <script>
            alert("삭제되었습니다.");
            location.href = "gung_list.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("삭제에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>
