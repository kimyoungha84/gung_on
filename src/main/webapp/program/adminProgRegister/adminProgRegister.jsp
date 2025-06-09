<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.gungon.file.FilePathDTO"%>
<%@page import="kr.co.gungon.file.FilePathService"%>
<%@page import="kr.co.gungon.program.ProgramDTO"%>
<%@page import="kr.co.gungon.program.ProgramService"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	
    	String uploadPath = "C:/Users/user/git${pageContext.request.contextPath}/src/main/webapp/program/images";
    	int maxSize = 10 * 1024 * 1024; // 최대 10MB

    	MultipartRequest multi = new MultipartRequest(
    	    request,
    	    uploadPath,
    	    maxSize,
    	    "UTF-8",
    	    new DefaultFileRenamePolicy()
    	);
    	
/*         String programPlace = request.getParameter("programPlace");
        String programName = request.getParameter("programName");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String openTimeStr = request.getParameter("openTime");
        String closeTimeStr = request.getParameter("closeTime");
        String priceAdultStr = request.getParameter("priceAdult");
        String priceChildStr = request.getParameter("priceChild");
        String language = request.getParameter("languageKorean"); */
        
        String programPlace = multi.getParameter("programPlace");
        String programName = multi.getParameter("programName");
        String startDateStr = multi.getParameter("startDate");
        String endDateStr = multi.getParameter("endDate");
        String openTimeStr = multi.getParameter("openTime");
        String closeTimeStr = multi.getParameter("closeTime");
        String priceAdultStr = multi.getParameter("priceAdult");
        String priceChildStr = multi.getParameter("priceChild");
        String language = multi.getParameter("languageKorean");
        
        if (language == null || language.trim().isEmpty()) {
            language = "no";
        }
        
/*         String contactPerson = request.getParameter("contactPerson");
        String progImgName = request.getParameter("progImgName"); */
        String contactPerson = multi.getParameter("contactPerson");
        String progImgName = null;
        
        File file = multi.getFile("progImgFile");
        if (file != null) {
            progImgName = file.getName();
        }

        // 숫자 타입 파싱
        int priceAdult = 0;
        int priceChild = 0;
        
        try {
            if (priceAdultStr != null && !priceAdultStr.trim().isEmpty()) {
                priceAdult = Integer.parseInt(priceAdultStr);
            }
            if (priceChildStr != null && !priceChildStr.trim().isEmpty()) {
                priceChild = Integer.parseInt(priceChildStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Date startDate = null;
        Date endDate = null;

        try {
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
            }
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);
            }
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }

        // 시간 파싱
        Timestamp openTime = null;
        Timestamp closeTime = null;
        
        try {
            if (openTimeStr != null && !openTimeStr.trim().isEmpty()) {
                Date dt = new SimpleDateFormat("HH:mm").parse(openTimeStr);
                openTime = new Timestamp(dt.getTime());
            }
            if (closeTimeStr != null && !closeTimeStr.trim().isEmpty()) {
                Date dt = new SimpleDateFormat("HH:mm").parse(closeTimeStr);
                closeTime = new Timestamp(dt.getTime());
            }
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }

        ProgramDTO programDTO = new ProgramDTO();

        programDTO.setProgramPlace(programPlace);
        programDTO.setProgramName(programName);
        if (startDate != null) {
            programDTO.setStartDate(new java.sql.Date(startDate.getTime()));
        }
        if (endDate != null) {
            programDTO.setEndDate(new java.sql.Date(endDate.getTime()));
        }
        programDTO.setOpenTime(openTime);
        programDTO.setCloseTime(closeTime);
        programDTO.setPriceAdult(priceAdult);
        programDTO.setPriceChild(priceChild);
        programDTO.setLanguageKorean(language);
        programDTO.setContactPerson(contactPerson);
        
        ProgramService programService = new ProgramService();
        
        try {
            int result = programService.insertProgram(programDTO);
            if (result > 0) {
                if (progImgName != null && !progImgName.trim().isEmpty()) {
                    FilePathDTO filePathDTO = new FilePathDTO();
                    filePathDTO.setPath("${pageContext.request.contextPath}/program/images/" + progImgName);
                    filePathDTO.setTargerType("program");
                    filePathDTO.setTargerNumber(String.valueOf(programDTO.getProgramId()));
                    filePathDTO.setImgName(progImgName);

                    FilePathService filePathService = new FilePathService();
                    filePathService.insertImagePath(filePathDTO);
                }

                response.sendRedirect(request.getContextPath() + "/program/adminProgInfo/adminProgInfo.jsp");
                return;
            } else {
%>
                <div class="alert alert-danger">행사 등록 실패</div>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <div class="alert alert-danger">오류 발생: <%= e.getMessage() %></div>
<%
        }
    }

