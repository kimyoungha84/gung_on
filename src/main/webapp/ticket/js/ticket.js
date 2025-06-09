/**
 * 
 */

$(function(){
	
	history.pushState({ page: 'ticket_frm' }, '', 'http://localhost${pageContext.request.contextPath}/ticket/ticket_frm.jsp');
	
	$('.slider').slick({
		dots: true,
		infinite: true,
		speed: 500,
		fade: true,
		sliesToShow:1,
		
		//cssEase: 'linear',
		centerMode:true,
		autoplay:true,
		autoplaySpeed:3000,
		
	});//slider
	
	var startDay=$(".start-day").val();
	var endDay=$(".end-day").val();
	
	//debugger;
	$("#datepicker").datepicker({
		autoClose : true,
		language: 'ko',
		minDate: new Date(startDay),
		maxDate: new Date(endDay),

	});//datepicker
	
	/* 클릭되었을 때, 화살표 표시 변경 */
	$("#datepicker").click(function(){
		var arrowStatus=$(".datepickerStatus").val();
		
		if(arrowStatus == "click"){
			$(".datepickerStatus").val("non-click");
			$("#arrowDatepicker").attr('src','images/upArrow.png');
		}//end if
		var values=$("#datepicker").is(':visible');
		//debugger;
		//alert(values);
		if(arrowStatus == "non-click"){
			$(".datepickerStatus").val("click");
			$("#arrowDatepicker").attr('src','images/downArrow.png');
		}//end if
		
	});//click
	
	
	/*어른*/
	var personValue=0;
	var adultPersonValue=0;
	
	//adult의 plus 이미지가 클릭되었을 때,
	$(".plusAdultImg").click(function(){
		personValue++;
		adultPersonValue++;
		
		$(".adult").val(adultPersonValue);
		$(".calcValue").html("￦"+feeCalc('adult','plus').toLocaleString('ko-kr'));
		
	});//click
	
	//adult의 minus 이미지가 클릭되었을 때
	$(".minusAdultImg").click(function(){
		personValue--;
		adultPersonValue--;
		
		if(adultPersonValue<0){
			adultPersonValue=0;
		}//end if
		
		$(".adult").val(adultPersonValue);
		$(".calcValue").html("￦"+feeCalc('adult','minus').toLocaleString('ko-kr'));
	});//click


	/*아이*/
	var kidPersonValue=0;
	//kid의 plus 이미지가 클릭되었을 때,
	$(".plusKidImg").click(function(){
		personValue++;
		kidPersonValue++;
		
		$(".kid").val(kidPersonValue);
		$(".calcValue").html("￦"+feeCalc('kid','plus').toLocaleString('ko-kr'));
	});//click

	//kid의 minus 이미지가 클릭되었을 때
	$(".minusKidImg").click(function(){
		personValue--;
		kidPersonValue--;
		
		if(kidPersonValue<0){
			kidPersonValue=0;
		}//end if
		
		$(".kid").val(kidPersonValue);
		$(".calcValue").html("￦"+feeCalc('kid','minus').toLocaleString('ko-kr'));
	});//click
	
	/*완료 버튼이 눌리면 메인 view로 뿌려주기*/
	$(".chooseBtn").click(function(){
		$(".priceView").val("￦"+totalCost.toLocaleString('ko-kr'));
		changeStatus('.viewPersonNum','.classificationWrap');	
		
		totalPersonValue=adultPersonValue+kidPersonValue;
		
		if(totalPersonValue != 0){
			$(".personChoose").html(totalPersonValue+"명");	
		}else{
			$(".personChoose").html("인원선택");
		}//end if~else
		
		
	});//click
	
/*	
	const langArea=document.querySelector(".lang");
	langArea.addEventListener("click",function(event){
		debugger;
		//alert(event);
	});
	
*/	

	/*해설 선택*/
	const onClick = (event) =>{
		//debugger;
		//alert(event.target);
		//alert(event.target.className);
		var regex=/lang\s/;
		var name=event.target.className;
		if(regex.test(name)){
			
			var commentChoose=$(event.target).text();
			
			$(".langChoose").val(commentChoose);
			changeStatus('.langGroup','.langWrap');
		}//end if
	
	}//onClick
	window.addEventListener('click',onClick);

	
	$(".popup_box").hide();
	
});//ready


/**************************************************************************/


function changeStatus(parentClassValue,classValue){
	var displayValue=$(classValue).css("display");
	
	if(displayValue == "none"){
		//열기
		$(classValue).css("display","block");
		$(parentClassValue).children('img').attr('src','images/upArrow.png');
	}else{
		//닫기
		
		//만약 메인view의 가격과, 조그마한 view의 가격이 일치하지 않으면 alert 시키기
		if($(".calcValue").html() != $(".priceView").val()){
			if(confirm("선택한 내용이 저장되지 않았습니다.")){	
				initCal();
				$(classValue).css("display","none");
				$(parentClassValue).children('img').attr('src','images/downArrow.png');
				
				//http://localhost${pageContext.request.contextPath}/ticket/images/downArrow.png
			}//end if
		
		}else{//값이 같을 경우에는 그냥 닫히면 되지
			$(classValue).css("display","none");
			$(parentClassValue).children('img').attr('src','images/downArrow.png');
		}//end if~else
		

	
	}//end if~else	
}//changeStaus

/********************************************************************************************/
function changeArrowStatus(){
	
}




/********************************************************************************************/
/*입장료 계산*/
//어차피 버튼은 1번 눌리니까 눌릴 때마다 계산한다고 하면....
/*사람 종류, 계산(plus인지 -인지)*/
var totalCost=0;
var adultTotalCost=0;
var kidTotalCost=0;

function feeCalc(personClassification, plusMinus){
	
	if(personClassification == 'adult'){
		adultCalc(plusMinus);
	}else{
		kidCalc(plusMinus);
	}//end if~else
	
	totalCost=adultTotalCost+kidTotalCost;
	
	return totalCost;
}//feeCalc


/**************************************************************************************/

function adultCalc(plusMinus){
	var fee=5000;//어른 요금
	
	if(plusMinus == 'plus'){
		adultTotalCost+=fee;
	}else{
		adultTotalCost-=fee;
		if(adultTotalCost<0){
			adultTotalCost=0;
		}//end if
	}//end if~else
	
}//adultCalc


/*******************************************************************************************/

function kidCalc(plusMinus){
	var fee=2500;//아이 요금
	
	if(plusMinus == 'plus'){
		kidTotalCost+=fee;
	}else{
		kidTotalCost-=fee;
		if(kidTotalCost<0){
			kidTotalCost=0;
		}//end if
	}//end if~else
	
}//kidCalc


/****************************************************************************************/

function initCal(){
	adultPersonValue=0;
	kidPersonValue=0;
	adultTotalCost=0;
	kidTotalCost=0;
	totalCost=0;
	
	
	$(".calcValue").html("￦0");
	$(".priceView").html("￦0");
	$(".adult").val("0");
	$(".kid").val("0");
	$(".personChoose").html("인원선택");
}

