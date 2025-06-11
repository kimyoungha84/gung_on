<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.cs.InquiryDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="kr.co.gungon.cs.InquiryFilteringInfo"%>
<%@page import="java.sql.Date"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="application/json; charset=UTF-8" %>

<%
  request.setCharacterEncoding("UTF-8");

request.setCharacterEncoding("UTF-8");

String answerStatusParam = request.getParameter("answerStatus");
String searchText = request.getParameter("searchText");
String searchCategory = request.getParameter("searchCategory");
String startDateStr = request.getParameter("startDate");
String endDateStr = request.getParameter("endDate");
String currentPageParam = request.getParameter("currentPage");
String pageSizeParam = request.getParameter("pageSize");
int currentPage = 0;
int startNum = 0;
int endNum = 0;
int pageSize = 0;



/* if( searchText.equals("null")){
	
	searchText = null;
}
if( startDateStr.equals("null")){
	
	startDateStr = null;
}
if( endDateStr.equals("null")){
	
	endDateStr = null;
}

 */

if (currentPageParam != null && !currentPageParam.isEmpty()){

	
	try{
	currentPage = Integer.parseInt(currentPageParam);
	
	}catch(NumberFormatException nfe){
		nfe.printStackTrace();
	}
}

/* if (startNumParam != null && !startNumParam.isEmpty()){

	
	try{
		startNum = Integer.parseInt(startNumParam);
	
	}catch(NumberFormatException nfe){
		nfe.printStackTrace();
	}
}

if (endNumParam != null && !endNumParam.isEmpty()){

	
	try{
		endNum = Integer.parseInt(endNumParam);
	
	}catch(NumberFormatException nfe){
		nfe.printStackTrace();
	}
}
 */

if (pageSizeParam != null && !pageSizeParam.isEmpty()){

	
	try{
		pageSize = Integer.parseInt(pageSizeParam);
	
	}catch(NumberFormatException nfe){
		nfe.printStackTrace();
	}
}





Boolean answerStatus = null;
if (answerStatusParam != null && !answerStatusParam.isEmpty()) {
    if ("true".equalsIgnoreCase(answerStatusParam) || "Y".equalsIgnoreCase(answerStatusParam)) {
        answerStatus = true;
    } else if ("false".equalsIgnoreCase(answerStatusParam) || "N".equalsIgnoreCase(answerStatusParam)) {
        answerStatus = false;
    }
}

Date startDate = null;
Date endDate = null;


try {
    if (startDateStr != null && !startDateStr.isEmpty()) {
        startDate = Date.valueOf(startDateStr); // 형식: "yyyy-MM-dd"

    }
    if (endDateStr != null && !endDateStr.isEmpty()) {
        endDate = Date.valueOf(endDateStr);
    }
} catch (Exception e) {
    e.printStackTrace();
}




startNum = (currentPage - 1) * pageSize + 1;
endNum = currentPage * pageSize;

	// FilteringInfo 객체 생성 및 값 세팅
	InquiryFilteringInfo ifi = new InquiryFilteringInfo();
	ifi.setAnswerStatus(answerStatus);
	ifi.setSearchText(searchText); 
	ifi.setSearchCategory(searchCategory);
	ifi.setStartDate(startDate);
	ifi.setEndDate(endDate);
	ifi.setCurrentPage(currentPage);
	ifi.setStartNum(startNum);
	ifi.setEndNum(endNum);
	

	// 서비스 호출
	CsService service = new CsService();
	List<InquiryDTO> inquiryList = service.searchInquiry(ifi);
	 
	JSONObject result = new JSONObject(); // 전체 응답 객체
	JSONArray jsonArray = new JSONArray();

	
	
	if (inquiryList != null) {
	    PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, service.totalInquiryCount(ifi));
	    
	    String referer = request.getHeader("referer");
	    String baseUrl = "";

	    if (referer != null) {
	        int questionMarkIndex = referer.indexOf("?");
	        if (questionMarkIndex > -1) {
	            baseUrl = referer.substring(0, questionMarkIndex);
	        } else {
	            baseUrl = referer;
	        }
	    } else {
	        // fallback URL, 예: 현재 JSP 요청 URI
	        baseUrl = request.getRequestURI();
	    }
	    
	 // --- extraParams 생성 ---
	    StringBuilder extraParams = new StringBuilder();

	    if (searchText != null && !searchText.isEmpty()) {
	        extraParams.append("searchText=").append(java.net.URLEncoder.encode(searchText, "UTF-8"));
	    }

	    if (searchCategory != null && !searchCategory.isEmpty()) {
	        if (extraParams.length() > 0) extraParams.append("&");
	        
	        String transParam = searchCategory.equals("inquiry_content") ? "content" : "userId";
	        extraParams.append("searchCategory=").append(transParam);
	    }

	    if (startDateStr != null && !startDateStr.isEmpty()) {
	        if (extraParams.length() > 0) extraParams.append("&");
	        extraParams.append("startDate=").append(startDateStr);
	    }

	    if (endDateStr != null && !endDateStr.isEmpty()) {
	        if (extraParams.length() > 0) extraParams.append("&");
	        extraParams.append("endDate=").append(endDateStr);
	    }

	    if (answerStatusParam != null && !answerStatusParam.isEmpty()) {
	        if (extraParams.length() > 0) extraParams.append("&");
	        extraParams.append("answerStatus=").append(answerStatusParam);
	    }

	    
	    
	    
	    
	    String paginationHtml = paginationBuilder.build(baseUrl, extraParams.toString());

	    for (InquiryDTO idto : inquiryList) {
	        JSONObject obj = new JSONObject();
	        obj.put("inquiry_num", idto.getInquiry_num());
	        obj.put("inquiry_content", idto.getInquiry_content());
	        obj.put("member_id", idto.getMember_id());
	        obj.put("answer_status", idto.isAnswer_status());
	        obj.put("inquiry_regDate", idto.getInquiry_regDate() != null ? idto.getInquiry_regDate().toString() : "");
	        jsonArray.add(obj);
	    }

	    result.put("list", jsonArray);
	    result.put("paginationHtml", paginationHtml);
	} else {
	    result.put("list", new JSONArray());
	    result.put("paginationHtml", "");
	}

	out.print(result.toJSONString());
	out.flush();
%>