/*     String imagesPath = application.getRealPath("/program/images");
    System.out.println("이미지 경로 확인: " + imagesPath);

    File folder = new File(imagesPath);
    File[] imageFiles = folder.listFiles();

    if(imageFiles != null){
        for(File file : imageFiles){
            System.out.println("파일: " + file.getName());
        }
    } */
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
    <link href="adminProgRegister.css" rel="stylesheet" />
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
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사등록</li>
                    </ol>

<form action="adminProgRegister.jsp" method="post" enctype="multipart/form-data">
    <div class="card p-4">
        <div class="row g-2">
            <div class="col-md-6">
                <label for="programPlace" class="form-label">행사장소</label>
                <input type="text" class="form-control" id="programPlace" name="programPlace" required>
            </div>
            <div class="col-md-6">
                <label for="programName" class="form-label">행사</label>
                <input type="text" class="form-control" id="programName" name="programName" required>
            </div>

			<div class="col-md-12">
    			<label class="form-label">행사기간</label>
    		<div class="d-flex align-items-center">
        		<input type="date" class="form-control me-2" id="startDate" name="startDate" required>
        			<span class="mx-2">~</span>
        		<input type="date" class="form-control ms-2" id="endDate" name="endDate" required>
    		</div>
			</div>

			<div class="col-md-12">
    			<label class="form-label">행사시간</label>
    		<div class="d-flex align-items-center">
        		<input type="time" class="form-control me-2" id="openTime" name="openTime" required>
        			<span class="mx-2">~</span>
        		<input type="time" class="form-control ms-2" id="closeTime" name="closeTime" required>
    		</div>
			</div>

            <div class="col-md-6">
                <label for="priceAdult" class="form-label">성인 가격</label>
                <input type="number" class="form-control" id="priceAdult" name="priceAdult" step="500" required>
            </div>
            <div class="col-md-6">
                <label for="priceChild" class="form-label">아동 가격</label>
                <input type="number" class="form-control" id="priceChild" name="priceChild" step="500" required>
            </div>

            <div class="col-md-6">
                <label class="form-label d-block">해설언어</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="languageKorean" id="languageKorean" value="ko" onclick="toggleRadio(this)">
                    <label class="form-check-label" for="languageKorean">한국어</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="languageKorean" id="languageKorean" value="en" onclick="toggleRadio(this)">
                    <label class="form-check-label" for="languageEnglish">영어</label>
                </div>
            </div>

            <div class="col-md-6">
                <label for="contactPerson" class="form-label">담당자</label>
                <input type="text" class="form-control" id="contactPerson" name="contactPerson" required>
            </div>

<%--            <div class="col-12">
                <label for="progImgName" class="form-label">이미지 선택</label>
                <select name="progImgName" id="progImgName" class="form-select">
                    <option value="">-- 이미지 선택 --</option>
                    <%
                        if(imageFiles != null){
                            for(File file : imageFiles){
                                if(file.isFile()){
                                    String fileName = file.getName();
                    %>
                                    <option value="<%=fileName%>"><%=fileName%></option>
                    <%
                                }
                            }
                        }
                    %>
                </select>
            </div> --%>
            
            <div class="col-12">
    			<label for="progImgFile" class="form-label">이미지 업로드</label>
    			<input type="file" class="form-control" name="progImgFile" id="progImgFile" accept="image/*">
			</div>

            <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="registerBtn" onclick="return confirm('정말 등록하시겠습니까?')">확인</button>
                <button class="cancelBtn" onclick="history.back()">취소</button>
            </div>
        </div>
    </div>
</form>
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
let lastChecked = null;

function toggleRadio(radio) {
    if (lastChecked === radio) {
        radio.checked = false;
        lastChecked = null;
    } else {
        lastChecked = radio;
    }
}
</script>

</body>
</html>