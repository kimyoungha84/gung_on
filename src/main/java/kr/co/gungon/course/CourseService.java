package kr.co.gungon.course;

import java.sql.SQLException;
import java.util.List;

import kr.co.gungon.cs.CsDAO;
import kr.co.gungon.cs.FilteringInfo;
import kr.co.gungon.file.FilePathDTO;
import kr.co.gungon.gung.GungDTO;

public class CourseService {

	public List<GungDTO> getAllGungs() {
		List<GungDTO> list= null; 
		CourseDAO cDAO= CourseDAO.getInstance();
			
		try {
			list=cDAO.selectAllGung();
		} catch (SQLException e) {
			e.printStackTrace();
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
		}//end catch
		return list;
    }//getCoursesByGungId
	
	
	public List<CourseDTO> getCoursesByGungId(int gung_Id, String fi) {
	    List<CourseDTO> list = null;
	    CourseDAO cDAO = CourseDAO.getInstance();
	    try {
	        list = cDAO.selectCoursesByGungIdAndFilter(gung_Id, fi);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public CourseDTO getCourseDetail(int course_Num) {
		CourseDTO cDTO=null;
		CourseDAO cDAO= CourseDAO.getInstance();
		
         try {
			cDTO=cDAO.selectCourseByCourseNum(course_Num);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
         return cDTO;
    }//getCourseDetail
	
	public boolean addCourse(CourseDTO course, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
        if (member_Id == null || member_Id.isEmpty()) {
            return flag;
        }//end if
        course.setMember_Id(member_Id);

        if (course.getCourse_Title() == null || course.getCourse_Title().trim().isEmpty() ||
            course.getCourse_Content() == null || course.getCourse_Content().trim().isEmpty()) {
            return flag;
        }//end if

		try {
			int result = cDAO.insertCourse(course);
			flag=result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
        return flag;
    }//addCourse
	
	public boolean modifyCourse(CourseDTO course, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
        if (member_Id == null || member_Id.isEmpty()) {
            return flag;
        }//end if

        CourseDTO cDTO=null;
		try {
			cDTO = cDAO.selectCourseByCourseNum(course.getCourse_Num());
			if (cDTO == null) {
	            return flag; 
	        }
             if (!cDTO.getMember_Id().equals(member_Id)) {
                 return flag;
             }

		} catch (SQLException e) {
			e.printStackTrace();
             return flag; 
		}//end catch

        course.setMember_Id(member_Id); 

        if (course.getCourse_Title() == null || course.getCourse_Title().trim().isEmpty() ||
            course.getCourse_Content() == null || course.getCourse_Content().trim().isEmpty()) {
            return flag; 
        }//end if

        int result;
		try {
			result = cDAO.updateCourse(course);
			flag = result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
            flag = false; 
		}//end catch
        
        return flag; 
   }//modifyCourse

	 public boolean removeCourse(int courseNum, String member_Id) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;
		
         if (member_Id == null || member_Id.isEmpty()) {
             return flag;
         }//end if

         CourseDTO cDTO = null;
         try {
			cDTO=cDAO.selectCourseByCourseNum(courseNum);
		} catch (SQLException e) {
			e.printStackTrace();
             return flag;
		}//end catch
         if (cDTO == null) {
             return flag; 
         }
         if (!cDTO.getMember_Id().equals(member_Id)) {
             return flag;
         }//end if

         int result=0;
		try {
			result = cDAO.deleteCourse(courseNum);
			flag=result > 0;
		} catch (SQLException e) {
			e.printStackTrace();
             flag = false; // 예외 발생 시 실패 처리
		}//end catch
         return flag;
    }//removeCourse
	 
	 
	 public boolean removeCourse(int courseNum) {
			CourseDAO cDAO= CourseDAO.getInstance();
			boolean flag=false;

	         CourseDTO cDTO = null;
	         try {
				cDTO=cDAO.selectCourseByCourseNum(courseNum);
			} catch (SQLException e) {
				e.printStackTrace();
	             return flag;
			}//end catch
	         if (cDTO == null) {
	             return flag; 
	         }
	         int result=0;
			try {
				result = cDAO.deleteCourse(courseNum);
				flag=result > 0;
			} catch (SQLException e) {
				e.printStackTrace();
	             flag = false; // 예외 발생 시 실패 처리
			}//end catch
	         return flag;
	    }//removeCourse
	 
	 
	 
	 public List<CourseDTO> getUserCourses(String member_Id) {
		 List<CourseDTO> list=null;
		 CourseDAO cDAO= CourseDAO.getInstance();
		 
	         if (member_Id == null || member_Id.isEmpty()) {
	             return null;
	         }//end if
	         try {
				list=cDAO.selectCoursesByMemberId(member_Id);
			} catch (SQLException e) {
				e.printStackTrace();
			}//end catch
	         
	        return list; 
	    }//getUserCourses
	 
	 public boolean addCourseRating(int course_Num, double rating) { 
			CourseDAO cDAO= CourseDAO.getInstance();
			boolean flag=false;

	         if (rating < 0.5 || rating > 5.0 || rating * 2 % 1 != 0) { 
	             return flag;
	         }//end if

	        CourseDTO currentRatingInfo = null;
	        try {
	            currentRatingInfo = cDAO.selectCourseRatingInfo(course_Num);

	        } catch (SQLException e) {
	             e.printStackTrace();
	             return false; 
	        }//end catch

	        if (currentRatingInfo == null) {
	             return false; 
	        }//end if

	        double currentAverageRating = currentRatingInfo.getCourse_Rating();
	        int currentRatingCount = currentRatingInfo.getCourse_Rating_Cnt();

	        double newTotalRating = (currentAverageRating * currentRatingCount) + rating;
	        int newRatingCount = currentRatingCount + 1;
	        double newAverageRating = newTotalRating / newRatingCount;


			try {
				int result = cDAO.updateCourseRating(course_Num, newAverageRating); 

				flag=result > 0;

			} catch (SQLException e) {
				e.printStackTrace();
	            flag = false; 
			}//end catch
	         return flag;
	     }//addCourseRating


	 public List<FilePathDTO> getCourseImages(int course_Num) {
		 CourseDAO cDAO= CourseDAO.getInstance();
		 List<FilePathDTO> list=null;
	     
		 try {
			list=cDAO.selectFilePathsByTarget("course", String.valueOf(course_Num));
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
         return list;
	    }//getCourseImages
	 
	 public boolean removeAllCourseImages(int courseNum) {
		 CourseDAO cDAO= CourseDAO.getInstance();
		 boolean flag=false;
		 
         try {
			int result = cDAO.deleteFilePathsByTarget("course", String.valueOf(courseNum)) ;
			flag = result > 0; 
             if (result >= 0) flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
             flag = false;
		}//end catch
    
         return flag;
	 }//getCourseImages
	
	 public boolean addCourseWithImages(CourseDTO course, List<FilePathDTO> uploadedFileList, String member_Id) {
		    CourseDAO cDAO = CourseDAO.getInstance();
		    boolean flag = false; 

		    int courseNum = 0;
		    try {
		        courseNum = cDAO.insertCourse(course); 

		        if (courseNum < -1) { 
		             return false; 
		        }//end if

		        boolean allFilesAddedSuccessfully = true; 

		        if (uploadedFileList != null && !uploadedFileList.isEmpty()) { 

		            for (FilePathDTO file : uploadedFileList) {
		               	file.setTargerType("course"); // 대상 타입 설정
		                file.setTargerNumber(String.valueOf(courseNum));

		                int fileInsertResult = cDAO.insertFilePath(file);

		                if (fileInsertResult <= 0) {
		                    allFilesAddedSuccessfully = false;
		                 }//end if
		            }//end for
		             flag = allFilesAddedSuccessfully;

		        } else {
		            flag = true; 
		        }//end else


			} catch (SQLException e) {
				e.printStackTrace();
				flag = false;
			} catch (Exception e) {
		        e.printStackTrace();
		        flag = false;
		    }//end catch

		    return flag;
		}//addCourseWithImages
	 
	 public boolean modifyCourseWithImages(CourseDTO course, List<FilePathDTO> newUploadedFileList, List<Integer> deletedFileIds, String memberId) {
		CourseDAO cDAO= CourseDAO.getInstance();
		boolean flag=false;

		boolean courseUpdateSuccess=false;
		try {
			courseUpdateSuccess = cDAO.updateCourse(course) > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch

	    if (!courseUpdateSuccess) {
	            return false;
	    }//end if

         boolean allFilesDeletedSuccessfully = true;
	        if (deletedFileIds != null && !deletedFileIds.isEmpty()) {
	            for (Integer fileId : deletedFileIds) {
	            	try {
						cDAO.deleteFilePath(fileId) ;

					} catch (SQLException e) {
						e.printStackTrace();
                         allFilesDeletedSuccessfully = false;
					}//end catch 
	            }//end for
	        }//end if

         boolean allNewFilesAddedSuccessfully = true;
	        if (newUploadedFileList != null && !newUploadedFileList.isEmpty()) {
	            int course_Num = course.getCourse_Num();
	            for (FilePathDTO file : newUploadedFileList) {
	            	file.setTargerType("course");
	            	file.setTargerNumber(String.valueOf(course_Num));

                    int fileInsertResult=0;
					try {
						fileInsertResult = cDAO.insertFilePath(file);
					} catch (SQLException e) {
						e.printStackTrace();
					}//end catch

                    if (fileInsertResult <= 0) {
		                allNewFilesAddedSuccessfully = false;
                    }//end if
	            }//end for
	        }//end if

        flag = courseUpdateSuccess && allFilesDeletedSuccessfully && allNewFilesAddedSuccessfully;

        return flag; 
	    }//modifyCourseWithImages

     public String getGungNameById(int gungId) {
         String gungName = null;
         CourseDAO cDAO = CourseDAO.getInstance();

         try {
             gungName = cDAO.selectGungNameById(gungId);

         } catch (SQLException e) {
             e.printStackTrace(); 
         }//end catch

         return gungName;
     }//getGungNameById
     
     
	public int totalCourseCount( FilteringInfo fi ) {
		
		int cnt = 0;
		var cDAO = CourseDAO.getInstance();
		try {
			cnt = cDAO.selectTotalCourseCount(fi);
		} catch (SQLException e) {
			e.printStackTrace();
		}//catch
		return cnt;
	}//totalCourseCount

	public List<CourseDTO> getFilteredCoursesByGungId(int gungId, FilteringInfo fi) throws Exception {
		var cDAO = CourseDAO.getInstance();
	    return cDAO.getFilteredCoursesByGungId(gungId, fi);
	}

	 
}//class
