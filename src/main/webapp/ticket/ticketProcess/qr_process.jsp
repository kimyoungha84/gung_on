<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
 <!DOCTYPE html>
 <html>
 <head>
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
<%
String img=request.getParameter("img");
%>
<!-- prompt 창을 띄워서 로그인 해야함. -->
var str=prompt("관리자번호를 입력해주세요.");
//alert(str);

var imgimg="${param.img}";
var param = "adminNum="+str +"&img="+imgimg;


$.ajax({
	url : "/ticket/ticketProcess/qr_process_detail.jsp",
	type : "post",
	data : param,
	
	dataType : "html",
	error:function(xhr){
		alert(xhr.status+" / "+xhr.statusText);
	},
	success: function(htmldata){
		var data=$.trim(htmldata);
		//alert(data);
		
		if( data == "yes"){
			alert("성공");
		}else if(data == "already"){
			alert("이미 처리되었습니다.\n사용자화면 새로고침을 요청해주세요.");
		}else{
			alert("실패");
		}
	}
	
});//ajax

</script>

</head>
 <body>




</body>
 
</html>



