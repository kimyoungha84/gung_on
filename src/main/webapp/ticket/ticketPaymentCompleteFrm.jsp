<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="결제완료 페이지"%>
<%@include file="ticketProcess/paymentComplete_process.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>결제완료</title>
<c:import url="http://192.168.10.71/Gung_On/common/jsp/header.jsp"/>	

<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.71/Gung_On/common/images/gungOnFavicon.ico"/>

<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>
<!-- CSS 설정 -->
<link rel="stylesheet" type="text/css" href="http://192.168.10.71/Gung_On/ticket/css/payment.css"/>
<link rel="stylesheet" type="text/css" href="http://192.168.10.71/Gung_On/ticket/css/paymentComplete.css"/>
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 
</head>

<body>
    <div class="entireWrap">
    	<h1>결제완료</h1>
        <div class="identifier">
        <span class="titleText">예매정보</span> <span class="titleVal"><%=ticketDTO.getBookingNum() %></span> <span class="titleText">결제일</span> <span  class="titleVal"><%=ticketDTO.getPaymentTimeStamp() %></span>
        </div>
        <br><br>
        <div class="ticketInfoTable">
            <table class="table-bordered" style="width:850px; font-size: 20px; text-align: center; border: 1px solid #9398A2;">
                <thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
                    <tr>
                        <th scope="col">관람</th>
                        <th scope="col">관람 시간</th>
                        <th scope="col">해설 언어</th>
                        <th scope="col">인원</th>
                        <th scope="col">결제 금액</th>
                    </tr>
                </thead>
                <tbody class="border-start border-end" style="height:90px">
                    <tr>
                        <td><%=ticketDTO.getProgramName() %></td>
                        <td><%= date %></td> 
                        <td><%=ticketDTO.getCommentLang() %></td>
                        <td><%=totalPersonStr %><br></td>    
                        <td><%=ticketDTO.getPayment() %>원</td>
                    </tr>

                </tbody>

            </table>
        </div><!--ticketInfoTable-->
       

    <div class="btnGroup">
        <input type="button"  value="확인" class="check">
        
    </div>
	<br>


    </div><!--entireWrap-->
    <c:import url="http://192.168.10.71/Gung_On/common/jsp/footer.jsp"/>
</body>
</html>