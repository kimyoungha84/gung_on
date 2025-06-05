<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="kr.co.gungon.program.ProgramService" %>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.gungon.pagination.PaginationBuilder" %>

<%
    String searchPlace = request.getParameter("placeSearchInput");
    if (searchPlace == null) {
        searchPlace = "";
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
    ProgramService pService = new ProgramService();
    
    int pageSize = 7;
    int totalCount = pService.getTotalCount(searchPlace);
    
    PaginationBuilder pb = new PaginationBuilder(request, pageSize, totalCount);
    
    int currentPage = pb.getCurrentPage();
    
    ArrayList<ProgramDTO> program = pService.getAllPrograms();
    List<ProgramDTO> programList = pService.getProgramsByPage(currentPage, pageSize, searchPlace);
    
    int startNo = totalCount - (currentPage - 1) * pageSize;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <link href="adminProgInfo.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="sb-nav-fixed">

    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand ps-3" href="adminMain.jsp">
            <img src="${pageContext.request.contextPath}/img/logo.png" class="logo">
        </a>
    </nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">관리자 메뉴</div>

                            <a class="nav-link" href="adminMain.jsp">
                                대시보드
                            </a>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                궁 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="#">세부메뉴 1</a>
                                    <a class="nav-link" href="#">세부메뉴 2</a>
                                </nav>
                            </div>

							<a class="nav-link active" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2"
   							   aria-expanded="true" aria-controls="collapseLayouts2">
   							    행사 관리
							</a>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts3" aria-expanded="false" aria-controls="collapseLayouts3">
                                예약 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts3" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="#">세부메뉴 1</a>
                                    <a class="nav-link" href="#">세부메뉴 2</a>
                                </nav>
                            </div>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts4" aria-expanded="false" aria-controls="collapseLayouts4">
                                관람 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts4" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="#">세부메뉴 1</a>
                                    <a class="nav-link" href="#">세부메뉴 2</a>
                                </nav>
                            </div>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts5" aria-expanded="false" aria-controls="collapseLayouts5">
                                회원 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts5" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="memberList.jsp"onclick="loadPage('${pageContext.request.contextPath}/admin/memberList.jsp')">회원 목록</a>
                                    <a class="nav-link" href="#">세부메뉴 2</a>
                                </nav>
                            </div>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts6" aria-expanded="false" aria-controls="collapseLayouts6">
                                고객센터 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts6" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="#">세부메뉴 1</a>
                                    <a class="nav-link" href="#">세부메뉴 2</a>
                                </nav>
                            </div>

                        </div>
                </div>
                <div class="sb-sidenav-footer">
                    <div class="small">Logged in as:</div>
                    관리자
                </div>
            </nav>
        </div>

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <ol class="breadcrumb mb-4 custom-breadcrumb">
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사목록</li>
                    </ol>

                    <form method="get" action="adminProgInfo.jsp">
                        <input class="form-control search-place-input" type="text" name="placeSearchInput"
                               value="<%= searchPlace %>" placeholder="행사장소 검색"
                               onkeydown="submitOnEnter(event)" />
                    </form>

                    <table class="event-table">
                        <thead>
                            <tr>
                                <th class="col-no">No.</th>
                                <th class="col-name">행사</th>
                                <th class="col-place">행사장소</th>
                                <th class="col-period">행사기간</th>
                                <th class="col-contact">담당자</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (programList != null && !programList.isEmpty()) {
                                    int count = 0;
                                    for (ProgramDTO p : programList) {
                                        int displayNo = startNo - count;
                            %>
                                <tr onclick="goToDetail('<%= p.getProgramName() %>')" style="cursor: pointer;">
                                    <td><%= p.getProgramId() %></td>
                                    <td><%= p.getProgramName() %></td>
                                    <td><%= p.getProgramPlace() %></td>
                                    <td><%= sdf.format(p.getStartDate()) %> ~ <%= sdf.format(p.getEndDate()) %></td>
                                    <td><%= p.getContactPerson() %></td>
                                </tr>
                            <%
                                        count++;
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="5">등록된 행사가 없습니다.</td>
                                </tr>
                            <%
                                }
                                String paginationHtml = pb.build(request.getRequestURI());
                            %>
                        </tbody>
                    </table>

                    <nav aria-label="Page navigation">
                        <%= paginationHtml %>
                    </nav>

                    <div class="button-container mt-3">
                        <button class="registerBtn" type="button" onclick="location.href='../adminProgRegister/adminProgRegister.jsp'">등록</button>
                    </div>
                </div>
            </main>

            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2023</div>
                        <div>
                            <a href="#">Privacy Policy</a>
                            &middot;
                            <a href="#">Terms &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/assets/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>

    <script>
        function goToDetail(programName) {
            location.href = '../adminProgDetail/adminProgDetail.jsp?programName=' + encodeURIComponent(programName);
        }

        function submitOnEnter(e) {
            if (e.key === "Enter") {
                e.preventDefault();
                e.target.form.submit();
            }
        }
    </script>

</body>
</html>