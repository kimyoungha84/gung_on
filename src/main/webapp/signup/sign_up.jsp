<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <c:import url="/common/jsp/external_file.jsp"/>
  <link rel="stylesheet" href="/GungOn/common/css/common.css">
  <title>회원가입</title>
  
  <script type="text/javascript">
$(function(){
	var passFlag = false;
	
	
	$("#idConfirmBtn").click(function(){
		var id=$("#idCon").val();
		  if(id.length > 5 && id.length < 16){
			  var param={id:id};
			  $.ajax({
				  url:"ajax_id_dup.jsp",
			  type:"GET",
			  data:param,
			  dataType:"JSON",
			  error: function(xhr){
				  alert("버튼 눌러서 팝업창으로 중복검사해주세요.");
				  console.log(xhr.status);
			  },
			  success: function(jsonObj){
				var msg ="이미 사용 중";
				if(jsonObj.idFlag){
					msg="사용가능";
					$("#id").val(id);
				}//end if
				$("#idMsg").html(msg);  
			  }
			  });//ajax
		  }else{
			  $("#idMsg").html("6자 이상 15자 이하입력해주세요");
		  }//end if
		
	});//click
	
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
	
	$("#btnConfirm").click(function(){
		var id=$("#idCon").val();
		var hidId=$("#id").val();
		if (!checkField()) return; // 여기서 잘못되면 중단
		if(id !== hidId){
			alert("중복확인 해주세요.");
			return;
		}
		if(!passFlag){
			alert("비밀번호를 확인해주세요.");
			return;
		}
		
		$("#frm").submit();
		
	});//click
	
	$("#btnCancel").click(function(){
		location.href = "/GungOn/mainpage/mainpage.jsp";
	});//click
	
	
});//ready


function checkField(){
	if ($("#id").val() == "") {
	      alert('아이디는 필수 입력입니다.');
	      $("#idCon").focus(); return false;
	    }
	    if ($("#pass").val() == "") {
	      alert('비밀번호는 필수 입력입니다.');
	      $("#pass").focus(); return false;
	    }
	    if ($("#name").val() == "") {
	      alert('이름은 필수 입력입니다.');
	      $("#name").focus(); return false;
	    }
	    if ($("#tel").val() == "") {
	      alert('휴대폰은 필수 입력입니다.');
	      $("#tel").focus(); return false;
	    }
	    if ($("#email").val() == "") {
	      alert('이메일은 필수 입력입니다.');
	      $("#email").focus(); return false;
	    }if ($("#domain").val().trim() === "") {
	    	  alert("도메인을 입력하거나 선택해주세요.");
	    	  $("#domain").focus(); return false;
	    	}
	 
	    return true;
}//checkField

//유효성 검사 함수
function isStrongPassword(str) {
  const hasAlphabet = /[A-Za-z]/.test(str);
  const hasDigit = /\d/.test(str);
  const hasSpecial = /[!@#$%^&*()]/.test(str);
  return str.length >= 8 && hasAlphabet && hasDigit && hasSpecial;
}
</script>
</head>

  <body class="signup-body">

<jsp:include page="/common/jsp/header.jsp"/>

  <form method="post" action="/GungOn/signup/sign_up_process.jsp" class="signup-form" id="frm" name="frm">
    
    <!-- 약관 -->
    <div class="terms-box">
      <p><strong>제1장 총칙</strong><br>제1조 목적<br>이 약관은 ...</p>
    </div>
    <div class="checkbox">
      <input type="checkbox" id="agree1" name="agree1">
      <label for="agree1">회원가입약관에 동의합니다.</label>
    </div>

    <div class="terms-box">
      <p><strong>개인정보 수집 및 이용</strong><br>공단은 회원의 개인정보를 안전하게 보호합니다...</p>
    </div>
    <div class="checkbox">
      <input type="checkbox" id="agree2" name="agree2">
      <label for="agree2">개인정보취급방침에 동의합니다.</label>
    </div>

    <!-- 회원정보 입력 -->
    
    <table class="signup-table">
      <tr>
        <th>*아이디</th>
        <td>
          <div class="id-row">
            <input type="text" id="idCon" name="idCon">
            <input type="text" id="id" name="id" style="display: none;">
            <button type="button" class="btn btn-success" id="idConfirmBtn">ID 중복확인</button>
          </div>
        </td>
      </tr>
      <tr>
      <td colspan="2" style="position: relative; left: 150px">
      <span id="idMsg">아이디 </span>
      </td>
      </tr>

      <tr>
        <th>*비밀번호</th>
        <td>
          <input type="password" id="pass" name="pass" placeholder="비밀번호는 영어, 숫자, 특수문자를 포함해 8자 이상이어야 합니다." style="width: 100%">
        </td>
        
        </tr>
        
       
      <tr>
        <th>*비밀번호 확인</th>
        <td>
          <input type="password" id="pass2" name="pass2" style="width: 100%">
        </td>
      </tr>
      <tr>
        <td>
        </td>
        <td>
          <span id="errMsg">오류 나올 메세지</span>
        </td>
        </tr>

      <tr>
        <th>*이름</th>
        <td><input type="text" id="name" name="name" style="width: 100%"></td>
      </tr>

      <tr>
        <th>*휴대폰</th>
        <td><input type="text" id="tel" name="tel" style="width: 100%" maxlength="13"></td>
      </tr>

      <tr>
        <th>*이메일</th>
        <td class="email-domain">
          <input type="text" id="email" name="email" style="width: 48.3%">
          <span style="position: relative; top 3px;">@</span> 
          <input list="domainList" id="domain" name="domain" style="width: 48.3%; height: 42px" placeholder="도메인 입력 또는 선택">
			<datalist id="domainList">
			  <option value="naver.com">
			  <option value="daum.net">
			  <option value="gmail.com">
			</datalist>
        </td>
      </tr>
    </table>

    <div class="submit-buttons">
      <button type="button" class="submit" id="btnConfirm">확인</button>
      <button type="button" class="reset" id="btnCancel">취소</button>
    </div>

  </form>
  
  <!-- 푸터 -->
<jsp:include page="/common/jsp/footer.jsp"/>
</body>
</html>
