<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.admin.DashboardInfoDTO" %>
<%@ page import="kr.co.gungon.admin.AdminDashboardService" %>

<%
    String adminId = (String) session.getAttribute("admin_id");
    if (adminId == null) {
        response.sendRedirect("../adminLoginForm.jsp");
        return;
    }

    AdminDashboardService service = new AdminDashboardService();
    DashboardInfoDTO info = service.getDashboardInfo();
%>



<div class="row">
    <!-- 회원 현황 -->
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">회원 현황</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">전체 회원</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getTotalMembers() %>명</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">탈퇴 회원</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getWithdrawnMembers() %>명</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">오늘 가입자</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getTodayJoinMembers() %>명</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 고객센터 현황 -->
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header bg-success text-white">
                <h5 class="mb-0">고객센터(CS) 현황</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">공지사항</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getNoticeCount() %>건</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">미답변 문의</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getUnansweredCount() %>건</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light mb-3">
                            <div class="card-header">답변 완료 문의</div>
                            <div class="card-body text-center">
                                <h4 class="card-title"><%= info.getAnsweredCount() %>건</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 행사별 예매 현황 -->
<div class="card mb-4">
    <div class="card-header bg-info text-white">
        <h5 class="mb-0">행사별 예매 현황</h5>
    </div>
    <div class="card-body">
        <canvas id="programChart" height="80"></canvas>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    fetch("<%= request.getContextPath() %>/dashboard/dashboardChartData.jsp")
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById("programChart").getContext("2d");
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: '총 예매 수',
                        data: data.data,
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1,
                        borderRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        yAxes: [{
                            display: false, // y축 눈금 제거
                            gridLines: { display: false }
                        }],
                        xAxes: [{
                            gridLines: { display: false }
                        }]
                    },
                    plugins: {
                        datalabels: {
                            anchor: 'end',
                            align: 'end',
                            color: '#000',
                            font: {
                                weight: 'bold'
                            },
                            formatter: function(value) {
                                return value + '건';
                            }
                        }
                    },
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.yLabel + "건";
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels]
            });
        })
        .catch(err => {
            console.error("차트 로드 실패:", err);
        });
});
</script>