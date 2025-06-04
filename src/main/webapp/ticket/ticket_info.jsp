<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 


<style>
.user_wrap{
    position:relative;
}

.info_wrap img{
    vertical-align: middle;
}

.info_text {
    position:absolute;
    top:0px;
    color:white;
    margin-left: 20px;
    font-size:25px;
    transform: translate(-9%,12%);
    

}

.info_explain{
    width: 380px;
    font-size: 14px;
    /* margin-left: 40px; */

    border-style: solid;
    border-width:1px;
    border-color: black;
    
}

.check{
    font-size:15px;
}

input[type="checkbox"]{
    margin-left: 95px;
    zoom:1.0;
    /* vertical-align: -4px; */
}



input[type="button"] {
    width:100px;
    height: 40px;
    font-size:20px;
    text-align: center;
    margin-left:135px;
    background-color:#565E6D;
    color:white;
    /* display: block; */
}


</style><!--style-->

<!-- ---------------------------------------------------------------------------------- -->

<script type="text/javascript">



</script><!--text/javascript-->



</head>
<!-- ----------------------------------------------------------------------- -->
<body>
    <div class="info_wrap" >
        <div clss="info_img">
            <img src="./images/banner2.png"/>
        </div>
        <div class="info_text">
            <p>예약 안내</p>
        </div>
    </div><!--info_wrap-->
    <br>
    <div class="info_explain">
    <p>
        <span style="color:red">
        ※ 후원 관람권은 해당 회차의 후원 입장시간 15분 전까지만 구입할 수 있습니다.<br>
        ※ 봄, 가을 성수기에는 매표소 및 입장 대기줄이 길 수 있으니, 여유 있게 도착해 주십시오.<br>
        </span>
    </p>
    <p>
        ◎휴관일은 매주 월요일입니다.<br>
        *월요일이 공휴일이면 그 다음 평일에 휴관<br>
        <br>
        ◎후원관람은 회차별 시간제관람.<br>
        - 관람소요 시간은 약70분<br>
        *가장 안쪽 옥류천 구역은 문화재 보수중으로 제외<br>
        (기상상황, 기관사정등에 따라 관람 취소/단축/변경될 수 있습니다.)<br>
        <br>
        ◎ 전각관람은 개별자유관람으로 인원 제한없음<br>
    </p>
    <p>
        ※ 후원입구는 창덕궁 정문에서 도보로 10~15분<br>
        걸어감. 입장시각까지 후원입구에 모여 함께 입장함.<br>
        (늦으면 입장 및 환불 불가)<br>
        <span style="color:red">
        ※ 전각 및 후원티켓은 타인에게 재판매 불가<br>
        </span>
        *자세한 내용은 홈페이지를 참고해주세요.<br>
    </p>
    </div><!--info_explain-->

    <br>
    
    <label>
        <div class="check">
            <input type="checkbox" name="today_open_chk" />&nbsp;오늘 하루 다시 열지 않기<br>
        </div>
    </label>
    <br>
    <input type="button" name="today_open_btn" value="확인" /><br>
</body>
