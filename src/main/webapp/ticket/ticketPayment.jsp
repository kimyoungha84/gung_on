<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="My 예매정보 페이지"%>
<%@ include file="config/site_config.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="ticketProcess/payment_process.jsp" %>

<!DOCTYPE html>
<html>
<head>
<!-- favicon 설정 -->
<link rel="icon shortcut"  href="common/images/cs/gungOnFavicon.ico"/>

<title>내 예매정보</title>
<c:import url="/common/jsp/header.jsp"/>	


<!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>
<!-- CSS 설정 -->
<link rel="stylesheet" type="text/css" href="/ticket/css/payment.css"/>
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script src="/ticket/js/payment.js" type="text/javascript"></script>
</head>

<body>
    <div class="entireWrap">
    <div class="myTicketInfo"><span style="margin-left:150px; margin-top:100px;">My 예매정보</span></div>
        <div class="ticketInfoTable">
            <table class="table-bordered" style="width:850px; font-size: 20px; text-align: center; border: 1px solid #9398A2;">
                <thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
                    <tr style="background:#ECECEC">
                        <th scope="col">관람</th>
                        <th scope="col">관람 시간</th>
                        <th scope="col">해설 언어</th>
                        <th scope="col">인원</th>
                        <th scope="col">결제 금액</th>
                    </tr>
                </thead>
                <tbody class="border-start border-end" style="height:90px">
                    <tr>
                        <td><%=tDTO.getProgramName() %></td>
                        <td><%=chooseDate %></td> 
                        <td><%=tDTO.getCommentLang() %></td>
                        <td><%=personString %><br></td>    
                        <td><%=tDTO.getPayment() %>원</td>
                    </tr>

                </tbody>

            </table>
        </div><!--ticketInfoTable-->
        <br><br>
      
 		<div style="margin-left:250px;">QR 코드 링크를 받을 핸드폰 번호를 입력해주세요.</div>
  	<form id="authFrm" style="margin-left:250px">
  	
	<input type="text" name="authenPhoneNum" id="authenPhoneNum" class="authDesign" placeholder="핸드폰 번호를 입력해주세요."/>
	<input type="button" id="authenBtn" style="display:block; margin-left:10px; margin-top:5px;" class="authDesign" value="인증"/>
	
	<input type="text" id="checkNum" class="authChk authDesign" placeholder="인증번호를 입력해주세요." style="display:none"/>
	<input type="button" id="checkBtn" class="authChk authDesign"  value="확인" style="display:none;margin-left:10px; margin-top:5px;"/>
	<input type="text" readonly id="completAuthen" class="authDesign" value="인증완료" style="display:none"/>
	</form>
	<br><br><br>
	<div style="display:flex">
	<form id="calcFrm" action="/ticket/ticketProcess/ticket_calc_procss.jsp" method="post">
	    <div class="btnGroup">
	        <input type="button" id="moneyCalc" value="결제하기" class="money" />
	        <input type="hidden" id="hidPhoneNum" name="hidPhoneNum" value=""/>
	       
	    </div>
    </form>
     		<input type="button" id="cancleCalc"  value="취소" class="cancel" onclick="location.href='/program/programDetail/programDetail.jsp'">
	</div>
	<br>
	<div class="infoText">
        <ul>
            <li class="caution">※ QR 코드 링크를 타인에게 전송했을 시, 책임은 본인에게 있습니다.</li>
            <li>추가 문의 사항이 있을 경우, 고객센터로 연락하시거나 글을 남겨주세요.</li>
            <li class="caution">※ 24시간 내로 QR 코드 링크가 전송이 되지 않을 경우, 고객센터로 연락하시거나 글을 남겨주세요.</li>
        </ul>
    </div>

    </div><!--entireWrap-->
    <c:import url="/common/jsp/footer.jsp"/>
</body>
</html>