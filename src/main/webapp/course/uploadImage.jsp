<%@ page import="java.io.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.UUID"%> <%-- 파일명 중복 방지를 위해 사용 --%>
<%@page import="org.json.simple.JSONObject"%> <%-- JSON 응답을 위해 사용 --%>
<%@page import="java.sql.SQLException"%> 
<%-- 궁 이름 조회를 위해 필요한 Service/DAO 클래스 임포트 --%>
<%@page import="kr.co.gungon.course.CourseService"%> 


<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    response.setContentType("application/json; charset=UTF-8");
    JSONObject jsonResponse = new JSONObject(); // JSON 응답 객체

    int maxSize = 10 * 1024 * 1024; // 최대 업로드 크기: 10MB
    String encoding = "UTF-8";
    
    String baseUploadPathRelative = "/Gung_On/common/images/course"; 
    String baseUploadPathAbsolute = application.getRealPath(baseUploadPathRelative);

    String gungIdStr = null;
    String savedFileName = null;
    String originalFileName = null;

    
    File baseUploadDir = new File(baseUploadPathAbsolute);
    if (!baseUploadDir.exists()) {
        boolean success = baseUploadDir.mkdirs();
        if (success) {
            System.out.println(">>> DEBUG uploadImage.jsp: Base directory created successfully: " + baseUploadPathAbsolute);
        } else {
             System.err.println(">>> ERROR uploadImage.jsp: Failed to create base directory: " + baseUploadPathAbsolute);
             jsonResponse.put("status", "error");
             jsonResponse.put("message", "기본 이미지 저장 폴더 생성에 실패했습니다.");
             response.getWriter().write(jsonResponse.toJSONString());
             return;
        }
    }


    try {
        MultipartRequest multi = new MultipartRequest(
            request,
            baseUploadPathAbsolute,
            maxSize,
            encoding,
            new DefaultFileRenamePolicy() // 같은 이름이 있으면 자동으로 변경
        );

        gungIdStr = multi.getParameter("gungId");
        originalFileName = multi.getOriginalFileName("upload"); // 업로드된 원본 파일명 (MultipartRequest 생성 후)
        savedFileName = multi.getFilesystemName("upload"); // COS가 저장한 파일명 (MultipartRequest 생성 후)
        
        System.out.println(">>> DEBUG uploadImage.jsp: Received gungIdStr = " + gungIdStr);
        System.out.println(">>> DEBUG uploadImage.jsp: Uploaded originalFileName = " + originalFileName);
        System.out.println(">>> DEBUG uploadImage.jsp: SavedFileName by COS = " + savedFileName);


        if (savedFileName == null || originalFileName == null || savedFileName.isEmpty()) {
             jsonResponse.put("status", "error");
             jsonResponse.put("message", "업로드된 파일이 없거나 파일 업로드에 실패했습니다.");
             response.getWriter().write(jsonResponse.toJSONString());
             return;
        }

        if (gungIdStr == null || gungIdStr.isEmpty()) {
             jsonResponse.put("status", "error");
             jsonResponse.put("message", "궁 ID가 누락되었습니다.");
             File tempFileToDelete = new File(baseUploadPathAbsolute, savedFileName);
              if (tempFileToDelete.exists()) {
                  tempFileToDelete.delete();
                  System.out.println(">>> DEBUG uploadImage.jsp: Deleted uploaded file due to missing gungId: " + tempFileToDelete.getAbsolutePath());
              }
             response.getWriter().write(jsonResponse.toJSONString());
             return;
        }

        int gungId = -1;
         try {
            gungId = Integer.parseInt(gungIdStr);
         } catch (NumberFormatException e) {
             jsonResponse.put("status", "error");
             jsonResponse.put("message", "유효하지 않은 궁 ID 형식입니다.");
              // 유효하지 않은 궁 ID 형식 시 COS가 저장한 파일을 삭제
             File tempFileToDelete = new File(baseUploadPathAbsolute, savedFileName);
              if (tempFileToDelete.exists()) {
                  tempFileToDelete.delete();
                  System.out.println(">>> DEBUG uploadImage.jsp: Deleted uploaded file due to invalid gungId format: " + tempFileToDelete.getAbsolutePath());
              }
             response.getWriter().write(jsonResponse.toJSONString());
             return;
         }

        String gungInitialFolder = null; 
        String gungName = null; 
        
        // --- CourseService의 getGungNameById 메소드 호출 ---
        // DB 조회로 이니셜을 가져오는 것이 요청이므로, 해당 메소드가 있다고 가정하고 호출합니다.
        CourseService courseService = new CourseService(); // CourseService 인스턴스 생성
        try {
             // CourseService에 궁 ID로 궁 이름(String)을 조회하는 메소드가 있다고 가정합니다.
             // 예시: public String getGungNameById(int gungId) { ... DAO 호출 ... }
             // 이 메소드는 궁 ID에 해당하는 궁 이름 문자열 또는 null을 반환해야 합니다.
             gungName = courseService.getGungNameById(gungId); 
             
             if (gungName == null || gungName.isEmpty()) {
                 // DB 조회 결과가 없다면 기본값 또는 오류 처리
                 gungInitialFolder = "other"; // 예: 기본 폴더명
                  System.out.println(">>> WARNING uploadImage.jsp: Could not find gung name for id " + gungId + " in DB. Using 'other' folder.");
             } else {
                 // *** 궁 이름에 따라 원하는 폴더명 (이니셜) 결정 ***
                 // 이 부분을 실제 궁 이름과 원하는 폴더명 매핑 로직으로 구현해야 합니다.
                 // 예시: 궁 이름 "경복궁" -> 폴더명 "gbg", "창덕궁" -> "cdg" 등
                 switch (gungName) {
                     case "경복궁": gungInitialFolder = "gbg"; break;
                     case "창덕궁": gungInitialFolder = "cdg"; break;
                     case "덕수궁": gungInitialFolder = "dsg"; break;
                     case "창경궁": gungInitialFolder = "cgg"; break;
                     case "경희궁": gungInitialFolder = "ghg"; break;
                     default:
                         gungInitialFolder = "other"; // 정의되지 않은 궁 이름은 'other' 폴더에 저장
                         System.out.println(">>> WARNING uploadImage.jsp: Unknown gungName '" + gungName + "' for id " + gungId + ". Saving to 'other' folder.");
                         break;
                 }
                 System.out.println(">>> DEBUG uploadImage.jsp: Found gung name '" + gungName + "' for id " + gungId + ". Using folder '" + gungInitialFolder + "'.");
             }

        } catch (Exception e) { // SQLException 등 DB 관련 예외도 포함
             System.err.println(">>> ERROR uploadImage.jsp: Exception occurred while getting gung name from Service for id " + gungId + ". Using 'other'.");
             e.printStackTrace();
             gungInitialFolder = "other"; // DB 조회 중 오류 발생 시 기본 폴더명 사용
        }
        // --- 궁 이름으로 폴더명 결정 로직 끝 ---
        
        // 이미지를 이동시킬 최종 서버 파일 시스템 상의 디렉토리 경로
        String finalUploadDirectoryAbsolute = application.getRealPath(baseUploadPathRelative) + File.separator + gungInitialFolder;
        // 웹에서 접근 가능한 최종 상대 경로
        String finalUploadDirectoryRelative = baseUploadPathRelative + "/" + gungInitialFolder; // 웹 접근 경로 (슬래시 사용)

        // *** 최종 디렉토리 생성 로직 (파일 이동 전에 수행) ***
        File finalUploadDir = new File(finalUploadDirectoryAbsolute);

        // 지정된 디렉토리가 존재하지 않으면 모든 상위 디렉토리까지 생성
        if (!finalUploadDir.exists()) {
            boolean success = finalUploadDir.mkdirs(); // 디렉토리 생성 시도
            if (success) {
                System.out.println(">>> DEBUG uploadImage.jsp: Final directory created successfully: " + finalUploadDirectoryAbsolute);
            } else {
                System.err.println(">>> ERROR uploadImage.jsp: Failed to create final directory: " + finalUploadDirectoryAbsolute);
                // 최종 디렉토리 생성 실패 시 COS가 저장한 파일을 삭제
                File tempFile = new File(baseUploadPathAbsolute, savedFileName);
                if (tempFile.exists()) {
                    tempFile.delete();
                     System.out.println(">>> DEBUG uploadImage.jsp: Deleted uploaded file after final directory creation failure: " + tempFile.getAbsolutePath());
                 }
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "이미지 최종 저장 폴더 생성에 실패했습니다.");
                response.getWriter().write(jsonResponse.toJSONString());
                return; // 처리 중단
            }
        }
        
        // COS가 기본 경로에 저장한 파일
        File sourceFile = new File(baseUploadPathAbsolute, savedFileName);
        // 파일을 이동시킬 최종 경로
        File destFile = new File(finalUploadDirectoryAbsolute, savedFileName);

        // 파일 이동
        if (sourceFile.exists()) {
             // java.nio.file.Files.move 사용 또는 File.renameTo 사용
             // renameTo는 같은 파일 시스템 내에서만 동작할 가능성 있음, 다른 파일 시스템 간 이동은 copy 후 delete 필요
             // 여기서는 간단히 renameTo 시도
             boolean moved = sourceFile.renameTo(destFile); // 파일 이름 변경하여 이동 시도
             if (moved) {
                 System.out.println(">>> DEBUG uploadImage.jsp: File moved to final location: " + destFile.getAbsolutePath());
             } else {
                 System.err.println(">>> ERROR uploadImage.jsp: Failed to move file from " + sourceFile.getAbsolutePath() + " to " + destFile.getAbsolutePath());
                 // 파일 이동 실패 시 오류 응답
                 jsonResponse.put("status", "error");
                 jsonResponse.put("message", "업로드된 파일 이동에 실패했습니다.");
                 // 이동 실패 시 원본 파일 삭제 로직 필요
                 if (sourceFile.exists()) {
                    sourceFile.delete();
                     System.out.println(">>> DEBUG uploadImage.jsp: Deleted source file after move failure: " + sourceFile.getAbsolutePath());
                 }
                 response.getWriter().write(jsonResponse.toJSONString());
                 return; // 처리 중단
             }
        } else {
             System.err.println(">>> ERROR uploadImage.jsp: Source file not found after COS upload: " + sourceFile.getAbsolutePath());
              jsonResponse.put("status", "error");
              jsonResponse.put("message", "업로드된 파일을 찾을 수 없습니다.");
              response.getWriter().write(jsonResponse.toJSONString());
              return; // 처리 중단
        }


        // 클라이언트에 응답할 웹 접근 가능한 파일 URL 및 정보 구성
        // 최종 저장 경로 기준의 URL 및 상대 경로
        String fileUrl = request.getContextPath() + finalUploadDirectoryRelative + "/" + savedFileName; // 웹 URL (최종 경로)
        String relativePath = finalUploadDirectoryRelative + "/" + savedFileName; // 웹 접근 가능한 상대 경로 (최종 경로)

        System.out.println(">>> DEBUG uploadImage.jsp: Final file URL = " + fileUrl);
        System.out.println(">>> DEBUG uploadImage.jsp: Final relative path = " + relativePath);
        System.out.println(">>> DEBUG uploadImage.jsp: Saved file name = " + savedFileName);


        // 성공 응답
        jsonResponse.put("status", "success");
        jsonResponse.put("message", "이미지 업로드 및 이동 성공");
        // originalFileName은 MultipartRequest 생성 시 얻어야 합니다.
        // savedFileName은 DefaultFileRenamePolicy에 의해 변경된 이름입니다.
        jsonResponse.put("originalFileName", originalFileName); // 원본 파일명 
        jsonResponse.put("savedFileName", savedFileName); // 서버에 저장된 파일명 (DB 저장 시 사용)
        jsonResponse.put("url", fileUrl); // 웹에서 접근 가능한 URL (Summernote 삽입 시 사용)
        jsonResponse.put("relativePath", relativePath); // 웹에서 접근 가능한 상대 경로 (DB 저장 시 사용)
        // targetType, targetNumber는 코스 등록 process 페이지에서 DB 삽입 시 설정
        // 여기서는 반환하지 않음.

    } catch (Exception e) { // MultipartException, IOException 등 모든 하위 예외 처리
        // COS Multipart 요청 파싱 중 예외 (MultipartException), 파일 처리 중 예외 (IOException), 
        // Service/DAO 호출 중 예외 (SQLException 등) 등 모든 예상치 못한 예외 처리
        System.err.println(">>> ERROR uploadImage.jsp: Exception occurred during file upload processing!");
        e.printStackTrace();
        
        // 예외 종류에 따라 좀 더 상세한 메시지를 반환할 수 있지만, 여기서는 일반 오류로 처리
        String errorMessage = "서버 오류 발생.";
        /*
        if (e instanceof com.oreilly.servlet.multipart.MultipartException) {
             errorMessage = "파일 업로드 용량이 초과되었습니다.";
             // MultipartException 발생 시 파일이 이미 임시 경로에 저장될 수 있으므로 삭제 로직 필요
             // getFilesystemName("upload")는 MultipartException 발생 후에는 null일 수 있음.
             // 복잡한 처리 필요 시 COS 라이브러리 문서 참고
        } else if (e instanceof IOException) {
             errorMessage = "파일 처리 중 오류 발생.";
        } // 다른 예외 종류에 따른 메시지 추가 가능
        */

        jsonResponse.put("status", "error");
        jsonResponse.put("message", errorMessage);

        // 오류 발생 시 COS가 기본 경로에 저장한 파일 삭제 시도
        // 이 로직은 try 블록 외부에서 multi 객체 생성 후 발생한 예외에 대해 동작
        // MultipartException 발생 시 multi 객체 생성 자체에 실패할 수 있으므로 완전한 처리는 어려움
        File tempFileToDelete = new File(baseUploadPathAbsolute, savedFileName); // savedFileName은 try 블록 시작에서 null
         if (savedFileName != null && tempFileToDelete.exists()) { // savedFileName이 null이 아니고 파일이 존재하면 삭제
             boolean deleted = tempFileToDelete.delete();
             if(deleted) {
                 System.out.println(">>> DEBUG uploadImage.jsp: Deleted uploaded file after exception: " + tempFileToDelete.getAbsolutePath());
             } else {
                  System.err.println(">>> WARNING uploadImage.jsp: Failed to delete uploaded file after exception: " + tempFileToDelete.getAbsolutePath());
             }
         }
         
    } // end catch (Exception e)

    // 최종 JSON 응답 전송
    response.getWriter().write(jsonResponse.toJSONString());
%>
