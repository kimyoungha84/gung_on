<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.program.ProgramService" %>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String programName = request.getParameter("programName");
    ProgramService pService = new ProgramService();
    ProgramDTO program = pService.getProgramByName(programName);

    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd(E)");
    DecimalFormat formatter = new DecimalFormat("#,###");
    
    int programId = 0;
    if (program != null) {
        programId = program.getProgramId();
    }
    
    FilePathService fps = new FilePathService();
    
    String imgFullPath = fps.getImageFullPath("program", String.valueOf(program.getProgramId()));
    if (imgFullPath == null) {
        imgFullPath = request.getContextPath() + "/images/no-image.png";
    }
    
    String action = request.getParameter("action");
    if ("delete".equals(action)) {
        int deleteResult = 0;
        if (programId > 0) {
            deleteResult = pService.deleteProgram(programId);
        }

        if (deleteResult > 0) {
        	response.sendRedirect(request.getContextPath() + "/program/adminProgInfo/adminProgInfo.jsp");
            return;
        } else {
%>
<script>alert('삭제에 실패했습니다.'); history.back();</script>
<%
            return;
        }
    }
%>
    <link href="adminProgDetail.css" rel="stylesheet" />
    
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                	<h2 class="mt-4 underline-title">상세정보</h2>
<!--                     <ol class="breadcrumb mb-4 custom-breadcrumb">
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사상세</li>
                    </ol> -->

    <% if (program != null) { %>
     	<div class="centered-container">
			<img src="<%= request.getContextPath() + imgFullPath %>?t=<%= System.currentTimeMillis() %>" alt="<%= program.getProgramName() %> 행사 이미지" class="program-detail-img" />
  		</div>
  		
    <table class="table table-bordered">
        <tr>
            <th>행사장소</th>
            <td><%= program.getProgramPlace() %></td>
        </tr>
        <tr>
            <th>행사</th>
            <td><%= program.getProgramName() %></td>
        </tr>
        <tr>
            <th>행사기간</th>
            <td><%= sdf.format(program.getStartDate()) %> ~ <%= sdf.format(program.getEndDate()) %></td>
        </tr>
		<tr>
    		<th>행사시간</th>
    		<td><%= timeFormat.format(program.getOpenTime()) + " ~ " + timeFormat.format(program.getCloseTime()) %></td>
		</tr>
		<tr>
    		<th>성인가격</th>
    		<td><%= formatter.format(program.getPriceAdult()) + "원" %></td>
		</tr>
		<tr>
    		<th>아동가격</th>
    		<td><%= formatter.format(program.getPriceChild()) + "원" %></td>
		</tr>
		<tr>
    		<th>해설언어</th>
    		<td>
        	<% if ("ko".equals(program.getLanguageKorean())) { %>
            	한국어
        	<% } else if ("en".equals(program.getLanguageKorean())) { %>
            	영어
        	<% } else { %>
            	없음
        	<% } %>
    		</td>
		</tr>
		<tr>
            <th>담당자</th>
            <td><%= program.getContactPerson() %></td>
        </tr>
    </table>
    
	<div class="button-group-right">
    	<form action="${pageContext.request.contextPath}/program/adminProgUpdate/adminProgUpdate.jsp" method="get">
        	<input type="hidden" name="programName" value="<%= program.getProgramName() %>" />
        	<button type="submit" class="updateBtn">수정</button>
    	</form>

    	<form method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
        	<input type="hidden" name="programId" value="<%= program.getProgramId() %>" />
        	<input type="hidden" name="action" value="delete" />
        	<button type="submit" class="deleteBtn">삭제</button>
    	</form>
	</div>
<% } %>

	<div class="button-group-center">
    	<button type="button" class="listBtn" onclick="location.href='${pageContext.request.contextPath}/program/adminProgInfo/adminProgInfo.jsp'">목록보기</button>
	</div>

				</div>
            </main>
<%@ include file="/admin/common/footer.jsp" %>
		</div>

</body>
</html>