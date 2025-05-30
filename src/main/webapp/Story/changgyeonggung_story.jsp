<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }"/></title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<link rel="stylesheet" href="/Gung_On/common/css/common.css">
<link rel="stylesheet" href="/Gung_On/hjs/mainGung.css">
<link rel="stylesheet" href="/Gung_On/Story/Story.css">
<style>
</style>

<script type="text/javascript">
$(function(){
    $(".gung-btn").on("click", function(e){
        e.preventDefault();
        const palaceName = $(this).data("name");

        $.ajax({
            url: "g_story.jsp",
            type: "GET",
            data: { name: palaceName },
            success: function(response){
                $("#gung-info").html(response);
            },
            error: function(){
                $("#gung-info").html("<p>정보를 불러오는 데 실패했습니다.</p>");
            }
        });
    });
});
</script>

</head>
<body>

<header data-bs-theme="dark">
 <jsp:include page="/common/jsp/header.jsp" />
</header>

<main>
<div id="container">

    <!-- ✅ 사이드탭 -->
    <div id="side-tab">
        <jsp:include page="/gung/sideTab.jsp" />
    </div>

<div class="gung-wrap">
    <!-- ✅ 버튼 영역 -->
    <div class="gung-button-wrap">
        <button class="gung-btn" data-name="홍화문">홍화문</button>
        <button class="gung-btn" data-name="옥천교">옥천교</button>
        <button class="gung-btn" data-name="문정전">문정전</button>
        <button class="gung-btn" data-name="관천대">관천대</button>
        <button class="gung-btn" data-name="숭문당">숭문당</button>
        <button class="gung-btn" data-name="함인당">함인정</button>
        <button class="gung-btn" data-name="환경전">환경전</button>
        <button class="gung-btn" data-name="경춘전">경춘전</button>
        <button class="gung-btn" data-name="대온실">대온실</button>
        <button class="gung-btn" data-name="양화당">양화당</button>
    </div>

    <!-- ✅ AJAX 결과 출력 영역 -->
    <div id="gung-info" class="gung-info-box">
        <!-- AJAX 로딩 시 궁 정보가 여기에 표시됩니다 -->
        <p>원하는 궁 버튼을 선택해주세요.</p>
    </div>

</div>
</div>
</main>

<footer class="text-body-secondary py-5">
 <jsp:include page="/common/jsp/footer.jsp" />
</footer>

</body>
</html>
