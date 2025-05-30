<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    StoryService service = new StoryService();
    StoryDTO story = service.getStoryByName(name);
    System.out.println("[g_story.jsp] 받은 name : " + name);
%>

<% if (story != null) { %>
    <div class="story-container">
        <h2><%= story.getStory_name() %></h2>
        <% if (story.getStory_img() != null && !story.getStory_img().isEmpty()) { %>
        <img src="<%= request.getContextPath() %>/test/image/<%= story.getStory_img() %>.jpg"
     alt="<%= story.getStory_name() %>" style="max-width:100%;" />
        
        <% } %>
        <p><%= story.getStory_info() %></p>
    </div>
<% } else { %>
    <p>해당 궁에 대한 정보가 없습니다.</p>
<% } %>