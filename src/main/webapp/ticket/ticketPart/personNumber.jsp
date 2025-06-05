<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="결제DOM"%> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="http://192.168.10.71/gungProject/ticket/css/personNum.css"/> 
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 

</head>
<body>
<div class="classificationWrap">
    
        
    <table>
    <thead></thead>
    <tbody>
        <tr> 
      	<td style="width: 27%; line-height: 80%;">
            <span style="font-size:15px; font-weight: bold;">대인</span><br>
      	    <span style="font-size: 10px;">만 19세 이상<br>(경로포함)</span>
        </td>  
        <td style="width:30%;">
            <div class="ticketCost">￦5,000</div>
        </td>
        <td style="width:43%;">
            <div class="classifiationTable">
        	<div class="minusDiv"><img src="http://192.168.10.71/gungProject/ticket/images/minusImg.png"/></div>
        	<div class="personDiv">2</div>
        	<div class="plusDiv"><img src="http://192.168.10.71/gungProject/ticket/images/plusImg.png"/></div>
            </div>
        </td>
    </tr>
    <tr>
        <td style="line-height: 80%;">
            <span style="font-size: 15px; font-weight: bold;">소인</span><br>
            <span style="font-size: 10px;">만 7세 ~ 만 18세</span>
        </td>
        <td>
            <div class="ticketCost">￦2,500</div>
        </td>
        <td>
           <div class="classifiationTable">
        	<div class="minusDiv"><img src="http://192.168.10.71/gungProject/ticket/images/minusImg.png"/></div>
        	<div class="personDiv">3</div>
        	<div class="plusDiv"><img src="http://192.168.10.71/gungProject/ticket/images/plusImg.png"/></div>
            </div>
        </td>
    </tr>
    </tbody>
    </table>
        <div style="font-size:35px; float:right; margin-right: 30px; color:#FF4D4D">￦<span>17,500</span></div>
    <input type="button" value="완료" style="background-color:#FF4D4D; border: none; color:#FFFFFF; width: 120px; height:40px; margin-top: 30px; margin-left: 100px; font-size: 25px; text-align: center;margin-bottom: 30px;" />
</div><!--classificationWrap-->

</body>
</html>

