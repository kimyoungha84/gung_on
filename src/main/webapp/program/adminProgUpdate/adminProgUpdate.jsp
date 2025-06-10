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

    if (request.getMethod().equalsIgnoreCase("post")) {
    	
    	String uploadPath = "C:/Users/user/git/Gung_On/src/main/webapp/program/images";
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
        
        if (programName != null && !programName.trim().isEmpty()) {
            program = pService.getProgramByName(programName);
        }
        
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
        String progImgName = request.getParameter("progImgName"); */        String contactPerson = multi.getParameter("contactPerson");
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

        int updatedSuccess = pService.updateProgram(programDTO);
        String encodedProgramName = java.net.URLEncoder.encode(programName, "UTF-8").replace("+", "%20");
        String redirectURL = request.getContextPath() + "/program/adminProgDetail/adminProgDetail.jsp?programName=" + encodedProgramName;

        if (updatedSuccess > 0) {
            if (progImgName != null && !progImgName.trim().isEmpty()) {
                FilePathDTO filePathDTO = new FilePathDTO();
                filePathDTO.setPath("/program/images/" + progImgName);
                filePathDTO.setPropertyId(program.getProgramId());
                filePathDTO.setImgName(progImgName);

                FilePathService filePathService = new FilePathService();
                filePathService.updateImagePath(filePathDTO);
            }

            response.sendRedirect(redirectURL);
            return;
        } else {
%>
<script>alert('수정에 실패했습니다.'); history.back();</script>
<%
            return;
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
    <link href="adminProgUpdate.css" rel="stylesheet" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                	<h2 class="mt-4">행사수정</h2>
<!--                     <ol class="breadcrumb mb-4 custom-breadcrumb">
                        <li class="breadcrumb-item active custom-breadcrumb-text">행사수정</li>
                    </ol> -->

<form class="update-form" action="adminProgUpdate.jsp" method="post" enctype="multipart/form-data">
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
            
<%--             <div class="col-12">
                <label for="progImgName" class="form-label">이미지 선택</label>
				<select name="progImgName" id="progImgName" class="form-select">
    				<option value="">-- 이미지 선택 --</option>
			<%
			String currentImgName = (String) request.getAttribute("imgName");
			if (imageFiles != null) {
    			for (File file : imageFiles) {
        			if (file.isFile()) {
            			String fileName = file.getName();
            			String selected = fileName.equals(currentImgName) ? "selected" : "";
			%>
			<option value="<%=fileName%>" <%=selected%>><%=fileName%></option>
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