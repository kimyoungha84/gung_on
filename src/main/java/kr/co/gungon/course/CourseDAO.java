package kr.co.gungon.course;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.file.FilePathDTO;
import kr.co.gungon.gung.GungDTO;

public class CourseDAO {

	private static CourseDAO cDAO;
	
	private CourseDAO() {
	}//CourseDAO
	
	public static CourseDAO getInstance() {
		if(cDAO == null) {
			cDAO=new CourseDAO();
		}//end if
		return cDAO;
	}//getInstance
	
	 public List<GungDTO> selectAllGung() throws SQLException {
	        List<GungDTO> gungList = new ArrayList<GungDTO>();
	        DbConnection db = DbConnection.getInstance();
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection con = null;
			
	        try {
	        		
	        	con=db.getDbConn();
	        	String selectGungSql = "SELECT gung_id, gung_name FROM gung ORDER BY gung_id";
	        	
	        	pstmt = con.prepareStatement(selectGungSql);
	        	rs = pstmt.executeQuery();
	        	
	        	GungDTO gDTO=null;
	            while (rs.next()) {
	            	gDTO = new GungDTO();
	                gDTO.setGung_id(rs.getInt("gung_id"));
	                gDTO.setGung_name(rs.getString("gung_name"));
	                gungList.add(gDTO);
	            	}//end while
	            }finally {
	            	db.dbClose(rs, pstmt, con);
	            }//end finally
	        return gungList;
	    }//selectAllGung
	 
	 
	 public List<CourseDTO> selectCoursesByGungId(int gung_Id) throws SQLException {
	        List<CourseDTO> courseList = new ArrayList<CourseDTO>();
	        DbConnection db = DbConnection.getInstance();
	        
	        ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection con = null;
			
	        try {
	        	con=db.getDbConn();
	        	String selectCourseSql = "SELECT course_num, member_id, course_title, course_rating, course_rating_cnt, course_reg_date, gung_id " +
	        			"FROM course " +
	        			"WHERE gung_id = ? " +
	        			"ORDER BY course_reg_date DESC";
	        	
	        	pstmt = con.prepareStatement(selectCourseSql);
	            pstmt.setInt(1, gung_Id);
	            rs = pstmt.executeQuery();
	            
	            CourseDTO cDTO=null;
	                while (rs.next()) {
	                	cDTO = new CourseDTO();
	                	cDTO.setCourse_Num(rs.getInt("course_num"));
	                	cDTO.setMember_Id(rs.getString("member_id"));
	                	cDTO.setCourse_Title(rs.getString("course_title"));
	                	cDTO.setCourse_Rating(rs.getDouble("course_rating"));
	                	cDTO.setCourse_Rating_Cnt(rs.getInt("course_rating_cnt"));
	                	cDTO.setCourse_Reg_Date(rs.getDate("course_reg_date"));
	                	cDTO.setGung_Id(rs.getInt("gung_id"));
	                    courseList.add(cDTO);
	            }//end while
	        } finally {
				db.dbClose(rs, pstmt, con);
			} // end finally
	        return courseList;
	    }//selectCoursesByGungId
	
	 
	 public CourseDTO selectCourseByCourseNum(int course_Num) throws SQLException {
	        CourseDTO cDTO = null;
	        DbConnection db = DbConnection.getInstance();
	        
	        ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection con = null;
			
	        try {
	        	con=db.getDbConn();
	        	
	        	String selectCourseSql = "SELECT course_num, member_id, course_title, course_content, course_rating, course_rating_cnt, course_reg_date, gung_id " +
	                     "FROM course " +
	                     "WHERE course_num = ?";
	        	
	        	pstmt = con.prepareStatement(selectCourseSql);
	            pstmt.setInt(1, course_Num);
	            rs = pstmt.executeQuery();
	                if (rs.next()) {
	                	cDTO = new CourseDTO();
	                	cDTO.setCourse_Num(rs.getInt("course_num"));
	                	cDTO.setMember_Id(rs.getString("member_id"));
	                	cDTO.setCourse_Title(rs.getString("course_title"));
	                    // CLOB 데이터 읽기
	                    Clob clob = rs.getClob("course_content");
	                    if (clob != null) {
	                    	cDTO.setCourse_Content(clob.getSubString(1, (int) clob.length()));
	                    } else {
	                    	cDTO.setCourse_Content("");
	                    }//end else
	                    cDTO.setCourse_Rating(rs.getDouble("course_rating"));
	                    cDTO.setCourse_Rating_Cnt(rs.getInt("course_rating_cnt"));
	                    cDTO.setCourse_Reg_Date(rs.getDate("course_reg_date"));
	                    cDTO.setGung_Id(rs.getInt("gung_id"));
	                }//end if
	        } finally {
				db.dbClose(rs, pstmt, con);
			} // end finally
	        return cDTO;
	    }//selectCourseByCourseNum
	 
	 
	 public int insertCourse(CourseDTO course) throws SQLException {
			DbConnection db = DbConnection.getInstance();
			PreparedStatement pstmt = null;
			Connection con = null;
			int result=0;
			 
	        System.out.println(">>> DEBUG DAO: Entering insertCourse...");
	        System.out.println(">>> DEBUG DAO: CourseDTO - memberId=" + course.getMember_Id() + ", title=" + course.getCourse_Title() + ", gungId=" + course.getGung_Id());

		        try {
		        	con = db.getDbConn();
		        	String insertCourseSql = "INSERT INTO course (course_num, member_id, course_title, course_content, gung_id) " +
		        			"VALUES (course_seq.NEXTVAL, ?, ?, ?, ?)";

	                System.out.println(">>> DEBUG DAO: Preparing statement: " + insertCourseSql);
		        	pstmt = con.prepareStatement(insertCourseSql);
		        	
	                System.out.println(">>> DEBUG DAO: Binding 1 (member_id) = " + course.getMember_Id());
	                System.out.println(">>> DEBUG DAO: Binding 2 (course_title) = " + course.getCourse_Title());
	                System.out.println(">>> DEBUG DAO: Binding 3 (course_content) length = " + (course.getCourse_Content() != null ? course.getCourse_Content().length() : "null"));
	                System.out.println(">>> DEBUG DAO: Binding 4 (gung_id) = " + course.getGung_Id());

		            pstmt.setString(1, course.getMember_Id());
		            pstmt.setString(2, course.getCourse_Title());
		            
	                // *** course_content CLOB 처리 ***
	                if (course.getCourse_Content() != null) {
	                     // Connection에서 Clob 객체 생성
	                     Clob courseContentClob = con.createClob();
	                     // Clob 객체에 문자열 내용 기록
	                     courseContentClob.setString(1, course.getCourse_Content());
	                     // pstmt.setClob()으로 바인딩
	                     pstmt.setClob(3, courseContentClob); // 3번째 바인딩 (SQL의 ?)
	                } else {
	                     // 내용이 null일 경우 NULL로 설정
	                     pstmt.setNull(3, java.sql.Types.CLOB); 
	                }
	                // *** CLOB 처리 끝 ***

		            pstmt.setInt(4, course.getGung_Id()); // 4번째 바인딩 (SQL의 ?)

	                System.out.println(">>> DEBUG DAO: Executing executeUpdate...");
		            result=pstmt.executeUpdate();
	                System.out.println(">>> DEBUG DAO: executeUpdate result (rows affected) = " + result);

				} finally {
					db.dbClose(null, pstmt, con); 
	                System.out.println(">>> DEBUG DAO: insertCourse finished.");
				} 
		        return result;
		    }
		 
