<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String adminId = (String) session.getAttribute("admin_id");
    if (adminId == null) {
        out.println("<script>location.href='adminLoginForm.jsp';</script>");
        return;
    }
%>

<!-- 대시보드 본문 시작 -->
<h1 class="mt-4">대시보드</h1>
<ol class="breadcrumb mb-4">
    <li class="breadcrumb-item active">관리자 홈</li>
</ol>

<div class="row">
    <div class="col-xl-3 col-md-6">
        <div class="card bg-primary text-white mb-4">
            <div class="card-body">오늘 등록된 회원</div>
            <div class="card-footer d-flex align-items-center justify-content-between">
                <a class="small text-white stretched-link" href="#" onclick="loadPage('memberList.jsp')">자세히 보기</a>
                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
            </div>
        </div>
    </div>

    <!-- 다른 카드들도 추가 가능 -->
</div>

<div class="row">
    <div class="col-xl-6">
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-area me-1"></i>
                방문자 통계 (예시)
            </div>
            <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
        </div>
    </div>
    <div class="col-xl-6">
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-chart-bar me-1"></i>
                매출 통계 (예시)
            </div>
            <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
        </div>
    </div>
</div>
<!-- 대시보드 본문 끝 -->
