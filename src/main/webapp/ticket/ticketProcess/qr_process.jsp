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

var str=prompt("관리자번호를 입력해주세요.");
var param = str + " " + <%=img%>
$.ajax({
	url : "qr_process.detail.jsp",
	type : "post",
	data : param,
	
	dataType : "html",
	error:function(xhr){
		alert("실패했습니다.\n링크에 다시 접속해주세요.");
	},
	success: function(htmldata){
		alert("처리완료!");
	}
	
});//ajax

</script>

</head>
 <body>
<!-- prompt 창을 띄워서 로그인 해야함. -->

</body>
 
</html>



