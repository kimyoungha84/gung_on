package kr.co.gungon.course;

import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList; // 디버깅용 ArrayList 임포트

import kr.co.gungon.file.FilePathDTO;
import kr.co.gungon.gung.GungDTO;
// import kr.co.gungon.gung.GungDAO; // GungDAO 필요시 임포트

public class CourseService {

	public List<GungDTO> getAllGungs() {
		List<GungDTO> list= null; 
		CourseDAO cDAO= CourseDAO.getInstance();
			
		try {
			list=cDAO.selectAllGung();
		} catch (SQLException e) {
			e.printStackTrace();
            System.err.println(">>> ERROR Service: SQLException in getAllGungs");
		}//end catch
		return list;
    }//getAllGungs
	
	public List<CourseDTO> getCoursesByGungId(int gung_Id) {
		List<CourseDTO> list=null;
		CourseDAO cDAO= CourseDAO.getInstance();
		
		try {
			list=cDAO.selectCoursesByGungId(gung_Id);
		} catch (SQLException e) {
			e.printStackTrace();
            System.err.println(">>> ERROR Service: SQLException in getCoursesByGungId for gungId=" + gung_Id);
		}//end catch
		return list;
    }//getCoursesByGungId
	
	public CourseDTO getCourseDetail(int course_Num) {
		CourseDTO cDTO=null;
		CourseDAO cDAO= CourseDAO.getInstance();
		
         try {
			cDTO=cDAO.selectCourseByCourseNum(course_Num);
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException in getCourseDetail for courseNum=" + course_Num);
		}//end catch
         return cDTO;
    }//getCourseDetail
	
	public boolean addCourse(CourseDTO course, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
        if (member_Id == null || member_Id.isEmpty()) {
             System.out.println(">>> DEBUG Service: addCourse failed - memberId is null or empty.");
            return flag;
        }//end if
        course.setMember_Id(member_Id);

        if (course.getCourse_Title() == null || course.getCourse_Title().trim().isEmpty() ||
            course.getCourse_Content() == null || course.getCourse_Content().trim().isEmpty()) {
             System.out.println(">>> DEBUG Service: addCourse failed - title or content is empty.");
            return flag;
        }//end if

		try {
            System.out.println(">>> DEBUG Service: Calling CourseDAO.insertCourse...");
			int result = cDAO.insertCourse(course);
            System.out.println(">>> DEBUG Service: CourseDAO.insertCourse result = " + result);
			flag=result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
            System.err.println(">>> ERROR Service: SQLException in addCourse");
		}//end catch
        return flag;
    }//addCourse
	
	public boolean modifyCourse(CourseDTO course, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
        if (member_Id == null || member_Id.isEmpty()) {
             System.out.println(">>> DEBUG Service: modifyCourse failed - memberId is null or empty.");
            return flag;
        }//end if

        CourseDTO cDTO=null;
		try {
             System.out.println(">>> DEBUG Service: Checking course ownership for courseNum=" + course.getCourse_Num() + ", memberId=" + member_Id);
			cDTO = cDAO.selectCourseByCourseNum(course.getCourse_Num());
			if (cDTO == null) {
                 System.out.println(">>> DEBUG Service: modifyCourse failed - course not found.");
	            return flag; 
	        }
             if (!cDTO.getMember_Id().equals(member_Id)) {
                 System.out.println(">>> DEBUG Service: modifyCourse failed - memberId mismatch. Course owner=" + cDTO.getMember_Id());
                 return flag;
             }
              System.out.println(">>> DEBUG Service: Course ownership confirmed.");

		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException checking course ownership in modifyCourse");
             return flag; // 예외 발생 시 실패 처리
		}//end catch

        course.setMember_Id(member_Id); // member_Id 다시 설정 (혹시 모르니)

        if (course.getCourse_Title() == null || course.getCourse_Title().trim().isEmpty() ||
            course.getCourse_Content() == null || course.getCourse_Content().trim().isEmpty()) {
             System.out.println(">>> DEBUG Service: modifyCourse failed - title or content is empty.");
            return flag; 
        }//end if

        int result;
		try {
            System.out.println(">>> DEBUG Service: Calling CourseDAO.updateCourse for courseNum=" + course.getCourse_Num());
			result = cDAO.updateCourse(course);
            System.out.println(">>> DEBUG Service: CourseDAO.updateCourse result = " + result);
			flag = result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
            System.err.println(">>> ERROR Service: SQLException in updateCourse");
            flag = false; // 예외 발생 시 실패 처리
		}//end catch
        
        return flag; 
   }//modifyCourse

