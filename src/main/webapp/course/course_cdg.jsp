<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<div class="sub_con_section">
	<div class="tab_con_wrap">
		<div class="tab_con current">
					<div class="course_tab_wrap">
						<div class="left course_pop_con">
							<span class="course_tit"><img src="course_img/ic_loca.jpg" alt=""> 코스안내</span>
								<ul class="list course_info_list">
									<li class="item" data-num="0">
											<a href="#;"><span class="inn">🚶전각/후원 코스</span></a>
										</li>
									</ul>
							</div>
						<select class="sel_st">
           			        <option value="gbg" >경복궁</option>
            		        <option value="cdg" selected="selected">창덕궁</option>
            		        <option value="dsg">덕수궁</option>
            		        <option value="cgg">창경궁</option>
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
									<button id="zoomInButton" class="zoomIn" data-panzoom-action="zoomIn" title="확大">
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
										<img data-id="1" class="map_content" src="course_img/cdg_img/cdg_map1.JPG" alt="전체 맵" draggable="false"> <%-- draggable="false" 권장 --%>
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
									<a href="#;"><span class="num">1</span>돈화문</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;"><span class="num">2</span>인정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;"><span class="num">3</span>선정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;"><span class="num">4</span>희정당</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;"><span class="num">5</span>대조전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;"><span class="num">6</span>성정각</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm7" data-num="7" data-tab="cm7">
									<a href="#;"><span class="num">7</span>궐내각사</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm8" data-num="8" data-tab="cm8">
									<a href="#;"><span class="num">8</span>구 선원전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm9" data-num="9" data-tab="cm9">
									<a href="#;"><span class="num">9</span>낙선재</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm10" data-num="10" data-tab="cm10">
									<a href="#;"><span class="num">10</span>부용지와 주합루</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm11" data-num="11" data-tab="cm11">
									<a href="#;"><span class="num">11</span>애련지와 의두합</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm12" data-num="12" data-tab="cm12">
									<a href="#;"><span class="num">12</span>연경당</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm13" data-num="13" data-tab="cm13">
									<a href="#;"><span class="num">13</span>존덕정</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm14" data-num="14" data-tab="cm14">
									<a href="#;"><span class="num">14</span>옥류천</a>
								</li>
							</ul>

					<div id="photoDiv">
                        <div class="tab_con_wrap course_slide_wrap">
                            <div class="tab_con cm1 current" data-tab="cm1">
                                <h3 class="txt_section_tit vcPartTitle">돈화문</h3>
                                <div class="hidden">돈화문</div>
                                <div class="course_slide swiper" id="course_slide0">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Donhwamun.jpg" data-key="4801" alt="돈화문">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">돈화문(敦化門)은 창덕궁의 정문으로 1412년(태종 12)에 처음 지어졌는데 창건 당시 창덕궁 앞에는 종묘가 자리 잡고 있어 궁의 진입로를 궁궐의 남서쪽에 세웠다. 이후 임진왜란 때 소실된 것을 1609년(광해군 1)에 다시 지었는데, 규모는 2층 누각형 건물로 궁궐 대문 가운데 가장 큰 규모이다. 돈화문은 왕의 행차와 같은 의례가 있을 때 출입문으로 사용하였고, 신하들은 보통 서쪽의 금호문으로 드나들었다.</p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm2" data-tab="cm2">
                                <h3 class="txt_section_tit vcPartTitle">인정전</h3>
                                <div class="hidden">인정전</div>
                                <div class="course_slide swiper" id="course_slide1">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Injeongjeon.jpg" data-key="4801" alt="인정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">인정전(仁政殿)은 창덕궁의 정전으로 왕의 즉위식, 신하들의 하례, 외국 사신의 접견, 궁중 연회 등 중요한 국가행사를 치르던 곳이다. 인정전은 2단의 월대 위에 웅장한 중층 전각으로 지어졌는데, 월대의 높이가 낮고 난간이 없어 경복궁의 근정전에 비하면 소박한 모습이다. 내부의 마루와 전등, 커튼, 유리창문 등은 1908년(융희 2)에 서양식으로 개조한 것이다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm3" data-tab="cm3">
                                <h3 class="txt_section_tit vcPartTitle">선정전</h3>
                                <div class="hidden">선정전</div>
                                <div class="course_slide swiper" id="course_slide2">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Seonjeongjeon.jpg" data-key="4801" alt="선정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">선정전(宣政殿)은 왕이 신하들과 함께 일상 업무를 보던 공식 집무실인 편전(便殿)이다. 이곳에서 조정 회의, 업무 보고, 경연 등 각종 회의가 이곳에서 매일 열렸다. 선정전은 임진왜란을 거쳐 인조반정 때 소실되었다가 1647년(인조 25) 인경궁의 편전인 광정전(光政殿)을 옮겨 지었는데, 현재 궁궐에 남아있는 유일한 청기와 건물이다.</p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm4" data-tab="cm4">
                                <h3 class="txt_section_tit vcPartTitle">희정당</h3>
                                <div class="hidden">희정당</div>
                                <div class="course_slide swiper" id="course_slide3">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Huijeongdang.jpg" data-key="4801" alt="희정당">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">희정당(熙政堂)은 원래는 왕이 가장 많이 머물렀던 침전 건물이었으나 조선 후기에는 편전으로 기능이 바뀐 건물이다. 1917년 대화재로 모두 소실되었다가 1920년 경복궁 강녕전을 옮겨다 복원하였는데, 이때 내부를 쪽매널 마루와 카펫, 유리 창문, 샹들리에 등을 설치하여 서양식으로 꾸몄다. 입구는 전통 건물에서 볼 수 없는 현관의 형태로 되어있고, 자동차가 들어설 수 있는 구조로 바뀌었다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm5" data-tab="cm5">
                                <h3 class="txt_section_tit vcPartTitle">대조전</h3>
                                <div class="hidden">대조전</div>
                                <div class="course_slide swiper" id="course_slide4">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Daejojeon.jpg" data-key="4801" alt="대조전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">대조전(大造殿)는 창덕궁의 정식 침전이자 왕비의 생활공간이다. 대조전은 창덕궁의 전각 중 유일하게 용마루가 없는 건물로, 창덕궁 창건 당시부터 여러 차례 화재로 소실되었다가 다시 지었다. 현재의 대조전은 1917년 대화재로 소실되었다가 1920년 경복궁 교태전을 옮겨 희정당처럼 내부를 마루와 유리창 등 서양식으로 꾸몄다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm6" data-tab="cm6">
                                <h3 class="txt_section_tit vcPartTitle">성정각</h3>
                                <div class="hidden">성정각</div>
                                <div class="course_slide swiper" id="course_slide5">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Seongjeonggak.jpg" data-key="4801" alt="성정각">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">성정각은 세자의 교육장이었으나, 일제강점기에는 내의원으로 쓰기도 했다.  성정각은 단층이지만 동쪽에 직각으로 꺾인  2층의 누(樓)가 붙어 있어 독특한 모습이다.  누각에는 희우루(喜雨樓), 보춘정(報春亭)이라는 편액들이 걸려 있다.  성정각 뒤편에 있는 관물헌(觀物軒)은 왕이 자주 머물면서 독서와 접견을 했던 곳으로, 현재는 집희(緝熙)라는 현판이 남아 있다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm7" data-tab="cm7">
                                <h3 class="txt_section_tit vcPartTitle">궐내각사</h3>
                                <div class="hidden">궐내각사</div>
                                <div class="course_slide swiper" id="course_slide6">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Gwolnaegagsa.jpg" data-key="4801" alt="궐내각사">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">궐내각사(闕內各司)는 궁궐 내의 관청을 의미하는데, 왕을 가까이에서 보좌하기 위해 특별히 궁궐 안에 세운 관청을 말한다. 인정전 서쪽 금천교 뒤로 동편에 약방(내의원), 옥당(홍문관), 예문관이, 서편에 내각(규장각), 봉모당(奉謨堂), 검서청(檢書廳) 등이 있다. 지금 있는 건물들은 2000~2004년에 복원하였다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm8" data-tab="cm8">
                                <h3 class="txt_section_tit vcPartTitle">구 선원전</h3>
                                <div class="hidden">구 선원전</div>
                                <div class="course_slide swiper" id="course_slide7">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Seonwonjeon.jpg" data-key="4801" alt="구선원전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">선원전은 역대 왕들의 초상화인 어진(御眞)을 모시고 제사를 지내는 신성한 곳이다. 1656년(효종 7)에 경덕궁(慶德宮)의 경화당을 옮겨 지은 춘휘전(春暉殿)을 숙종대부터 선원전으로 사용하였다. 이후 1921년에 신 선원전을 후원 깊숙한 곳에 건립하여 어진을 옮겨가면서 이 일대는 폐허가 되었다. 선원전은 지금까지 남아 있으나 부속건물들은 이때 없어졌다가 2005년에 복원되었다.</p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm9" data-tab="cm9">
                                <h3 class="txt_section_tit vcPartTitle">낙선재</h3>
                                <div class="hidden">낙선재</div>
                                <div class="course_slide swiper" id="course_slide8">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Nakseonjae.jpg" data-key="4801" alt="낙선재">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">낙선재는 헌종의 서재 겸 사랑채로 사용하던 건물로 1847년(헌종 13)에 지었다. 낙선재 바로 옆은 헌종의 후궁 경빈의 처소인 석복헌이 있으며 석복헌 옆에는 당시 대왕대비인 순원왕후의 처소인 수강재가 있다. 단청을 하지 않은 소박한 모습을 지녔으며 후원에는 세련된 굴뚝과 괴석들을 배열하여 궁궐의 품격과 여인의 공간 특유의 아기자기함을 볼 수 있다. 낙선재 일원은 대한제국의 마지막 황후 순정 황후와 의민황태자비(이방자 여사), 덕혜옹주 등 대한제국 마지막 황실가족이 생활 하다가 세상을 떠난 곳이기도 하다.</p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm10" data-tab="cm10">
                                <h3 class="txt_section_tit vcPartTitle">부용지와 주합루</h3>
                                <div class="hidden">부용지와 주합루</div>
                                <div class="course_slide swiper" id="course_slide9">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Buyongji.jpg" data-key="4801" alt="부용지와 주합루">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">부용지(芙蓉池)는 창덕궁 후원의 첫 번째 중심 정원으로 휴식뿐 아니라 학문과 교육을 하던 비교적 공개된 장소이다. 300평(약 1000㎡) 넓이의 사각형 연못인 부용지를 중심으로 여러 건물을 지었다. 부용정(芙蓉亭)은 부용지 남쪽에 있는 정자로, 지붕 위에서 봤을 때 열 십(十)자의 독특한 모습을 하고 있다. <br>
                                        <br> 주합루(宙合樓)는 부용지 북쪽에 1776년(정조 즉위)에 지은 건물이다. 주합루는 2층 규모로 지어졌는데 1층은 왕실도서관인 규장각이고, 2층은 주합루이다. 주합루의 정문인 어수문(魚水門)은 물과 물고기, 즉 왕과 신하의 관계를 뜻하며 지은 이름이다. 주합루로 들어가기 위해 왕은 어수문으로 출입하지만, 신하들은 어수문 옆 협문으로 출입하였다.</p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm11" data-tab="cm11">
                                <h3 class="txt_section_tit vcPartTitle">애련지와 의두합</h3>
                                <div class="hidden">애련지와 의두합</div>
                                <div class="course_slide swiper" id="course_slide10">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Aelyeonji.jpg" data-key="4801" alt="애련지와 의두합">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p>애련지(愛蓮池)는 창덕궁 후원의 두 번째 정원이다. 1692년(숙종 18) 숙종은 연못 가운데 섬을 쌓고 정자를 지었다고 하는데, 현재 그 섬은 없고 정자는 연못 북쪽 끝에 걸쳐 있다. 연꽃을 좋아했던 숙종이 이 정자에 애련(愛蓮)이라는 이름을 붙여 애련정이라 불렀고, 연못은 애련지가 되었다.<br> 기오헌(奇傲軒)은 1827년(순조 27) 효명세자(추존 문조)가 애련지 부근에 의두합을 비롯하여 몇 개의 건물을 짓고 애련지와 구분하여 담장을 쌓았다고 한다. 그러나 현재는 기오헌(奇傲軒)이라는 현판이 걸려있는 의두합과 운경거 두 건물만 남아있다. 의두합과 운경거는 단청이 없는 매우 소박한 건물이다.</p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm12" data-tab="cm12">
                                <h3 class="txt_section_tit vcPartTitle">연경당</h3>
                                <div class="hidden">연경당</div>
                                <div class="course_slide swiper" id="course_slide11">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Yeongyeongdang.jpg" data-key="4801" alt="연경당">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">연경당(演慶堂)은 추존 문조(효명세자)가 아버지 순조에게 존호(尊號)를 올리는 의례를 행하기 위해 1827년(순조 27)경에 창건하였다. 연경당은 사대부 살림집과 유사하게 남성의 공간인 사랑채와 여성의 공간인 안채를 중심으로 이루어졌으며 단청을 하지 않았다. 사랑채와 안채가 분리되어 있지만 내부는 연결되어 있다.</p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm13" data-tab="cm13">
                                <h3 class="txt_section_tit vcPartTitle">존덕정</h3>
                                <div class="hidden">존덕정</div>
                                <div class="course_slide swiper" id="course_slide12">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Jondeogjeong.jpg" data-key="4801" alt="존덕정">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">존덕정(尊德亭)&nbsp;일원은 창덕궁 후원 가운데 가장 늦게 갖춰진 것으로 보인다. 연못을 중심으로 겹지붕의 육각형 정자인 존덕정, 부채꼴 형태의 관람정(觀纜亭), 서쪽 언덕 위에 있는 길쭉한 맞배지붕의 폄우사(砭愚榭), 관람정 맞은편의 승재정(勝在亭) 등 다양한 형태의 정자들이 있다. 이곳에 있는 정자 중 존덕정이 가장 오래된 건물이다.</p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm14" data-tab="cm14">
                                <h3 class="txt_section_tit vcPartTitle">옥류천</h3>
                                <div class="hidden">옥류천</div>
                                <div class="course_slide swiper" id="course_slide13">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/cdg_img/Oglyucheon.jpg" data-key="4801" alt="옥류천">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;">옥류천(玉流川)은 창덕궁 후원에서 가장 북쪽에 자리하고 있어, 가장 깊은 골짜기에 흐른다.『궁궐지(宮闕志)』에 의하면 바위에 새겨진 '玉流川' 세 글자는 인조의 친필이고, 오언절구 시는 이 일대의 경치를 읊은 숙종의 시로 기록되어 있다. 옥류천 주변으로는 소요정(逍遙亭), 태극정(太極亭), 농산정(籠山亭), 취한정(翠寒亭), 청의정(淸漪亭) 등 작은 규모의 정자를 곳곳에 세웠다.</p>
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

