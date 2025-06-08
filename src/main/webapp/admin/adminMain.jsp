<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h1 class="mt-4">관리자 대시보드</h1>
            <hr />

            <!-- 여기부터 콘텐츠 영역 -->
            <jsp:include page="/dashboard/dashboard.jsp" />
            <!-- 또는 직접 작성해도 됨 -->
        </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>