	     // 코스 정보 수정 메소드 (Service에서 호출)
		 public int updateCourse(CourseDTO course) throws SQLException {
			DbConnection db = DbConnection.getInstance();
			PreparedStatement pstmt = null;
			Connection con = null;
			int result=0;

	        System.out.println(">>> DEBUG DAO: Entering updateCourse...");
	        System.out.println(">>> DEBUG DAO: CourseDTO received - courseNum=" + course.getCourse_Num() + ", title=" + course.getCourse_Title() + ", memberId=" + course.getMember_Id() + ", gungId=" + course.getGung_Id());
	        
	         try  {
	        	con = db.getDbConn();
	        	String updateCourseSql = "UPDATE course SET course_title = ?, course_content = ?, gung_id = ? " + 
	                     "WHERE course_num = ? AND member_id = ?"; 

	            System.out.println(">>> DEBUG DAO: Preparing statement: " + updateCourseSql);
	        	pstmt = con.prepareStatement(updateCourseSql);

	            // *** 바인딩 값 디버깅 출력 ***
	            System.out.println(">>> DEBUG DAO: Binding 1 (course_title) = " + course.getCourse_Title());
	            System.out.println(">>> DEBUG DAO: Binding 2 (course_content) length = " + (course.getCourse_Content() != null ? course.getCourse_Content().length() : "null"));
	            System.out.println(">>> DEBUG DAO: Binding 3 (gung_id) = " + course.getGung_Id()); 
	            System.out.println(">>> DEBUG DAO: Binding 4 (course_num) = " + course.getCourse_Num());
	            System.out.println(">>> DEBUG DAO: Binding 5 (member_id) = " + course.getMember_Id()); 


	            pstmt.setString(1, course.getCourse_Title());
	            // *** course_content CLOB 처리 ***
	            if (course.getCourse_Content() != null) {
	                 // Connection에서 Clob 객체 생성
	                 Clob courseContentClob = con.createClob();
	                 // Clob 객체에 문자열 내용 기록
	                 courseContentClob.setString(1, course.getCourse_Content());
	                 // pstmt.setClob()으로 바인딩
	                 pstmt.setClob(2, courseContentClob); // 2번째 바인딩 (SQL의 ?)
	            } else {
	                 // 내용이 null일 경우 NULL로 설정
	                 pstmt.setNull(2, java.sql.Types.CLOB); 
	            }
	            // *** CLOB 처리 끝 ***

	            pstmt.setInt(3, course.getGung_Id()); 
	            pstmt.setInt(4, course.getCourse_Num());
	            pstmt.setString(5, course.getMember_Id());

	            System.out.println(">>> DEBUG DAO: Executing executeUpdate...");
	            result=pstmt.executeUpdate();
	            System.out.println(">>> DEBUG DAO: executeUpdate result (rows affected) = " + result);

	         } finally {
	 			db.dbClose(null, pstmt, con); 
	             System.out.println(">>> DEBUG DAO: updateCourse finished.");
	 		} 
	         return result;
	    }
	 
