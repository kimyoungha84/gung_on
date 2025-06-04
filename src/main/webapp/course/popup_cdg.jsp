<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="tab_menu">
    <ul>
        <li class="item current"><a href="#;" data-tab="cs0">전각  코스</a></li>
        <li class="item"><a href="#;" data-tab="cs1">후원  코스</a></li>
    </ul>
</div>

<div class="top">
    <div class="right half">
        <div class="tab_con_wrap">
            <div class="tab_con cs0 current">
                <ol class="course_list">
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">돈화문</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">금천교</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">인정전</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">선정전</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">희정당</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">대조전</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">낙선재</div></li>
                </ol>
            </div>
            <div class="tab_con cs1">
                <ol class="course_list">
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">후원</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">부용지</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">애련지</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">관람지</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">연경당</div></li>
                    <li class="course_item "><div class="course_dot"><div class="inn"></div></div><div class="course_txt">향나무</div></li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="btm tab_con_wrap"> 
    <div class="tab_con cs0 current"> 
        <div class="course_pop_slide swiper" id="course_pop_slide_cdg_cs0">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Donhwamun.jpg" alt="돈화문">
                        </div>
                        <div class="txt_wrap">돈화문</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Geumcheongyo.jpg" alt="금천교">
                        </div>
                        <div class="txt_wrap">금천교</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Injeongjeon.jpg" alt="인정전">
                        </div>
                        <div class="txt_wrap">인정전</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Seonjeongjeon.jpg" alt="선정전">
                        </div>
                        <div class="txt_wrap">선정전</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Huijeongdang.jpg" alt="희정당">
                        </div>
                        <div class="txt_wrap">희정당</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Daejojeon.jpg" alt="대조전">
                        </div>
                        <div class="txt_wrap">대조전</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/jeongag/Nakseonjae.jpg" alt="낙선재">
                        </div>
                        <div class="txt_wrap">낙선재</div>
                    </div>
                </div>
                <div class="swiper-scrollbar"></div>
         </div>
    </div>

    <div class="tab_con cs1"> 
        <div class="course_pop_slide swiper" id="course_pop_slide_cdg_cs1">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Hu.jpg" alt="후원">
                        </div>
                        <div class="txt_wrap">후원</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Buyongji.jpg" alt="부용지">
                        </div>
                        <div class="txt_wrap">부용지</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Aelyeonji.jpg" alt="애련지">
                        </div>
                        <div class="txt_wrap">애련지</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Gwanlamji.jpg" alt="관람지">
                        </div>
                        <div class="txt_wrap">관람지</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Yeongyeongdang.jpg" alt="연경당">
                        </div>
                        <div class="txt_wrap">연경당</div>
                    </div>
                <div class="swiper-slide">
                        <div class="img_wrap">
                            <img src="course_img/cdg_img/huwon/Hyangnamu.jpg" alt="향나무">
                        </div>
                        <div class="txt_wrap">향나무</div>
                    </div>
                </div>
                <div class="swiper-scrollbar"></div>
         </div>
    </div>
</div>
