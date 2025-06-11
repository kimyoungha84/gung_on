<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../config/site_config.jsp"%>
<%@ include file="adminProcess/ticket_manage_process.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!-- favicon 설정 -->
<link rel="icon shortcut"  href="/common/images/cs/gungOnFavicon.ico"/>
<meta charset="UTF-8">


<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<!-- 스타일 설정 -->
<link href="/ticket/ticketAdmin/css/ticket_manage_css.css" rel="stylesheet">
<!-- CSS 설정 -->
<link rel="stylesheet" type="text/css" href="/ticket/css/payment.css"/>
<link rel="stylesheet" type="text/css" href="/ticket/css/paymentComplete.css"/>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>
 

<script type="text/javascript">
$(function(){

   $(".wrapTableBody").click(function(){
      $("#bookingNum").val($(this).attr("id"));
      
      $("#tableFrm").submit();
    
         
   });//click
   
   
   $(".datatable-bottom").click(function(){
      
   });

   
});//ready


</script>
<div id="layoutSidenav_content">
<main>
  <div class="container-fluid px-4">
           <h2 class="mt-4">예매 관리</h2>
           <hr/>
<!-- <div class="entireWrap" style="margin-left:300px; margin-top:100px"> -->

<div class="card m-3 entireWrap"><!-- card m-3 start -->
<div class="card-body"><!-- card-body start -->
<h2>예매 목록</h2>
<br>
<div class="">
<form method="POST" id="">
<input class="" placeholder="이름을 입력해주세요" type="search" style="margin-left:20px;" title="wow" />
<input type="button" id="btn" value="검색" class=""/>
</form>
</div>
<br>


<div class="">
 <form action="manage_detail_Frm.jsp" id="tableFrm" method="post">
 <input type="hidden" id="bookingNum" name="bookingNum" value=""/>
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
       <%int cnt=startNum; %>
       <c:forEach var="adminTicketDTO" items="${ pageList }" varStatus="i">
      
         <tr class="wrapTableBody" id="${ adminTicketDTO.booking_num }">
            <td><c:out value="<%=cnt%>"/></td>
            <td><c:out value="${ adminTicketDTO.booking_num }"/></td>
            <td><c:out value="${ adminTicketDTO.member_name }"/></td>
            <td><c:out value="${ adminTicketDTO.member_id }"/></td>
            <td><c:out value="${ adminTicketDTO.total_person }"/></td>
            <td><c:out value="${ adminTicketDTO.phone_number}"/></td>
            <td><c:out value="${ adminTicketDTO.comment_flag }"/></td>
         </tr>
         <% cnt++;%>
    
         
      </c:forEach>
      
      
    </tbody>
</table>
   </form>
      <%//페이지네이션 HTML 생성
      String paginationHtml = paginationBuilder.build(request.getRequestURI());
      %>
      <nav aria-label="Page navigation"><%= paginationHtml %></nav>
    <div class="datatable-bottom" style="display:flex; align-items: center;">
      
   </div>
</div><!-- includeTable -->

<br><br><br><br><br><br><br><br><br>
</div></div>
</main>
<%@ include file="/admin/common/footer.jsp" %>
<!-- </div>entireWrap -->
</div><!-- container-fluid -->

</body>

</html>