	 public int deleteCourse(int course_Num) throws SQLException  {
		DbConnection db = DbConnection.getInstance();
		PreparedStatement pstmt = null;
		Connection con = null;
		int result=0;
        
        try {
        	con = db.getDbConn();
        	String delteCourseSql = "DELETE FROM course WHERE course_num = ?";

        	pstmt = con.prepareStatement(delteCourseSql);
            pstmt.setInt(1, course_Num);

            result=pstmt.executeUpdate();
        } finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally
        return result;
	 }//deleteCourse
	 
	 public List<CourseDTO> selectCoursesByMemberId(String member_Id) throws SQLException {
        List<CourseDTO> courseList = new ArrayList<CourseDTO>();
        DbConnection db = DbConnection.getInstance();
	        
	    ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
         
        try {
        	con=db.getDbConn();
        	String selectCourseSql = "SELECT course_num, member_id, course_title, course_rating, course_rating_cnt, course_reg_date, gung_id " +
                    "FROM course " +
                    "WHERE member_id = ? " +
                    "ORDER BY course_reg_date DESC";
        	
        	pstmt = con.prepareStatement(selectCourseSql);
        	pstmt.setString(1, member_Id);
            rs = pstmt.executeQuery();
            
            CourseDTO cDTO=null;
            while (rs.next()) {
                  cDTO = new CourseDTO();
                  cDTO.setCourse_Num(rs.getInt("course_num"));
                  cDTO.setMember_Id(rs.getString("member_id"));
                  cDTO.setCourse_Title(rs.getString("course_title"));
                  cDTO.setCourse_Rating(rs.getDouble("course_rating"));
                  cDTO.setCourse_Rating_Cnt(rs.getInt("course_rating_cnt"));
                  cDTO.setCourse_Reg_Date(rs.getDate("course_reg_date"));
                  cDTO.setGung_Id(rs.getInt("gung_id"));
                  courseList.add(cDTO);
                }//end while
        } finally {
			db.dbClose(rs, pstmt, con);
		} // end finally
        return courseList;
    }//selectCoursesByMemberId
	 
	 
	 public int updateCourseRating(int course_Num, double newRating) throws SQLException {
        CourseDTO cDTO = selectCourseRatingInfo(course_Num);
        DbConnection db = DbConnection.getInstance();
         
        PreparedStatement pstmt = null;
 		Connection con = null;
        if (cDTO == null) {
             return 0; 
        }//end if

        double currentTotalRating = cDTO.getCourse_Rating() * cDTO.getCourse_Rating_Cnt();
        int newRatingCnt = cDTO.getCourse_Rating_Cnt() + 1;
        double newAverageRating = (currentTotalRating + newRating) / newRatingCnt;

        int result = 0;
        
        try {
        	con = db.getDbConn();
        	String updateCouseRatingSql = "UPDATE course SET course_rating = ?, course_rating_cnt = ? " +
        			"WHERE course_num = ?";
        	pstmt = con.prepareStatement(updateCouseRatingSql);
            pstmt.setDouble(1, newAverageRating); 
            pstmt.setInt(2, newRatingCnt);
            pstmt.setInt(3, course_Num);

            result = pstmt.executeUpdate();
        } finally {
 			// 7.연결 끊기
 			db.dbClose(null, pstmt, con);
 		} // end finally
        return result;
    }//updateCourseRating
	 
