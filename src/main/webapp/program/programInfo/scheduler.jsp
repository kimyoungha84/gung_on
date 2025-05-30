<%@page import="java.util.Date"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%

    String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
    String dbUser = "scott";
    String dbPass = "2222";

    int reqYear = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : Calendar.getInstance().get(Calendar.YEAR);
    int reqMonth = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : Calendar.getInstance().get(Calendar.MONTH) + 1;

    Calendar cal = Calendar.getInstance();
    cal.set(reqYear, reqMonth - 1, 1);

    int startDay = cal.get(Calendar.DAY_OF_WEEK);
    int lastDay = cal.getActualMaximum(Calendar.DATE);

    Calendar today = Calendar.getInstance();
    int todayYear = today.get(Calendar.YEAR);
    int todayMonth = today.get(Calendar.MONTH) + 1;
    int todayDate = today.get(Calendar.DATE);

    Calendar prevCal = (Calendar) cal.clone();
    prevCal.add(Calendar.MONTH, -1);
    int prevLastDay = prevCal.getActualMaximum(Calendar.DATE);

    Calendar nextCal = (Calendar) cal.clone();
    nextCal.add(Calendar.MONTH, 1);

    int prevMonth = reqMonth - 1;
    int nextMonth = reqMonth + 1;
    int prevYear = reqYear;
    int nextYear = reqYear;

    if (prevMonth < 1) {
        prevMonth = 12;
        prevYear--;
    }
    if (nextMonth > 12) {
        nextMonth = 1;
        nextYear++;
    }

    Set<String> eventDates = new HashSet<>();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

        String sql = "SELECT start_date, end_date FROM program " +
                     "WHERE (start_date <= TO_DATE(?, 'YYYY-MM-DD') AND end_date >= TO_DATE(?, 'YYYY-MM-DD')) " +
                     "OR (start_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')) " +
                     "OR (end_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD'))";

        String monthStart = String.format("%04d-%02d-01", reqYear, reqMonth);
        String monthEnd = String.format("%04d-%02d-%02d", reqYear, reqMonth, lastDay);

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, monthEnd);
        pstmt.setString(2, monthStart);
        pstmt.setString(3, monthStart);
        pstmt.setString(4, monthEnd);
        pstmt.setString(5, monthStart);
        pstmt.setString(6, monthEnd);

        rs = pstmt.executeQuery();

        while(rs.next()) {
            Date startDate = rs.getDate("start_date");
            Date endDate = rs.getDate("end_date");

            Calendar sCal = Calendar.getInstance();
            sCal.setTime(startDate);

            Calendar eCal = Calendar.getInstance();
            eCal.setTime(endDate);

            Calendar iterCal = (Calendar) sCal.clone();
            while(!iterCal.after(eCal)) {
                int y = iterCal.get(Calendar.YEAR);
                int m = iterCal.get(Calendar.MONTH) + 1;
                int d = iterCal.get(Calendar.DAY_OF_MONTH);

                if (y == reqYear && m == reqMonth) {
                    String dateStr = String.format("%04d-%02d-%02d", y, m, d);
                    eventDates.add(dateStr);
                }
                iterCal.add(Calendar.DATE, 1);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 달력</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="scheduler.css">
    <style>

    </style>
</head>
<body>

<div class="nav-buttons">
    <a href="?year=<%= prevYear %>&month=<%= prevMonth %>">←</a>
    <strong><%= reqYear %>년 <%= reqMonth %>월</strong>
    <a href="?year=<%= nextYear %>&month=<%= nextMonth %>">→</a>
</div>

<table>
    <thead>
        <tr>
            <th class="sunday">일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th class="saturday">토</th>
        </tr>
    </thead>
    <tbody>
<%
    int day = 1;
    boolean started = false;
    int nextMonthDay = 1;

    for (int week = 0; week < 6; week++) {
%>
    <tr>
<%
        for (int weekDay = 1; weekDay <= 7; weekDay++) {
            if (!started && weekDay == startDay) started = true;

            String cssClass = "";
            String content = "";
            boolean isBlackCircle = false;

            if (!started) {
                int prevDay = prevLastDay - (startDay - weekDay) + 1;
                cssClass = "gray";
                content = String.valueOf(prevDay);
            } else if (day <= lastDay) {
                boolean isToday = (reqYear == todayYear && reqMonth == todayMonth && todayDate == day);
                boolean isSunday = (weekDay == 1);
                boolean isSaturday = (weekDay == 7);

                if (isSunday) cssClass += " sunday";
                else if (isSaturday) cssClass += " saturday";
                if (isToday) cssClass += " today";

                content = String.valueOf(day);

                String fullDate = String.format("%04d-%02d-%02d", reqYear, reqMonth, day);
                isBlackCircle = eventDates.contains(fullDate);

                day++;
            } else {
                cssClass = "gray";
                content = String.valueOf(nextMonthDay++);
            }
%>
        <td class="<%= cssClass.trim() %><%= (!cssClass.contains("gray")) ? " clickable" : "" %>" 
            <% if (!cssClass.contains("gray")) { %> 
                data-date="<%= reqYear %>-<%= String.format("%02d", reqMonth) %>-<%= content %>"
            <% } %>>
            <%= content %>
            <% if (isBlackCircle) { %>
                <div class="circle blackCircle"></div>
            <% } %>
        </td>
<%
        }
%>
    </tr>
<%
        if (day > lastDay && nextMonthDay > 7) break;
    }
%>
    </tbody>
</table>

<script>
function onDateClick(dateStr) {
    window.parent.postMessage({ type: "dateSelected", date: dateStr }, "*");
  }

$(document).ready(function() {
    $('td.clickable').on('click', function() {
        var dateStr = $(this).data('date');
        onDateClick(dateStr);

    });
});

</script>

</body>
</html>