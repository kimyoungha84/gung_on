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
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	
    	String uploadPath = application.getRealPath("/program/images");
    	int maxSize = 10 * 1024 * 1024; // 최대 10MB

    	MultipartRequest multi = new MultipartRequest(
    	    request,
    	    uploadPath,
    	    maxSize,
    	    "UTF-8",
    	    new DefaultFileRenamePolicy()
    	);
        
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
                    filePathDTO.setPath("/program/images/" + progImgName);
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
%>
    <link href="adminProgRegister.css" rel="stylesheet" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                	<h2 class="mt-4 underline-title">행사등록</h2>

<form class="register-form" action="adminProgRegister.jsp" method="post" enctype="multipart/form-data">
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
            
            <div class="col-12">
				<label for="progImgFile" class="form-label">이미지 업로드</label>
                <input type="file" class="form-control" name="progImgFile" id="progImgFile" accept="image/*" onchange="previewImage(event)">
                <img id="preview" style="max-width: 200px; margin-top: 10px;" />
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
<%@ include file="/admin/common/footer.jsp" %>
		</div>

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

function previewImage(event) {
    const preview = document.getElementById('preview');
    preview.src = URL.createObjectURL(event.target.files[0]);
}
</script>

</body>
</html>