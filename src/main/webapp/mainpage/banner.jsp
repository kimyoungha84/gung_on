<%@ page contentType="text/html; charset=UTF-8" language="java" %>


<!-- 캐러셀 슬라이드 -->
<div class="swiper main-banner-swiper">
  <div class="swiper-wrapper">
<div class="custom-banner-controls">
  <div class="page-info"><span id="page-now">1</span>/<span id="page-total">5</span></div>
  <img src="gung_on/common/images/mainpage/left-button.png" style="cursor: pointer;" class="custom-prev"/>
  <img src="gung_on/common/images/mainpage/right-button.png" style="cursor: pointer;" class="custom-next"/>
</div>
    <div class="swiper-slide">
      <a href="palaceInfo.jsp?name=gyeongbokgung" class="slide-link">
      	<img class="banner-slide" src="/gung_on/common/images/gung/gyeongbokgung/gyeongbokgung.jpg"/>
      </a>
          <div class="banner-text" style="margin-left:200px">
            <p class="sub-title">Gyeongbokgung Palace</p>
            <h2>경복궁</h2>
          </div>
    </div>
    <div class="swiper-slide">
      <a href="palaceInfo.jsp?name=gyeonghuigung" class="slide-link">
      	<img class="banner-slide" src="/gung_on/common/images/gung/gyeonghuigung/gyeonghuigung.jpg"/>
      </a>
          <div class="banner-text" style="margin-left:200px">
            <p class="sub-title">Gyeonghuigung Palace</p>
            <h2>경희궁</h2>
          </div>
    </div>
    <div class="swiper-slide">
      <a href="palaceInfo.jsp?name=changdeokgung" class="slide-link">
      	<img class="banner-slide" src="/gung_on/common/images/gung/changdeokgung/changdeokgung.jpg"/>
      </a>
          <div class="banner-text" style="margin-left:200px">
            <p class="sub-title">Changdeokgung Palace</p>
            <h2>창덕궁</h2>
        </div>
    </div>
    <div class="swiper-slide">
      <a href="palaceInfo.jsp?name=changgyeonggung" class="slide-link">
      	<img class="banner-slide" src="/gung_on/common/images/gung/changgyeonggung/changgyeonggung.jpg"/>
      </a>
          <div class="banner-text" style="margin-left:200px">
            <p class="sub-title">Changgyeonggung Palace</p>
            <h2>창경궁</h2>
          </div>
    </div>
    <div class="swiper-slide">
      <a href="palaceInfo.jsp?name=deoksugung" class="slide-link">
      	<img class="banner-slide" src="/gung_on/common/images/gung/deoksugung/deoksugung.jpg"/>
      </a>
          <div class="banner-text" style="margin-left:200px">
            <p class="sub-title">Deoksugung Palace</p>
            <h2>덕수궁</h2>
          </div>
    </div>
  </div>
</div>