	 public CourseDTO selectCourseRatingInfo(int course_Num) throws SQLException {
		CourseDTO cDTO = null;
	    DbConnection db = DbConnection.getInstance();
	        
	    ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
         
         try {
        	 con = db.getDbConn();
        	 String selectCourseSql = "SELECT course_rating, course_rating_cnt FROM course WHERE course_num = ?";

        	 pstmt = con.prepareStatement(selectCourseSql);
	         pstmt.setInt(1, course_Num);
	         rs = pstmt.executeQuery();
             
             if (rs.next()) {
              cDTO = new CourseDTO();
              cDTO.setCourse_Rating(rs.getDouble("course_rating"));
              cDTO.setCourse_Rating_Cnt(rs.getInt("course_rating_cnt"));
             }//end if
         } finally {
 			db.dbClose(rs, pstmt, con);
 		} // end finally
         return cDTO;
    }//selectCourseRatingInfo 
	 

	 
	 public int insertFilePath(FilePathDTO filePath) throws SQLException {
			DbConnection db = DbConnection.getInstance();
			PreparedStatement pstmt = null;
			Connection con = null;
			int result=0;

	        System.out.println(">>> DEBUG DAO: Entering insertFilePath...");
	        // *** Service에서 넘어온 FilePathDTO 값 디버깅 출력 ***
	        // path, imgName, targerNumber 값이 올바른지 확인
	        System.out.println(">>> DEBUG DAO: FilePathDTO received - path=" + filePath.getPath() + ", imgName=" + filePath.getImgName() + ", targetType=" + filePath.getTargerType() + ", targetNumber=" + filePath.getTargerNumber());
		        
		    try  {
		       	con = db.getDbConn();
		       	// property_id는 sequence 사용
		       	String insertFileSql = "INSERT INTO file_path (property_id, path, targer_type, targer_number, img_name) " + 
		      		"VALUES (course_file_seq.NEXTVAL, ?, ?, ?, ?)";

	            System.out.println(">>> DEBUG DAO: Preparing statement: " + insertFileSql);
		       	pstmt = con.prepareStatement(insertFileSql);
		       	
	            // *** DB에 바인딩될 실제 값 디버깅 출력 ***
	            // DB에 삽입될 실제 값 확인
	            System.out.println(">>> DEBUG DAO: Binding 1 (path) = " + filePath.getPath());
	            System.out.println(">>> DEBUG DAO: Binding 2 (targer_type) = " + filePath.getTargerType());   
	            System.out.println(">>> DEBUG DAO: Binding 3 (targer_number) = " + filePath.getTargerNumber()); 
	            System.out.println(">>> DEBUG DAO: Binding 4 (img_name) = " + filePath.getImgName());

	            // *** 바인딩 실행 ***
		       	pstmt.setString(1, filePath.getPath());
		        pstmt.setString(2, filePath.getTargerType());   
		        pstmt.setString(3, filePath.getTargerNumber()); // targerNumber는 String 타입
		        pstmt.setString(4, filePath.getImgName());

	            System.out.println(">>> DEBUG DAO: Executing executeUpdate...");
		        result=pstmt.executeUpdate();
	            System.out.println(">>> DEBUG DAO: executeUpdate result (rows affected) = " + result);

			} finally {
				db.dbClose(null, pstmt, con); 
	            System.out.println(">>> DEBUG DAO: insertFilePath finished.");
			} 
	        return result; 
		    }
	 