	 public boolean removeCourse(int courseNum, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
         if (member_Id == null || member_Id.isEmpty()) {
             System.out.println(">>> DEBUG Service: removeCourse failed - memberId is null or empty.");
             return flag;
         }//end if

         CourseDTO cDTO = null;
         try {
             System.out.println(">>> DEBUG Service: Checking course ownership for removal for courseNum=" + courseNum + ", memberId=" + member_Id);
			cDTO=cDAO.selectCourseByCourseNum(courseNum);
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException checking course ownership for removal");
             return flag; // 예외 발생 시 실패 처리
		}//end catch
         if (cDTO == null) {
             System.out.println(">>> DEBUG Service: removeCourse failed - course not found for removal.");
             return flag; 
         }
         if (!cDTO.getMember_Id().equals(member_Id)) {
             System.out.println(">>> DEBUG Service: removeCourse failed - memberId mismatch for removal. Course owner=" + cDTO.getMember_Id());
             return flag;
         }
          System.out.println(">>> DEBUG Service: Course ownership confirmed for removal.");


         int result;
		try {
            System.out.println(">>> DEBUG Service: Calling CourseDAO.deleteCourse for courseNum=" + courseNum);
			result = cDAO.deleteCourse(courseNum);
            System.out.println(">>> DEBUG Service: CourseDAO.deleteCourse result = " + result);
			flag=result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException in deleteCourse");
             flag = false; // 예외 발생 시 실패 처리
		}//end catch
         return flag;
    }//removeCourse
	 
	 public List<CourseDTO> getUserCourses(String member_Id) {
		 List<CourseDTO> list=null;
		 CourseDAO cDAO= CourseDAO.getInstance();
		 
	         if (member_Id == null || member_Id.isEmpty()) {
                 System.out.println(">>> DEBUG Service: getUserCourses failed - memberId is null or empty.");
	             return null;
	         }//end if
	         try {
                 System.out.println(">>> DEBUG Service: Calling CourseDAO.selectCoursesByMemberId for memberId=" + member_Id);
				list=cDAO.selectCoursesByMemberId(member_Id);
                System.out.println(">>> DEBUG Service: CourseDAO.selectCoursesByMemberId result size = " + (list != null ? list.size() : "null"));
			} catch (SQLException e) {
				e.printStackTrace();
                 System.err.println(">>> ERROR Service: SQLException in selectCoursesByMemberId");
			}//end catch
	         
	        return list; 
	    }//getUserCourses
	 
