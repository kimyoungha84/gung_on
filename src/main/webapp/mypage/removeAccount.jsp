<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/login_chk.jsp" %>
<% 
pageContext.getAttribute("userData");
  %>
<!DOCTYPE html>
<html>
<head>
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="/Gung_On/common/css/common.css">
    <c:import url="/common/jsp/external_file.jsp"/>
    
<script type="text/javascript">
$(function(){
	
	$("#pass").keyup( function(e) {
		  if (e.key === "Enter" || e.keyCode === 13) {
		    $("#removeBtn").click(); // 버튼 클릭 트리거
		  }
		});
	
	$("#removeBtn").click(function(){
		console.log("입력한 비밀번호:", $("#pass").val());
		 var param = {id:"${userData.id}",pass:$("#pass").val()};
		$.ajax({
			  url:"removeAccount_process.jsp",
		  type:"POST",
		  data:param,
		  dataType:"JSON",
		  error: function(xhr){
			  console.log(xhr.status);
		  },
		  success: function(jsonObj){
			  if (jsonObj.removeFlag) {
			        alert("탈퇴 완료");
			        location.href="/Gung_On/login/logout.jsp";
			      } else {
			        alert("탈퇴 실패");
			      }
		  }
		  });//ajax
	});//click
});//ready
</script>
	
</head>
<body class="login">
<!-- 상단 메뉴 등 -->
<jsp:include page="/common/jsp/header.jsp"/>
<div class="login-container" style="width: 450px; height: 290px;">
    <h2>회원탈퇴</h2>
    
    <form method="post">
    	 <label style="position: absolute; left: 50px;">아이디 :</label>
  <span style="position: absolute; left: 120px;">${ userData.id }</span>
        <input type="hidden" style="display: none;"><br>
        <input type="password" name="pass" id="pass" placeholder="비밀번호" required><br>
        <input type="text" style="display: none;"><br>
        <button type="button" id="removeBtn">회원탈퇴</button>
    </form>

</div>
<!-- 푸터 -->
<jsp:include page="/common/jsp/footer.jsp"/>
</body>
</html>
