<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String storyName = request.getParameter("name");
    if (storyName == null || storyName.trim().isEmpty()) {
%>
    <p>스토리 이름이 제공되지 않았습니다.</p>
<%
        return;
    }

    StoryService ss = new StoryService();
    StoryDTO story = ss.getStoryByName(storyName);
    if (story == null) {
%>
    <p>스토리 정보를 찾을 수 없습니다.</p>
<%
        return;
    }

    FilePathService fps = new FilePathService();
    List<FilePathDTO> imageList = fps.getStoryImagesByName("story", String.valueOf(story.getStory_id()));
    int imageCount = (imageList != null) ? imageList.size() : 0;
%>

<style>
  .story-container {
    max-width: 700px;
    margin: 0 auto;
    padding: 20px;
    text-align: left;
  }
  .story-container h2 {
    font-size: 32px;
    margin-bottom: 20px;
  }
  .story-container p {
    font-size: 18px;
    line-height: 1.8;
    margin-top: 20px;
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
    width: calc(600px * <%= Math.max(imageCount, 1) %>);
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

  /* 썸네일 스타일 */
  .thumbnail-list {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 15px;
    flex-wrap: wrap;
  }
  .thumbnail {
    width: 80px;
    height: 60px;
    object-fit: cover;
    border: 2px solid transparent;
    border-radius: 6px;
    cursor: pointer;
    transition: border 0.2s;
  }
  .thumbnail:hover,
  .thumbnail.active {
    border: 2px solid #007bff;
  }
</style>

<div class="story-container">
  <h2><%= story.getStory_name() %></h2>

  <% if (imageCount > 0) { %>
  <div class="slider-container">
    <div class="slider-images" id="imageSlider">
    <% 
        for (FilePathDTO img : imageList) {
            String rawPath = img.getPath();
            String contextPath = request.getContextPath();
            String path = rawPath.startsWith(contextPath) ? rawPath.substring(contextPath.length()) : rawPath;
            String fullPath = contextPath + path;
    %>
        <img src="<%= fullPath %>" alt="스토리 이미지">
    <% } %>
    </div>
    <button class="slider-btn left" onclick="prevSlide()">&#10094;</button>
    <button class="slider-btn right" onclick="nextSlide()">&#10095;</button>
  </div>

  <div class="thumbnail-list" id="thumbnailList">
    <% 
        for (int i = 0; i < imageList.size(); i++) {
            FilePathDTO img = imageList.get(i);
            String rawPath = img.getPath();
            String contextPath = request.getContextPath();
            String path = rawPath.startsWith(contextPath) ? rawPath.substring(contextPath.length()) : rawPath;
            String fullPath = contextPath + path;
    %>
      <img class="thumbnail" src="<%= fullPath %>" alt="썸네일" onclick="goToSlide(<%= i %>)">
    <% } %>
  </div>
  <% } else { %>
    <p>이미지가 없습니다.</p>
  <% } %>

  <p><%= story.getStory_info() %></p>
</div>

<script>
(function() {
  let index = 0;
  const total = <%= imageCount %>;

  function updateSlider() {
    const slider = document.getElementById("imageSlider");
    if (slider) {
      slider.style.transform = "translateX(" + (-600 * index) + "px)";
    }
    updateThumbnailActive();
  }

  window.prevSlide = function() {
    if (index > 0) {
      index--;
      updateSlider();
    }
  };

  window.nextSlide = function() {
    if (index < total - 1) {
      index++;
      updateSlider();
    }
  };

  window.goToSlide = function(i) {
    index = i;
    updateSlider();
  };

  function updateThumbnailActive() {
    const thumbs = document.querySelectorAll(".thumbnail");
    thumbs.forEach((t, i) => {
      if (i === index) t.classList.add("active");
      else t.classList.remove("active");
    });
  }

  updateSlider(); // 초기화
})();
</script>