	 public boolean addCourseRating(int course_Num, double rating) { 
			CourseDAO cDAO= CourseDAO.getInstance();
			boolean flag=false; // 최종 성공 여부

	        // *** 메소드 시작 및 인수 디버깅 출력 ***
	        System.out.println(">>> DEBUG Service: Entering addCourseRating for courseNum=" + course_Num + ", rating=" + rating);


	         // 0.5 ~ 5.0 범위 및 0.5 단위 유효성 검사
	         if (rating < 0.5 || rating > 5.0 || rating * 2 % 1 != 0) { 
	             System.out.println(">>> DEBUG Service: addCourseRating failed - Invalid rating value: " + rating);
	             return flag; // 유효성 검사 실패 시 false 반환
	         }//end if


	        // --- 1. 현재 코스의 별점 정보 조회 ---
	        CourseDTO currentRatingInfo = null;
	        try {
	            System.out.println(">>> DEBUG Service: Calling CourseDAO.selectCourseRatingInfo for courseNum=" + course_Num);
	            currentRatingInfo = cDAO.selectCourseRatingInfo(course_Num);
	            System.out.println(">>> DEBUG Service: CourseDAO.selectCourseRatingInfo result = " + (currentRatingInfo != null ? "Found" : "Not Found"));

	        } catch (SQLException e) {
	             e.printStackTrace();
	             System.err.println(">>> ERROR Service: SQLException occurred while getting current rating info for courseNum=" + course_Num);
	             return false; // 조회 중 예외 발생 시 실패 처리
	        }

	        // 코스 정보가 없으면 별점 등록 불가
	        if (currentRatingInfo == null) {
	             System.err.println(">>> ERROR Service: addCourseRating failed - Course not found for rating update: " + course_Num);
	             return false; 
	        }

	        // --- 2. 새로운 평균 별점 및 참여자 수 계산 ---
	        double currentAverageRating = currentRatingInfo.getCourse_Rating();
	        int currentRatingCount = currentRatingInfo.getCourse_Rating_Cnt();

	        double newTotalRating = (currentAverageRating * currentRatingCount) + rating; // 현재 총점 + 새로 등록할 별점
	        int newRatingCount = currentRatingCount + 1; // 참여자 수 1 증가
	        double newAverageRating = newTotalRating / newRatingCount; // 새로운 평균 별점 계산

	        // 계산 결과 디버깅 출력
	        System.out.println(">>> DEBUG Service: Calculated new rating info - currentAvg=" + currentAverageRating + ", currentCount=" + currentRatingCount + ", newRating=" + rating + ", newTotal=" + newTotalRating + ", newCount=" + newRatingCount + ", newAvg=" + newAverageRating);


	        // --- 3. CourseDAO.updateCourseRating 호출 (계산된 값 전달) ---
			try {
	            System.out.println(">>> DEBUG Service: Calling CourseDAO.updateCourseRating with calculated values...");
	            System.out.println(">>> DEBUG Service: Args - courseNum=" + course_Num + ", newAverageRating=" + newAverageRating + ", newRatingCnt=" + newRatingCount);

				// DAO의 updateCourseRating 메소드는 인자 3개를 받습니다.
				int result = cDAO.updateCourseRating(course_Num, newAverageRating); 
	            System.out.println(">>> DEBUG Service: CourseDAO.updateCourseRating result = " + result);

				flag=result > 0; // 업데이트된 행 수가 0보다 크면 성공

			} catch (SQLException e) {
				e.printStackTrace();
	            System.err.println(">>> ERROR Service: SQLException occurred during CourseDAO.updateCourseRating!");
	            flag = false; // 예외 발생 시 실패 처리
			}//end catch

	        // *** 최종 결과 반환 전 디버깅 출력 ***
	        System.out.println(">>> DEBUG Service: Exiting addCourseRating with final flag = " + flag);

	         return flag; // 최종 결과 반환
	     }//addCourseRating


	 // 특정 코스의 이미지 파일 목록을 조회하는 메소드 (users_course, detail_course에서 호출)
	 public List<FilePathDTO> getCourseImages(int course_Num) {
		 CourseDAO cDAO= CourseDAO.getInstance();
		 List<FilePathDTO> list=null;
	     
		 try {
             System.out.println(">>> DEBUG Service: Calling CourseDAO.selectFilePathsByTarget for courseNum=" + course_Num);
			list=cDAO.selectFilePathsByTarget("course", String.valueOf(course_Num)); // 'course' 타입 사용
             System.out.println(">>> DEBUG Service: CourseDAO.selectFilePathsByTarget result size = " + (list != null ? list.size() : "null"));
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException in getCourseImages");
		}//end catch
         return list; // 조회 결과 반환
	    }//getCourseImages
	 
