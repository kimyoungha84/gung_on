<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.gungon.ticket.admin.TicketAdminDTO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.gungon.ticket.admin.AdminTicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 스타일 설정 -->
<link href="/ticket/ticketAdmin/css/ticket_manage_css.css" rel="stylesheet">
<!-- CSS 설정 -->
<link rel="stylesheet" type="text/css" href="/ticket/css/payment.css"/>
<link rel="stylesheet" type="text/css" href="/ticket/css/paymentComplete.css"/>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>
 
    
    
<%

String id = request.getParameter("id");

AdminTicketService ats=new AdminTicketService();
List<TicketAdminDTO> list=new ArrayList<TicketAdminDTO>();

list=ats.searchById(id);
System.out.println("list------------------"+list);

request.setAttribute("list", list);

%>


<table class="table table-bordered table-hover text-center">
   <thead class="table-light">
        <tr>
            <th>번호</th>
            <th>예매번호</th>
            <th>이름</th>
            <th>아이디</th>
            <th>총 예매 인원</th>
            <th>핸드폰 번호</th>
            <th>해설 선택 여부</th>
        </tr>
    </thead>
    <tbody class="border-start border-end">
       
       <c:forEach var="adminTicketDTO" items="${ list }" varStatus="i">
      
         <tr class="wrapTableBody" id="${ adminTicketDTO.booking_num }">
            <td><c:out value="${i.count }"/></td>
            <td><c:out value="${ adminTicketDTO.booking_num }"/></td>
            <td><c:out value="${ adminTicketDTO.member_name }"/></td>
            <td><c:out value="${ adminTicketDTO.member_id }"/></td>
            <td><c:out value="${ adminTicketDTO.total_person }"/></td>
            <td><c:out value="${ adminTicketDTO.phone_number}"/></td>
            <td><c:out value="${ adminTicketDTO.comment_flag }"/></td>
         </tr>
        
    
         
      </c:forEach>
      
      
    </tbody>
</table>