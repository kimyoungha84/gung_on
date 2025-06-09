<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String storyName = request.getParameter("name");
    FilePathService fps = new FilePathService();
    List<FilePathDTO> imageList = fps.getStoryImagesByName("story", storyName);
%>

<style>
  .slider-container {
    position: relative;
    width: 600px;
    height: 400px;
    overflow: hidden;
    margin: 20px auto;
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

<% if (imageList != null && !imageList.isEmpty()) { %>
<div class="slider-container">
  <div class="slider-images" id="imageSlider">
    <% for (FilePathDTO img : imageList) { 
         String fullPath = img.getPath() + "/" + img.getImgName();
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
