/**
 * 
 */

$(function(){

$(".row").click(function(){
	var id=$(this).attr("id");
	window.location.href="manage_detail_Frm.jsp?bookingNum="+id;
});	
	
		
});//ready