	 public List<FilePathDTO> selectFilePathsByTarget(String targerType, String targerNumber) throws SQLException{
	        List<FilePathDTO> fileList = new ArrayList<FilePathDTO>();
	        DbConnection db = DbConnection.getInstance();
	        
		    ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection con = null;
	         
	        try {
	        	con=db.getDbConn();

	        	String selectFilePathSql = "SELECT property_id, path, targer_type, targer_number, img_name " + 
	                     "FROM file_path " +
	                     "WHERE targer_type = ? AND targer_number = ?"; 
	        	
	        	pstmt = con.prepareStatement(selectFilePathSql);
	            pstmt.setString(1, targerType);
	            pstmt.setString(2, targerNumber);

	            rs = pstmt.executeQuery();
	            
	            FilePathDTO fpDTO=null;
	                while (rs.next()) {
	                	fpDTO = new FilePathDTO();
	                	fpDTO.setPropertyId(rs.getInt("property_id"));
	                	fpDTO.setPath(rs.getString("path"));
	                	fpDTO.setTargerType(rs.getString("targer_type"));
	                	fpDTO.setTargerNumber(rs.getString("targer_number"));
	                	fpDTO.setImgName(rs.getString("img_name"));
	                    fileList.add(fpDTO);
	                }
	        } finally {
				db.dbClose(rs, pstmt, con);
			} // end finally
	        return fileList;
	    }//selectFilePathsByTarget
	 
	 public int deleteFilePath(int property_Id) throws SQLException{
		DbConnection db = DbConnection.getInstance();
		PreparedStatement pstmt = null;
		Connection con = null;
		int result=0;
		
		try {
        	con = db.getDbConn();
	      	String deleteFilePathSql = "DELETE FROM file_path WHERE property_id = ?";

	      	pstmt = con.prepareStatement(deleteFilePathSql);
	        pstmt.setInt(1, property_Id);

	        result=pstmt.executeUpdate();
        } finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally
        return result;
	 }//deleteFilePath

