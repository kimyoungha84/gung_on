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
<link rel="stylesheet" href="/Gung_On/gung/mainGung.css">
<link rel="stylesheet" href="/Gung_On/Story/Story.css">
<link rel="stylesheet" href="/Gung_On/gung/sideTab.css">
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
        <button class="gung-btn" data-name="대한문">대한문</button>
        <button class="gung-btn" data-name="석어당">석어당</button>
        <button class="gung-btn" data-name="닥헝잔">덕홍전</button>
        <button class="gung-btn" data-name="정관헌">정관헌</button>
        <button class="gung-btn" data-name="석조전">석조전</button>
        <button class="gung-btn" data-name="돈덕전">돈덕전</button>
        <button class="gung-btn" data-name="증명전">중명전</button>
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
