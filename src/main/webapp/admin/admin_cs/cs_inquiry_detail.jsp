<%@page import="kr.co.gungon.cs.InquiryDTO"%>
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
    
    InquiryDTO iDTO = css.searchOneInquiry(num);
    
    if(iDTO == null){
      response.sendRedirect(request.getContextPath() + "/errorpage/gungon_error.jsp");
   	  return;
    }
    
    pageContext.setAttribute("iDTO", iDTO);
    
 // notice_title에서 "를 &quot;로 치환
    
%>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
        <link href="cs_common/styles.css" rel="stylesheet">
        
        <style>
        
 /*        .form-select, .datatable-selector {
    display: block;
    width: 100%;
    padding: 0.375rem 2.25rem 0.375rem 0.75rem;
    -moz-padding-start: calc(0.75rem - 3px);
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    background-color: #fff;
    background-image: url(data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e);
    background-repeat: no-repeat;
    background-position: right 0.75rem center;
    background-size: 16px 12px;
    border: 1px solid #ced4da;
    border-radius: 0.375rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
}
         */
        
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
    <style>
  .inquiry-box {
    width: 1500px;
    margin: 20px auto;
    margin-top: 0px !important;
    height: 600px;
    /* border: 3px solid #353535; */
    border-radius: 12px;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .inquiry-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    font-weight: bold;
    font-size: 16px;
    border-bottom: 1px solid #333;
  }

  .inquiry-content {
    background-color: #bcbcbc;
    /* padding: 15px; */
    border-radius: 8px;
    min-height: 200px;
    max-height: 200px;
    overflow-y: auto;
    margin-bottom: 40px;
    white-space: pre-wrap;
  }

  .answer-area textarea {
    width: 100%;
    min-height: 200px;
    padding: 10px;
    resize: vertical;
    border-radius: 8px;
    border: 2px solid #606060;
    font-size: 14px;
    margin-bottom: 10px;
  }
  
  .inquiry-user{
  padding : 10px; 
  
  }
  
  .inquiry-status{
  padding : 10px;
  }

  /* .answer-area button {
    margin-top: 10px;
    padding: 8px 16px;
    font-size: 14px;
    border: none;
    background-color: #007BFF;
    color: white;
    border-radius: 6px;
    cursor: pointer;
  } */

  /* .answer-area button:hover {
    background-color: #0056b3;
  } */
</style>
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        
        <script type="text/javascript">
        // 메인 페이지로 이동
        function moveToMain() {
            window.location.href = "cs_inquiry_main.jsp";  
        }
        
        
        
        $(document).ready(function() {
            // checkAnswerValidation 함수 정의
            function checkAnswerValidation() {
              var answerContent = $('#answerText').val().trim();
              
              // 텍스트 영역이 비어있는지 체크
              if (answerContent === "") {
                alert("답변은 필수입력입니다.");
              } else {
                $('#answerFrm').submit(); 
              }
            }

            $('#saveBtn').click(function() {
              checkAnswerValidation();
            });
          });
        
        
        function moveToMain() {
            window.location.href = "cs_inquiry_main.jsp";  
        }
      
        

        </script>
		
		
		
<%@ include file="/admin/common/header.jsp" %>
<%@ include file="/admin/common/sidebar.jsp" %>

<div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h2 class="mt-4">고객센터 관리</h2>
            <hr/>

            <!-- 여기부터 콘텐츠 영역 -->
                 <div class="card m-3">
  <div class="card-header">
    <h2>1:1 문의관리</h2>
  </div>
  <div class="card-body">
    <div class="tab-content">
    </div>
    
    
   

<div class="inquiry-box">
  <div class="inquiry-header">
    <div class="inquiry-user">작성자ID: <span id="writerId">${ iDTO.member_id }</span></div>
    <div class="inquiry-status">처리상태: <span id="status" style="font-weight : bold; color: ${ iDTO.answer_status == true ? 'green' : 'red' }">${ iDTO.answer_status == true ? '답변완료' : '답변대기' }</span></div>
  </div>

  <label for="answerText"><strong>문의내용</strong></label>
  <div class="inquiry-content" id="inquiryContent">
    ${ iDTO.inquiry_content }
  </div>

  <div class="answer-area">
  <form action="inquirymodify_process.jsp" method="post" id="answerFrm">
    <label for="answerText"><strong>답변</strong></label>
    <textarea id="answerText" placeholder="답변을 입력하세요..." name="answer_content">${ iDTO.inquiry_answer }</textarea>
    <input type="hidden" name="num" value="${param.num}"/>
    <div style="margin-left: 600px;">
    <button type="button" id="saveBtn" class="btn btn-primary">답변 저장</button>
    <button type="button" id="cancleBtn" class="btn btn-secondary" onclick="moveToMain()">취소</button>
    </div>
  </form>
  </div>
</div>

    
    
  </div>
</div>              
                            
                
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="cs_common/simple-datatables.js"></script>
        <script src="cs_common/datatables-simple-demo.js"></script>
        </div>
    </main>
<%@ include file="/admin/common/footer.jsp" %>		
        
        

                        

    

