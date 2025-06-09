<%@page import="kotlin.reflect.jvm.internal.impl.types.model.TypeSystemOptimizationContext"%>
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
AdminTicketService ats=new AdminTicketService();

ticketAdminList=ats.showDefaultAdminPageData();

pageContext.setAttribute("ticketAdminList", ticketAdminList);



//--- 페이지네이션 처리 ---
int pageSize = 5;
int rowCounts = ticketAdminList.size();

PaginationBuilder paginationBuilder = new PaginationBuilder(request, pageSize, rowCounts);

int currentPage = paginationBuilder.getCurrentPage();
System.out.println("currentPage------"+currentPage);

int first=currentPage-1;
int second=first*pageSize;
int third=second+1;

int startNum= third;
int endNum=startNum+pageSize;
/* System.out.println("startNum--------"+startNum);
System.out.println("endNum--------"+endNum);

System.out.println("ticketAdminListSize=="+ticketAdminList.size()); */

List<TicketAdminDTO> pageList=ats.cutList(startNum, endNum, ticketAdminList);
pageContext.setAttribute("pageList", pageList);

%>