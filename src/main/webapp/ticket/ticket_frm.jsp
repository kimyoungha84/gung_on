<%@page import="kr.co.gungon.ticket.user.TicketService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="예매화면"%>
 <%@ include file="config/site_config.jsp"%>
 
 <%@ include file="/common/jsp/login_chk.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
 
<!DOCTYPE html>
<html>
<head>

<!-- favicon 설정 -->
<link rel="icon shortcut"  href="/common/images/cs/gungOnFavicon.ico"/>


<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<c:import url="/common/jsp/header.jsp"/>	
<title>예매</title>

<meta name="viewport" content="width=device-width, initial-scale=1"/>

<!-- 달력 -->
<link rel="stylesheet" href="/ticket/datepicker/air-datepicker/dist/css/datepicker.min.css">
<script src="/ticket/datepicker/jquery-3.1.1.min.js"></script>
 <script src="/ticket/datepicker/air-datepicker/dist/js/datepicker.min.js"></script>
 <script src="/ticket/datepicker/air-datepicker/dist/js/i18n/datepicker.ko.js"></script>

<script src="/ticket/js/ticket.js" type="text/javascript"></script>


<!-- 사진돌리기 -->
<link rel="stylesheet" type="text/css" href="/ticket/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="/ticket/slick/slick-theme.css"/>


<!-- site CSS-->
 <!-- 이거 이클립스에서 한 번 실행시켜주면, 정상 작동함 ㅋㅋㅋ -->
<link rel="stylesheet" type="text/css" href="/ticket/css/ticket_ver0514.css"/>
	



<style>

</style><!--style-->





<!-- 사진 넘어가기 -->
<!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="slick/slick.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>



	
</head>

<body>

<%
//여기서 getprogramName 받아줘야한다.
String programName=request.getParameter("programName");//이거 나중에 주석 풀어야 함.
//pageContext.setAttribute("programName", programName);
String member_id=((MemberDTO)session.getAttribute("userData")).getId();//이거 나중에 주석 풀기
//pageContext.setAttribute("member_id", member_id);
//value 부분에 ${programName} 변경 필요

//String member_id="testest";
//String programName="경복궁 야간관람";

TicketService ticketService=new TicketService();
//program 시작, 끝 날짜 가져오기
String startday=ticketService.getStartDate(programName);
System.out.println(startday);
String endday=ticketService.getEndDate(programName);
System.out.println(endday);

%>

