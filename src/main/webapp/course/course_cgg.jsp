<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <div class="container">
        <div class="sidebar">
            <h3>관람안내 메뉴</h3>
            <nav class="sub-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/course/course_rule.jsp" >관람규칙</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course_time.jsp">관람시간</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/course.jsp" class="active">관람코스</a></li>
                    <li><a href="${pageContext.request.contextPath}/course/users_course.jsp">사용자 추천 코스</a></li>
                </ul>
            </nav>
        </div>
        	<article class="content">
            <h1>관람코스</h1>

<div class="sub_con_section">
	<div class="tab_con_wrap">
		<div class="tab_con current">
					<div class="course_tab_wrap">
						<div class="left course_pop_con">
							<span class="course_tit"><img src="course_img/ic_loca.jpg" alt=""> 코스안내</span>
								<ul class="list course_info_list">
									<li class="item" data-num="0">
											<a href="#;"><span class="inn">🚶종류 별 코스</span></a>
										</li>
									</ul>
							</div>
						<select class="sel_st">
           			        <option value="gbg" >경복궁</option>
            		        <option value="cdg" >창덕궁</option>
            		        <option value="dsg" >덕수궁</option>
            		        <option value="cgg" selected="selected">창경궁</option>
            		        <option value="ghg">경희궁</option>
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
									<button id="resetButton" class="zoomReset" data-panzoom-action="zoomReset" title="초기화">
										<img src="course_img/ic_refresh.png" width="20px" alt="초기화">
									</button>
								</div>
								<div class="course_map" style="overflow: hidden; user-select: none; touch-action: none; width: 900px;">
									<div class="zoomable" id="panzoom-container" style="cursor: move; user-select: none; touch-action: none; transform-origin: 50% 50%;">
										<img data-id="1" class="map_content" src="course_img/cgg_img/cgg_all01.jpg" alt="전체 맵" draggable="false">
									</div>
								</div>
							</div>
						</div>
					</div>

						<div class="course_info box_wrap">
							<img src="course_img/ic_info.png" alt=""> 번호를 클릭하시면 아래 화면에서 시설사진을 볼 수 있습니다.
						</div>

						<ul class="course_num_list tab_menu">
							<li class="child_tab_menu course_num_item tab_link current cm1" data-num="1" data-tab="cm1">
									<a href="#;"><span class="num">1</span>홍화문</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;"><span class="num">2</span>옥천교</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;"><span class="num">3</span>명정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;"><span class="num">4</span>문정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;"><span class="num">5</span>함인정</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;"><span class="num">6</span>경춘전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm7" data-num="7" data-tab="cm7">
									<a href="#;"><span class="num">7</span>환경전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm8" data-num="8" data-tab="cm8">
									<a href="#;"><span class="num">8</span>통명전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm9" data-num="9" data-tab="cm9">
									<a href="#;"><span class="num">9</span>양화당</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm10" data-num="10" data-tab="cm10">
									<a href="#;"><span class="num">10</span>영춘헌/집복헌</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm11" data-num="11" data-tab="cm11">
									<a href="#;"><span class="num">11</span>대온실</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm12" data-num="12" data-tab="cm12">
									<a href="#;"><span class="num">12</span>춘당지</a>
								</li>
							</ul>

					<div id="photoDiv">
                        <div class="tab_con_wrap course_slide_wrap">
                            <div class="tab_con cm1 current" data-tab="cm1">
                                <h3 class="txt_section_tit vcPartTitle">홍화문</h3>
                                <div class="hidden">홍화문</div>
                                <div class="course_slide swiper" id="course_slide0">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Honghwamun.jpg" data-key="4801" alt="홍화문">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">홍화문(弘化門)은 창경궁 창건 당시에 처음 건립되었다가 임진왜란 때 소실되어 1616년(광해군 8)에 재건되었다. 같은 동궐인 창덕궁의 정문(돈화문)은 앞면이 5칸인데 비해 홍화문은 3칸의 작은 규모로 지었다. 정조는 1795년(정조 19) 어머니 혜경궁 홍씨(헌경황후)의 회갑을 기념하여 홍화문 밖에서 가난한 백성들에게 쌀을 나누어 주었다고 한다.</span></p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm2" data-tab="cm2">
                                <h3 class="txt_section_tit vcPartTitle">옥천교</h3>
                                <div class="hidden">옥천교</div>
                                <div class="course_slide swiper" id="course_slide1">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Ogcheongyo.jpg" data-key="4801" alt="옥천교">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">옥천교(玉川橋)는 응봉산의 명당수가 창덕궁의 존덕정을 지나 창경궁의 북쪽 춘당지를 거쳐 옥천교로 흘러 남쪽으로 흘러간다. 다리 양쪽 아래에 아치(무지개) 모양 사이에는 도깨비 얼굴의 귀면이 조각되어 있는데, 이것은 물길을 타고 들어오는 귀신을 쫓아내어 궁궐을 보호하고 수호하는 의미를 가지고 있다. 옥천교는 궁궐에 남아 있는 다리 중 원형이 잘 보존되어 있다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm3" data-tab="cm3">
                                <h3 class="txt_section_tit vcPartTitle">명정전</h3>
                                <div class="hidden">명정전</div>
                                <div class="course_slide swiper" id="course_slide2">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Myeongjeongjeon.jpg" data-key="4801" alt="명정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">명정전(明政殿)은 창경궁의 정전으로 왕의 즉위식, 신하들의 하례, 과거시험, 궁중연회 등 중요한 국가행사를 치르던 곳이다. 명정전은 1484년(성종 15)에 지어졌고, 임진왜란 때 소실되었다가 1616년(광해군 8)에 재건되었는데, 현재 궁궐의 정전 가운데 가장 오래된 건물이다. 경복궁의 근정전과 창덕궁의 인정전은 중층 규모이지만 명정전은 단층으로 지어졌다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm4" data-tab="cm4">
                                <h3 class="txt_section_tit vcPartTitle">문정전</h3>
                                <div class="hidden">문정전</div>
                                <div class="course_slide swiper" id="course_slide3">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Munjeongjeon.jpg" data-key="4801" alt="문정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">문정전(文政殿)은 창경궁의 편전으로, 왕이 신하를 만나 업무 보고를 받고, 중요한 정책을 결정하던 집무실이다. 그러나 편전 외에 왕실의 장례 때 혼전(魂殿, 왕과 왕비의 신주를 종묘로 모시기 전까지 임시로 신주를 모시는 건물)으로 쓰인 경우도 있었다. 문정전은 임진왜란 때 소실되었다가 광해군 대에 다시 지었고, 일제강점기 때 소실되었다가 1986년에 다시 복원하였다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm5" data-tab="cm5">
                                <h3 class="txt_section_tit vcPartTitle">함인정</h3>
                                <div class="hidden">함인정</div>
                                <div class="course_slide swiper" id="course_slide4">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Haminjeong.jpg" data-key="4801" alt="함인정">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">함인정(涵仁亭)은 앞마당이 넓게 트여 있어 왕이 신하들을 만나고 경연을 하는 곳으로 사용되었다. 함인정은 건물 사방이 벽체 없이 시원하게 개방된 모습인데, 『동궐도』에는 지금과 달리 3면이 막혀 있다. 함인정 앞의 넓은 마당은 『동궐도』에도 그대로 나와 있어, 이곳에서 공연 등이 열렸음을 짐작할 수 있다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm6" data-tab="cm6">
                                <h3 class="txt_section_tit vcPartTitle">경춘전</h3>
                                <div class="hidden">경춘전</div>
                                <div class="course_slide swiper" id="course_slide5">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Gyeongchunjeon.jpg" data-key="4801" alt="경춘전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">경춘전(景春殿)은 1483년(성종 15) 성종이 어머니 인수대비(소혜왕후 한씨)를 위해 지은 대비의 침전이었다. 그러나 정조와 헌종이 이곳에서 태어났고, 인현왕후 민씨(숙종 두 번째 왕비), 헌경황후 홍씨(혜경궁, 정조의 어머니)가 이곳에서 세상을 떠난 것으로 보아, 대비뿐 아니라 왕비와 왕세자빈의 생활 공간으로도 많이 사용한 듯하다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm7" data-tab="cm7">
                                <h3 class="txt_section_tit vcPartTitle">환경전</h3>
                                <div class="hidden">환경전</div>
                                <div class="course_slide swiper" id="course_slide6">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Hwangyeongjeon.jpg" data-key="4801" alt="환경전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">환경전(歡慶殿)은 왕이나 왕세자가 생활하던 내전 건물로 보인다. 환경전은 창경궁이 창건될 때 지어졌다가 임진왜란, 이괄의 난, 순조 연간 대화재 등으로 소실과 재건을 반복하였다. 지금의 건물은 1834년(순조 34)에 재건한 것이다. 이곳에서 중종과 소현세자가 세상을 떠났다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm8" data-tab="cm8">
                                <h3 class="txt_section_tit vcPartTitle">통명전</h3>
                                <div class="hidden">통명전</div>
                                <div class="course_slide swiper" id="course_slide7">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Tongmyeongjeon.jpg" data-key="4801" alt="통명전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">통명전(通明殿)은&nbsp;왕비의 침전이며 내전 중 가장 으뜸이 되는 건물이다. 통명전은 월대 위에 기단을 형성하고 그 위에 건물을 올렸으며, 연회나 의례를 열 수 있는 넓은 마당에는 얇고 넓적한 박석(薄石)을 깔았다. 통명전 서쪽에는 동그란 샘과 네모난 연못이 있으며, 그 주변에 정교하게 돌난간을 두르고 작은 돌다리를 놓았다. 통명전은 창경궁에 남아 있는 전각 중에서 용마루가 없는 유일한 건물이다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm9" data-tab="cm9">
                                <h3 class="txt_section_tit vcPartTitle">양화당</h3>
                                <div class="hidden">양화당</div>
                                <div class="course_slide swiper" id="course_slide8">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Yanghwadang.jpg" data-key="4801" alt="양화당">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">양화당(養和堂)은 통명전과 함께 내전의 한 공간으로 사용되었다. 인조가 병자호란 후 남한산성에서 돌아와 이곳에서 머무르기도 하였으나, 25대 철종의 왕비 철인황후 김씨가 이곳에서 세상을 떠났다. 지금의 양화당은 1830년(순조 30)화재로 소실된 것을 1834년(순조 34)에 재건한 것이다.</span></p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm10" data-tab="cm10">
                                <h3 class="txt_section_tit vcPartTitle">영춘헌/집복헌</h3>
                                <div class="hidden">영춘헌/집복헌</div>
                                <div class="course_slide swiper" id="course_slide9">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Yeongchunheon Jipbokheon.jpg" data-key="4801" alt="영춘헌/집복헌">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">영춘헌(迎春軒)과 집복헌(集福軒)은 창경궁의 생활 공간으로 사용한 건물로 보인다. 남향인 영춘헌은 내전 건물이고, 집복헌은 영춘헌의 서쪽 방향에 5칸으로 연결된 서행각이다. 영춘헌은 정조가 왕위에 오른 후 자주 머물렀던 곳으로 독서실 겸 집무실로 사용하였고, 1800년 이곳에서 세상을 떠났다. 집복헌은 추존 장조(사도세자)와 순조가 태어난 곳이다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm11" data-tab="cm11">
                                <h3 class="txt_section_tit vcPartTitle">대온실</h3>
                                <div class="hidden">대온실</div>
                                <div class="course_slide swiper" id="course_slide10">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Daeonsil.jpg" data-key="4801" alt="대온실">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">대온실(大溫室)은 1909년(융희 3)에 완공한 우리나라 최초의 서양식 온실로, 철골구조와 목조가 혼합된 구조체를 유리로 둘러싼 서양식 온실이다. 준공 당시에는 열대지방의 관상식물을 비롯한 희귀한 식물을 전시하였다. 1986년 창경궁 복원 이후에는 국내 자생 식물을 전시하고 있다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm12" data-tab="cm12">
                                <h3 class="txt_section_tit vcPartTitle">춘당지</h3>
                                <div class="hidden">춘당지</div>
                                <div class="course_slide swiper" id="course_slide11">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cgg_img/Chundangji.jpg" data-key="4801" alt="춘당지">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">춘당지(春塘池)는 현재 두 개의 연못으로 나누어져 있으나 원래는 뒤쪽의 작은 연못이 조선시대 때부터 있었던 본래의 춘당지이다. 그러나 1909년 일제가 창경궁을 훼손할 때 이 자리에 연못을 파서 유원지로 만들었다. 이후 1986년 창경궁 복원 때 춘당지 가운데에 섬을 조성하여 우리나라 전통양식에 가깝게 다시 조성하였다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                        </div>
					</div>
				</div>
	</div>
</div>

    </article>
    </div>

