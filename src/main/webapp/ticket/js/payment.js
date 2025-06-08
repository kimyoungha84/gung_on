/**
 * 
 */

$(function(){
	history.pushState(null, document.title, location.href);
	
	
	var authenNumFlag=false;

	/*"인증" 버튼 눌림*/
	$("#authenBtn").click(function(){
		//3,4,3을 '-'를 주도록 해야지
		
		var param="phoneNum="+$("#authenPhoneNum").val();
		
		$.ajax({
			url:"./authen_process.jsp",
			type:"post",
			data: param,
			
			dataType:"html",
			error : function(xhr){
				console.log(xhr.status+" / "+xhr.statusText);
			},
			success: function(data){
				var result=$.trim(data);
				
				if(result != "yes"){
					alert("알맞지 않은 핸드폰 번호 입니다.\n다시 입력해주세요.");
				}else{
				
				$("#authenBtn").css("display","none");
				$("#authenPhoneNum").attr("readonly",true);//핸드폰 번호 창은 더 못건드리게.....
				$(".authChk").css("display","block");
				
				}//end if~else
			}//success
		});//ajax

	});//click


	
	/*인증번호 확인 버튼*/
	$("#checkBtn").click(function(){
		//사용자가 입력한 인증번호 값
		var param="authenNum="+$("#checkNum").val();
		
		
		$.ajax({
			url:"./authenCheck_process.jsp",
			type:"post",
			data: param,
			
			dataType:"html",
			error : function(xhr){
				console.log(xhr.status+" / "+xhr.statusText);
			},
			success: function(data){
				var result=$.trim(data);
				
				if(result != "yes"){
					alert("인증번호가 다릅니다.\n다시 확인해 주세요.");
					
					//전화번호 입력창이랑
					//인증 버튼 다시 뜨게끔 만들어줘야 함.
					$("#authenBtn").css("display","block");
					$("#checkNum").css("display","none");
					$("#checkBtn").css("display","none");
					$("#authenPhoneNum").attr("readonly",false);//핸드폰 번호 창, 다시 쓸 수 있게 열어줘야해
					
				}else{
					//alert("인증완료 되었습니다.");
					//확인버튼, 인증입력, 확인 버튼 모두 display : none
					$("#authenBtn").css("display","none");
					$("#checkNum").css("display","none");
					$("#checkBtn").css("display","none");
					
					
					//빨간색으로 인증완료 뜨게끔.
					$("#completAuthen").css("display","block");
					
					authenNumFlag=true;
					//debugger;
					$("#hidPhoneNum").val($("#authenPhoneNum").val());
					
				}//end if~else
				
			}//success
		});//ajax
		
	});//click
	
	
	/*결제하기 버튼 클릭*/
	/*인증이 완료되면 DB로 보냅시다아.*/	
	$("#moneyCalc").click(function(){
		if(authenNumFlag == false){
			alert("휴대폰 번호 인증을 먼저 수행해 주세요.");
		}else{
			 $("#calcFrm").submit();
		}//end if~else
	});//click

	
	/*취소버튼 클릭*/
	$("#cancleCalc").click(function(){
		window.location.href="./ticket_frm.jsp";
	});//click
	
});//ready