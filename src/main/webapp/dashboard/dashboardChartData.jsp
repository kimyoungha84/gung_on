<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, kr.co.gungon.admin.AdminDashboardService" %>

<%
    AdminDashboardService service = new AdminDashboardService();
    Map<String, Integer> chartData = service.getReservationChartData();

    StringBuilder json = new StringBuilder();
    json.append("{");
    json.append("\"labels\":[");

    Iterator<String> keyIt = chartData.keySet().iterator();
    while (keyIt.hasNext()) {
        String key = keyIt.next();
        json.append("\"").append(key.replace("\"", "\\\"")).append("\"");
        if (keyIt.hasNext()) json.append(",");
    }
    json.append("],");

    json.append("\"data\":[");
    Iterator<Integer> valIt = chartData.values().iterator();
    while (valIt.hasNext()) {
        json.append(valIt.next());
        if (valIt.hasNext()) json.append(",");
    }
    json.append("]}");

    out.print(json.toString());
%>