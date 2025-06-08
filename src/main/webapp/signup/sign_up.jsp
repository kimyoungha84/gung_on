<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <c:import url="/common/jsp/external_file.jsp"/>
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
  <title>회원가입</title>
  <style type="text/css">
  #timer {
  display: inline-block;
  min-width: 60px;
  margin-left: 10px;
  font-weight: bold;
  font-size: 14px;
  color: black;
}
  </style>
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
		
		// ✅ 인증번호가 아직 확인되지 않은 경우
		if (!$("#certi").prop("readonly")) {
			alert("인증번호를 확인해주세요.");
			return;
		}
		$("#frm").submit();
		
	});//click
	
	$("#btnCancel").click(function(){
		location.href = "/Gung_On/mainpage/mainpage.jsp";
	});//click
	
	 $("#emailCon").click(function(){
		var email = $("#email").val()+"@"+$("#domain").val();
		if ($("#email").val().trim() === "" || $("#domain").val().trim() === "") {
		    alert("이메일과 도메인을 모두 입력해주세요.");
		    return;
		}
		$.ajax({
			  url:"email_process.jsp",
		  type:"GET",
		  data: { email: email },
		  dataType:"JSON",
		  error: function(xhr){
			  console.log(xhr.status);
		  },
		  success: function(jsonObj){
			if(jsonObj.emailFlag){
				$("#certiTr").css("display","table-row");
				startTimer(); // 타이머 시작
			}else{
		  		alert("인증코드가 발송되지 않았습니다.")
	  		}//end else
		  }
		  });//ajax
	  
	});//click
	
	
	$("#certiCon").click(function() {
		  const inputCode = $("#certi").val();

		  $.ajax({
		    url: "email_verify.jsp", // 인증번호 비교 처리용 JSP
		    type: "POST",
		    data: { inputCode: inputCode },
		    dataType: "json",
		    success: function(jsonObj) {
		      if (jsonObj.result === "success") {
		        alert(" 인증 성공!");
		        clearInterval(timerInterval);
		        $("#timer").text("");
		        $("#certi").prop("readonly", true);
		      } else if (jsonObj.result === "timeout") {
		        alert(" 인증 시간이 초과되었습니다.");
		      } else {
		        alert(" 인증번호가 일치하지 않습니다.");
		      }
		    },
		    error: function(xhr) {
		      console.log("오류: " + xhr.status);
		    }
		  });
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
	
	$("#tel").keyup(function (evt) {
		const raw = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 추출

	    let formatted = '';
	    if (raw.length <= 3) {
	        formatted = raw;
	    } else if (raw.length <= 7) {
	        formatted = raw.slice(0, 3) + '-' + raw.slice(3);
	    } else {
	        formatted = raw.slice(0, 3) + '-' + raw.slice(3, 7) + '-' + raw.slice(7);
	    }

	    $(this).val(formatted);
	});

	
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
}//isStrongPassword

let timerInterval;
let timerSeconds = 180; // ✅ 꼭 전역에!
function startTimer() {
	  clearInterval(timerInterval); // 중복 방지
	  timerSeconds = 180;
	  console.log("🔁 타이머 시작", timerSeconds);
	  timerInterval = setInterval(function() {
	    let min = Math.floor(timerSeconds / 60);
	    let sec = timerSeconds % 60;
	    $("#timer").html(min + ":" + sec.toString().padStart(2, '0'));

	    if (timerSeconds-- <= 0) {
	      clearInterval(timerInterval);
	      $("#timer").html("시간초과");
	    }
	  }, 1000);
	}//startTimer

</script>
</head>

  <body class="signup-body">

<jsp:include page="/common/jsp/header.jsp"/>

  <form method="post" action="/Gung_On/signup/sign_up_process.jsp" class="signup-form" id="frm" name="frm">
    
    <!-- 약관 -->
    <!-- <div class="terms-box">
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
    </div> -->

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
			<input type="button" id="emailCon" value="이메일 인증" class="btn btn-success"/>
        </td>
      </tr>
      <tr id="certiTr" style="display: none;">
      <th>*인증번호</th>
      <td><input type="text" id="certi" style="width: 48.3%" maxlength="6" >
      <input type="button" value="인증번호 확인" id="certiCon" class="btn btn-success">
       <span id="timer" style="margin-left: 10px; font-weight: bold;"></span> <!-- 타이머 표시 -->
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
