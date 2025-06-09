<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }"/></title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/gung/mainGung.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/Story/Story.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/gung/sideTab.css">
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
 <jsp:include page="${pageContext.request.contextPath}/common/jsp/header.jsp" />
</header>

<main>
<div id="container">

    <!-- ✅ 사이드탭 -->
    <div id="side-tab">
        <jsp:include page="${pageContext.request.contextPath}/gung/sideTab.jsp" />
    </div>

<div class="gung-wrap">
    <!-- ✅ 버튼 영역 -->
    <div class="gung-button-wrap">
        <button class="gung-btn" data-name="광화문">광화문</button>
        <button class="gung-btn" data-name="흥례문">흥례문</button>
        <button class="gung-btn" data-name="사정전">사정전</button>
        <button class="gung-btn" data-name="수정전">수정전</button>
        <button class="gung-btn" data-name="경회루">경회루</button>
        <button class="gung-btn" data-name="풍기대">풍기대</button>
        <button class="gung-btn" data-name="영추문">영추문</button>
        <button class="gung-btn" data-name="강녕전">강녕전</button>
        <button class="gung-btn" data-name="건청궁">건청궁</button>
        <button class="gung-btn" data-name="신무문">신무문</button>
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
 <jsp:include page="${pageContext.request.contextPath}/common/jsp/footer.jsp" />
</footer>

</body>
</html>
