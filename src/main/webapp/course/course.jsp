<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관람코스</title>

  <link rel="stylesheet" type="text/css" href="/Gung_On/course/css/course_style.css" />
  <c:import url="/common/jsp/external_file.jsp"/>

<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="https://unpkg.com/@panzoom/panzoom@4.5.1/dist/panzoom.min.js"></script>

<script type="text/javascript">
  window.addEventListener('DOMContentLoaded', () => {
    const elem = document.getElementById('panzoom-container');
    const panzoom = Panzoom(elem, {
      maxScale: 5,
      minScale: 0.5,
      step: 0.2
    });

    // 마우스 휠로 줌
    elem.parentElement.addEventListener('wheel', panzoom.zoomWithWheel);

    // 버튼 이벤트
    document.getElementById('zoomInButton').addEventListener('click', () => panzoom.zoomIn());
    document.getElementById('zoomOutButton').addEventListener('click', () => panzoom.zoomOut());
    document.getElementById('resetButton').addEventListener('click', () => panzoom.reset());
  });
</script>


<script type="text/javascript">
	/*tab_menu*/
	$(".tab_link a").on("click", function() {
		var thisCon = "." + $(this).parent().attr("data-tab");

		$(this).closest(".tab_menu").find('.tab_link').removeClass('current');
		$(this).closest(".tab_menu").find(".hidden").remove();
		$(this).parent().addClass('current');
		$(this).append('<span class="hidden">현재 선택됨</span>');

		$(thisCon).siblings(".tab_con").removeClass("current");
		$(thisCon).addClass("current");

		if ($(".tab_con .slick-slider").length != 0) {
			$('.slick-slider').resize();
			$('.slick-slider').slick('refresh');
		}
	});



	var pop_swiper = new Swiper(".course_pop_slide", {
		slidesPerView : 2,
		spaceBetween : 20,
		initialSlide : 0,
		observer : true,
		observeParents : true,
		navigation : {
			nextEl : ".pop_course .popup_body .btm .swiper-button-next",
			prevEl : ".pop_course .popup_body .btm .swiper-button-prev",
		},
		breakpoints: {
			1024: {
			slidesPerView: 5,
			spaceBetween : 35,
			},
		},
	});

	$(function() {
		//궁능그룹 박스 활성화
		$(".reservation_tab").show();

		//궁능선택
		var admGroup = "gbg";
		if(admGroup == 'rtm'){
			$(".map_select_wrap").show();
// 			fn_thombChange('');
		}

		//기본 맵
		fn_viewCourseList("all");

		//우측버튼(전체,둘러보기,편의시설)
		$(document).on("click", ".course_tab_wrap > .course_tab > li.tab_link", function(){
			//맵이미지
			var id = $(this).attr("data-tab");
			fn_viewCourseList(id);
		});

		$(".pop_course .tab_link a").click(function() {
			var idx = $(".pop_course .tab_link a").index($(this));
			setTimeout(function() {
				pop_swiper[idx].slideTo(0);
				pop_swiper[idx].update();
			}, 100);

			var thisCon = "." + $(this).attr("data-tab");

			$(this).closest(".tab_menu").find('.tab_link').removeClass('current');
			$(this).closest(".tab_menu").find(".hidden").remove();
			$(this).addClass('current');
			$(this).append('<span class="hidden">현재 선택됨</span>');

			$(thisCon).siblings(".tab_con").removeClass("current");
			$(thisCon).addClass("current");

			if ($(".tab_con .slick-slider").length != 0) {
				$('.slick-slider').resize();
				$('.slick-slider').slick('refresh');
			}
		});

		$('.pop_close').on('focusout',function(){
			$('.pop_course').closest(".dim").hide();
			$('.pop_course').hide();
			$('.course_tab .tab_link a').focus();
		});

		$('.course_map_wrap .amenities_wrap ul li a').on('click', function(e){
			e.preventDefault();
		});
		
	});

	var queryString = "";
	  function dragstartHandler(ev) {
	    // Add the target element's id to the data transfer object
	    ev.dataTransfer.setData("text/plain", ev.target.id);
	  }

	function fn_viewCourseList(_id) {
		HoldOn.open();
		var gubun = "ALL";
		var gubunNm = "전체";

		if(_id == "tour"){
			gubun = "VIW";
			gubunNm = "둘러보기";
		}else if(_id == "amenities"){
			gubun = "FAC";
			gubunNm = "편의시설";
		}

		var schGroupCode = "gbg";
		var params = {
			schGubun : gubun,
			schList : "list",
			siteCode : "ROYAL",
			schGroupCode : schGroupCode
		}
		if(schGroupCode == "rtm") {
			params = {
				schGubun : gubun,
				schList : "list",
				schGroupCode : schGroupCode,
				siteCode : "ROYAL",
				title : ""
			}
		}
		$.ajax({
			type : "post",
			url : "/ROYAL/module/R701000000_viewCourseList.ajax",
			data : params,
			dataType : "json",
			beforeSend : false,
			async : false,
			success : function(data) {
				if(data.result[0] != null && data.result[0].fileId != null) {

					var addhtml = "";
					addhtml += '<div class="hidden">'+gubunNm+'</div>';
					addhtml += '<div class="course_map">';
					addhtml += '	<img src="/afile/previewThumbnail/'+data.result[0].fileId+'" alt="'+data.result[0].gubunNm+'"/>';
					addhtml += '</div>';
					//$(".map_info").empty().html(addhtml);
					$(".map_info").addClass("current");

					$(".map_content").attr("src","/afile/previewThumbnail/"+data.result[0].fileId);
					$(".map_content").attr("alt",data.result[0].gubunNm);
					$(".gubunNm").text(gubunNm);

					if(_id == "tour"){
						$('.course_map_wrap .amenities_wrap').addClass('hid');
					}else{
						$('.course_map_wrap .amenities_wrap').removeClass('hid');
					}

					fn_imageLoad("20231006174040783840","23121340174Lmpv5",'.cm1',1);
				}else{
					HoldOn.close();
				}
			},
			error : function(request, status, error) {
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_imageLoad(vcIdx, fileId, btn, idx) {
		var params = {
			vcIdx : vcIdx,
			fileId : fileId,
			siteCode : "ROYAL",
			schGubun : "VIW",
			schGroupCode : "gbg",
			idx: idx
		}
		$.ajax({
			type : "post",
			url : "/ROYAL/module/R701000000_viewCourse_getPhoto.ajax",
			data : params,
			dataType : "html",
			beforeSend : false,
			async : false,
			success : function(data) {
				$("#photoDiv").empty().html(data);
				HoldOn.close();
			},
			error : function(request, status, error) {
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_thombChange(idx){
		var tmpQuery = queryString;
		tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "schGroupCode", "gbg");
		tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "vcIdx", idx.value);
		tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "title", $("select[name=title] option:selected").text());
		tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "schGubun", "ALL");

		location.href="?" + tmpQuery;
	}
</script><!-- [S] survey_wrap -->
<script type="text/javascript">
	/* 탭 구분 변경 function */
	function fn_goSchGrpCode(grpCode, grpCodeNm){
		var queryString = "";
		if(queryString == "") queryString = "";
		var tmpQuery = queryString;

				tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "schGroupCode", grpCode);
				tmpQuery = ManpaJs.fn_replaceQueryString(tmpQuery, "schGroupCodeNm", grpCodeNm);
			
		location.href = "?" + tmpQuery;
	}
</script><!-- [S] sub_con_wrap -->
<script type="text/javascript" src="course_js/panzoom.min.js"></script>
<style type="text/css">
.f-custom-controls {
	position: absolute;
	border-radius: 4px;
	overflow: hidden;
	z-index: 1;
}

.f-custom-controls.top-right {
	right: 16px;
	top: 16px;
}

.f-custom-controls.bottom-right {
	right: 16px;
	bottom: 16px;
}

.f-custom-controls button {
	width: 32px;
	height: 32px;
	background: none;
	border: none;
	margin: 0;
	padding: 0;
	background: #222;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
}

.f-custom-controls svg {
	pointer-events: none;
	width: 18px;
	height: 18px;
	stroke: #fff;
	stroke-width: 2;
}

.f-custom-controls button[disabled] svg {
	opacity: 0.7;
}
</style>

</head>
<body class="main">

  <!-- 상단 메뉴 등 -->
  <jsp:include page="/common/jsp/header.jsp" />

  <!-- 본문:  -->
  <main>

    
    <!-- 사이드바와 콘텐츠를 감싸는 container div -->
    <div class="container">
        <div class="sidebar">
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="/Gung_On/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="/Gung_On/course/course_time.jsp">관람시간</a></li>
                    <li><a href="/Gung_On/course/course.jsp" class="active">관람코스</a></li>
                    <li><a href="/Gung_On/course/users_course.jsp">사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>
        	<article class="content">
            <h1>관람코스</h1>
        


<!-- [S] sub_con_section -->
<div class="sub_con_section">
	<div class="tab_con_wrap">
		<div class="tab_con current">
			<!-- [S] course_tab_wrap -->
					<div class="course_tab_wrap">
						<!-- [S] 코스안내 -->
						<div class="left course_pop_con">
							<span class="course_tit"><img src="course_img/ic_loca.jpg" alt=""> 코스안내</span>
								<ul class="list course_info_list">
									<li class="item">
											<a href="#;" data-num="0"><span class="inn">🚶40분  코스</span></a>
										</li>
									<li class="item">
											<a href="#;" data-num="1"><span class="inn">🚶60분  코스</span></a>
										</li>
									<li class="item">
											<a href="#;" data-num="2"><span class="inn">🚶90분 코스</span></a>
										</li>
									</ul>
							</div>
						<ul class="course_tab tab_menu right">
							<li class="tab_link current" data-tab="total"><a href="#;">전체</a></li>
							<li class="tab_link" data-tab="tour"><a href="#;">둘러보기</a></li>
							<li class="tab_link" data-tab="amenities"><a href="#;">편의시설</a></li>
						</ul>
						<select class="sel_st">
            		<option value="1" selected="selected">경복궁</option>
            		<option value="2">창덕궁</option>
            		<option value="3">덕수궁</option>
            		<option value="4">창경궁</option>
            		<option value="5">경희궁</option>
             </select>
					</div>
					<div class="course_map_wrap" id="course_map_wrap">
						<div class="course_map_fix">
							<div class="amenities_wrap">
									<ul>
										<li><a href=""><em><img src="course_img/icon_1.svg" alt=""></em><span>안내</span></a></li>
										<li><a href=""><em><img src="course_img/icon_2.svg" alt=""></em><span>매표소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_3.svg" alt=""></em><span>음성안내기 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_4.svg" alt=""></em><span>휠체어 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_5.svg" alt=""></em><span>유모차 대여소</span></a></li>
										<li><a href=""><em><img src="course_img/icon_6.svg" alt=""></em><span>주차장</span></a></li>
										<li><a href=""><em><img src="course_img/icon_7.svg" alt=""></em><span>기념품점</span></a></li>
										<li><a href=""><em><img src="course_img/icon_8.svg" alt=""></em><span>물품보관함</span></a></li>
										<li><a href=""><em><img src="course_img/icon_9.svg" alt=""></em><span>수유실</span></a></li>
										<li><a href=""><em><img src="course_img/icon_10.svg" alt=""></em><span>자판기</span></a></li>
										<li><a href=""><em><img src="course_img/icon_11.svg" alt=""></em><span>휠체어리프트</span></a></li>
										<li><a href=""><em><img src="course_img/icon_12.svg" alt=""></em><span>화장실</span></a></li>
										<li><a href=""><em><img src="course_img/icon_13.svg" alt=""></em><span>구급약</span></a></li>
										<li><a href=""><em><img src="course_img/icon_14.svg" alt=""></em><span>심장제세동기</span></a></li>
									</ul>
								</div>
						</div>
						<div class="tab_con_wrap">
							<div class="tab_con map_info current">
								<div class="hidden gubunNm">전체</div>
								<div class="f-custom-controls top-right">
								
								
										<button id="zoomInButton" class="zoomIn" data-panzoom-action="zoomIn" title="확대">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M12 5v14M5 12h14"></path>
								            </svg>
										</button>
										<button id="zoomOutButton" class="zoomOut" data-panzoom-action="zoomOut" title="축소">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M5 12h14"></path>
								            </svg>
										</button>
										<button id="resetButton" class="zoomReset" data-panzoom-action="zoomReset" data-panzoom-change="{" angle":="" 90}"="" title="초기화">
											<img src="course_img/ic_refresh.png" width="20px">
										</button>
									</div>
								<div class="course_map" style="overflow: hidden; user-select: none; touch-action: none;">
									<div class="zoomable" id="panzoom-container" style="cursor: move; user-select: none; touch-action: none; transform-origin: 50% 50%; transition: none; transform: scale(1) translate(0px, 0px);">
										<img data-id="1" class="map_content" src="course_img/gbg_img/gbg_map_all.png" alt="전체 맵" draggable="true">
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- [E] course_map_wrap -->

					<!-- [S] course_info -->
						<div class="course_info box_wrap">
							<img src="course_img/ic_info.png" alt=""> 번호를 클릭하시면 아래 화면에서 시설사진을 볼 수 있습니다.
						</div>
						<!-- [E] course_info -->

						<!-- [S] course_num_list -->
						<ul class="course_num_list tab_menu">
							<li class="child_tab_menu course_num_item tab_link current cm1" data-num="1" data-tab="cm1">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121340174Lmpv5',this, '1');"><span class="num">1</span>근정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121304563Ek5Ar',this, '2');"><span class="num">2</span>사정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121333831OgUjv',this, '3');"><span class="num">3</span>수정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121351810EPWVA',this, '4');"><span class="num">4</span>경회루</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121352494fKbpi',this, '5');"><span class="num">5</span>강녕전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121352290jX3Fb',this, '6');"><span class="num">6</span>교태전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm7" data-num="7" data-tab="cm7">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121315081weCj4',this, '7');"><span class="num">7</span>동궁</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm8" data-num="8" data-tab="cm8">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121300614f7RJr',this, '8');"><span class="num">8</span>소주방</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm9" data-num="9" data-tab="cm9">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121358610AnIVt',this, '9');"><span class="num">9</span>자경전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm10" data-num="10" data-tab="cm10">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121318313CRCkR',this, '10');"><span class="num">10</span>흥복전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm11" data-num="11" data-tab="cm11">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121309222CtUl7',this, '11');"><span class="num">11</span>향원정</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm12" data-num="12" data-tab="cm12">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121309504FKs4D',this, '12');"><span class="num">12</span>건청궁</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm13" data-num="13" data-tab="cm13">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121334419sSdJm',this, '13');"><span class="num">13</span>집옥재</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm14" data-num="14" data-tab="cm14">
									<a href="#;" onclick="fn_imageLoad('20231006174040783840','23121341262qSWlp',this, '14');"><span class="num">14</span>태원전</a>
								</li>
							</ul>
						<!-- [E] course_num_list -->
					<div id="photoDiv">


<!-- Empty Layout -->
<!-- [S] course_num_con -->
<div class="tab_con_wrap course_slide_wrap">
		<div class="tab_con cm1 current" data-tab="cm1">
				<h3 class="txt_section_tit vcPartTitle">
								근정전</h3>
                        <div class="hidden">
					근정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal swiper-backface-hidden course_slide0">
					<div class="swiper-wrapper" id="swiper-wrapper-67eeb24bcfc6c0910" aria-live="polite">
						<div class="swiper-slide swiper-slide-active swiper-slide-next" data-seq="8" role="group" aria-label="1 / 1" data-swiper-slide-index="0" style="width: 100%">
								<img src="course_img/gbg_img/경복궁_근정전_근정전 전체 전경(궁능유적본부).jpg" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p class="0" style="margin-right: 0px; margin-left: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; text-align: justify;"><span style="color: rgb(19, 19, 19);">근정전(勤政殿)은 경복궁의 정전으로 왕의 즉위식, 신하들의 하례, 외국 사신의 접견, 궁중연회 등 중요한 국가행사를 치르던 곳이다. 근정전은&nbsp;궁궐 내에서도 가장 규모가 크고 격식을 갖춘 건물로 면적도 가장 넓게 차지하고 있다.&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">근정전 앞마당</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">은 다른 궁궐의 정전과 같이 박석이 깔려있고</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">,&nbsp;</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">중앙에는 삼도</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">(</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">三道</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">)</span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">를 두어 궁궐의 격식을 갖추었으며 조정에는 </span><span style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box;">품계석을 놓았다</span><span lang="EN-US" style="margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; letter-spacing: 0pt;">.</span></p>
<div></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm2" data-tab="cm2">
				<h3 class="txt_section_tit vcPartTitle">
								사정전</h3>
                        <div class="hidden">
					사정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide1">
					<div class="swiper-wrapper" id="swiper-wrapper-a6d6a2d54fb10ce80" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">사정전(思政殿)은 왕이 신하들과 함께 일상 업무를 보던 공식 집무실인 편전(便殿)이다. 이곳에서 매일 아침 업무 보고와 회의, 경연 들이 이루어졌다.&nbsp;사정전 좌우에는 만춘전(萬春殿)과 천추전(千秋殿)은 사정전의 부속건물로 사정전에 없는 온돌시설이 갖추어져 있어 사계절로 이용이 가능하였던 것으로 보인다.</div>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm3" data-tab="cm3">
				<h3 class="txt_section_tit vcPartTitle">
								수정전</h3>
                        <div class="hidden">
					수정전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide2">
					<div class="swiper-wrapper" id="swiper-wrapper-ca5a3110917a17996" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">수정전(修政殿)은 고종 대 편전으로 사용했던 건물이다.&nbsp;경복궁 창건 당시에는 없었으나 고종 대 경복궁을 다시 지을 때 지은 건물이다.&nbsp;1894년(고종 31) 갑오개혁 때 군국기무처가 들어섰고, 이후 의정부(議政府)가 내각(內閣)으로 바뀌면서 내각의 청사로 사용되었다.&nbsp;특히 조선 초기 수정전 일대에는 세종 대에 훈민정음 창제의 산실인 집현전이 있었다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm4" data-tab="cm4">
				<h3 class="txt_section_tit vcPartTitle">
								경회루</h3>
                        <div class="hidden">
					경회루</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide3">
					<div class="swiper-wrapper" id="swiper-wrapper-f8f5d86da2107883e" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="text-align: justify;">경회루(慶會樓)는 경복궁 침전영역 서쪽에 위치한 연못 안에 조성된 누각으로,&nbsp;왕이 신하들과 규모가 큰 연회를 열거나 외국 사신을 접대하던 곳이다.&nbsp;</span><span style="text-align: justify;">경회루의 1층은 48개(둥근 기둥과 네모난 기둥 각 24개)의 높은 돌기둥들만 세웠으며, 2층에 마루를 깔아 연회장으로 이용했다. 추녀마루에는 우리나라 건물 가운데 가장 많은 11개의 잡상(雜像)이 있다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm5" data-tab="cm5">
				<h3 class="txt_section_tit vcPartTitle">
								강녕전</h3>
                        <div class="hidden">
					강녕전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide4">
					<div class="swiper-wrapper" id="swiper-wrapper-d015deff431101621" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">강녕전(康寧殿)은 교태전과 함께 왕과 왕비가 일상생활을 하던&nbsp;침전이다. 강녕전은 왕의 침전으로,&nbsp;왕은 이곳에서 독서와 휴식 등 일상생활뿐 아니라 신하들과 은밀한 정무를 보기도 하였다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">건물 앞에는 넓은 월대가 있고, 지붕 위에 용마루가 없는 건물이다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">지금의 강녕전은 1995년에 복원하였다.&nbsp;</span><span style="color: rgb(19, 19, 19);">강녕전 주변으로는 경성전(慶成殿), 연생전(延生殿), 응지당(膺祉堂), 연길당(延吉堂) 등 강녕전 부속건물이 있다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm6" data-tab="cm6">
				<h3 class="txt_section_tit vcPartTitle">
								교태전</h3>
                        <div class="hidden">
					교태전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide5">
					<div class="swiper-wrapper" id="swiper-wrapper-c9d47e86ea7d11e4" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">교태전(交泰殿)은 강녕전과 함께 왕과 왕비가 일상생활을 하던 침전이자,&nbsp;왕비의 생활공간이다. 교태전은 궁궐의 가장 가운데에 위치하고 있어, 왕비의 생활공간이기 때문에 중궁전이라고도 부른다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">강녕전과 마찬가지로 지붕 위에 용마루가 없고 내부 모습은 비슷하나, 건물 앞에 월대는 없다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">지금의 교태전은 1995년에 복원한 것이다.&nbsp;</span><span style="color: rgb(19, 19, 19);">교태전 뒤로는 아미산(峨嵋山)이라는 왕비를 위한 후원을 조성하였다.</span><span style="color: rgb(19, 19, 19);">&nbsp;</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm7" data-tab="cm7">
				<h3 class="txt_section_tit vcPartTitle">
								동궁</h3>
                        <div class="hidden">
					동궁</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide6">
					<div class="swiper-wrapper" id="swiper-wrapper-a09e7151aff9e25a" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">동궁(東宮) 영역은 왕세자와 왕세자빈의 교육공간이자 생활공간으로 궁궐의 동쪽에 있어 동궁, 또는 세자궁이라고 부른다.&nbsp;현재 동궁 영역에는 왕세자와 왕세자빈의 생활공간인 자선당(資善堂)과 왕세자의 교육과 정무를 보던 비현각(丕顯閣), 그리고 동궁의 정당(正堂)인 계조당(繼照堂)이 있다.&nbsp;</span><span style="color: rgb(19, 19, 19); text-align: justify;">자선당과 비현각은 1999년에, 계조당은 2023년에 복원하였다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm8" data-tab="cm8">
				<h3 class="txt_section_tit vcPartTitle">
								소주방</h3>
                        <div class="hidden">
					소주방</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide7">
					<div class="swiper-wrapper" id="swiper-wrapper-2468e9326aa5af72" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p class="0" style="text-align: justify;">소주방<span lang="EN-US" style="letter-spacing: 0pt;">(</span><span style="letter-spacing: 0pt;">燒廚房</span><span lang="EN-US" style="letter-spacing: 0pt;">)</span>은 왕의 수라와 궁중의 잔치 음식 등을 준비하던 궁중 부엌이다<span lang="EN-US" style="letter-spacing: 0pt;">. </span>이곳은 왕의 수라를 만들던 내소주방(內燒廚房)<span lang="EN-US" style="letter-spacing: 0pt;">, </span>궁중 잔치나 고사 음식을 차리던 외소주방(外燒廚房)<span lang="EN-US" style="letter-spacing: 0pt;">, </span>그리고 간식<span lang="EN-US" style="letter-spacing: 0pt;">, </span>죽<span lang="EN-US" style="letter-spacing: 0pt;">, </span>과일<span lang="EN-US" style="letter-spacing: 0pt;">, </span>떡 등을 차리던 생물방<span lang="EN-US" style="letter-spacing: 0pt;">(</span><span style="letter-spacing: 0pt;">生物房</span><span lang="EN-US" style="letter-spacing: 0pt;">) </span>세 구역으로 나뉘어 있다<span lang="EN-US" style="letter-spacing: 0pt;">. </span>현재의 소주방은 <span lang="EN-US" style="letter-spacing: 0pt;">2015</span>년에 복원한 것이다<span lang="EN-US" style="letter-spacing: 0pt;">.</span></p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm9" data-tab="cm9">
				<h3 class="txt_section_tit vcPartTitle">
								자경전</h3>
                        <div class="hidden">
					자경전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide8">
					<div class="swiper-wrapper" id="swiper-wrapper-bf86705c767e302f" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="margin-right: 0px; margin-left: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; box-sizing: border-box; text-align: justify;"><span style="color: rgb(19, 19, 19);">자경전(慈慶殿)은 1867년(고종 4) 경복궁을 다시 지을 때 신정황후 조씨(24대 헌종의 어머니이자 26대 고종의 양어머니, 대한제국 선포 후 황후로 추존됨)를 위해 지은 건물이다. 그러나 지은 지 얼마 지나지 않아 화재로 소실된 것을 1888년(고종 25)에 다시 지어 지금까지 남아 있는 건물이다. 자경전 주변으로는 복안당(福安堂)과 청연루(淸讌樓), 협경당(協慶堂) 등 부속건물을 따로 두었는데 모두 연결되어 있다.&nbsp;</span></p>
<div></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm10" data-tab="cm10">
				<h3 class="txt_section_tit vcPartTitle">
								흥복전</h3>
                        <div class="hidden">
					흥복전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide9">
					<div class="swiper-wrapper" id="swiper-wrapper-10cc60da46684433" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p>흥복전(興福殿)은 고종 대 경복궁을 다시 지을 때 처음 지어졌다.&nbsp;이곳은 고종 연간에 독일, 일본, 이탈리아, 프랑스 등 외국 사신을 접견했다는 기록이 있다.&nbsp;<span style="color: rgb(19, 19, 19); text-align: justify;">이후 신정황후 조씨(24대 헌종의 어머니이자 26대 고종의 양어머니, 대한제국 선포 후 황후로 추존됨)가 세상을 떠난 곳이기도 하다.&nbsp;</span>흥복전은 일제강점기 때 철거되었다가 2020년에 복원하였다.</p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm11" data-tab="cm11">
				<h3 class="txt_section_tit vcPartTitle">
								향원정</h3>
                        <div class="hidden">
					향원정</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide10">
					<div class="swiper-wrapper" id="swiper-wrapper-fee1d5bcba1836a4" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">향원정(香遠亭)은 1873년(고종 10) 고종이 건청궁을 지을 때 그 앞에 연못(향원지)을 파서 연못 가운데 섬을 만들고 2층의 육모지붕의 형태로 지었다. 향원정을 가기 위해 지은 다리는 ‘향기에 취한다’라는 뜻에 취향교(醉香橋)라고 불렀다. 2017년부터 2020년까지 향원정 보수공사 때 취향교는 원래의 자리로 복원하였다.</span></p>
<div style="text-align: justify;"></div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm12" data-tab="cm12">
				<h3 class="txt_section_tit vcPartTitle">
								건청궁</h3>
                        <div class="hidden">
					건청궁</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide11">
					<div class="swiper-wrapper" id="swiper-wrapper-d21421a9c092caff" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<p style="text-align: justify;">건청궁(乾淸宮)은 1873년(고종 10)에 왕과 왕비의 생활공간으로 지어진 궁 안의 궁이다.&nbsp;건청궁의 왕의 생활공간인 장안당(長安堂)과 왕비의 생활공간인 곤녕합(坤寧閤) 등으로 구성되어 있는데, 장안당과 곤녕합은 복도로 이어져 있다. 이곳에서 고종과 명성황후는 10년 정도 생활하였다. 2007년에 지금의 모습으로 복원하였다.</p></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm13" data-tab="cm13">
				<h3 class="txt_section_tit vcPartTitle">
								집옥재</h3>
                        <div class="hidden">
					집옥재</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide12">
					<div class="swiper-wrapper" id="swiper-wrapper-210e8ccbff66caffc" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">집옥재(集玉齋)는 1891년(고종 28) 창덕궁 함녕전의 별당이었던 집옥재와 협길당 등을 건청궁 서쪽으로 옮겨지은 것으로, 고종의 서재와 외국 사신을 접견하던 장소로 사용되었다.&nbsp;<span style="color: rgb(19, 19, 19); text-align: justify;">집옥재를 중심으로 왼쪽에 팔우정(八隅亭), 오른쪽에 협길당(協吉堂)이 있다.&nbsp;</span>집옥재는 경복궁의 전각 중 유일하게 현판이 세로형으로 되어있다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		<div class="tab_con cm14" data-tab="cm14">
				<h3 class="txt_section_tit vcPartTitle">
								태원전</h3>
                        <div class="hidden">
					태원전</div>
				<div class="course_slide swiper-initialized swiper-horizontal course_slide13">
					<div class="swiper-wrapper" id="swiper-wrapper-9103267edc6b8618c" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
						<div class="swiper-slide" data-seq="8" data-swiper-slide-index="0" role="group" aria-label="1 / 1">
								<img src="/afile/preview/4801" data-key="4801" alt="근정전 전경">
							</div>
						</div>
					<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span><span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
				<div class="course_txt_wrap">
					<div class="txt">
						<div style="text-align: justify;">태원전(泰元殿)은 태조의 어진을 모셨고, 이후에는&nbsp;빈전(殯殿, 왕과 왕비가 세상을 떠난 후 발인하기 전까지 재궁(관)을 모셔둔 건물)으로 사용되었다.&nbsp;태원전 주변에는 부속 건물인 문경전(文慶殿)과 공묵재(恭默齋), 영사재(永思齋) 등 의례용 건물이 있다. 태원전은&nbsp;2006년에 현재 모습으로 복원하였다.</div></div>
				</div>
				<div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
					<img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
					<div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
				</div>
			</div>
		</div>
	<!-- [E] course_num_con -->
<script type="text/javascript">
	$(function() {
		var course_slide;
		$(".course_slide").each(function(index) {
			$(this).addClass("course_slide" + index);
			courseSliderSet(".course_slide" + index);
		})

		function courseSliderSet($slidermain) {
			course_slide = new Swiper($slidermain, {
				slidesPerView : 1,
				loop : true,
				pagination : {
					el : $slidermain + " .swiper-pagination",
					type : "fraction",
				},
				observer : true,
				observeParents : true,
				initialSlide : 0,
				navigation : {
					nextEl : $slidermain + " .swiper-button-next",
					prevEl : $slidermain + " .swiper-button-prev",
				},
			});
		}
	});

	var swiper = new Swiper(".course_slide", {
		initialSlide : 0,
		centeredSlides : true,
		observer : true,
		observeParents : true,
		loop : false,
		navigation : {
			nextEl : ".course_slide .swiper-button-next",
			prevEl : ".course_slide .swiper-button-prev",
		},
		on: {
            slideChange: function() {
              const index_currentSlide = this.realIndex;
              sw_realIndex = this.slides[index_currentSlide];
            },
		}
	});


	var  course_sw = 0;
	$('.course_slide_wrap.course_slide .btn_pause').click(function() {
		if (course_sw == 0) {
			$('.course_slide .btn_pause').addClass('on');
			swiper.autoplay.stop();
			course_sw = 1;
		} else {
			$('.course_slide .btn_pause').removeClass('on');
			swiper.autoplay.start();
			course_sw = 0;
		}
	});

	function fn_downloadImage(fileId){
		var dataFileSeq = $(".course_slide .swiper-slide.swiper-slide-active").eq(0).attr("data-seq");
		location.href = "/jfile/readDownloadFile.do?fileId="+fileId+"&fileSeq="+dataFileSeq;
	}
</script>
					</div>
				</div>
	</div>
</div>

<!-- pop : 코스(경복궁) -->
<div class="dim">
	<div class="layer_popup pop_type02 pop_course" id="pop_course01">
		<div class="popup_body">
			<div class="course_pop_con">
				<ul class="list tab_menu">
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs0">
								<span class="inn">🚶40분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs1">
								<span class="inn">🚶60분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs2">
								<span class="inn">🚶90분 코스</span>
							</a>
						</li>
					</ul>
			</div>
			<div class="top">
				<div class="left half align_center">
					<img src="/afile/previewThumbnail/23100637476shOAS" alt="" style="width:80%;">
				</div>
				<div class="right half">
					<div class="tab_con_wrap">
						<div class="tab_con cs0 current">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											</ol>
									</div>
								<div class="tab_con cs1">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">교태전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">강녕전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">자경전</div>
												</li>
											</ol>
									</div>
								<div class="tab_con cs2">
										<ol class="course_list">
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">흥례문</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">영제교</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">근정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">수정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">경회루</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">사정전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">강녕전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">교태전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">자경전</div>
												</li>
											<li class="course_item ">
													<div class="course_dot">
														<div class="inn"></div>
													</div>
													<div class="course_txt">향원정</div>
												</li>
											</ol>
									</div>
								</div>
				</div>
			</div>
			<div class="btm tab_con_wrap">
				<div class="tab_con cs0 current">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide0">
								<div class="swiper-wrapper" id="swiper-wrapper-cebdd16b24e348c2" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3401" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3370" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3371" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3372" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3373" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3374" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
					<div class="tab_con cs1">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide1">
								<div class="swiper-wrapper" id="swiper-wrapper-9fb21bb2585d148a" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3402" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3383" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3384" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3385" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3386" alt="교태전">
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3387" alt="강녕전">
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3388" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3389" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3390" alt="자경전">
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
					<div class="tab_con cs2">
							<div class="course_pop_slide swiper-initialized swiper-horizontal" id="course_pop_slide2">
								<div class="swiper-wrapper" id="swiper-wrapper-79ca49fd16ebf06e" aria-live="polite" style="transition-duration: 0ms; transition-delay: 0ms;">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3403" alt="흥례문">
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3404" alt="영제교">
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3405" alt="근정전">
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3406" alt="수정전">
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3407" alt="경회루">
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3408" alt="사정전">
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3409" alt="강녕전">
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3410" alt="교태전">
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3411" alt="자경전">
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3412" alt="향원정">
											</div>
											<div class="txt_wrap">향원정</div>
										</div>
									</div>
							<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
						</div>
					<a href="#" class="swiper-button-prev" tabindex="0" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-79ca49fd16ebf06e" aria-disabled="false"><span class="sr_only">슬라이드 이전</span></a>
				<a href="#" class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-79ca49fd16ebf06e" aria-disabled="false"><span class="sr_only">슬라이드 다음</span></a>
			</div>
		</div>
		<a href="#;" class="pop_close ic_close"><span class="hidden">레이어 팝업 닫기</span></a>
	</div>
</div>

</article>
    </div> <!-- .container 닫는 태그 -->

  </main>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div>
</body>
</html>
