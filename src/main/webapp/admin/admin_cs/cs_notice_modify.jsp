<%@page import="kr.co.gungon.cs.NoticeDTO"%>
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
    
    NoticeDTO nDTO = css.searchOneNotice(num);
    if(nDTO == null){
    	response.sendRedirect(request.getContextPath() + "/errorpage/gungon_error.jsp");
   	    return;
    	
    }
    pageContext.setAttribute("nDTO", nDTO);
    
 // notice_title에서 "를 &quot;로 치환
    
	  String safeTitle = nDTO.getNotice_title().replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
	  String safeContent = nDTO.getNotice_content().replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
%>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
        <link href="cs_common/styles.css" rel="stylesheet">
        
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
            window.location.href = "cs_notice_main.jsp";  
        }

        // 특정 조건에 따라 action을 변경하는 함수
        function modifyProcess() {
		    var $form = $("#summerNoteFrm"); 
		    
		    var title = $("#title").val().trim();

		    // 제목이 비었거나 공백만 있으면
		    if (title === "") {
		        alert("제목은 필수입력입니다.");
		        return; 
		    }

		    var content = $("#summernote").summernote('code').trim(); 

			 var plainText = $("<div>").html(content).text().trim();  
	
			 // 비어있는지 체크
			 if (plainText === '' || content === '<p><br></p>' || content === '&lt;p&gt;&lt;br&gt;&lt;/p&gt;') {
			     alert("내용은 필수입력입니다.");
			     return;
			 }
		
		    if ($form.length > 0) {
		        if (confirm("수정하시겠습니까?")) {
		            $form.attr("action", "noticemodify_process.jsp");
		            $form.submit();  // 사용자가 '예'를 누른 경우에만 제출
		        } else {
		            return;
		        }
		    } else {
		        alert("폼을 찾을 수 없습니다!");
		    }
		}
        	
        </script>
        
        
		
		
		<script>
		  const noticeData = {
		    title: "<%= safeTitle %>",
		    content: "<%= safeContent %>"
		  };
		</script>

        
        <script>
        document.addEventListener("DOMContentLoaded", function () {
        	  const titleInput = document.getElementById("title");
        	  if (titleInput) titleInput.value = noticeData.title || "";

        	  let tryCount = 0;
        	  const maxTries = 20;

        	  const checkSummernoteReady = setInterval(() => {
        	    if ($('#summernote').summernote && $('#summernote').next().hasClass('note-editor')) {
        	      $('#summernote').summernote('code', noticeData.content || '');
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
            <h2 class="mt-4">관리자 대시보드</h2>
            <hr/>

            <!-- 여기부터 콘텐츠 영역 -->
                                 
     <div class="card m-3">
  <div class="card-header">
    <h2>공지사항 수정</h2>
  </div>
  <div class="card-body">
    <div class="tab-content">
    </div>
    
    
   
    
     <%@ include file="summernoteExample.jsp" %>
     
    <button type="button" id="writeBtn" class="btn btn-primary" onclick="modifyProcess()">수정</button>
    <button type="button" class="btn btn-info" onclick="previewNotice()">미리보기</button>
    <button type="button" class="btn btn-secondary" onclick="moveToMain()">뒤로가기</button>
    
     
    
    
    
  </div>
</div>              
                            
                            
                               
                </div>
               </main>
                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="cs_common/simple-datatables.js"></script>
        <script src="cs_common/datatables-simple-demo.js"></script>
    
        
        
        
        
    
    
    
    
    
    

                        

