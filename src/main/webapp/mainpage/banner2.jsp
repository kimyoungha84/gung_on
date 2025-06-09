<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="kr.co.gungon.program.ProgramDTO, kr.co.gungon.program.ProgramService, kr.co.gungon.file.FilePathService, java.util.*" %>
<%
    ProgramService ps = new ProgramService();
    List<ProgramDTO> list = ps.getAllPrograms();
    FilePathService fps = new FilePathService();
%>

<div class="banner2-main">
  <h2>[행사 목록]</h2>

  <div class="main-container2">
    <!-- 설명 -->
    <div class="poster-description2">
      <h3>포스터 설명</h3>
      <p id="poster-desc-text">왼쪽 강조 포스터에 대한 설명이 이 영역에 나오며,<br>JS로 변경 가능합니다.</p>
    </div>

    <!-- 캐러셀 -->
    <div class="carousel-area2">
      <button id="prev-btn" class="nav-btn2">&#x2039;</button>
      <div class="poster-slider2">
        <div class="poster2-track" id="poster2-track">
          <!-- JS로 포스터 생성 -->
        </div>
      </div>
      <button id="next-btn" class="nav-btn2">&#x203A;</button>
    </div>
  </div>

  <div class="poster-index2">
    <span id="current-index">1</span> / <span id="total-count">0</span>
  </div>
</div>

<script>
  // JSP에서 DB 데이터를 JS 배열로 변환
  const posterData = [
    <% for (ProgramDTO dto : list) {
         String fileName = fps.getImageFullPath("program", String.valueOf(dto.getProgramId()));
         String desc = "행사 장소: " + dto.getProgramPlace()
         + "<br>행사 명: " + dto.getProgramName()
         + "<br>행사 기간: " + dto.getStartDate() + " ~ " + dto.getEndDate();
desc = desc.replace("\"", "\\\"").replace("\n", "").replace("\r", "").replace("'", "\\'");
    %>
    {
      fileName: "<%= fileName %>",
      description: "<%= desc.replace("\"", "\\\"") %>"
    }<%= (list.indexOf(dto) < list.size() - 1) ? "," : "" %>
    <% } %>
  ];

  // 캐러셀 로직 시작
  let current2 = 1;
  const max2 = posterData.length;
  const posterTrack2 = document.getElementById("poster2-track");
  const indexDisplay2 = document.getElementById("current-index");
  const totalCount2 = document.getElementById("total-count");
  const descDisplay2 = document.getElementById("poster-desc-text");
  const autoSlideDelay2 = 4000;
  let autoSlideTimer2 = null;

  totalCount2.textContent = max2;

  function createPoster2(index, position) {
    const div = document.createElement("div");
    div.className = "poster2 " + position;

    const poster = posterData[index - 1];

    const link = document.createElement("a");
    link.href = "/Gung_On/program/programInfo/programInfo.jsp?";

    const img = document.createElement("img");
    img.src = poster.fileName;
    img.alt = "포스터 " + index;

    link.appendChild(img);
    div.appendChild(link);
    return div;
  }

  function updatePosters2() {
    const next = current2 === max2 ? 1 : current2 + 1;
    posterTrack2.innerHTML = "";
    posterTrack2.appendChild(createPoster2(current2, "left"));
    posterTrack2.appendChild(createPoster2(next, "right"));
    posterTrack2.style.transform = "translateX(0px)";
    indexDisplay2.textContent = current2;

    const desc = posterData[current2 - 1].description || "설명이 없습니다.";
    descDisplay2.innerHTML = desc;
  }

  function slideTo2(direction) {
    const offset = direction === "next" ? -300 : 300;
    posterTrack2.style.transition = "transform 0.5s ease";
    posterTrack2.style.transform = `translateX(${offset}px)`;
    setTimeout(() => {
      current2 = direction === "next"
        ? (current2 === max2 ? 1 : current2 + 1)
        : (current2 === 1 ? max2 : current2 - 1);
      posterTrack2.style.transition = "none";
      updatePosters2();
    }, 500);
  }

  function startAutoSlide2() {
    if (autoSlideTimer2) clearTimeout(autoSlideTimer2);
    autoSlideTimer2 = setTimeout(() => {
      slideTo2("next");
      startAutoSlide2();
    }, autoSlideDelay2);
  }

  document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("prev-btn").addEventListener("click", () => {
      slideTo2("prev");
      startAutoSlide2();
    });

    document.getElementById("next-btn").addEventListener("click", () => {
      slideTo2("next");
      startAutoSlide2();
    });

    updatePosters2();
    startAutoSlide2();
  });
</script>
