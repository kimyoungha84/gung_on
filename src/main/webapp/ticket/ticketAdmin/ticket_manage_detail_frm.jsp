<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	

<meta name="viewport" content="width=device-width, initial-scale=1"/>

<title>예매 관리 상세</title>

 <!-- 내가 만든 js -->
 <script src="./js/ticket_manage_detail_js.js" type="text/javascript"></script>
 
 <!-- 부트스트랩  CDN -->    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"/>
 
 <!-- 내가 만든 CSS -->
 <link rel="stylesheet" type="text/css" href="./css/ticket_manage_detail_css.css"/>
</head>
<body>

       <div class="identifier">
       <span class="titleText">예매번호</span> <span class="titleVal">123123</span> 
       </div>
<span>예매 정보</span><span class="titleText">결제일</span> <span  class="titleVal">123</span>
       <br><br>
       <div class="ticketInfoTable">
           <table class="table-bordered" style="width:850px; font-size: 20px; text-align: center; border: 1px solid #9398A2;">
               <thead class="border-start border-end border border-2" style="height:50px ; border: #9398A2; ">
                   <tr>
                       <th scope="col">행사명</th>
                       <th scope="col">예매 일자</th>
                       <th scope="col">해설 언어</th>
                       <th scope="col">인원</th>
                       <th scope="col">결제 금액</th>
                   </tr>
               </thead>
               <tbody class="border-start border-end" style="height:90px">
                   <tr>
                       <td>123</td>
                       <td>123</td> 
                       <td>123</td>
                       <td>123<br></td>    
                       <td>123</td>
                   </tr>

               </tbody>

           </table>
       </div><!--ticketInfoTable-->
       
       <br><br><br><br><br><br><br>
       <table class="table-bordered" style="width:850px; font-size: 20px; text-align: center; border: 1px solid #9398A2;">
       <thead>
		<tr>
			<th>연령 구분</th>		
			<th>입장 시간</th>		
			<th>입장 여부</th>
			<th>선택</th>		
			<th>QR 전송 횟수</th>		
		</tr>       
       </thead>
       <tbody>
       		<tr>
       		<td>대인 1</td>
       		<td>2025-103450984569</td>
       		<td>O</td>
       		<td><input type="checkbox"/></td>
       		<td>1</td>
       		</tr>
       
       </tbody>
       </table>



</body>
</html>