	 public int deleteFilePathsByTarget(String targerType, String targerNumber) throws SQLException {
		 DbConnection db = DbConnection.getInstance();
			PreparedStatement pstmt = null;
			Connection con = null;
			int result=0;
			
			try {
	        	con = db.getDbConn();
	        	String deleteFilePathSql = "DELETE FROM file_path WHERE targer_type = ? AND targer_number = ?";
	        	
	        	pstmt = con.prepareStatement(deleteFilePathSql);
	            pstmt.setString(1, targerType);
	            pstmt.setString(2, targerNumber);

	            result=pstmt.executeUpdate();
	        } finally {
				// 7.연결 끊기
				db.dbClose(null, pstmt, con);
			} // end finally
	        return result;
		 }//deleteFilePathsByTarget
	 
	 public String selectGungNameById(int gungId) throws SQLException {
		    String gungName = null;
		    DbConnection db = DbConnection.getInstance();
		    ResultSet rs = null;
		    PreparedStatement pstmt = null;
		    Connection con = null;

	        System.out.println(">>> DEBUG DAO: Entering selectGungNameById for gungId=" + gungId);

		    try {
		        con = db.getDbConn();
		        String selectGungNameSql = "SELECT gung_name FROM gung WHERE gung_id = ?";

		        pstmt = con.prepareStatement(selectGungNameSql);
		        pstmt.setInt(1, gungId);

	            System.out.println(">>> DEBUG DAO: Executing query: " + selectGungNameSql + " with gungId=" + gungId);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            gungName = rs.getString("gung_name");
	                System.out.println(">>> DEBUG DAO: Found gung name: " + gungName);
		        } else {
	                System.out.println(">>> DEBUG DAO: No gung name found for gungId=" + gungId);
	            }
		    } finally {
		        db.dbClose(rs, pstmt, con);
	            System.out.println(">>> DEBUG DAO: selectGungNameById finished.");
		    }
		    return gungName;
		}
	 
	 public List<CourseDTO> selectUserCoursesByGungId(int gungId, String memberId) throws SQLException {
		    List<CourseDTO> courseList = new ArrayList<CourseDTO>();
		    DbConnection db = DbConnection.getInstance();
		    ResultSet rs = null;
		    PreparedStatement pstmt = null;
		    Connection con = null;

	        System.out.println(">>> DEBUG DAO: Entering selectUserCoursesByGungId for gungId=" + gungId + ", memberId=" + memberId);

		    try {
		        con = db.getDbConn();
		        String selectSql = "SELECT course_num, member_id, course_title, course_rating, course_rating_cnt, course_reg_date, gung_id " +
		                           "FROM course " +
		                           "WHERE gung_id = ? AND member_id = ? " + // 두 조건 모두 사용
		                           "ORDER BY course_reg_date DESC";

		        pstmt = con.prepareStatement(selectSql);
		        pstmt.setInt(1, gungId);
	            pstmt.setString(2, memberId);

	            System.out.println(">>> DEBUG DAO: Executing query: " + selectSql + " with gungId=" + gungId + ", memberId=" + memberId);
		        rs = pstmt.executeQuery();

	            CourseDTO cDTO = null;
	            int rowCount = 0;
		        while (rs.next()) {
		            cDTO = new CourseDTO();
		            cDTO.setCourse_Num(rs.getInt("course_num"));
		            cDTO.setMember_Id(rs.getString("member_id"));
		            cDTO.setCourse_Title(rs.getString("course_title"));
		            cDTO.setCourse_Rating(rs.getDouble("course_rating"));
		            cDTO.setCourse_Rating_Cnt(rs.getInt("course_rating_cnt"));
		            cDTO.setCourse_Reg_Date(rs.getDate("course_reg_date"));
		            cDTO.setGung_Id(rs.getInt("gung_id"));
		            courseList.add(cDTO);
	                rowCount++;
		        }//end while
	             System.out.println(">>> DEBUG DAO: selectUserCoursesByGungId result row count = " + rowCount);

		    } finally {
		        db.dbClose(rs, pstmt, con);
	             System.out.println(">>> DEBUG DAO: selectUserCoursesByGungId finished.");
		    }//end finally
		    return courseList;
		}//selectUserCoursesByGungId
	 
}//class
