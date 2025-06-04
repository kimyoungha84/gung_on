<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/jsp/login_chk.jsp" %>
<% 
String email=((MemberDTO) session.getAttribute("userData")).getUseEmail();
String id = ((MemberDTO) session.getAttribute("userData")).getId();
String domain=email.substring(email.indexOf("@")+1);
email = email.substring(0,email.indexOf("@"));

pageContext.setAttribute("email", email);
pageContext.setAttribute("domain", domain);

session.setAttribute("changePass", true);
session.setAttribute("id", id);
  %>
 <!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <!-- 기타 공통 스타일 -->
  <link rel="stylesheet" href="/Gung_On/common/css/common.css">
  <c:import url="/common/jsp/external_file.jsp"/>

  

 <script type="text/javascript">
$(function(){
	
	$("#detailProgram").click(function(){
		location.href="/Gung_On/mypage/detail_program.jsp";
		
	});
	
	$("#btnConfirm").click(function(){
		if (!checkField()) return; // 여기서 잘못되면 중단
		
		 var param = {id:"${userData.id}", 
				tel: $("#tel").val(), 
				email: $("#email").val(), 
				domain:$("#domain").val()};
		$.ajax({
			  url:"mypage_process.jsp",
		  type:"POST",
		  data:param,
		  dataType:"JSON",
		  error: function(xhr){
			  console.log(xhr.status);
		  },
		  success: function(jsonObj){
			  if (jsonObj.modifyFlag) {
			        alert("회원 정보 수정 완료");
			        location.reload();
			      } else {
			        alert("수정 실패");
			      }
		  }
		  });//ajax
		
		
	});//click
	
	$("#changePass").click(function(){
		
		location.href="/Gung_On/mypage/changePassword.jsp";
	})
	
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

  
  
  
  
  
  
    function showTab(tabId) {
      const tabs = document.querySelectorAll('.tab-content');
      const buttons = document.querySelectorAll('.tab-button');

      tabs.forEach(tab => tab.classList.add('hidden'));
      buttons.forEach(btn => btn.classList.remove('active'));

      document.getElementById(tabId).classList.remove('hidden');
      document.getElementById(tabId + '-btn').classList.add('active');
    }

    window.addEventListener('DOMContentLoaded', () => {
      showTab('info-tab');
    });
  </script>
</head>
<body>

<jsp:include page="/common/jsp/header.jsp"/>

<!-- ✅ 탭 버튼 -->
<div class="tab-container" style="position: relative; right: 70px">
  <div id="info-tab-btn" class="tab-button" onclick="showTab('info-tab')">회원정보수정</div>
  <div id="reserve-tab-btn" class="tab-button" onclick="showTab('reserve-tab')">예약내역</div>
</div>


<!-- ✅ 탭 내용 1: 회원정보수정 -->
<div id="info-tab" class="tab-content" style="position: relative; right: 70px">
  <form method="post" name="frm" id="frm" action="/Gung_On/process.jsp" class="signup-form" style="width: 900px;">
    <table class="signup-table">
      <tr>
        <th>아이디</th>
        <td><div class="id-row"><span><c:out value="${ userData.id }"/></span></div></td>
      </tr>
      <tr>
        <th>이름</th>
        <td><div class="id-row"><span><c:out value="${ userData.name }"/></span></div></td>
      </tr>
      <tr>
        <th>휴대폰</th>
        <td><input style="width: 73%" value="${ userData.tel }" type="text" id="tel" name="tel" maxlength="13"></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td class="email-domain">
          <input type="text" id="email" value="${ email }" name="email" style="width: 35.3%"> @
          <input list="domainList" id="domain" value="${ domain }" name="domain" style="width: 35.3%; height: 42px" placeholder="도메인 입력 또는 선택">
			<datalist id="domainList">
			  <option value="naver.com">
			  <option value="daum.net">
			  <option value="gmail.com">
			</datalist>
        </td>
      </tr>
    </table>
    <div class="submit-buttons">
      <button type="button" class="submit" id = "btnConfirm">수정</button>
      <button type="button" class="submit btn btn-success" id = "changePass">비밀번호 변경</button>
    </div>
    <a href="/Gung_On/mypage/removeAccount.jsp" class="withdraw-link">회원탈퇴</a>
  </form>
</div>

<!-- ✅ 탭 내용 2: 예약내역 -->
<div id="reserve-tab" class="tab-content hidden"  >
  <form class="signup-form" style="width: 900px; position: relative; right: 70px"  >
    <table style="width: 100%; border: 1px solid #ccc; border-collapse: collapse; text-align: center;">
      <thead style="background-color: #f9f9f9;">
        <tr>
          <th style="border: 1px solid #ccc; padding: 8px;">예매 정보</th>
          <th style="border: 1px solid #ccc; padding: 8px;">관람</th>
          <th style="border: 1px solid #ccc; padding: 8px;">예약 일자</th>
          <th style="border: 1px solid #ccc; padding: 8px;">해설 언어</th>
          <th style="border: 1px solid #ccc; padding: 8px;">예약 인원</th>
          <th style="border: 1px solid #ccc; padding: 8px;">결제 금액</th>
        </tr>
      </thead>
      <tbody>
        <tr id="detailProgram" style="cursor: pointer;">
          <td style="border: 1px solid #ccc; padding: 8px;">20250501133211</td>
          <td style="border: 1px solid #ccc; padding: 8px;">경복궁 공식 해설</td>
          <td style="border: 1px solid #ccc; padding: 8px;">2025-05-05 11:00</td>
          <td style="border: 1px solid #ccc; padding: 8px;">한국어</td>
          <td style="border: 1px solid #ccc; padding: 8px;">대인 3명</td>
          <td style="border: 1px solid #ccc; padding: 8px;">15,000원</td>
        </tr>
      </tbody>
    </table>
  </form>
</div>
<jsp:include page="/common/jsp/footer.jsp"/>

</body>
</html>
