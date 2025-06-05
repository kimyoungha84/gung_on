<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.program.ProgramService" %>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat"%>

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

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <link href="adminProgDetail.css" rel="stylesheet" />
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
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사상세</li>
                    </ol>

    <% if (program != null) { %>
     	<div class="centered-container">
    		<img src="<%= imgFullPath %>" alt="<%= program.getProgramName() %> 행사 이미지" class="program-detail-img" />
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

	<div class="button-group-center">
    	<button type="button" class="listBtn" onclick="location.href='${pageContext.request.contextPath}/program/adminProgInfo/adminProgInfo.jsp'">목록보기</button>
	</div>
    <% } else { %>
        <div class="alert alert-danger">해당 행사를 찾을 수 없습니다.</div>
    <% } %>
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

</body>
</html>