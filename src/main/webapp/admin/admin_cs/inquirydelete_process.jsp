<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
request.setCharacterEncoding("UTF-8");

String inquiryNumListJson = request.getParameter("inquiryNumList");

JSONArray jsonArr = (JSONArray) new org.json.simple.parser.JSONParser().parse(inquiryNumListJson);

List<Integer> inquiryNums = new ArrayList<>();
for (Object obj : jsonArr) {
	inquiryNums.add(Integer.parseInt(obj.toString()));
}

CsService css = new CsService();
boolean result = css.removeInquiries(inquiryNums);

JSONObject responseJson = new JSONObject();
if (result) {
    responseJson.put("status", "success");
} else {
    responseJson.put("status", "failure");
    responseJson.put("message", "삭제실패");
}

response.setContentType("application/json; charset=UTF-8");
response.getWriter().write(responseJson.toJSONString());
%>
