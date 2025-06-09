<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String storyName = request.getParameter("name");
    if (storyName == null || storyName.trim().isEmpty()) {
%>
    <p>스토리 이름이 제공되지 않았습니다.</p>
<%
        return;
    }
    
    // 스토리 정보를 story_name 기준으로 조회 (스토리의 ID가 DB에 저장된 이미지의 기준입니다)
    StoryService ss = new StoryService();
    StoryDTO story = ss.getStoryByName(storyName);
    if (story == null) {
%>
    <p>스토리 정보를 찾을 수 없습니다.</p>
<%
        return;
    }

    // DB에는 target_number가 story_id로 저장되어 있으므로, story.getStory_id() 기준으로 이미지 리스트 조회
    FilePathService fps = new FilePathService();
    List<FilePathDTO> imageList = fps.getStoryImagesByName("story", String.valueOf(story.getStory_id()));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= story.getStory_name() %> | 스토리</title>
  <style>
    .story-container {
      max-width: 700px;
      margin: 0 auto;
      padding: 20px;
      text-align: center;
    }
    .story-container h2 {
      font-size: 32px;
      margin-bottom: 20px;
    }
    .story-container p {
      font-size: 18px;
      line-height: 1.8;
      text-align: justify;
    }
    .slider-container {
      position: relative;
      width: 600px;
      height: 400px;
      overflow: hidden;
      margin: 30px auto;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .slider-images {
      display: flex;
      transition: transform 0.5s ease;
      width: calc(600px * <%= imageList.size() %>);
    }
    .slider-images img {
      width: 600px;
      height: 400px;
      object-fit: cover;
    }
    .slider-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background-color: rgba(0,0,0,0.4);
      color: white;
      border: none;
      font-size: 24px;
      cursor: pointer;
      padding: 8px 12px;
      z-index: 10;
    }
    .slider-btn.left { left: 0; }
    .slider-btn.right { right: 0; }
  </style>
</head>
<body>
<div class="story-container">
  <h2><%= story.getStory_name() %></h2>

  <% if (imageList != null && !imageList.isEmpty()) { %>
  <div class="slider-container">
    <div class="slider-images" id="imageSlider">
<% for (FilePathDTO img : imageList) {
     String rawPath = img.getPath();  // "/Gung_On/common/images/..."
     // "Gung_On" 중복 제거
     String path = rawPath.replaceFirst("^/Gung_On", ""); // 앞의 Gung_On 제거
     String fullPath = request.getContextPath() + path;
%>
  <img src="<%= fullPath %>" alt="스토리 이미지">
<% } %>


    </div>
    <button class="slider-btn left" onclick="prevSlide()">&#10094;</button>
    <button class="slider-btn right" onclick="nextSlide()">&#10095;</button>
  </div>
  <% } else { %>
    <p>이미지가 없습니다.</p>
  <% } %>
  <p><%= story.getStory_info() %></p>
</div>

<script>
  let index = 0;
  const total = <%= imageList.size() %>;

  function updateSlider() {
    const slider = document.getElementById("imageSlider");
    slider.style.transform = "translateX(" + (-600 * index) + "px)";
  }

  function prevSlide() {
    if (index > 0) {
      index--;
      updateSlider();
    }
  }

  function nextSlide() {
    if (index < total - 1) {
      index++;
      updateSlider();
    }
  }
</script>

</body>
</html>
