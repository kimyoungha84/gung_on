<%@page import="kr.co.gungon.gung.GungDTO"%>
<%@page import="kr.co.gungon.gung.GungService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>창경궁</title>
<c:import url="../common/jsp/external_file.jsp"/>
<link rel="stylesheet" href="../common/css/common.css">
<link rel="stylesheet" href="sideTab.css">
<link rel="stylesheet" href="mainGung.css">
<style>
  .history-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  .history-table th, .history-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
  }
  .history-table th {
    background-color: #f2f2f2;
  }
</style>
</head>
<body>

<header data-bs-theme="dark">
 <jsp:include page="../common/jsp/header.jsp" />
</header>

<main>
  <div id="container">

    <!-- ✅ 사이드탭 왼쪽 고정 -->
    <div id="side-tab">
      <jsp:include page="sideTab.jsp" />
    </div>

    <!-- ✅ 궁 정보 내용 오른쪽 출력 -->
    <div id="gung-content">
    <%
        GungService service = new GungService();
        GungDTO gung = service.getGungDetail("창경궁");

        if (gung != null) {
            String[] historyRows = gung.getGung_history().split("\\s*/\\s*");  // ✅ 여기를 수정
    %>
        <h2><%= gung.getGung_name() %></h2>

      <% if (gung.getImg_path() != null && !gung.getImg_path().trim().isEmpty()) { %>
    <img src="<%= request.getContextPath() + gung.getImg_path() %>" alt="<%= gung.getGung_name() %> 이미지" class="gung-img" />
<% } %>



        <div class="txt_wrap">
        <img src="https://royal.khs.go.kr/imgs/images/2023/12/22/20231222151102361_6YOCUH0E.png" style="display: block; margin: 0 auto; max-width: 100%;" alt="" >
        <p><Strong style="text-align: center; font-size: 25px;">
        창경궁(昌慶宮)은 성종이 세 명의 대비를 위해 옛 수강궁에 창건한 궁이다.</Strong></p>
           <p><%= gung.getGung_info().replaceAll("\n", "<br>") %></p>
        </div>

        <h3 class="txt_section_tit">역사</h3>
        <table class="history-table">
            <thead>
                <tr>
                    <th>연도</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                <% for (String row : historyRows) {
                    String[] parts = row.trim().split(":", 2);
                    if (parts.length == 2) {
                %>
                    <tr>
                        <td><%= parts[0].trim() %></td>
                        <td><%= parts[1].trim() %></td>
                    </tr>
                <%  }} %>
            </tbody>
        </table>

    <%
        } else {
    %>
        <p>경복궁 정보를 불러올 수 없습니다.</p>
    <%
        }
    %>
    <!-- 구글 지도  -->
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3161.994331405819!2d126.99230793956413!3d37.5787511721519!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca2d63cdfd837%3A0x4ae06b4de851f3cf!2z7LC96rK96raB!5e0!3m2!1sko!2skr!4v1747700907780!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
  </div>
</main>

<footer class="text-body-secondary py-5">
 <jsp:include page="../common/jsp/footer.jsp" />
</footer>

</body>
</html>
