<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if (session.getAttribute("id") != null && session.getAttribute("changePass") != null ) { 
	  String id =(String) session.getAttribute("id");
}else{
	response.sendRedirect("${pageContext.request.contextPath}/login/login.jsp");
}
   %>
   
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 변경</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">
     <c:import url="${pageContext.request.contextPath}/common/jsp/external_file.jsp"/>
     
     <script>
     $(function(){
    	 
    	 $("#changeBtn").click(function(){
    		 if($("#pass").val() == $("#pass2").val()){
    			 
    		 var param = {id:"${id}",pass:$("#pass").val()}
    			$.ajax({
    				  url:"${pageContext.request.contextPath}${pageContext.request.contextPath}/changePassword_process.jsp",
    			  type:"POST",
    			  data:param,
    			  dataType:"JSON",
    			  error: function(xhr){
    				  console.log(xhr.status);
    			  },
    			  success: function(jsonObj){
    				  if (jsonObj.flag) {
    				        alert("비밀번호 변경 완료");
    				        location.reload();
    				      } else {
    				        alert("변경 실패");
    				      }
    			  	}
    			  });//ajax 
    		 }else{
    			 alert("비밀번호를 확인해주세요");
    		 }
    	 });
    	 
    	 $("#pass, #pass2").keyup(function (evt) {
    			const allowed = /[A-Za-z0-9!@#$%^&*()]/g;

    			  // 허용 문자 외 제거
    			  const filtered = $(this).val().match(allowed)?.join('') || '';
    			  $(this).val(filtered);

    			  const pass1 = $("#pass").val();
    			  const pass2 = $("#pass2").val();

    			  

    			  let msg = "";
    			  if (pass1 !== pass2) {
    			    msg = "비밀번호가 일치하지 않습니다.";
    			    passFlag = false;
    			  } else {
    			    msg = "비밀번호가 일치합니다.";
    			    passFlag = true;
    			  }

    			  if(!isStrongPassword(pass1)){
    				  msg="유효한 비밀번호인지 확인해주세요";
    				  passFlag = false;
    				  
    			  }
    			  $("#errMsg").html(msg);
    			});
    	 
    	 
    	 
     });//ready
     
     
   //유효성 검사 함수
     function isStrongPassword(str) {
       const hasAlphabet = /[A-Za-z]/.test(str);
       const hasDigit = /\d/.test(str);
       const hasSpecial = /[!@#$%^&*()]/.test(str);
       return str.length >= 8 && hasAlphabet && hasDigit && hasSpecial;
     }
     </script>
</head>
<body class="login">
<!-- 상단 메뉴 등 -->
  <jsp:include page="${pageContext.request.contextPath}${pageContext.request.contextPath}/common/jsp/header.jsp"/>
<div class="login-container" style="width: 450px; height: 350px;">
    <h2>비밀번호 변경</h2>
    <form action="login.do" method="post">
        <input type="password" id="pass" name="pass" placeholder="비밀번호" required><br>
        <input type="password" id="pass2" name="pass2" placeholder="비밀번호 확인" required><br>
        <input type="hidden" style="display: none;"><br>
        <span id="errMsg">비밀번호</span>
        <button type="button" id="changeBtn">변경하기</button>
    </form>

</div>
<!-- 푸터 -->
  <jsp:include page="${pageContext.request.contextPath}${pageContext.request.contextPath}/common/jsp/footer.jsp"/>
</body>
</html>