<main>
<div class="wrap">
    <form onsubmit="return valiableData()" action="/ticket/ticketProcess/ticket_process.jsp" name="viewDateFrm" method="post">
    	<input type="hidden" id="member_id" name="member_id" value="<%=member_id%>"/>
  	   <div><input type="text" id="programName" name="programName" class="title" value="<%=programName%>" style="margin-left: 80px"/></div>
    <!-- 오른쪽 -->
    <div class="right">
		<div class="ticket_box">
			
			<div class="viewTitle">
				<img src="/ticket/images/ico_date.png" width="20px"/><span class="view">관람일자</span>
			</div><!--viewTitle-->
			<!-- <form action="" name="viewDateFrm" method="post"> -->
				<div class="viewDateParent calendarParent" style="position:relative"><!-- 부모 -->
				<div class="selectDesign viewDate" id="viewDate" >
					<input type="hidden" class="start-day" value="<%=startday%>"/><input type="hidden" class="end-day" value="<%=endday%>"/>
					<span class="ex"><input id="datepicker" name="datepicker" type="text" readonly placeholder="날짜를 선택해주세요." /></span>
					<input type="hidden" class="datepickerStatus" value="non-click"/>
					<img src="/ticket/images/downArrow.png" width="16px" id="arrowDatepicker" class="arrow"/>	
				</div><!--selectionDesign-->
				</div><!-- viewDateParent -->
			<!-- </form>	 --><!-- viewDateFrm -->
			
			<br>

			<div class="viewTitle"> 
				<img src="/ticket/images/ico_person.png" width="20px"/><span class="view">관람인원</span>
			</div><!--viewTitle-->
			<!-- <form name="viewPersonFrm " method="post"> -->
			<div class="personWrap"><!-- 부모 -->
				
				<div class="selectDesign viewPersonNum" id="viewPersonNum" onclick="changeStatus('.viewPersonNum','.classificationWrap')">
					<span class="ex personChoose">인원선택</span>
					<img src="/ticket/images/downArrow.png" id="arrow" class="arrow"  width="16px" />
				 </div> <!-- selectDesign viewPersonNum  -->
					<!-- 요기 style을 display : none 이랑 block으로 해주면 된다. -->
					<!-- --------------------------zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz----------------------------- -->
				<div class="classificationWrap" style="display:none"><!-- 자식 -->
				    
				     <div>   
				    <table>
				    <thead></thead>
				    <tbody>
				        <tr> 
				      	<td style="width: 27%; line-height: 80%;">
				            <span style="font-size:15px; font-weight: bold;">대인</span><br>
				      	    <span style="font-size: 10px;">만 19세 이상<br>(경로포함)</span>
				        </td>  
				        <td style="width:30%;">
				            <input type="text" class="ticketCost" id="adultCost" name="adultCost" value="￦5,000" readonly style="border:none">
				        </td>
				        <td style="width:43%;">
				            <div class="classifiationTable">
				        	<div class="minusDiv"><img src="/ticket/images/minusImg.png" class="minusImg minusAdultImg"/></div>
				        	<input type="text" class="person adult"  id="adult"  name="adult" value="0" readonly style="border:1px #333 solid; width:44px"/>
				        	<div class="plusDiv"><img src="/ticket/images/plusImg.png" class="plusImg plusAdultImg"/></div>
				            </div>
				        </td>
				    </tr>
				    <tr>
				        <td style="line-height: 80%;">
				            <span style="font-size: 15px; font-weight: bold;">소인</span><br>
				            <span style="font-size: 10px;">만 7세 ~ 만 18세</span>
				        </td>
				        <td>
				        	<input type="text" class="ticketCost" id="kidCost" name="kidCost" value="￦2,500" readonly style="border:none">
				        </td>
				        <td>
				           <div class="classifiationTable">
				        	<div class="minusDiv"><img src="/ticket/images/minusImg.png" class="minusImg minusKidImg" id="minusImg"/></div>
				        	<input type="text" class="person kid" id="kid" name="kid" value="0" readonly style="border:1px #333 solid; width:44px">
				        	<div class="plusDiv"><img src="/ticket/images/plusImg.png" class="plusImg plusKidImg" id="plusImg"/></div>
				            </div>
				        </td>
				    </tr>
				    </tbody>
				    </table>
				    
				    </div><!-- table -->
				    <div class="annoyWrap">
				    <div class="calcValue" data-name="calcValue">￦0</div>
				   	<div class="chooseBtnWrap"><input type="button" value="완료" class="chooseBtn"/></div>
				   	</div><!-- annoyWrap -->
				</div><!--classificationWrap-->
					<!-- -------------------zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz-- -->
				</div><!-- personWrap -->
					
			
			<!-- viewPersonFrm -->


			<br>

			<div class="viewTitle">
				<img src="/ticket/images/ico_person.png" class="20px"/><span class="view">해설관람</span><span style="font-size: 11px;">(선택사항)</span>		
			</div><!--viewTitle-->

			<!-- <form name="commentFrm"> -->
			<div class="langGroupWrap">
				<div class="selectDesign langGroup" onclick="changeStatus('.langGroup','.langWrap')">
					<input type="text"  id="langChoose" name="langChoose" class="ex langChoose" value="선택 안함" style="border:none;   user-select:none;">
					<img src="/ticket/images/downArrow.png" width="16px" id="arrow" class="arrow" />
				</div>
				<!-- 여기기기기기기기기기ㅣ -->
				<div class="langWrap" style="display:none">
					<div class="lang noChoose">선택 안함</div>
					<div class="lang korea">한국어</div>
					<div class="lang english">영어</div>
				</div><!-- langWrap  -->
		</div><!-- langGroupWrap -->
				<br><br>
				<input type="text" class="priceView" value="￦0" style="border:none;   user-select:none;"/>
			<!-- </form> -->
			<!-- viewPersonFrm -->

			<input type="button" value="예매하기" class="reserveBtn" onclick="forSubmit()"/>
		<!-- 	
			<a href="/ticketProcess/ticket_process.jsp" class="reserveBtn">
				<font class="reserveBtnFont">예매하기</font>
			</a> 
			-->
			

		</div><!--ticket_box-->
		

    </div><!-- right -->
   
    </form><!-- 오른쪽 form -->
    
    
  

	<!-- 왼쪽 -->
    <div class="left">
 <%-- 
		<div data-slick='{}' class='slider' style=" margin-left: 35px;">
		  <img src="/ticket/images/Gyeongbokgung.jpg"/>
		  <img src="/ticket/images/Gyeongbokgung2.jpg"/>
		  <img src="/ticket/images/Gyeongbokgung3.jpg"/> 

		</div><!-- data-slick -->
 --%>	
 		<%String imgFullPath=request.getParameter("imgFullPath"); %>
 		
		<div style="">
			<img src="<%=imgFullPath %>" style="width:339px;height:450px; margin-top:20px;margin-left:100px;"/>
		</div>


	<div class="explain_ticket">
		<font class="import_red">※ 단체 관람객인 경우에는 고객센터로 연락해주시기 바랍니다.<br>
		&nbsp&nbsp&nbsp 현재 페이지는 소규모 관람객이 신청가능한 페이지입니다.<br>
		&nbsp&nbsp&nbsp (최대 10명까지 가능합니다.)<br>
		</font>
		<br>
		<div class="subTitle">관람 방법</div>
		<ul>
			<li><font class="import_red">후원 외국인 관람시간에는 내국인 예약 불가합니다.</font><br>
			<font color="#1C6CA2">(단, 외국인 동반자가 있는 경우 내국인 2명까지 입장 가능)</font></li>
			<li><font class="import_red">전각및 후원티켓은 타인에게 재판매하지 못합니다.</font></li>
			<li>무료 및 할인대상자도 사전 예매하시고,  관람당일 입장시간전까지 매표소에 관련증빙 제시 후 환불 요청하시기 바랍니다.</li>
			<!--li>무료 및 할인 대상자: 관람 당일 매표소에 관련 신분증 제시 후, 관람권을 선착순 발권 받으시기 바랍니다.</li>
			<li2>통합관람권 소지자: 관람 당일 매표소에서 현장 구매표로 선착순 교환하시기 바랍니다.</li2-->
			<li>매주 월요일 휴관(정기휴관일이 공휴일 및 대체휴일과 겹칠 경우에는 개방하며, 그다음의 첫번째 비공휴일이 정기휴일임)</li>
		</ul><!--관람 방법 ul-->

		<br><br>




		<!-- 관람 안내 -->
		<div class="subTitle">관람 안내</div>
		<ul>
			<li>후원관람권은 <font class="import_red">해당 회차의 후원입장시간 15분 전까지만</font> 구입 가능합니다.</li>
			<li><font class="import_red">※ 봄.가을 성수기에는 매표소 및 정문 주변이 혼잡하므로(대기시간증가) 충분한 시간적 여유를 가지고 도착해 주시기 바랍니다.</font></li>
		

		<table style="margin-left: 5px;">
			<colgroup>
				<col style="background-color:#F8F8F8">
				<col span="2">
			</colgroup>
			<thead> 
				<tr>
					<th width="20%">구분</th>
					<th>관람 동선</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center">3~6월<br>9월~11월</td>
					<td>후원입구 > 부용지 > 애련지 > 연경당 > 관람지 > 옥류천(약90분)</td>
				</tr>
				<tr>
					<td align="center">7월~8월<br>12월~2월</td>
					<td>후원입구 > 부용지 > 애련지 > 관람지 > 연경당 > 향나무길(약70분)</td>
				</tr>		
			</tbody>
		</table>

			<br><br>
			<li>※소요시간 및 관람 동선은 날씨, 일몰시간 및 기관사정에 따라 변경될 수 있습니다.</li>
		</ul><!--관람 안내 ul-->

		<br><br>

		<!--예매 방법-->
		<div class="subTitle">예매 방법</div>
		<ul>
			<li>관람일 선택 : 관람희망일 제외 6일전 오전10시부터 예약 가능(선착순)</li>
			<li>결제하지 않을 경우 자동으로 예약이 취소됩니다.</li>
			<li>해설 선택 : 원하시는 언어의 해설을 선택해 주세요. 해설은 선택사항힙니다.</li>
			<li>관람료 결제 : 신용카드 및 체크카드 결제(무통장 입금 불가)</li>
			<li>단체할인 없음.</li>
			<li>예약/예매 SMS 발송 : 결제완료 시 발송됩니다. 단, 해외로는 발송되지 않습니다.</li>
		</ul><!--예매 방법 ul-->


		<br><br>


		<!--취소/환불 규정-->
		<div class="subTitle">취소/환불 규정</div>
		<ul>
			<li>예매 완료된 티켓을 취소/환불하는 경우에는 취소 시점에 따라 위약금이 발생하오니 유의하시기 바랍니다.</li>	

			<table style="margin-left:5px; width:600px">
				<colgroup>
					<col style="background-color:#F8F8F8">
					<col span="2">
				</colgroup>
				<thead>
					<tr>
						<th width="20%">구분</th>
						<th>후원 특별 관람</th>
					</tr>
				</thead>
					<tr>
						<td align="center">위약금 없음</td>
						<td>관람 회차 시작 시간 2시간 전</td>
					</tr>
					<tr>
						<td align="center">위약금 10%</td>
						<td>관람 회차 시작 시간 2시간 전 ~ 시작 시간</td>
					</tr>
					<tr>
						<td align="center">위약금 100%<br>(취소불가)</td>
						<td>관람 회차 시작 이후</td>
					</tr>
				<tbody>

				</tbody>
			</table>

		</ul><!--취소/환불 규정 ul-->


		<br><br>

		<!--관람 당일 입장 방법의 종류-->
		<div class="subTitle">관람 당일 입장 방법의 종류</div>
		<ul>
			<li>궁궐입구에서 후원입구까지 15분 이상 소요되오니, 후원관람 예매자께서는 관람시작시간 전까지 후원입구로 오시기 바랍니다.<br>
            ※입장 시간 미준수시 입장 및 환불이 불가합니다.</li>
			<li>스마트폰 내 SMS로 전송된 모바일 티켓으로 검표 확인 후 바로 입장 가능합니다.</li>

		</ul><!--관람 당일 입장 방법의 종류 ul-->

	</div><!--explain_ticket-->


  </div><!--end left-->
<!-- </form> -->
</div><!--wrap-->
<c:import url="/common/jsp/footer.jsp"/>
</main>
</body>

</html>