	 // 특정 코스의 모든 이미지 파일 정보를 DB에서 삭제하는 메소드
	 // 코스 삭제 시 호출 예상
	 public boolean removeAllCourseImages(int courseNum) {
		 CourseDAO cDAO= CourseDAO.getInstance();
		 boolean flag=false;
		 
         try {
            System.out.println(">>> DEBUG Service: Calling CourseDAO.deleteFilePathsByTarget for courseNum=" + courseNum);
			int result = cDAO.deleteFilePathsByTarget("course", String.valueOf(courseNum)) ; // 'course' 타입 사용
            System.out.println(">>> DEBUG Service: CourseDAO.deleteFilePathsByTarget result = " + result);
			flag = result > 0; // 삭제된 행 수가 0보다 크면 성공으로 간주
             // 삭제된 행 수가 0이어도 오류는 아니므로, 삭제 대상이 없었을 수도 있음.
             // 이 로직은 삭제 성공 여부를 정확히 반영하는지 검토 필요. 최소 1개 이상 삭제 시 성공?
             // 여기서는 result > 0으로 flag 설정하는 기존 로직 유지.
             if (result >= 0) flag = true; // 0개 이상 삭제 시 성공 (삭제 대상 없었을 경우 포함)
             // 또는 삭제하려는 대상이 DB에 있는지 먼저 확인 후 삭제 시도하는 로직 추가 가능
             // List<FilePathDTO> filesToDelete = cDAO.selectFilePathsByTarget("course", String.valueOf(courseNum));
             // if (filesToDelete != null && !filesToDelete.isEmpty()) { ... 삭제 시도 ... }
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException in removeAllCourseImages");
             flag = false; // 예외 발생 시 실패 처리
		}//end catch
    
         return flag;
	 }//removeAllCourseImages
	
