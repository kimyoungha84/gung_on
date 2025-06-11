/**
 * 
 */

$(function(){
	//history.pushState({ page: 'payment' }, '', '/ticket/ticketPayment.jsp');
	var authenNumFlag=false;
	var testStrangeFlag=false;

	/*"인증" 버튼 눌림*/
	$("#authenBtn").click(function(){
		//3,4,3을 '-'를 주도록 해야지
		
		var param="phoneNum="+$("#authenPhoneNum").val();
		
		$.ajax({
			url:"/ticket/ticketProcess/authen_process.jsp",
			type:"post",
			data: param,
			
			dataType:"html",
			error : function(xhr){
				console.log(xhr.status+" / "+xhr.statusText);
			},
			success: function(data){
				var result=$.trim(data);
				if(result == "badstatus"){
					alert("해당 네트워크에서 접근 20번을 초과했습니다.\n관리자에게 문의해주세요 ㅇㅅㅇ");
					$("#authenBtn").css("display","block");
					$("#authenPhoneNum").attr("readonly",true);//핸드폰 번호 창은 더 못건드리게.....
					$("#authenPhoneNum").css("background","#ECECEC");
					testStrangeFlag=true;
				}
				else if(result != "yes"){
					alert("알맞지 않은 핸드폰 번호 입니다.\n다시 입력해주세요.");
					$("#authenPhoneNum").val("");//핸드폰 번호창 지워주기
				}else{
				$("#authenBtn").css("display","none");
				$("#authenPhoneNum").attr("readonly",true);//핸드폰 번호 창은 더 못건드리게.....
				$("#authenPhoneNum").css("background","#ECECEC");
				$(".authChk").css("display","block");
				
				}//end if~else
			}//success
		});//ajax

	});//click


	
	/*인증번호 확인 버튼*/
	$("#checkBtn").click(function(){
		//사용자가 입력한 인증번호 값
		var param="authenNum="+$("#checkNum").val();
		
		//여기는 인증 자체 카운트를 세주자, 프로젝트 시연 때, 혹시 모르니까,
		//아예 network단을 count를 주자
		 
		
		$.ajax({
			url:"/ticket/ticketProcess/authenCheck_process.jsp",
			type:"post",
			data: param,
			
			dataType:"html",
			error : function(xhr){
				console.log(xhr.status+" / "+xhr.statusText);
			},
			success: function(data){
				var result=$.trim(data);
				
				if(result == "badstatus"){
					alert("해당 네트워크에서 접근 20번 초과함... \n관리자에게 문의해주세요.");
					testStrangeFlag=true;
				}//alert
				
				
				else if(result != "yes"){
					alert("인증번호가 다릅니다.\n휴대폰 번호부터 다시 입력해주세요.");
										
					//전화번호 입력창이랑
					//인증 버튼 다시 뜨게끔 만들어줘야 함.
					$("#authenBtn").css("display","block");
					$("#checkNum").css("display","none");
					$("#checkNum").val("");
					$("#checkBtn").css("display","none");
					
					
					$("#authenPhoneNum").val("");//핸드폰 번호창 지워주기
					$("#authenPhoneNum").attr("readonly",false);//핸드폰 번호 창, 다시 쓸 수 있게 열어줘야해
					$("#authenPhoneNum").css("background","#FFFFFF");
					
					
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

					//인증이 완료되었으니까 DB에 저장해야지
										
				}//end if~else
				
			}//success
		});//ajax
		
	});//click
	
	
	/*결제하기 버튼 클릭*/
	/*인증이 완료되면 DB로 보냅시다아.*/	
	$("#moneyCalc").click(function(){
		var param="phoneNum="+$("#hidPhoneNum").val();
		//debugger;
		//alert("hidePhoneNum" +$("#hidPhoneNum").val());
		
		if(testStrangeFlag){
			alert("해당 네트워크에서 접근 20번을 초과했습니다.\n관리자에게 문의해주세요 ㅇㅅㅇ");
		}//end if
		else if(authenNumFlag == false){
			alert("휴대폰 번호 인증을 먼저 수행해 주세요.");
		}else{
			$.ajax({
				url:"/ticket/ticketProcess/ticket_calc_procss.jsp",
				type:"post",
				data: param,
				
				dataType:"html",
				error : function(xhr){
					console.log(xhr.status+" / "+xhr.statusText);
				},
				success: function(htmlData){
					//var result=$.trim(data);
					//alert(htmlData);
					$(".entireWrap").html(htmlData);
					
				}//success
				
			});//ajax
			 
			//$("#calcFrm").submit();
		}//end if~else
	});//click

	
	/*취소버튼 클릭*/
	$("#cancleCalc").click(function(){
		location.replace('/ticket/ticket_frm.jsp');
	});//click
	
});//ready