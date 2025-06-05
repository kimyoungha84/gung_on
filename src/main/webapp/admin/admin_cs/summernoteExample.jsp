<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Summernote 예제</title>

  <!-- Bootstrap + jQuery -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

  <!-- Summernote -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

  <style>
    .note-editor.note-frame {
      border: 1px solid #ccc;
    }
    #sourceCodeDiv {
      border: 1px solid #ccc;
      padding: 10px;
      margin-top: 20px;
      background-color: #f7f7f7;
      white-space: pre-wrap;
      word-wrap: break-word;
      font-family: monospace;
      font-size: 14px;
      line-height: 1.5;
      max-height: 400px;
      overflow-y: auto;
    }

    pre {
      background-color: #282c34;
      color: #f8f8f2;
      padding: 15px;
      border-radius: 5px;
      font-size: 14px;
      overflow-x: auto;
      white-space: pre-wrap;
      word-wrap: break-word;
    }
  </style>
</head>
<body class="p-4">

  
  <form method="post" id="summerNoteFrm">
    제목: <input type="text" name="title" id="title" placeholder="제목을 입력하세요" class="form-control mb-3"><br>

    내용:
    <textarea id="summernote" name="content"></textarea><br>
    <input type="hidden" name="num" value=${ param.num }>

   <!--  <button type="submit" id="writeBtn" class="btn btn-primary mt-3">작성</button>
    <button type="button" class="btn btn-info mt-3" onclick="previewNotice()">미리보기</button>
    <button type="button" class="btn btn-secondary mt-3" onclick="viewSource()">소스보기</button> -->
  </form>

  <!-- 소스보기 영역 -->
  <div id="sourceCodeDiv" style="display:none;">
    <h5>소스 코드:</h5>
    <pre id="sourceCodePre"></pre>
  </div>

  <script>
    $('#summernote').summernote({
      placeholder: '내용을 입력하세요...',
      height: 500,
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'underline', 'clear']],
        ['fontsize', ['fontsize']],  // 폰트 크기 선택 기능 추가
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['insert', ['link', 'picture']]
        /* ['view', ['fullscreen', 'codeview', 'help']] */
      ],
      fontsize: ['8', '10', '12', '14', '18', '24', '36'], // 폰트 크기 옵션 설정
      callbacks: {
        onImageUpload: function(files) {
          for (let i = 0; i < files.length; i++) {
            sendImage(files[i]);
          }
        }
      } 
    });

   function sendImage(file) {
	//이미지 파일을 업로드하고 이미지테이블 갱신
		alert("이미지업로드");
      const formData = new FormData();
      formData.append('upload', file);

      $.ajax({
        url: 'uploadImage.jsp',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(url) {
          $('#summernote').summernote('insertImage', url);
        },
        error: function() {
          alert('이미지 업로드 실패');
        }
      });
    } 

    // 미리보기 버튼 클릭 시 POST 요청으로 공지사항 미리보기 페이지로 이동
    function previewNotice() {
		  const title = $('input[name="title"]').val();
		  const content = $('#summernote').summernote('code');
		
		  // 팝업창 열기
		  const popup = window.open('', 'previewPopup', 'width=1200,height=800,scrollbars=yes');
		
		  // form 생성
		  const form = document.createElement('form');
		  form.method = 'POST';
		  form.action = 'notice_preview_popup.jsp'; // 팝업에서 렌더링할 JSP
		  form.target = 'previewPopup';
		
		  // 제목 hidden input
		  const titleInput = document.createElement('input');
		  titleInput.type = 'hidden';
		  titleInput.name = 'title';
		  titleInput.value = title;
		
		  // 내용 hidden input
		  const contentInput = document.createElement('input');
		  contentInput.type = 'hidden';
		  contentInput.name = 'content';
		  contentInput.value = content;
		
		  // form 구성 및 전송
		  form.appendChild(titleInput);
		  form.appendChild(contentInput);
		  document.body.appendChild(form);
		  form.submit();
		  document.body.removeChild(form); // cleanup
		}
    
    function previewFaq() {
		  const title = $('input[name="title"]').val();
		  const content = $('#summernote').summernote('code');
		
		  // 팝업창 열기
		  const popup = window.open('', 'previewPopup', 'width=1200,height=800,scrollbars=yes');
		
		  // form 생성
		  const form = document.createElement('form');
		  form.method = 'POST';
		  form.action = 'faq_preview_popup.jsp'; // 팝업에서 렌더링할 JSP
		  form.target = 'previewPopup';
		
		  // 제목 hidden input
		  const titleInput = document.createElement('input');
		  titleInput.type = 'hidden';
		  titleInput.name = 'title';
		  titleInput.value = title;
		
		  // 내용 hidden input
		  const contentInput = document.createElement('input');
		  contentInput.type = 'hidden';
		  contentInput.name = 'content';
		  contentInput.value = content;
		
		  // form 구성 및 전송
		  form.appendChild(titleInput);
		  form.appendChild(contentInput);
		  document.body.appendChild(form);
		  form.submit();
		  document.body.removeChild(form); // cleanup
		}
    
    
    
    
    // 소스보기 버튼 클릭 시 소스 코드 확인하여 div에 표시
    function viewSource() {
      const content = $('#summernote').summernote('code');
      const sourceCodeDiv = document.getElementById("sourceCodeDiv");
      const sourceCodePre = document.getElementById("sourceCodePre");

      // 소스보기 div를 보여주고 소스 코드 삽입
      sourceCodeDiv.style.display = "block";

      // HTML 태그를 실제로 화면에 보여주지 않고 소스코드로 출력
      const formattedContent = formatSourceCode(content);
      sourceCodePre.textContent = formattedContent; // 소스 코드를 textContent로 출력
    }

    // HTML 소스 코드에서 줄바꿈 및 공백을 보기 좋게 처리
    function formatSourceCode(content) {
      // HTML 태그를 화면에 출력할 수 있도록 변환
      let formatted = content.replace(/</g, '&lt;').replace(/>/g, '&gt;');
      
      // 줄바꿈 및 공백을 처리
      formatted = formatted.replace(/\n/g, '<br>').replace(/\r/g, '');
      formatted = formatted.replace(/ {2,}/g, '  '); // 여러 공백을 2개로 처리 (선택사항)
      
      // 개행을 <br>로 처리하여 소스 코드 안에서 보기 좋게 줄바꿈이 되도록 함
      return formatted;
    }
  </script>

</body>
</html>