    // 이미지 파일 정보를 포함한 코스 등록 메소드 (process 페이지에서 호출)
	 public boolean addCourseWithImages(CourseDTO course, List<FilePathDTO> uploadedFileList, String member_Id) {
		    CourseDAO cDAO = CourseDAO.getInstance();
		    boolean flag = false; // 최종 성공 여부를 반환할 변수 (기본값 false)

            // *** 메소드 시작 및 인수 디버깅 출력 ***
            System.out.println(">>> DEBUG Service: Entering addCourseWithImages...");
            System.out.println(">>> DEBUG Service: Args - course title=" + (course != null ? course.getCourse_Title() : "null") + ", uploadedFileList size=" + (uploadedFileList != null ? uploadedFileList.size() : "null") + ", memberId=" + member_Id);


		    int courseNum = 0; // 새로 삽입된 코스 번호 저장 변수
		    try {
                // --- 1. 코스 정보 삽입 ---
                System.out.println(">>> DEBUG Service: Calling CourseDAO.insertCourse...");
		        courseNum = cDAO.insertCourse(course); 
                System.out.println(">>> DEBUG Service: CourseDAO.insertCourse result (new courseNum) = " + courseNum);


		        if (courseNum <= 0) { 
                     System.err.println(">>> ERROR Service: addCourseWithImages failed - CourseDAO.insertCourse returned <= 0.");
		             return false; // 코스 등록 실패 시 즉시 false 반환
		        }

                // 코스 삽입 성공 시에만 파일 정보 처리
                // --- 2. 파일 정보 DB 삽입 ---
		        boolean allFilesAddedSuccessfully = true; // 모든 파일이 성공적으로 DB에 추가되었는지 여부 추적

                System.out.println(">>> DEBUG Service: Checking uploadedFileList...");
		        if (uploadedFileList != null && !uploadedFileList.isEmpty()) { 
                    System.out.println(">>> DEBUG Service: uploadedFileList size = " + uploadedFileList.size());

		            for (FilePathDTO file : uploadedFileList) {
                        // FilePathDTO에 targetType과 targetNumber(코스 번호) 설정
		               	file.setTargerType("course"); // 대상 타입 설정
		                file.setTargerNumber(String.valueOf(courseNum)); // 새로 삽입된 코스 번호 사용 (String으로 변환)

                        // *** DAO 호출 전 FilePathDTO 값 디버깅 출력 ***
                         System.out.println(">>> DEBUG Service: Preparing to insert FilePathDTO - path=" + file.getPath() + ", imgName=" + file.getImgName() + ", targetType=" + file.getTargerType() + ", targetNumber=" + file.getTargerNumber());

                        // CourseDAO.insertFilePath 메소드 호출
                        System.out.println(">>> DEBUG Service: Calling CourseDAO.insertFilePath...");
		                int fileInsertResult = cDAO.insertFilePath(file);
                        System.out.println(">>> DEBUG Service: CourseDAO.insertFilePath result = " + fileInsertResult);

		                if (fileInsertResult <= 0) {
		                    System.err.println(">>> ERROR Service: addCourseWithImages failed - File info DB insertion failed for file: " + file.getImgName() + ", executeUpdate result <= 0.");
		                    allFilesAddedSuccessfully = false; // 하나라도 실패하면 전체 파일 삽입은 실패
		                    // TODO: 파일 DB 삽입 실패 시, 이미 DB에 삽입된 다른 파일 정보 및 코스 정보를 롤백하는 로직 필요 (트랜잭션 관리)
		                 }
		            }
                    // 파일 목록이 있었고, 모든 파일 정보 삽입이 성공했으면 최종 flag는 true
                    // 하나라도 실패했으면 allFilesAddedSuccessfully가 false이므로 flag는 false
		             flag = allFilesAddedSuccessfully;

		        } else {
		            // 이미지 첨부 안 한 경우 (uploadedFileList가 null 또는 empty)
		            // 코스 삽입은 이미 성공했으므로, 파일 처리 단계에 문제가 없다고 간주하고 최종 결과는 true
                    System.out.println(">>> DEBUG Service: No uploaded images to process.");
		            flag = true; 
		        }

                // TODO: 트랜잭션 커밋 로직 추가 (자동 커밋이 아니라면) - 예: conn.commit();

			} catch (SQLException e) {
				e.printStackTrace();
                System.err.println(">>> ERROR Service: SQLException occurred during addCourseWithImages!");
                // TODO: 예외 발생 시 롤백 로직 (DB 트랜잭션 및 서버에 저장된 파일 삭제)
				flag = false; // 예외 발생 시 실패 처리
			} catch (Exception e) {
		        e.printStackTrace();
                 System.err.println(">>> ERROR Service: Unexpected Exception occurred during addCourseWithImages!");
                 // TODO: 예외 발생 시 롤백 로직 (DB 트랜잭션 및 서버에 저장된 파일 삭제)
		        flag = false; // 예외 발생 시 실패 처리
		    }

            // *** 최종 결과 반환 전 디버깅 출력 ***
            System.out.println(">>> DEBUG Service: Exiting addCourseWithImages with final flag = " + flag);

		    return flag; // 최종 결과 반환
		} 
	 
	 // 이미지 파일 수정 및 삭제를 포함한 코스 수정 메소드
	 public boolean modifyCourseWithImages(CourseDTO course, List<FilePathDTO> newUploadedFileList, List<Integer> deletedFileIds, String memberId) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false; // 최종 성공 여부 반환 (기본값 false)

        // *** 메소드 시작 및 인수 디버깅 출력 ***
        System.out.println(">>> DEBUG Service: Entering modifyCourseWithImages...");
        System.out.println(">>> DEBUG Service: Args - courseNum=" + (course != null ? course.getCourse_Num() : "null") + ", newUploadedFileList size=" + (newUploadedFileList != null ? newUploadedFileList.size() : "null") + ", deletedFileIds size=" + (deletedFileIds != null ? deletedFileIds.size() : "null") + ", memberId=" + memberId);


		boolean courseUpdateSuccess=false;
		try {
            // --- 1. 코스 정보 수정 ---
            System.out.println(">>> DEBUG Service: Calling CourseDAO.updateCourse for courseNum=" + (course != null ? course.getCourse_Num() : "null"));
			courseUpdateSuccess = cDAO.updateCourse(course) > 0;
            System.out.println(">>> DEBUG Service: CourseDAO.updateCourse result = " + courseUpdateSuccess);
		} catch (SQLException e) {
			e.printStackTrace();
             System.err.println(">>> ERROR Service: SQLException in modifyCourseWithImages during course update!");
		}//end catch

