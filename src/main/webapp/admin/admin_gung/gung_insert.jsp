<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="kr.co.gungon.gung.GungDTO" %>
<%@ page import="kr.co.gungon.gung.GungService" %>

<%
    request.setCharacterEncoding("UTF-8");

    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        String gungName = request.getParameter("gung_name");
        String gungSummary = request.getParameter("gung_summary");
        String gungHistory = request.getParameter("gung_history");

        GungDTO dto = new GungDTO();
        dto.setGung_name(gungName);
        dto.setGung_info(gungSummary);     // 요약 내용
        dto.setGung_history(gungHistory); // 역사 (String으로 저장한다고 가정)

        GungService service = new GungService();
        boolean result = service.insertGung(dto);

        if (result) {
%>
            <script>
                alert("궁이 성공적으로 등록되었습니다.");
                location.href = "gung_list.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("등록에 실패했습니다.");
                history.back();
            </script>
<%
        }
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>궁 정보 등록</title>
    <style>
        table { width: 80%; border-collapse: collapse; margin: 30px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f5f5f5; width: 120px; }
        textarea { width: 100%; height: 100px; }
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">궁 등록</h2>
    <form method="post" action="gung_insert.jsp">
        <table>
            <tr>
                <th>궁 이름</th>
                <td><input type="text" name="gung_name" required style="width: 100%;"></td>
            </tr>
            <tr>
                <th>요약 내용</th>
                <td><textarea name="gung_summary" required></textarea></td>
            </tr>
            <tr>
                <th>역사</th>
                <td><textarea name="gung_history" required></textarea></td>
            </tr>
        </table>
        <input type="submit" value="등록">
    </form>
</body>
</html>
<%
    }
%>
