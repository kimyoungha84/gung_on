<%@page import="kr.co.gungon.cs.FilteringInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="kr.co.gungon.pagination.PaginationBuilder"%>
<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.ticket.admin.TicketAdminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

TicketAdminDTO adminTicketDTO=new TicketAdminDTO();
List<TicketAdminDTO> ticketAdminList=new ArrayList<TicketAdminDTO>();
FilteringInfo fi = new FilteringInfo();
AdminTicketService ats=new AdminTicketService();

ticketAdminList=ats.showDefaultAdminPageData();

pageContext.setAttribute("ticketAdminList", ticketAdminList);



String startDateParam = request.getParameter("startDate");

// 날짜 파싱
Date startDate = null, endDate = null;
try {
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    if (startDateParam != null && !startDateParam.isEmpty()) {
        startDate = new Date(df.parse(startDateParam).getTime());
    }
} catch (Exception e) {
    e.printStackTrace();
}

//--- 페이지네이션 처리 ---
int pageSize = 8;
int rowCounts = ticketAdminList.size();

PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);

int currentPage = paginationBuilder.getCurrentPage();
System.out.println(currentPage);

int startNum=((currentPage-1)*pageSize)+1;
//startNum = rowCounts - ((currentPage - 1) * pageSize);
//int endNum = currentPage * pageSize;
%>