<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  GungService service = new GungService();
  List<GungDTO> gungList = service.selectAllGung();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>궁 관리</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
      margin: 40px;
    }

    h1 {
      text-align: center;
      margin-bottom: 30px;
    }

    .content {
      max-width: 900px;
      margin: 0 auto;
    }

    .gung-table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    }

    .gung-table th, .gung-table td {
      padding: 14px 16px;
      border: 1px solid #e0e0e0;
      text-align: left;
    }

    .gung-table th {
      background-color: #f1f1f1;
      font-weight: 600;
      color: #333;
    }

    .gung-table tr:hover {
      background-color: #f5faff;
    }

    .gung-table tr {
      transition: background-color 0.2s ease-in-out;
      cursor: pointer;
    }

    .register-btn {
      margin-top: 20px;
      display: block;
      margin-left: auto;
      background-color: #007bff;
      color: #fff;
      padding: 12px 24px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .register-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

<main class="content">

  <h1>궁 관리</h1>
  <table class="gung-table">
    <thead>
      <tr>
        <th>No.</th>
        <th>궁 이름</th>
        <th>요약 내용</th>
        <th>수정일</th>
      </tr>
    </thead>
    <tbody>
      <%
        int no = 1;
        for (GungDTO dto : gungList) {
          String html = dto.getGung_info(); // DB에 저장된 HTML 포함 문자열
          String plain = html.replaceAll("<[^>]*>", ""); // 태그 제거

          // 요약 텍스트 생성
          String preview = plain;
          int dotIndex = plain.indexOf(".");

          if (dotIndex != -1) {
              preview = plain.substring(0, dotIndex + 1) + " ...";
          } else if (plain.length() > 50) {
              preview = plain.substring(0, 50) + " ...";
          }
      %>
      <tr onclick="location.href='gung_detail.jsp?id=<%= dto.getGung_id() %>'">
        <td><%= no++ %></td>
        <td><%= dto.getGung_name() %></td>
        <td><%= preview %></td>
        <td><%= dto.getGung_reg_date() %></td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>

  <button class="register-btn"onclick="location.href='/Gung_On/admin/admin_gung/gung_insert.jsp'">등록</button>
</main>

</body>
</html>
