<%@page import="kr.co.gungon.cs.CsService"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
request.setCharacterEncoding("UTF-8");

// 클라이언트에서 전송된 JSON 문자열을 받는다
String noticeNumListJson = request.getParameter("noticeNumList");

// JSON 문자열을 JSONArray로 파싱
JSONArray jsonArr = (JSONArray) new org.json.simple.parser.JSONParser().parse(noticeNumListJson);

// JSONArray를 List<Integer>로 변환
List<Integer> noticeNumList = new ArrayList<>();
for (Object obj : jsonArr) {
    noticeNumList.add(Integer.parseInt(obj.toString()));
}

// 서비스 호출 (예: CsService의 deleteNotices 메서드)
CsService css = new CsService();
boolean result = css.removeNotices(noticeNumList);

JSONObject responseJson = new JSONObject();
if (result) {
    responseJson.put("status", "success");
} else {
    responseJson.put("status", "failure");
    responseJson.put("message", "삭제 실패");
}

// 응답 보내기
response.setContentType("application/json; charset=UTF-8");
response.getWriter().write(responseJson.toJSONString());
%>
