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
<script type="text/javascript">
	//도메인변경 이동처리
	var wl = window.location.href;
	if(wl.indexOf("royal.cha.go.kr") > -1){
		location.href = wl.replace("royal.cha.go.kr","royal.khs.go.kr");
	}

	var reservation_tab2 = undefined;

	// $(window).on('resize', fn_init).trigger('resize');
	var delta = 150;
	var timer = null;

	$( window ).on( 'resize', function() {
		clearTimeout( timer );
		timer = setTimeout( fn_init, delta );
	} );

	$(function() {
		//숫자만 입력되게
		$(document).on("keyup", ".numberOnly", function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
		//숫자,대쉬만 입력되게 (전화번호 사용 자동대쉬)
		$(document).on("keyup", ".numberDashOnly", function() {
			//$(this).val($(this).val().replace(/[^0-9\-]/g,""));
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});

		// 외부영역 클릭 시 팝업 닫기
		$(document).mouseup(function (e){
			//통합검색 레이어팝업
			if($(e.target).parents('.hd_search_trigger_wrap').length < 1 && $(".trigger_wrap").has(e.target).length === 0){
				close_trigger_wrap();
			}
			//레이어 팝업
// 			if($(".dim").has(e.target).length === 0){
// 				$(".layer_popup").closest(".dim").hide();
// 				$(".dim").hide();
// 			}
			//모바일 푸터 팝업
			if($(".mo_hd_box_inn").has(e.target).length === 0){
				$(".mo_hd_wrap").removeClass("open");
			}
			//SNS 팝업
			if($(".util_wrap").has(e.target).length === 0){
				$(".util_item").removeClass("on");
			}
		});

		$(".icon_search2").on('click', function() {
			$('.multiLangBox').hide();
			$(this).parents('.search_lng_wrap').find('.multiLangBox').toggle();
			return false;
		});
		$('.multiLangBox .multiLang ul.language li a').on('click', function() {
			$('.multiLangBox .multiLang ul.language li a').hasClass("selected");
			$('.multiLangBox .multiLang ul.language li a').removeClass("selected");
			$(this).addClass("selected");
			var multiLangIndex = $('.multiLangBox .multiLang ul.language li a').index($(this));
			$('.multiLangBox .multiLang .languageContents').hide();
			$('.multiLangBox .multiLang .languageContents').eq(multiLangIndex).show();
			return false;
		});
		$('.multiLangBox.multiLang ul.language li:first-child a').trigger('click');
		$('p.multiLangBox_close a').on("click", function() {
			$('.multiLangBox').hide();
			return false;
		});
		$('.multiLangBox .multiLang .languageContents ul li a').on('click', function(e) {
			$(this).parents('.search_lng_wrap').find('.lang_input')[0].value += $(this)[0].innerHTML;
		});
		fn_gnbMenu();
		//fn_mobileMenu();
	});

	var hdTimer;
	function fn_gnbMenu() {
		$.ajax({
			url : "/ROYAL/module/select_user_gbn_menu.ajax",
			data : "",
			success : function(data) {
				var add = "";
				$("#gnbMenuDiv").empty().html(add+""+data);

				clearTimeout(hdTimer);
				hdTimer = setTimeout(function() {
					fn_init();
					fn_mobInit();
				}, 350);
			},
			error : function(request, status, error) {
				//alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function fn_mobInit(){
		var win_w = $(window).innerWidth();
		var isMobile = "false";

		if (win_w < 1024 && isMobile) {
			$('.header_wrap .gnb').before('<div class="mob-gnb-depth1"></div>');
			// $('#hd_search_trigger_wrap').clone().prependTo('.header_wrap .header_btm .inner .gnb_wrap');
			// $('.header_left #hd_search_trigger_wrap').remove();
			// $('#hd_search_trigger_wrap').removeClass('trigger_wrap');
			// $('#hd_search_trigger_wrap .hd_search').remove();
			// $('#hd_search_trigger_wrap .trigger_close').remove();
			$('.header_wrap .gnb .menu-gnb-depth1__item .depth1__a').clone().appendTo('.mob-gnb-depth1');
			// var mobMenuHei = $('.mob-gnb-depth1').height();
			// $('.header_wrap .gnb').css('height',mobMenuHei);

			$('.mob-gnb-depth1 a').on('click',function(e){
				var idx = $(this).index();
				var gnb_top = $('.menu-gnb-depth1 > li').eq(idx).position().top;
				$('.header_wrap .gnb').animate({scrollTop:gnb_top});
				e.preventDefault();
			})

			$('.header_wrap .gnb').scroll(function() {
				var scrollDistance = $('.header_wrap .gnb').scrollTop();
				scrollDistance = scrollDistance + 10;
				$('.menu-gnb-depth1 > li').each(function(i) {
					if ($(this).position().top <= scrollDistance) {
						$('.header_wrap .header_btm>.inner .gnb_wrap .mob-gnb-depth1 a.active').removeClass('active');
						$('.header_wrap .header_btm>.inner .gnb_wrap .mob-gnb-depth1 a').eq(i).addClass('active');
					}
				});
			}).scroll();
		}
	}


	function fn_init() {
		var $body = $("body");
		var $headerWrap = $(".header_wrap");
		var $gnb = $(".menu-gnb-depth1");
		var $gnbInner = $(".menu-gnb-depth1 .inner");
		var $depth1 = $(".depth1__a"); //li > a
		var $depth2 = $(".menu-gnb-depth2__item a"); //li > a
		var $depth1_hasDepth2 = $(".has_depth2 .depth1__a");
		var $depth2_hasDepth3 = $(".has_depth3 .depth2__a");
		var $depth1_wrap = $(".menu-gnb-depth1__item"); //li
		var $depth2_wrap = $(".menu-gnb-depth2__item"); //li
		var $depth = $(".menu-gnb-depth1__item a"); //li a
		var $menu = $(".h_menu");
		var win_w = $(window).innerWidth();
		var isMobile = "false";

		if (win_w >= 1024 || !isMobile) {
			//pc
			$depth1_hasDepth2.off("click");
			$("meta[name='viewport']").attr("content","width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0");

			//통합검색 필터
			$(".filter_wrap").addClass("open");
			$(".filter_trigger").addClass("on");
			$(".filter_trigger .hide_txt").html("닫기");

			$depth1.off().on("mouseenter focus", function() {
				$depth1_wrap.removeClass("open");
				$(this).closest(".menu-gnb-depth1__item").addClass("open");
				$(this).closest(".header_wrap").addClass("open");
			});
			// $depth2.off().on("mouseenter focus", function() {
			// 	$(this).closest(".menu-gnb-depth2__item").addClass("active");
			// });
			$depth1_wrap.on("mouseleave blur", function() {
				$(this).removeClass("open");
				$(this).closest(".header_wrap").removeClass("open");
			});
			$depth2_wrap.off().on("mouseleave blur", function() {
				$(this).removeClass("active");
			});
			$depth1_wrap.each(function() {
				$(this).find("a").last().on("blur",function() {
					$(this).closest(".menu-gnb-depth1__item").removeClass("open");
					$(this).closest(".header_wrap").removeClass("open");
				});
			});
			$depth2_hasDepth3.off().on("click", function(e) {
				e.preventDefault();
				close_trigger_wrap();
				if($(this).closest(".menu-gnb-depth2__item").hasClass("open")){
					$(this).closest(".menu-gnb-depth2__item").removeClass("open");
				}else{
					$(".menu-gnb-depth2__item").removeClass("open");
					$(this).closest(".menu-gnb-depth2__item").addClass("open");
				}
			});
		} else {
			//mo
			$depth1.off("mouseenter focus");
			$depth1_wrap.off("mouseleave");
			// $("meta[name='viewport']").attr("content","width=500,user-scalable=no");

			$depth1_hasDepth2.off().on("click", function(e) {
				e.preventDefault();
				close_trigger_wrap();
				$(".menu-gnb-depth1__item").removeClass("open");
				$(this).closest(".menu-gnb-depth1__item").addClass("open");
			});
			$depth2_hasDepth3.off().on("click", function(e) {
				e.preventDefault();
				close_trigger_wrap();
				$(".menu-gnb-depth2__item").removeClass("open");
				$(this).closest(".menu-gnb-depth2__item").addClass("open");
			});

			$(".h_close").on("click", function(e) {
				$body.removeClass("m_open");
				$(".menu-gnb-depth1__item").removeClass("open");
			});

			/*header menu*/
			$menu.off().on("click", function() {
				$body.toggleClass("m_open");
			});


			var swiper = new Swiper(".palace_list_mo", {
				slidesPerView: 3,
				spaceBetween: 10,
			});
		}

		//모바일 탭 드롭다운
		setTimeout(function() {
			$(".tab_select_wrap").each(function() {
				var on_txt = $(this).find(".tab_select li.on").text();
				$(this).find(".tab_select_now").html(on_txt);
			})
		}, 30)

		$(".tab_select > li > a").on("click", function() {
			var on_txt = $(this).text();
			$(this).closest(".tab_select_wrap").find(".tab_select_now")
					.html(on_txt);
			$(this).closest(".tab_select_wrap").removeClass("open");

		});

		$(".sns_item_trigger").off().on("click", function() {
			if ($(this).closest(".sns_item_mo").hasClass("open")) {
				$(".sns_item_mo").removeClass("open");
				$(this).closest(".sns_item_mo").removeClass("open");
			} else {
				$(".sns_item_mo").removeClass("open");
				$(this).closest(".sns_item_mo").addClass("open");
			}
		})

		//trigger
		$(".trigger").off().on("click", function() {
			var thisWrap = "#" + $(this).attr("id") + "_wrap";
			if ($(thisWrap).hasClass("open")) {
				$(thisWrap).removeClass("open");
				$(this).find(".hide_txt").html("열기");
			} else {
				$(thisWrap).addClass("open");
				$(this).find(".hide_txt").html("닫기");
			}
		});
		//trigger close
		$(".trigger_close").off().on("click", function() {
			var targetWrap = $(this).closest(".trigger_wrap");
			targetWrap.find(".hide_txt").html("열기");
			targetWrap.removeClass("open");
			targetWrap.find(".trigger").focus();
			if (targetWrap.hasClass("filter_wrap")) {
				$(".filter_trigger").removeClass("on");
			}
			if (targetWrap.hasClass("lnb_wrap")) {
				$(".contents_main").removeClass("lnb_open");
			}
		});

		/*lnb*/
		setTimeout(function(){
			$(".lnb_depth2_trigger").attr("title", "하위메뉴 펼치기");
			$('.lnb_depth2_item.current .lnb_depth2_trigger').attr("title", "하위메뉴 열림");
		},500);

		$(".lnb_depth2_trigger").off().on("click", function() {
			var item = $(this).parent();
			if (!item.hasClass("current")) {
				if (!item.hasClass('active')) {
					$(this).attr("title", "하위메뉴 접기");
					$('.lnb_depth2_item.active').children('.lnb_depth2_trigger').attr("title", "하위메뉴 펼치기");
					$('.lnb_depth2_item.active').removeClass('active');
					item.addClass('active');
				} else {
					$(this).attr("title", "하위메뉴 펼치기");
					item.removeClass('active');
				}
			}
		});

		/*del_search_word*/
		$(".del_search_word").on("click", function() {
			$(this).closest(".search_input_wrap").find("input[type='text']").val("");
		});

		$('.search_input_wrap .trigger_close').on('focusout',function(){
			$('.hd_search_wrap').removeClass('open');
		})

		/*tab_menu*/
		$(".tab_link a").on("click", function() {
			var thisCon = "." + $(this).parent().attr("data-tab");

			$(this).closest(".tab_menu").find('.tab_link').removeClass('current');
			$(this).closest(".tab_menu").find(".hidden").remove();
			$(this).parent().addClass('current');
			$(this).append('<span class="hidden">현재 선택됨</span>');

			$(thisCon).siblings(".tab_con").removeClass("current");
			$(thisCon).addClass("current");

			// if ($(".tab_con .slick-slider").length != 0) {
			// 	$('.slick-slider').resize();
			// 	$('.slick-slider').slick('refresh');
			// }
		});

		//slider resize
		if ($(".slick-slider").length != 0) {
			$('.slick-slider').slick('resize');
			$('.slick-slider').slick('refresh');
		}

		if ($(".reservation_tab").length != 0 && $(".reservation_tab").find(".swiper-wrapper").length != 0) {
			$(".reservation_tab .swiper-slide").each(function(index){
				$(this).attr("data-num", index);
			})
			var data_num = $(".reservation_tab .swiper-slide.current").attr("data-num");
			data_num = parseInt(data_num);

			var reservation_tab = new Swiper(".reservation_tab", {
				speed: 800,
				loop: false,
				loopAdditionalSlides: 1,
				initialSlide: 0,
				observer: true,
				observeParents: true,
				slidesPerView: "auto",
			});

			reservation_tab.slideTo(data_num, 10, false);
		}

		if ($(".reservation_tab2").length != 0 && $(".reservation_tab2").find(".swiper-wrapper").length != 0) {
			$(".reservation_tab2 .swiper-slide").each(function(index){
				$(this).attr("data-num", index);
			})
			var data_num = $(".reservation_tab2 .swiper-slide.current").attr("data-num");
			data_num = parseInt(data_num);

			if (win_w >= 1024  && reservation_tab2 != undefined) {
				reservation_tab2.destroy();
				reservation_tab2 = undefined;
			}else if(win_w < 1024  && reservation_tab2 == undefined) {
				reservation_tab2 = new Swiper(".reservation_tab2", {
					speed: 800,
					navigation: {
						nextEl: ".noti_next",
						prevEl: ".noti_prev",
					},
					slidesPerView: "auto",
				});
				reservation_tab2.slideTo(data_num, 10, false);
			}
		}

		if ($(".sub_con_tab").length != 0 && $(".sub_con_tab").find(".swiper-wrapper").length != 0) {
			var sub_con_tab = new Swiper(".sub_con_tab", {
				speed: 800,
				loop: false,
				loopAdditionalSlides: 1,
				initialSlide: 0,
				observer: true,
				observeParents: true,
				slidesPerView: "auto",
			});
		}

		if ($(".sub_menu_tab").length != 0 && $(".sub_menu_tab").find(".swiper-wrapper").length != 0) {
			var sub_menu_tab = new Swiper(".sub_menu_tab", {
				speed: 800,
				loop: false,
				loopAdditionalSlides: 1,
				initialSlide: 0,
				observer: true,
				observeParents: true,
				slidesPerView: "auto",
				spaceBetween: 15,
			});
		}

		if ($(".history_tab").length != 0 && $(".history_tab").find(".swiper-wrapper").length != 0) {
			var swiper1 = new Swiper(".history_tab", {
				speed: 800,
				loop: false,
				loopAdditionalSlides: 1,
				initialSlide: 0,
				observer: true,
				observeParents: true,
				slidesPerView: "auto",
			});
		}
	}

	function fn_mobileMenu() {
		$.ajax({
			url : "/ROYAL/module/select_user_mobile_all_menu.ajax",
			data : "",
			success : function(data) {
				$("#mMenuDiv").empty().html(data);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}

	//메시지박스
	function msgBox(data) {
		toastr.options.escapeHtml = true;
		toastr.options.newestOnTop = false;
		toastr.options.progressBar = true;
		toastr.options.preventDuplicates = false;
		toastr.options.onclick = function() {
			//fn_search();
		}
		toastr.options.onHidden = function() {
		}
		var msg = data.msg;
		if (data.status == "OK") {
			if (!msg)
				msg = "저장되었습니다.";
			toastr.info("알림", msg, {
				timeOut : 1000
			});
		} else {
			if (!msg)
				msg = "저장에 실패하였습니다.";
			toastr.info("알림", msg, {
				timeOut : 1000
			});
		}
	}

	//통합검색
	function fn_totalSearch(){
		var f = document.mainSearchForm;
		if(f.query.value == "" || f.query.value == null){
			alert("검색어를 입력해주세요.");
			f.query.focus();
			return false;
		}else{
			f.action = "/ROYAL/contents/R09000000.do";
			f.submit();
		}
	}
</script>
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
										<button class="zoomIn" data-panzoom-action="zoomIn" title="확대">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M12 5v14M5 12h14"></path>
								            </svg>
										</button>
										<button class="zoomOut" data-panzoom-action="zoomOut" title="축소">
											<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
								            	<path d="M5 12h14"></path>
								            </svg>
										</button>
										<button class="zoomReset" data-panzoom-action="zoomReset" data-panzoom-change="{" angle":="" 90}"="" title="초기화">
											<img src="/Gung_On/course/course_img/ic_refresh.png" width="20px">
										</button>
									</div>
								<div class="course_map" style="overflow: hidden; user-select: none; touch-action: none;">
									<div class="zoomable" id="zoomable" style="cursor: move; user-select: none; touch-action: none; transform-origin: 50% 50%; transition: none; transform: scale(1) translate(0px, 0px);">
										<img data-id="1" class="map_content" src="/Gung_On/course/course_img/gbg_img/gbg_map_all.png" alt="전체 맵" draggable="true">
										
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- [E] course_map_wrap -->

					<!-- [S] course_info -->
						<div class="course_info box_wrap">
							<img src="/resource/templete/royal/img/sub/intro/ic_info.png" alt=""> 번호를 클릭하시면 아래 화면에서 시설사진을 볼 수 있습니다.
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
					<div id="photoDiv"></div>
				</div>
	</div>
</div>
<!-- [E] sub_con_section -->

<!-- pop : 코스(경복궁) -->
<div class="dim">
	<div class="layer_popup pop_type02 pop_course" id="pop_course01">
		<div class="popup_body">
			<div class="course_pop_con">
				<!-- <span class="course_tit"><img src="/resource/templete/royal/img/sub/information/ic_loca.png" alt=""> 코스안내</span> -->
				<ul class="list tab_menu">
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs0">
								<span class="inn"><img src="/resource/templete/royal/img/sub/information/ic_course.png" alt="">40분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs1">
								<span class="inn"><img src="/resource/templete/royal/img/sub/information/ic_course.png" alt="">60분  코스</span>
							</a>
						</li>
					<li class="item tab_link">
							<a href="#;" onclick="open_layer_pop('pop_course01',this)" data-tab="cs2">
								<span class="inn"><img src="/resource/templete/royal/img/sub/information/ic_course.png" alt="">90분 코스</span>
							</a>
						</li>
					</ul>
			</div>
			<div class="top">
				<div class="left half align_center">
					<img src="/afile/previewThumbnail/23100637476shOAS" alt="" style="width:80%;" />
				</div>
				<div class="right half">
					<div class="tab_con_wrap">
						<div class="tab_con cs0 current">
		<!-- 								<div class="course_tab_txt"> -->
		<!-- 									<img src="/resource/templete/royal/img/sub/information/ic_course.png" alt=""> 관람동선 -->
		<!-- 								</div> -->
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
		<!-- 								<div class="course_tab_txt"> -->
		<!-- 									<img src="/resource/templete/royal/img/sub/information/ic_course.png" alt=""> 관람동선 -->
		<!-- 								</div> -->
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
		<!-- 								<div class="course_tab_txt"> -->
		<!-- 									<img src="/resource/templete/royal/img/sub/information/ic_course.png" alt=""> 관람동선 -->
		<!-- 								</div> -->
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
							<div class="course_pop_slide" id="course_pop_slide0">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3401" alt="흥례문" />
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3370" alt="영제교" />
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3371" alt="근정전" />
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3372" alt="사정전" />
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3373" alt="수정전" />
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3374" alt="경회루" />
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									</div>
							</div>
						</div>
					<div class="tab_con cs1">
							<div class="course_pop_slide" id="course_pop_slide1">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3402" alt="흥례문" />
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3383" alt="영제교" />
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3384" alt="근정전" />
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3385" alt="수정전" />
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3386" alt="교태전" />
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3387" alt="강녕전" />
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3388" alt="사정전" />
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3389" alt="경회루" />
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3390" alt="자경전" />
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									</div>
							</div>
						</div>
					<div class="tab_con cs2">
							<div class="course_pop_slide" id="course_pop_slide2">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3403" alt="흥례문" />
											</div>
											<div class="txt_wrap">흥례문</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3404" alt="영제교" />
											</div>
											<div class="txt_wrap">영제교</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3405" alt="근정전" />
											</div>
											<div class="txt_wrap">근정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3406" alt="수정전" />
											</div>
											<div class="txt_wrap">수정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3407" alt="경회루" />
											</div>
											<div class="txt_wrap">경회루</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3408" alt="사정전" />
											</div>
											<div class="txt_wrap">사정전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3409" alt="강녕전" />
											</div>
											<div class="txt_wrap">강녕전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3410" alt="교태전" />
											</div>
											<div class="txt_wrap">교태전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3411" alt="자경전" />
											</div>
											<div class="txt_wrap">자경전</div>
										</div>
									<div class="swiper-slide">
											<div class="img_wrap">
												<img src="/afile/preview/3412" alt="향원정" />
											</div>
											<div class="txt_wrap">향원정</div>
										</div>
									</div>
							</div>
						</div>
					<a href="#" class="swiper-button-prev"><span class="sr_only">슬라이드 이전</span></a>
				<a href="#" class="swiper-button-next"><span class="sr_only">슬라이드 다음</span></a>
			</div>
		</div>
		<a href="#;" class="pop_close ic_close"><span class="hidden">레이어 팝업 닫기</span></a>
	</div>
</div>

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


	// $('.pop_course .popup_body .btm .tab_con').each(function(index) {
	// 	if($(this).find('.swiper-slide').length <= 6){
	// 		var pop_swiper = new Swiper("#course_pop_slide" + index, {
	// 			loop: true,
	// 			slidesPerView : 3,
	// 			spaceBetween : 35,
	// 			initialSlide : 0,
	// 			observer : true,
	// 			observeParents : true,
	// 			navigation : {
	// 				nextEl : ".pop_course .popup_body .btm .swiper-button-next",
	// 				prevEl : ".pop_course .popup_body .btm .swiper-button-prev",
	// 			},
	// 			breakpoints: {
	// 				1024: {
	// 				slidesPerView: 4,
	// 				},
	// 			},
	// 		});

	// 	}else if($(this).find('.swiper-slide').length === 7){
	// 		var pop_swiper = new Swiper("#course_pop_slide" + index, {
	// 			loop: true,
	// 			slidesPerView : 3,
	// 			spaceBetween : 35,
	// 			initialSlide : 0,
	// 			observer : true,
	// 			observeParents : true,
	// 			navigation : {
	// 				nextEl : ".pop_course .popup_body .btm .swiper-button-next",
	// 				prevEl : ".pop_course .popup_body .btm .swiper-button-prev",
	// 			},
	// 			breakpoints: {
	// 				1024: {
	// 				slidesPerView: 4,
	// 				},
	// 			},
	// 		});
	// 	}else{
	// 		var pop_swiper = new Swiper("#course_pop_slide" + index, {
	// 			loop: true,
	// 			slidesPerView : 3,
	// 			spaceBetween : 35,
	// 			initialSlide : 0,
	// 			observer : true,
	// 			observeParents : true,
	// 			navigation : {
	// 				nextEl : ".pop_course .popup_body .btm .swiper-button-next",
	// 				prevEl : ".pop_course .popup_body .btm .swiper-button-prev",
	// 			},
	// 			breakpoints: {
	// 				1024: {
	// 				slidesPerView: 4,
	// 				},
	// 			},
	// 		});
	// 	}
	// });

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

		/* $(".course_num_list .tab_link a").on("click",function(){
		    var marker_num = parseInt($(this).closest(".tab_link").attr("data-num"));
		    var wrap = $(this).closest(".tab_con");

		    wrap.find(".course_slide_tab .tab_link").removeClass("current");
		    wrap.find(".course_slide_tab .tab_link[data-num='"+ marker_num +"']").addClass("current");
		}); */

		
		/* 확대/축소 START */
		var instance = document.querySelector('.course_map_wrap');
		var maxScale = 4;
		var panzoom = new Panzoom(instance.querySelector(".zoomable"), {
			  minScale: 1,
			  maxScale: maxScale,
			  step: 0.5,
			  //contain: "outside",
			  panzoomMouseMove: 0,
			  panOnlyWhenZoomed: 1,
			  //cursor: 'zoom-in',	//pointer
		});

		//버튼
		$(".zoomIn").click(function(){
			panzoom.zoomIn({ animate: true, step: 0.4 });
		});
		$(".zoomOut").click(function(){
			panzoom.zoomOut({ animate: true, step: 0.4 });
		});
		$(".zoomReset").click(function(){
			panzoom.reset();
		});

		//마우스휠
// 		instance.parentElement.addEventListener('wheel', panzoom.zoomWithWheel);

		//클릭-버튼으로 대체
// 		instance.addEventListener('click', () => {
// 			instance.style.pointer = 'zoom-out';
// 			panzoom.zoomIn({ animate: true, step: 0.4 })
// 			if (panzoom.getScale() === maxScale) {
// 				instance.style.cursor = 'zoom-out';
// 				panzoom.reset();
// 				instance.style.cursor = 'zoom-in';
// 			}
// 		});
		/* 확대/축소 END */
		
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
					//픽토그램 숨김처리, 추후 롤업
					//var imghtml = '<img src="/resource/templete/royal/img/sub/information/amenities.png" alt="">';
					//$(".amenities_wrap").empty().html(imghtml);

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

</article>
    </div> <!-- .container 닫는 태그 -->

  </main>

  <!-- 푸터 -->
  <jsp:include page="/common/jsp/footer.jsp" />
<!-- <div> 아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/mike-zuidgeest" title="Mike Zuidgeest"> Mike Zuidgeest </a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com'</a></div> -->
</body>
</html>
