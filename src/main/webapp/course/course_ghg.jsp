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
									<a href="#;"><span class="num">1</span>흥화문</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm2" data-num="2" data-tab="cm2">
									<a href="#;"><span class="num">2</span>금천교</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm3" data-num="3" data-tab="cm3">
									<a href="#;"><span class="num">3</span>숭정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm4" data-num="4" data-tab="cm4">
									<a href="#;"><span class="num">4</span>자정전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm5" data-num="5" data-tab="cm5">
									<a href="#;"><span class="num">5</span>태령전</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm6" data-num="6" data-tab="cm6">
									<a href="#;"><span class="num">6</span>서암</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link cm7" data-num="7" data-tab="cm7">
									<a href="#;"><span class="num">7</span>경교장</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm8" data-num="8" data-tab="cm8">
									<a href="#;"><span class="num">8</span>서울성곽</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm9" data-num="9" data-tab="cm9">
									<a href="#;"><span class="num">9</span>홍난파 가옥</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm10" data-num="10" data-tab="cm10">
									<a href="#;"><span class="num">10</span>권율장군집터</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm11" data-num="11" data-tab="cm11">
									<a href="#;"><span class="num">11</span>독립문</a>
								</li>
							<li class="child_tab_menu course_num_item tab_link  cm12" data-num="12" data-tab="cm12">
									<a href="#;"><span class="num">12</span>서대문 독립공원</a>
								</li>
							</ul>

					<div id="photoDiv">
                        <div class="tab_con_wrap course_slide_wrap">
                            <div class="tab_con cm1 current" data-tab="cm1">
                                <h3 class="txt_section_tit vcPartTitle">흥화문</h3>
                                <div class="hidden">흥화문</div>
                                <div class="course_slide swiper" id="course_slide0">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Heunghwamun.jpg" data-key="4801" alt="흥화문">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">경희궁의 정문인 흥화문은 서울특별시 유형문화유산으로 지정되어 있습니다. 원래는 금천교 동쪽, 즉 현재의 구세군 빌딩자리에서 동쪽을 바라보고 있었습니다. 그러나 일제가 1932년 이토 히로부미를 위한 사당인 박문사의 정문으로 사용하기 위하여 흥화문을 떼어갔었습니다. 광복 이후 박문사가 폐지되고 그 자리에는 영빈관에 이어 신라호텔이 들어서면서 그 정문으로 남아있었습니다. 1988년 경희궁 복원사업의 일환으로 흥화문을 경희궁터로 옮겨 왔는데 원래의 자리에는 이미 구세군빌딩이 세워져 있어서, 현재의 위치에 이전하여 복원하였습니다.</span></p>
                                        <div></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm2" data-tab="cm2">
                                <h3 class="txt_section_tit vcPartTitle">금천교</h3>
                                <div class="hidden">금천교</div>
                                <div class="course_slide swiper" id="course_slide1">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Geumcheongyo.jpg" data-key="4801" alt="금천교">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">경희궁의 정문인 흥화문을 들어서면 궁내의 전각에 들어서기 전에 흐르던 금천에 놓여진 돌다리입니다. 난간의 돌짐승들이나 홍예 사이에 새겨진 도깨비 얼굴은 대궐 바깥의 나쁜 기운이 궐내에 들어오지 못하게 하려는 상징성을 띠는 것입니다. 1619년(광해군 11)에 건립되었던 것을 일제가 매몰시켰지만, 서울시에서는 2001년 발굴을 통하여 발견된 옛 석조물을 바탕으로 현재와 같이 복원하였습니다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm3" data-tab="cm3">
                                <h3 class="txt_section_tit vcPartTitle">숭정전</h3>
                                <div class="hidden">숭정전</div>
                                <div class="course_slide swiper" id="course_slide2">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Sungjeongjeon.jpg" data-key="4801" alt="숭정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">숭정전은 경희궁의 정전으로 국왕이 신하들과 조회를 하거나, 궁중 연회, 사신 접대 등 공식 행사가 행해진 곳입니다. 특히 경종, 정조, 헌종 등 세 임금은 이곳에서 즉위식을 거행하였습니다. 숭정전은 경희궁 창건공사 초기인 1618년(광해군 10)경에 정면 5칸, 측면 4칸의 규모로 건립되었습니다. 그러나 일제가 경희궁을 훼손하면서 1926년 건물을 일본인 사찰에 팔았는데, 현재는 동국대학교 정각원으로 사용하고 있습니다. 현 위치의 숭정전은 경희궁지 발굴을 통하여 확인된 위치에 발굴된 기단석 등을 이용하여 복원한 것입니다. 숭정전 내부 당가에 용상을 설치하였는데, 그 뒤로 곡병과 일월오봉병을 두었다. 우물천정에는 마주보고 있는 두 마리의 용을 새겨두었습니다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm4" data-tab="cm4">
                                <h3 class="txt_section_tit vcPartTitle">자정전</h3>
                                <div class="hidden">자정전</div>
                                <div class="course_slide swiper" id="course_slide3">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Jajeongjeon.jpg" data-key="4801" alt="자정전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">자정전은 경희궁의 편전으로서 국왕이 신하들과 회의를 하거나 경연을 여는 등 공무를 수행하던 곳입니다. 숙종이 승하한 후에는 빈전으로 사용되기도 하였으며, 선왕들의 어진이나 위패를 임시로 보관하기도 하였습니다. 1617~20년(광해군 9~12) 사이에 건립되었으나, 일제가 훼손하였습니다. 서울시에서는 발굴을 통하여 확인된 자리에 <서궐도안>에 현재의 건물을 복원하였습니다. 자정전 서쪽에는 발굴을 통하여 행랑의 바닥으로 사용된 것으로 추정되는 전돌이 발견되었기에 발굴 당시의 모습을 보존하여 복원하였습니다.</span></p>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm5" data-tab="cm5">
                                <h3 class="txt_section_tit vcPartTitle">태령전</h3>
                                <div class="hidden">태령전</div>
                                <div class="course_slide swiper" id="course_slide4">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Taeryeongjeon.jpg" data-key="4801" alt="태령전">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="swiper-button-next"></div>
                                     <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">태령전은 영조의 어진을 보관하던 곳입니다. 본래는 특별한 용도가 지정되지는 않았던 건물이었습니다. 그러나 영조의 어진이 새로 그려지자 1744년(영조 20)에 이 곳을 중수하여 어진을 봉안하였고, 영조가 승하한 후에는 혼전으로 사용되기도 하였습니다. 흔적조차 거의 남아있지 않던 태령전을 서울시에서는 <서궐도안>에 따라 정면 5칸, 측면 2칸의 건물로 복원하였습니다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm6" data-tab="cm6">
                                <h3 class="txt_section_tit vcPartTitle">서암</h3>
                                <div class="hidden">서암</div>
                                <div class="course_slide swiper" id="course_slide5">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Seoam.jpg" data-key="4801" alt="서암">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">태령전 뒤에 있는 기이한 모양의 바위, 암천(巖泉)으로 불리는 바위 속의 샘이 있어 예로부터 경희궁의 명물이었습니다. 본래는 왕암(王巖)으로 불리었는데 그 이름으로 인하여 광해군이 이 지역에 경희궁을 지었다는 속설도 있습니다.  1708년(숙종34)에 이름을 서암으로 고치고 숙종이 직접 '瑞巖' 두 글자를 크게 써서 새겨 두게 하였습니다.  현재 서암을 새겨 두었던 사방석은 국립고궁박물관에 소장되어 있습니다.</span></p>
                                        <div style="text-align: justify;"></div>
                                    </div>
                                </div>
                                <div class="course_info box_wrap flex_center_align mb0 koglCodeInfo">
                                    <img src="course_img/nuri.svg" alt="공공누리 제1유형 : 공공누리 공공저작물 자유이용허락 출처표시" class="flex_shrink">
                                    <div>궁능유적본부가 보유한 본 저작물은 "공공누리“ 제1유형(출처표시+상업적 이용가능) 조건에 따라 이용 할 수 있습니다.</div>
                                </div>
                            </div>
                            <div class="tab_con cm7" data-tab="cm7">
                                <h3 class="txt_section_tit vcPartTitle">경교장</h3>
                                <div class="hidden">경교장</div>
                                <div class="course_slide swiper" id="course_slide6">
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
                            <div class="tab_con cm8" data-tab="cm8">
                                <h3 class="txt_section_tit vcPartTitle">서울성곽</h3>
                                <div class="hidden">서울성곽</div>
                                <div class="course_slide swiper" id="course_slide7">
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
                            <div class="tab_con cm9" data-tab="cm9">
                                <h3 class="txt_section_tit vcPartTitle">홍난파 가옥</h3>
                                <div class="hidden">홍난파 가옥</div>
                                <div class="course_slide swiper" id="course_slide8">
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
                            <div class="tab_con cm10" data-tab="cm10">
                                <h3 class="txt_section_tit vcPartTitle">권율장군집터</h3>
                                <div class="hidden">권율장군집터</div>
                                <div class="course_slide swiper" id="course_slide9">
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
                            <div class="tab_con cm11" data-tab="cm11">
                                <h3 class="txt_section_tit vcPartTitle">독립문</h3>
                                <div class="hidden">독립문</div>
                                <div class="course_slide swiper" id="course_slide10">
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
                            <div class="tab_con cm12" data-tab="cm12">
                                <h3 class="txt_section_tit vcPartTitle">서대문 독립공원</h3>
                                <div class="hidden">서대문 독립공원</div>
                                <div class="course_slide swiper" id="course_slide11">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide" data-seq="8">
                                            <div class="img_wrap">
                                                <img src="course_img/ghg_img/Seodaemun doglibgongwon.jpg" data-key="4801" alt="서대문 독립공원">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div>
                                <div class="course_txt_wrap">
                                    <div class="txt">
                                        <p style="text-align: justify;"><span style="color: rgb(19, 19, 19); text-align: justify;">1897년 독립협회에서 건립한 독립문과 독립관, 3.1독립 선언 기념탑이 있는 공원이다. 조선 시대 중국 사신들을 영접하던 독립관은 1996년 복원해 순국선열 위패 2327위를 봉안했다. 독립문 바로 앞에는 영은문 주초가 자리한다. 그 외 순국선열 추념탑, 서재필 박사 동상 등이 있다. 2009년 8월 노후한 공간과 시설들을 개선해 역사 공원으로 재탄생했다.</span></p>
                                        <div style="text-align: justify;"></div>
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

