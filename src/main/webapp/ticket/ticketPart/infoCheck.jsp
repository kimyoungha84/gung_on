<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="정보 확인"%>
<!DOCTYPE html>
<html>


<!-- --------------------head-------------------------------------------- -->
<head>
<title>정보 확인</title>

<link rel="stylesheet" type="text/css" href="http://localhost/gungProject/ticket/css/info_check.css"/> 
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 
<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://localhost/gungProject/common/images/gungOnFavicon.ico"/>



</head>

<!-- ---------------------body--------------------------------------- -->

<body>
 <div class="entireWrap">
<h1>정보 확인</h1>


  <div class="authenPhoneNum" style="margin-top: 40px;">
            <span class="classificationPerson">대인 1</span><input type="text" class="phoneNumInput" placeholder="전화번호를 입력해주세요." /><input type="button" value="인증" class="authenBtn"/>
        </div>
        <div class="authenPhoneNum">
            <span class="classificationPerson">대인 2</span><input type="text" class="phoneNumInput" placeholder="전화번호를 입력해주세요."/><input type="button" value="인증" class="authenBtn"/>
        </div>
        <div class="authenPhoneNum" style="margin-bottom: 30px;">
            <span class="classificationPerson">대인 3</span><input type="text" class="phoneNumInput" placeholder="전화번호를 입력해주세요."/><input type="button" value="인증" class="authenBtn"/>
        </div>

    </div><!--classificationAge-->

    <div class="authenInfo" style="font-size: 10px; margin-left: 10px; margin-right: 10px;">
        ※ 행사 입장 QR 코드를 제공받을 수 있는 휴대폰 번호를 입력해주세요.<br>
        행사 입장 QR 코드 전송 및 입장 확인 외의 목적에는 사용하지 않습니다.<br>

        <br>
        ※ 중복으로 번호를 입력하실 경우, 해당 번호로 행사 입장 QR 코드가 모두 전송됩니다.<br>
    
    </div>

 
<div class="explain">
<span style="color:#FF0000">※ 휴대폰 번호를 정확히 확인해 주세요.</span><br>
휴대폰 번호를 올바르게 입력하셨습니까?<br>
</div>

<div class="btn-group">
<input type="button" class="btn  yesBtn" value="네" style="margin-right: 30px"/> 
<input type="button" class="btn  noBtn" value="아니오" style="margin-left: 30px"/> 
</div>

</div><!--entireWrap-->

</body>

</html>