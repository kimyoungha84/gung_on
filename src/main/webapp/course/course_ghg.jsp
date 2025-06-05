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
            		        <option value="cdg" >창덕궁</option>
            		        <option value="dsg" >덕수궁</option>
            		        <option value="cgg" >창경궁</option>
            		        <option value="ghg" selected="selected">경희궁</option>
                         </select>

					</div>
					<div class="course_map_wrap" id="course_map_wrap">
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
										<img data-id="1" class="map_content" src="course_img/ghg_img/ghg_all.png" alt="전체 맵" draggable="false">
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
									<a href="#;"><span class="num">1</span>경교장</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;"><span class="num">2</span>서울성곽</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;"><span class="num">3</span>홍난파 가옥</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;"><span class="num">4</span>권율장군집터</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;"><span class="num">5</span>독립문</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;"><span class="num">6</span>서대문 독립공원</a>
								</li>
							</ul>

					<div id="photoDiv">
                        <div class="tab_con_wrap course_slide_wrap">
                            <div class="tab_con cm1 current" data-tab="cm1">
                                <h3 class="txt_section_tit vcPartTitle">경교장</h3>
                                <div class="hidden">경교장</div>
                                <div class="course_slide swiper" id="course_slide0">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Gyeonggyojang.jpg" data-key="4801" alt="경교장">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">대한민국 임시정부의 주석이었던 백범 김구 선생이 1945년 중국에서 돌아온 이후 1949년 6월 26일 암살당할 때까지 집무실과 숙소로 사용했던 건물이다.</span></p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm2" data-tab="cm2">
                                <h3 class="txt_section_tit vcPartTitle">서울성곽</h3>
                                <div class="hidden">서울성곽</div>
                                <div class="course_slide swiper" id="course_slide1">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Seoulseonggwag.jpg" data-key="4801" alt="서울성곽">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">서울 성곽은 원래 1392년 조선을 개국한 태조가 한양 천도 이후 축조를 시작해 세종 4년(1422년) 골격을 갖추고 1704년 숙종 때 대대적인 정비를 거쳐 북악산(342m), 낙산(125m), 남산(262m), 인왕산(338m)를 잇는 총 길이 18.2km의 완전한 도성의 형태를 갖추고 있던 곳이었다. 그러나 일제시대 등을 거치며 평지 성곽의 대부분이 철거되었고 산지의 성곽들도 유실된 곳이 많아 지금은 10.5km의 구간만이 그 명맥을 유지하고 있는데, 경희궁-서대문 코스를 돌아보며 그 일부를 만나볼 수 있다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm3" data-tab="cm3">
                                <h3 class="txt_section_tit vcPartTitle">홍난파 가옥</h3>
                                <div class="hidden">홍난파 가옥</div>
                                <div class="course_slide swiper" id="course_slide2">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Hongnanpa gaog.jpg" data-key="4801" alt="홍난파 가옥">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">홍파동 홍난파 가옥은 1930년대 독일 선교사가 지은 벽돌조 서양식 건물을 작곡가 홍난파 선생이 인수하여 살던 곳이다. 홍난파 선생의 대표곡들이 작곡된 곳이고, 1930년대 서양식 주택 특성이 잘 보존되어 있어 가치가 있다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm4" data-tab="cm4">
                                <h3 class="txt_section_tit vcPartTitle">권율장군집터</h3>
                                <div class="hidden">권율장군집터</div>
                                <div class="course_slide swiper" id="course_slide3">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Gwonyuljanggunjibteo.jpg" data-key="4801" alt="권율장군집터">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">조선 중기의 문신이며 명장인 만취당(晩翠堂) 권율(1537∼1599) 장군의 집터</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm5" data-tab="cm5">
                                <h3 class="txt_section_tit vcPartTitle">독립문</h3>
                                <div class="hidden">독립문</div>
                                <div class="course_slide swiper" id="course_slide4">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Dongnimmun.jpg" data-key="4801" alt="독립문">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">1897년 독립협회가 국민 모금을 통해 세운 높이 14.28m, 너비 11.48m의 석조문이다. 원래는 중국 사신을 영접하는 사대외교의 상징인 영은문(迎恩門)이 있었으나, 이를 허물고 독립의 의지를 되새겼다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm6" data-tab="cm6">
                                <h3 class="txt_section_tit vcPartTitle">석어당</h3>
                                <div class="hidden">석어당</div>
                                <div class="course_slide swiper" id="course_slide5">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Seokgeodang.jpg" data-key="4801" alt="석어당">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">석어당(昔御堂)은 즉조당과 함께 덕수궁의 모태가 되는 건물로 임진왜란 때 선조가 임시로 거처했던 곳이다. 인조는 경운궁의 전각 대부분을 원래 주인에게 돌려주었으나 석어당과 즉조당은 보존하였다. 석어당은 덕수궁에 있는 건물 중 유일하게 남아 있는 2층 건물이자 단청을 하지 않은 건물이다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm7" data-tab="cm7">
                                <h3 class="txt_section_tit vcPartTitle">덕홍전</h3>
                                <div class="hidden">덕홍전</div>
                                <div class="course_slide swiper" id="course_slide6">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Deokhongjeon.jpg" data-key="4801" alt="덕홍전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">덕홍전(德弘殿)은 원래 고종의 황후인 명성황후의 혼전(왕과 왕비의 신주를 종묘로 모시기 전까지 임시로 신주를 모시는 건물)인 경효전이 있었던 곳이었다. 이후 고종은 고위 관료와 외교 사절 등 빈객을 접대하기 위한 접견실로 사용하였다. 내부는 천장의 샹들리에와 봉황문양의 단청, 오얏문양 등으로 화려하게 꾸몄다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm8" data-tab="cm8">
                                <h3 class="txt_section_tit vcPartTitle">함녕전</h3>
                                <div class="hidden">함녕전</div>
                                <div class="course_slide swiper" id="course_slide7">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Hamnyeongjeon.jpg" data-key="4801" alt="함녕전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">함녕전(咸寧殿)은 1897년 고종의 환궁과 함께 지어진 황제의 침전이다. 1904년(광무 8) 함녕전 온돌 수리공사 중 일어난 화재로 소실되어 이듬해 다시 지었다. 고종은 이곳에서 생활하다가 1919년에 세상을 떠났다. 함녕전 뒤편에는 계단식 정원으로 꾸며 아름다운 장식을 한 굴뚝들을 설치하였다. 함녕전의 정문인 광명문은 2018년 현재의 자리로 다시 옮겼다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm9" data-tab="cm9">
                                <h3 class="txt_section_tit vcPartTitle">정관헌</h3>
                                <div class="hidden">정관헌</div>
                                <div class="course_slide swiper" id="course_slide8">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Jeonggwanheon.jpg" data-key="4801" alt="정관헌">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">정관헌(靜觀軒)은『고종실록』에 의하면 조선 역대 왕의 초상화인 어진을 임시로 봉안했던 장소로 사용하였다. 정관헌은 동서양의 양식을 모두 갖춘 건물인데 기단 위에 로마네스크 양식의 인조석 기둥을 둘러서 내부 공간을 만들었고, 바깥에는 동·남·서 세 방향에 기둥을 세운 포치가 있다. 난간에는 사슴, 소나무, 당초, 박쥐 등의 전통 문양이 조각되어 있다.</span></p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm10" data-tab="cm10">
                                <h3 class="txt_section_tit vcPartTitle">석조전</h3>
                                <div class="hidden">석조전</div>
                                <div class="course_slide swiper" id="course_slide9">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Seokjojeon.jpg" data-key="4801" alt="석조전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">석조전(石造殿)은 고종이 침전 겸 편전으로 사용하기 위해 지은 서양식 석조건물이다. 석조전은 서양의 신고전주의 건축양식으로 지어졌으며, 건물의 앞과 동서 양면에 발코니가 설치된 것이 특징이다. 1910년에 준공된 후 고종은 고관대신과 외국 사절을 만나기 위한 접견실로 사용하였다. 현재는 대한제국역사관으로 개관하였다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm11" data-tab="cm11">
                                <h3 class="txt_section_tit vcPartTitle">석조전 서관</h3>
                                <div class="hidden">석조전 서관</div>
                                <div class="course_slide swiper" id="course_slide10">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Seogjojeon seogwan.jpg" data-key="4801" alt="석조전 서관">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">석조전 서관(石造殿 西館, 국립현대미술관 덕수궁관)은 1936년 8월 기공하여 1938년 6월에 준공하였으며, 이왕가 미술관으로 사용되었다. 현재는 국립현대미술관 덕수궁관으로 사용하고 있다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm12" data-tab="cm12">
                                <h3 class="txt_section_tit vcPartTitle">돈덕전</h3>
                                <div class="hidden">돈덕전</div>
                                <div class="course_slide swiper" id="course_slide11">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Dondeokjeon.jpg" data-key="4801" alt="돈덕전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">돈덕전(惇德殿)은 1902년(광무 6) 고종 즉위 40주년 기념 칭경 예식을 위해 지은 건물로, 돈덕은 덕이 도탑다는 뜻이다. 벽돌로 지었고 화려한 유럽풍 외관을 지녔다. 1층은 황제를 뵙는 폐현실, 2층은 황제의 침실이 있었으며, 각국 외교사절의 폐현 및 연회장, 국빈급 외국인의 숙소로 사용하였다. 1907년 순종은 이곳에서 황제 즉위식을 가졌다. 1919년 고종이 세상을 떠난 후 방치되었다가 1930년대에 없어진 것으로 보이며, 궁능유적본부가 2023년에 재건하였다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                             <div class="tab_con cm13" data-tab="cm13">
                                <h3 class="txt_section_tit vcPartTitle">중명전</h3>
                                <div class="hidden">중명전</div>
                                <div class="course_slide swiper" id="course_slide12">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/dsg_img/Jungmyeongjeon.jpg" data-key="4801" alt="중명전">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">중명전(重眀殿)은 처음 1897년 황실 도서관으로 지어진 후 수옥헌(漱玉軒)이라고 불렸다. 수옥헌이 중명전으로 불리게 된 것은 1906년 이후로 보여진다. 1905년(광무 9) 을사늑약이 체결된 비운의 장소이기도 하며, 일제강점기 이후 민간에서 활용하다가, 2009년에 복원공사하여 2010년에 전시관으로 개관하였다.</span></p>
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

