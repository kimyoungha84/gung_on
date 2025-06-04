/**
 * 
 */

$(function(){
	var adminNum=prompt("관리자 번호 입력");
	if(adminNum != null){
		$.ajax({
			url:"http://localhost/GungRemake333/ticket/ticketProcess/qr_process_detail.jsp",
			type:"post",
			data: adminNum,
			
			dataType: "html",
			error:function(){
				
			},
			success:function(data){
				
			}
		});//ajax
	}//end if
	
});//ready