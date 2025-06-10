<%@page import="kr.co.gungon.cs.FaqDTO"%>
<%@page import="kr.co.gungon.cs.CsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String numStr = request.getParameter("num");
int num = 0;
if (numStr != null && !numStr.isEmpty()) {
    try {
        num = Integer.parseInt(numStr);
    } catch (NumberFormatException e) {
        out.println("숫자로 변환할 수 없습니다: " + numStr);
    }
    
    
}
    CsService css = new CsService();
    
    FaqDTO fDTO = css.searchOneFaq(num);
    pageContext.setAttribute("fDTO", fDTO);
    
 // notice_title에서 "를 &quot;로 치환
    
	  String safeTitle = fDTO.getFaq_title().replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
	  String safeContent = fDTO.getFaq_content().replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
%>
        
        <style>
        .border-secondary{
  			border-width: 3px !important;
        	background-color: #F8F9FA;
        	font-weight: bold;
        	margin-right: -2rem;
        
        }
  		.card-hover:hover {
  			background-color: #A0A0A0;
  			border-color: #212511 !important;
		}
		.col-md-3{
			width: 120px;
			height : 80px;
		
		}
		

		</style>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        
        <script type="text/javascript">
        // 메인 페이지로 이동
        function moveToMain() {
            window.location.href = "cs_faq_main.jsp";  
        }

       function modifyProcess() {
		    var $form = $("#summerNoteFrm"); // jQuery로 폼 선택
		    
		    var title = $("#title").val().trim(); // 제목 입력값

		    // 제목이 비었거나 공백만 있으면
		    if (title === "") {
		        alert("제목은 필수입력입니다.");
		        return; // 유효성 검사 실패 시 함수 종료
		    }

		    var content = $("#summernote").summernote('code').trim();  // summernote에서 HTML 코드 가져오기

			 // HTML 코드에서 실제 텍스트만 추출 (공백/특수문자 제거)
			 var plainText = $("<div>").html(content).text().trim();  // 텍스트 추출 후 trim()
	
			 // 비어있는지 체크
			 if (plainText === '' || content === '<p><br></p>' || content === '&lt;p&gt;&lt;br&gt;&lt;/p&gt;') {
			     alert("내용은 필수입력입니다.");
			     return;
			 }
		
		    if ($form.length > 0) {
		        if (confirm("수정하시겠습니까?")) {
		            $form.attr("action", "faqmodify_process.jsp");
		            $form.submit();  // 사용자가 '예'를 누른 경우에만 제출
		        } else {
		            // 사용자가 취소를 누른 경우 아무 것도 하지 않음
		            return;
		        }
		    } else {
		        alert("폼을 찾을 수 없습니다!");
		    }
		}

        	
        </script>
        
        
		
		
		<script>
		  const faqData = {
		    title: "<%= safeTitle %>",
		    content: "<%= safeContent %>"
		  };
		</script>

        
        <script>
        document.addEventListener("DOMContentLoaded", function () {
        	  const titleInput = document.getElementById("title");
        	  if (titleInput) titleInput.value = faqData.title || "";

        	  let tryCount = 0;
        	  const maxTries = 20;

        	  const checkSummernoteReady = setInterval(() => {
        	    if ($('#summernote').summernote && $('#summernote').next().hasClass('note-editor')) {
        	      $('#summernote').summernote('code', faqData.content || '');
        	      clearInterval(checkSummernoteReady);
        	    }

        	    tryCount++;
        	    if (tryCount >= maxTries) clearInterval(checkSummernoteReady);
        	  }, 100);
        	});

		</script> 
        
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">고객센터 관리</h2>
            <hr/>
             <div class="card m-3">
  <div class="card-header">
    <h2>FAQ 수정</h2>
  </div>
  <div class="card-body">
    <div class="tab-content">
    </div>
    
    
   
    
     <%@ include file="summernoteExample.jsp" %>
    <button type="button" id="writeBtn" class="btn btn-primary mt-3" onclick="modifyProcess()">수정</button>
    <button type="button" class="btn btn-info mt-3" onclick="previewFaq()">미리보기</button>
    <button type="button" class="btn btn-secondary mt-3" onclick="viewSource()">소스보기(테스트용)</button>
    <button type="button" class="btn btn-secondary mt-3" onclick="moveToMain()">뒤로가기</button>
    
     
    
    
    
  </div>
</div>              
                            
                            
                               
                </div>
                
    

            
            

               </main>
        </div>
               
               <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/demo/chart-area-demo.js"></script>
<script src="${pageContext.request.contextPath}/assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/js/datatables-simple-demo.js"></script>
         --%>
        
        
