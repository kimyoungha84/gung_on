<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
  request.setCharacterEncoding("UTF-8");

  String bookingNum = request.getParameter("booking_num");
  TicketService ts = new TicketService();

  int result = ts.remove(bookingNum);  // 예약 삭제 처리

  if (result > 0) {
%>
    <script>
      alert("예약이 성공적으로 취소되었습니다.");
      location.href = "<%= request.getContextPath() %>/mypage/mypage.jsp"; // 돌아갈 페이지
    </script>
<%
  } else {
%>
    <script>
      alert("예약 취소에 실패했습니다. 이미 취소되었거나 잘못된 요청입니다.");
      history.back();
    </script>
<%
  }
%>
