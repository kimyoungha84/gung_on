<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
  <meta charset="UTF-8">
  <title>궁온 - 고객센터 - 1:1문의</title>
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/common.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/reset.css" />
  <link rel="stylesheet" type="text/css" href="/Gung_On/common/royal_css/layout.css" />
  

  <style>
    /* 이미지 정중앙 고정 및 반투명 처리 */
    
    .sub_con_wrap {
	border-top: 2px solid #333;
	text-align: center; 
	display: flex; 
	justify-content: center; 
	align-items: center;
	}
    
    
    
    
    .background-image {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0.25;
      z-index: -1;
      width: 850px; /* 필요에 따라 조절 */
      height: auto;
    }
   .lnb_wrap {
  	/* position: fixed; */
  	position: absolute;
  	top: 300px; /* 상단에서 거리 조절 */
  	left: 65px;
  	width: 300px; /* 원하는 너비 */
  	z-index: 1000; /* 다른 요소보다 위로 오도록 */
	}

  </style>
  
<script type="text/javascript">
$(function(){
	$("#noticeItem").click(function(){
	alert("공지사항 아이템 클릭");
	});//click
});//ready


</script> 
  
  
  
</head>

<body class="p-4">
  <!-- 실제 보이는 이미지 태그로 변경 -->
  <img class="background-image" src="/Gung_On/common/images/cs/궁온.png" alt="배경 이미지">

  <header class="customHeader">
    <%@ include file="/common/jsp/header.jsp" %>
  </header>

  <!-- <div class="mb-4" style="width: 700px; margin: 0 auto;"> -->
  <div class="mb-4" style="width: 1000px; margin: 200px auto 0 auto; border-bottom: 2px solid #333">
<%@ include file="side.jsp" %>
   <h2 style="font-size: 35px; font-weight: bold;">공지사항</h2><br>
   
   
 <div class="sub_con_wrap pt0">
  <div class="warning" style="width:800px; height: 500px; margin-top: 50px;">
    <h2 style="font-size: 30px;">해당 서비스는 로그인이 필요합니다.</h2>
    <!-- 로그인버튼 클릭 시 로그인페이지로 이동 (미구현) -->
    <input type="button" value="로그인하러가기" id="loginBtn" style="font-size : 17px; width: 150px; height: 60px; margin: 50px;"/>
  </div>  
 </div>
</div>



  <br>

  <footer>
    <%@ include file="/common/jsp/footer.jsp" %>
  </footer>
</body>
</html>
