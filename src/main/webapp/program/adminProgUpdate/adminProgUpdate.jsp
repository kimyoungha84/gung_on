<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.gungon.program.ProgramService" %>
<%@ page import="kr.co.gungon.program.ProgramDTO" %>
<%@ page import="kr.co.gungon.file.FilePathService" %>
<%@ page import="kr.co.gungon.file.FilePathDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.net.URLEncoder"%>
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

	ProgramService pService = new ProgramService();
	ProgramDTO program = null;

	if (request.getMethod().equalsIgnoreCase("get")) {
		
    	String programName = request.getParameter("programName");
    	
    	if (programName != null && !programName.trim().isEmpty()) {
        	program = pService.getProgramByName(programName);
    	}
	}
	
	FilePathService fps = new FilePathService();
	
	String imgFullPath = null;
	if (program != null) {
	    imgFullPath = fps.getImageFullPath("program", String.valueOf(program.getProgramId()));
	}
	if (imgFullPath == null) {
	    imgFullPath = request.getContextPath() + "/images/no-image.png"; // 대체 이미지 경로
	}

    if (request.getMethod().equalsIgnoreCase("post")) {
    	
    	String programPlace = request.getParameter("programPlace");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String openTimeStr = request.getParameter("openTime");
        String closeTimeStr = request.getParameter("closeTime");
        String priceAdultStr = request.getParameter("priceAdult");
        String priceChildStr = request.getParameter("priceChild");
        
        String programName = request.getParameter("programName");        
        if (programName != null && !programName.trim().isEmpty()) {
            program = pService.getProgramByName(programName);
        }
        
        String language = request.getParameter("languageKorean");        
        if (language == null || language.trim().isEmpty()) {
            language = "no";
        }
        
        String contactPerson = request.getParameter("contactPerson");
        String progImgName = request.getParameter("progImgName");

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

        int updatedSuccess = pService.updateProgram(programDTO);
        String encodedProgramName = java.net.URLEncoder.encode(programName, "UTF-8").replace("+", "%20");
        String redirectURL = request.getContextPath() + "/program/adminProgDetail/adminProgDetail.jsp?programName=" + encodedProgramName;

        if (updatedSuccess > 0) {
            response.sendRedirect(redirectURL);
            return;
            
        } else {
%>
<script>alert('수정에 실패했습니다.'); history.back();</script>
<%
            return;
        }
    }
%>
    <link href="adminProgUpdate.css" rel="stylesheet" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                	<h2 class="mt-4 underline-title">행사수정</h2>

<form class="update-form" method="post">
    <div class="card p-4">
        <div class="row g-2">
            <div class="col-md-6">
                <label for="programName" class="form-label">행사</label>
                <input type="text" class="form-control" id="programName" name="programName" value="<%= program.getProgramName() %>" readonly>
            </div>
            <div class="col-md-6">
                <label for="programPlace" class="form-label">행사장소</label>
                <input type="text" class="form-control" id="programPlace" name="programPlace" value="<%= program.getProgramPlace() %>" required>
            </div>

            <div class="col-md-12">
                <label class="form-label">행사기간</label>
                <div class="d-flex align-items-center">
                    <input type="date" class="form-control me-2" id="startDate" name="startDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(program.getStartDate()) %>" required>
                    <span class="mx-2">~</span>
                    <input type="date" class="form-control ms-2" id="endDate" name="endDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(program.getEndDate()) %>" required>
                </div>
            </div>

            <div class="col-md-12">
                <label class="form-label">행사시간</label>
                <div class="d-flex align-items-center">
                    <input type="time" class="form-control me-2" id="openTime" name="openTime" value="<%= new java.text.SimpleDateFormat("HH:mm").format(program.getOpenTime()) %>" required>
                    <span class="mx-2">~</span>
                    <input type="time" class="form-control ms-2" id="closeTime" name="closeTime" value="<%= new java.text.SimpleDateFormat("HH:mm").format(program.getCloseTime()) %>" required>
                </div>
            </div>

            <div class="col-md-6">
                <label for="priceAdult" class="form-label">성인 가격</label>
                <input type="number" class="form-control" id="priceAdult" name="priceAdult" value="<%= program.getPriceAdult() %>" required>
            </div>
            <div class="col-md-6">
                <label for="priceChild" class="form-label">아동 가격</label>
                <input type="number" class="form-control" id="priceChild" name="priceChild" value="<%= program.getPriceChild() %>" required>
            </div>

            <div class="col-md-6">
                <label class="form-label d-block">해설언어</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="languageKorean" id="languageKorean" value="ko" <%= "ko".equals(program.getLanguageKorean()) ? "checked" : "" %> onclick="toggleRadio(this)" >
                    <label class="form-check-label" for="languageKorean">한국어</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="languageKorean" id="languageKorean" value="en" <%= "en".equals(program.getLanguageKorean()) ? "checked" : "" %> onclick="toggleRadio(this)" >
                    <label class="form-check-label" for="languageEnglish">영어</label>
                </div>
            </div>

            <div class="col-md-6">
                <label for="contactPerson" class="form-label">담당자</label>
                <input type="text" class="form-control" id="contactPerson" name="contactPerson" value="<%= program.getContactPerson() %>" required>
            </div>

            <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="updateBtn" onclick="return confirm('정말 수정하시겠습니까?')">확인</button>
                <button type="button" class="cancelBtn" onclick="history.back()">취소</button>
            </div>
			
			<div class="col-12">
    			<label class="form-label">행사 이미지</label><br>
    			<img src="<%= request.getContextPath() + imgFullPath %>" alt="<%= program.getProgramName() %> 행사 이미지" style="max-width: 300px; height: auto;" />
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
</script>
</body>
</html>