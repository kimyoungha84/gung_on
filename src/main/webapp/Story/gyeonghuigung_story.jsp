<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.gungon.story.StoryDTO" %>
<%@ page import="kr.co.gungon.story.StoryService" %>

<%
    // 1. 선택한 궁 ID 받아오기 (기본은 경복궁 ID 1)
    String gungIdStr = request.getParameter("gung_id");
    int gungId = (gungIdStr != null && !gungIdStr.trim().isEmpty()) ? Integer.parseInt(gungIdStr) : 5;

    // 2. 전각 목록 불러오기
    StoryService storyService = new StoryService();
    List<StoryDTO> storyList = storyService.getStoriesByGungId(gungId);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>전각 이야기</title>
  <c:import url="/common/jsp/external_file.jsp"/>
  <link rel="stylesheet" href="/common/css/common.css">
  <link rel="stylesheet" href="/gung/mainGung.css">
  <link rel="stylesheet" href="/Story/Story.css">
  <link rel="stylesheet" href="/gung/sideTab.css">
  <style>
    .gung-button-wrap {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 20px;
    }
    .gung-btn {
      padding: 8px 14px;
      border: 1px solid #333;
      background-color: white;
      color: #333;
      border-radius: 5px;
      cursor: pointer;
      transition: all 0.2s;
    }
    .gung-btn:hover {
      background-color: #333;
      color: white;
    }
  </style>
  <jsp:include page="/common/jsp/external_file.jsp" />
  <script type="text/javascript">
    $(function(){
      $(".gung-btn").on("click", function(e){
        e.preventDefault();
        const palaceName = $(this).data("name");

        $.ajax({
          url: "<%= request.getContextPath() %>/Story/g_story.jsp",
          type: "GET",
          data: { name: palaceName },
          success: function(response){
            $("#gung-info").html(response);
          },
          error: function(){
            $("#gung-info").html("<p>정보를 불러오는 데 실패했습니다.</p>");
          }
        });
      });
    });
  </script>
</head>
<body>

<header data-bs-theme="dark">
  <jsp:include page="/common/jsp/header.jsp" />
</header>

<main>
  <div id="container">

    <!-- ✅ 사이드탭 -->
    <div id="side-tab">
      <jsp:include page="/gung/sideTab.jsp" />
    </div>

    <div class="gung-wrap">
      <!-- ✅ 전각 버튼 영역 -->
      <div class="gung-button-wrap">
        <% if (storyList != null && !storyList.isEmpty()) {
             for (StoryDTO s : storyList) { %>
               <button class="gung-btn" data-name="<%= s.getStory_name() %>"><%= s.getStory_name() %></button>
        <%   }
           } else { %>
               <p>전각 정보가 없습니다.</p>
        <% } %>
      </div>

      <!-- ✅ 전각 설명 AJAX 결과 영역 -->
      <div id="gung-info" class="gung-info-box" style="margin-left: calc(50% - 360px); transform: translateX(-10%); width: 700px;">
      
        <p>전각 버튼을 클릭하면 정보가 출력됩니다.</p>
      </div>
    </div>
  </div>
</main>

<footer class="text-body-secondary py-5">
  <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>