	    if (!courseUpdateSuccess) {
             System.err.println(">>> ERROR Service: modifyCourseWithImages failed - Course update failed.");
	            return false; // 코스 수정 실패 시 즉시 false 반환
	    }

        // --- 2. 파일 정보 삭제 ---
         boolean allFilesDeletedSuccessfully = true;
         System.out.println(">>> DEBUG Service: Checking deletedFileIds...");
	        if (deletedFileIds != null && !deletedFileIds.isEmpty()) {
                 System.out.println(">>> DEBUG Service: deletedFileIds size = " + deletedFileIds.size());
	            for (Integer fileId : deletedFileIds) {
                    System.out.println(">>> DEBUG Service: Preparing to delete file path with propertyId=" + fileId);
	            	try {
                        // CourseDAO.deleteFilePath 메소드 호출 (단일 파일 삭제)
                        System.out.println(">>> DEBUG Service: Calling CourseDAO.deleteFilePath for propertyId=" + fileId);
						int deleteResult = cDAO.deleteFilePath(fileId) ;
                        System.out.println(">>> DEBUG Service: CourseDAO.deleteFilePath result = " + deleteResult);
                        if (deleteResult <= 0) {
                            System.err.println(">>> WARNING Service: modifyCourseWithImages - File path DB deletion failed for propertyId: " + fileId + ", executeUpdate result <= 0.");
                            // 삭제 실패 시 경고만 출력하고 계속 진행할지, 아니면 전체 실패 처리할지 로직 결정 필요
                            // 여기서는 경고만 출력
                        } else {
                             // TODO: DB에서 파일 정보 삭제 성공 시, 해당 서버 파일도 삭제하는 로직 필요
                             // FilePathDTO를 먼저 조회하여 파일 경로를 얻어야 함.
                             System.out.println(">>> DEBUG Service: File path DB deletion successful for propertyId: " + fileId);
                        }

					} catch (SQLException e) {
						e.printStackTrace();
                         System.err.println(">>> ERROR Service: SQLException occurred during file path deletion for propertyId " + fileId + " in modifyCourseWithImages!");
                         allFilesDeletedSuccessfully = false; // 예외 발생 시 파일 삭제는 실패로 간주
                         // TODO: 예외 발생 시 롤백 로직 (코스 수정 및 다른 파일 정보 삭제/삽입)
                         // 여기서 전체 실패로 반환할지, 아니면 계속 진행 후 최종 flag 결정할지 로직 결정 필요
                         // 여기서는 예외 발생 시 해당 파일 삭제만 실패로 간주하고 루프 계속 진행
					}//end catch 
	            }//end for
                // allFilesDeletedSuccessfully 값을 최종 flag에 반영하는 로직 필요
                // 이 메소드의 flag 반환 로직이 명확하지 않음.
                // 파일 삭제 성공 여부와 새 파일 삽입 성공 여부를 종합하여 최종 flag 결정 필요.
	        }//end if


