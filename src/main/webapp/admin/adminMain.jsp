<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">대시보드</h2>
            <hr/>

            <!-- 여기부터 콘텐츠 영역 -->
            <jsp:include page="${pageContext.request.contextPath}/dashboard/dashboard.jsp" />
        </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>