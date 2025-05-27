/**
 * 
 */

/* 배너 1 영역*/

document.addEventListener("DOMContentLoaded", function () {
      const swiper = new Swiper('.main-banner-swiper', {
        loop: true,
        effect: 'fade',
        autoplay: {
          delay: 4000,
          disableOnInteraction: false
        }
      });

      const pageNow = document.getElementById('page-now');
      const pageTotal = document.getElementById('page-total');
      const realSlides = document.querySelectorAll('.main-banner-swiper .swiper-slide:not(.swiper-slide-duplicate)').length;
      pageTotal.textContent = realSlides;

      swiper.on('slideChange', () => {
        pageNow.textContent = (swiper.realIndex + 1).toString();
      });

      document.querySelector('.custom-prev').addEventListener('click', () => swiper.slidePrev());
      document.querySelector('.custom-next').addEventListener('click', () => swiper.slideNext());
    });

/* 배너 2 영역*/
document.addEventListener("DOMContentLoaded", function () {
  // 배너 2 영역
  const posterTrack2 = document.getElementById("poster2-track");
  const indexDisplay2 = document.getElementById("current-index");
  const prevBtn2 = document.getElementById("prev-btn");
  const nextBtn2 = document.getElementById("next-btn");

  
  
  const palaceMap = new Map();
  palaceMap.set("ChangdeokgungMoonlightTravel", "changdeokgung");
  palaceMap.set("Changgyeonggungnight", "changgyeonggung");
  palaceMap.set("DeoksugungNightSeokjojeonHall", "deoksugung");
  palaceMap.set("Gyeongbokgungnighttour", "gyeongbokgung");
  palaceMap.set("GyeongbokgungStarlightNight", "gyeongbokgung");
  
  const imageFiles2 = [
    "ChangdeokgungMoonlightTravel.jpg",
    "Changgyeonggungnight.png",
    "DeoksugungNightSeokjojeonHall.jpg",
    "Gyeongbokgungnighttour.jpg",
    "GyeongbokgungStarlightNight.jpg"
  ];
  
  let autoSlideTimer2 = null;
  const autoSlideDelay2 = 4000;
  const max2 = imageFiles2.length;
  let current2 = 1;

  function createPoster2(index, position) {
    const div = document.createElement("div");
    div.className = "poster2 " + position;

    const fileKey = imageFiles2[index - 1].split('.')[0]; // 확장자 제거
    const palaceName = palaceMap.get(fileKey) || "unknown"; // 매핑 없을 경우 대비

    const link = document.createElement("a");
    link.href = "palaceInfo.jsp?name=" + palaceName;

    const img = document.createElement("img");
    img.src = "/GungOn/common/images/program/" + imageFiles2[index - 1];
    img.alt = "포스터 " + index;

    link.appendChild(img);
    div.appendChild(link);

    return div;
  }


  const posterDescriptions = {
    "Gyeongbokgungnighttour": "경복궁 야간 특별관람은 아름다운 조명 아래 고궁의 밤을 감상할 수 있는 특별한 기회입니다.",
    "GyeongbokgungStarlightNight": "경복궁 별빛야행은 궁중 문화와 공연을 함께 즐길 수 있는 전통 야간행사입니다.",
    "ChangdeokgungMoonlightTravel": "창덕궁 달빛기행은 달빛 아래 후원을 거니는 특별한 체험 행사입니다.",
    "Changgyeonggungnight": "창경궁 야간 개방은 조용하고 운치 있는 분위기 속에서 궁을 감상할 수 있습니다.",
    "DeoksugungNightSeokjojeonHall": "덕수궁 석조전 야간관람은 대한제국의 역사와 서양식 건축을 경험할 수 있는 기회입니다."
  };
  
  function updatePosters2() {
    const next = current2 === max2 ? 1 : current2 + 1;
    posterTrack2.innerHTML = "";
    posterTrack2.appendChild(createPoster2(current2, "left"));
    posterTrack2.appendChild(createPoster2(next, "right"));
    posterTrack2.style.transform = "translateX(0px)";
    indexDisplay2.textContent = current2;
	
	const fileKey = imageFiles2[current2 - 1].split('.')[0];
	const desc = posterDescriptions[fileKey] || "해당 포스터에 대한 설명이 없습니다.";
	document.getElementById("poster-desc-text").innerHTML = desc;
  }

  function slideTo2(direction) {
    const offset = direction === "next" ? -300 : 300;
    posterTrack2.style.transition = "transform 0.5s ease";
    posterTrack2.style.transform = "translateX(" + offset + "px)";
    setTimeout(function () {
      current2 = direction === "next"
        ? (current2 === max2 ? 1 : current2 + 1)
        : (current2 === 1 ? max2 : current2 - 1);
      posterTrack2.style.transition = "none";
      updatePosters2();
    }, 500);
  }

  function startAutoSlide2() {
    if (autoSlideTimer2) {
      clearTimeout(autoSlideTimer2);
    }
    autoSlideTimer2 = setTimeout(function () {
      slideTo2("next");
      startAutoSlide2();
    }, autoSlideDelay2);
  }

  prevBtn2.addEventListener("click", function () {
    slideTo2("prev");
    startAutoSlide2();
  });

  nextBtn2.addEventListener("click", function () {
    slideTo2("next");
    startAutoSlide2();
  });

  updatePosters2();
  startAutoSlide2();
});