        // --- 3. 새로운 파일 정보 삽입 ---
         boolean allNewFilesAddedSuccessfully = true;
         System.out.println(">>> DEBUG Service: Checking newUploadedFileList...");
	        if (newUploadedFileList != null && !newUploadedFileList.isEmpty()) {
                 System.out.println(">>> DEBUG Service: newUploadedFileList size = " + newUploadedFileList.size());
	            int course_Num = course.getCourse_Num(); // 수정 대상 코스 번호 사용
	            for (FilePathDTO file : newUploadedFileList) {
                    // FilePathDTO에 targetType과 targetNumber(코스 번호) 설정
	            	file.setTargerType("course"); // 대상 타입 설정
	            	file.setTargerNumber(String.valueOf(course_Num)); // 수정 대상 코스 번호 사용

                    // *** DAO 호출 전 FilePathDTO 값 디버깅 출력 ***
                    System.out.println(">>> DEBUG Service: Preparing to insert new FilePathDTO - path=" + file.getPath() + ", imgName=" + file.getImgName() + ", targetType=" + file.getTargerType() + ", targetNumber=" + file.getTargerNumber());

                    // CourseDAO.insertFilePath 메소드 호출
                    System.out.println(">>> DEBUG Service: Calling CourseDAO.insertFilePath from modifyCourseWithImages...");
	            	// CourseService cService=new CourseService(); // <-- 여기서 새로운 Service 객체 생성 불필요!
	            	// cService.addCourseImage(file, course_Num); // <-- 이 메소드 호출 대신 직접 DAO 호출!
                    int fileInsertResult=0;
					try {
						fileInsertResult = cDAO.insertFilePath(file);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} // DAO 직접 호출!
                    System.out.println(">>> DEBUG Service: CourseDAO.insertFilePath result = " + fileInsertResult);

                    if (fileInsertResult <= 0) {
                        System.err.println(">>> ERROR Service: modifyCourseWithImages failed - New file info DB insertion failed for file: " + file.getImgName() + ", executeUpdate result <= 0.");
		                allNewFilesAddedSuccessfully = false; // 하나라도 실패하면 전체 새 파일 삽입 실패
                        // TODO: 새 파일 DB 삽입 실패 시, 이미 DB에 삽입된 다른 새 파일 정보 및 코스 정보를 롤백하는 로직 필요
                    } else {
                        System.out.println(">>> DEBUG Service: New file path DB insertion successful for file: " + file.getImgName());
                    }
	            }//end for
	        }//end if

        // --- 4. 최종 결과 결정 ---
        // 코스 수정 성공 AND (파일 삭제 성공 OR 삭제 대상이 없었음) AND (새 파일 삽입 성공 OR 새 파일 삽입 대상이 없었음)
        // 파일 삭제 성공 여부는 deleteFilePathsByTarget 결과가 0 이상인지 (삭제 대상이 없었을 경우 0) 등으로 판단해야 함.
        // 여기서는 간단히 코스 수정 성공 && 파일 삭제 중 예외 없었음 && 새 파일 삽입 중 예외 없었음 && 새 파일 삽입 결과 0 이하 없었음
        flag = courseUpdateSuccess && allFilesDeletedSuccessfully && allNewFilesAddedSuccessfully;
        // TODO: 트랜잭션 관리 로직 필요 (commit/rollback)

        // --- modifyCourseWithImages 전체 예외 처리 ---
        // 현재 각 단계(코스 수정, 파일 삭제, 파일 삽입)마다 try-catch가 있으나, 
        // 전체적인 트랜잭션 관리를 위해서는 외부에서 예외를 한번에 잡고 롤백하는 구조가 더 좋음.

	    // *** 최종 결과 반환 전 디버깅 출력 ***
        System.out.println(">>> DEBUG Service: Exiting modifyCourseWithImages with final flag = " + flag);

        return flag; 
	    }//modifyCourseWithImages

     // Service에 궁 ID로 궁 이름(String)을 조회하는 메소드 (uploadImage.jsp에서 호출 예상)
     // 이전에 제공해 드린 CourseDAO의 selectGungNameById 메소드를 호출합니다.
     public String getGungNameById(int gungId) {
         String gungName = null;
         CourseDAO cDAO = CourseDAO.getInstance();

         System.out.println(">>> DEBUG Service: Entering getGungNameById for gungId=" + gungId);

         try {
             System.out.println(">>> DEBUG Service: Calling CourseDAO.selectGungNameById...");
             gungName = cDAO.selectGungNameById(gungId);
             System.out.println(">>> DEBUG Service: CourseDAO.selectGungNameById result = " + gungName);

         } catch (SQLException e) {
             e.printStackTrace(); 
             System.err.println(">>> ERROR Service: SQLException in getGungNameById for gungId=" + gungId);
         }//end catch

         System.out.println(">>> DEBUG Service: Exiting getGungNameById with result = " + gungName);
         return gungName;
     }


	 
}//class
