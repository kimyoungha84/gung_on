<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.story.StoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.co.gungon.story.StoryDTO"%>
<%@page import="kr.co.gungon.story.StoryService"%>
<%@ page import="java.util.List" %>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");
  String keyword = request.getParameter("keyword");
  StoryService service = new StoryService();
  List<StoryDTO> storyList = null;

  if (keyword != null && !keyword.trim().isEmpty()) {
      storyList = service.searchStoryByKeyword(keyword.trim());
  } else {
      storyList = service.selectAllStory();
  }
%>

<%
    

    StoryDAO dao = StoryDAO.getInstance();
    int rowCount = dao.getStoryCount(); // 전체 전각 수
    int pageSize = 10; // 페이지 당 전각 수

    kr.co.gungon.pagination.PaginationBuilder pagination =
        new PaginationBuilder(request, pageSize, rowCount);

    int start = (pagination.getCurrentPage() - 1) * pageSize + 1;
    int end = pagination.getCurrentPage() * pageSize;

    List<StoryDTO> StoryList = null;
    if (keyword != null && !keyword.trim().isEmpty()) {
        storyList = dao.searchStoryList(keyword.trim(), start, end); // 이 메서드 만들어야 함
    } else {
        storyList = dao.getStoryList(start, end);
    }
%>


<div id="layoutSidenav_content">
<main>
<div class="container-fluid px-4">
<h2 class="mt-4">궁 관리</h2>
<hr/>

  <div class="card m-3">
  <div class="card-body">
  <h2>이야기 목록</h2>
  </div>

  <!-- ✅ 검색 폼 -->
  <form method="get" action="story_list.jsp" class="row mb-3">
    <div class="col-md-4">
      <input type="text" name="keyword" class="form-control" placeholder="제목 검색" value="<%= keyword != null ? keyword : "" %>">
    </div>
    <div class="col-md-2">
      <button type="submit" class="btn btn-outline-primary">검색</button>
    </div>
    <div class="col-md-6 text-end">
      <button onclick="location.href='story_register.jsp'" type="button" class="btn btn-primary">+ 이야기 등록</button>
    </div>
  </form>

  <!-- ✅ 이야기 목록 테이블 -->
  <table class="table table-bordered table-hover">
    <thead class="table-light">
      <tr>
        <th>No.</th>
        <th>궁 이름</th>
        <th>제목</th>
        <th>등록일</th>
      </tr>
    </thead>
    <tbody>
      <%
        int no = 1;
        for (StoryDTO dto : storyList) {
      %>
      <tr onclick="location.href='story_detail.jsp?id=<%= dto.getStory_id() %>'" style="cursor:pointer;">
        <td><%= no++ %></td>
        <td><%= dto.getGung_name() %></td>
        <td><%= dto.getStory_name() %></td>
        <td><%= dto.getStory_reg_date() %></td>
      </tr>
      <%
        }
        if (storyList.size() == 0) {
      %>
      <tr>
        <td colspan="4" class="text-center">검색 결과가 없습니다.</td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>
        <!-- 페이지네이션 표시 -->
            <div>
            	<%= pagination.build("story_list.jsp") %>
            </div>
        </div>
        </div><!-- card m-3 end -->

</main>
<%@ include file="/admin/common/footer.jsp" %>
</div>
