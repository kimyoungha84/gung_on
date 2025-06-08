<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="tab_menu">
    <ul>
        <li class="item current"><a href="#;" data-tab="cs0">핵심 코스</a></li>
        <li class="item"><a href="#;" data-tab="cs1">역사 탐방 코스</a></li>
    </ul>
</div>

<div class="tab_con_wrap">
     <div class="tab_con cs0 current">
         <ol class="course_list">
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">대한문</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">중화전</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">즉조당/준명당</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">정관헌</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">석조전</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">덕수궁 돌담길</div></li>
         </ol>
          <div class="course_pop_slide swiper" id="course_pop_slide_dsg_cs0"> 
             <div class="swiper-wrapper">
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Daehanmun.jpg" alt="대한문"></div><div class="txt_wrap">대한문</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Junghwajeon.jpg" alt="중화전"></div><div class="txt_wrap">중화전</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Jeugjodang Junmyeongdang.jpg" alt="즉조당/준명당"></div><div class="txt_wrap">즉조당/준명당</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Jeonggwanheon.jpg" alt="정관헌"></div><div class="txt_wrap">정관헌</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Seokjojeon.jpg" alt="석조전"></div><div class="txt_wrap">석조전</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/core/Deogsugung doldamgil.jpg" alt="덕수궁 돌담길"></div><div class="txt_wrap">덕수궁 돌담길</div></div>
             </div>
             <div class="swiper-scrollbar"></div>
          </div>
     </div>

      <div class="tab_con cs1"> 
          <ol class="course_list">
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">대한문 (수문장 교대식)</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">중화전</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">즉조당/준명당</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">석어당</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">정관헌</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">석조전 </div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">중명전</div></li>
              <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">덕수궁 돌담길</div></li>
          </ol>
          <div class="course_pop_slide swiper" id="course_pop_slide_dsg_cs1"> 
             <div class="swiper-wrapper">
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Daehanmun.jpg" alt="대한문 (수문장 교대식)"></div><div class="txt_wrap">대한문 (수문장 교대식)</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Junghwajeon.jpg" alt="중화전"></div><div class="txt_wrap">중화전</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Jeugjodang Junmyeongdang.jpg" alt="즉조당/준명당"></div><div class="txt_wrap">즉조당/준명당</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Seokgeodang.jpg" alt="석어당"></div><div class="txt_wrap">석어당</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Jeonggwanheon.jpg" alt="정관헌"></div><div class="txt_wrap">정관헌</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Seokjojeon.jpg" alt="석조전 "></div><div class="txt_wrap">석조전 </div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Jungmyeongjeon.jpg" alt="중명전"></div><div class="txt_wrap">중명전</div></div>
                 <div class="swiper-slide"><div class="img_wrap"><img src="course_img/dsg_img/history/Deogsugung doldamgil.jpg" alt="덕수궁 돌담길"></div><div class="txt_wrap">덕수궁 돌담길</div></div>
             </div>
             <div class="swiper-scrollbar"></div>
          </div>
      </div>


</div>

