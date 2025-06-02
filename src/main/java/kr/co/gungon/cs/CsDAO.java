package kr.co.gungon.cs;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;



public class CsDAO {

	private static CsDAO csDAO;
	
	private CsDAO() {
		
		
	}
	
	public static CsDAO getInstance() {
		if( csDAO == null ) {
			
			csDAO = new CsDAO();
		}
		return csDAO;
	}
	
	
	public int selectTotalNoticeCount(FilteringInfo fi) throws SQLException {
	    int cnt = 0;

	    DbConnection db = DbConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        // 1.JNDI 사용객체 생성
	        // 2.DBCP에서 연결객체 얻기(DataSource)
	        // 3.Connection 얻기
	        con = db.getDbConn();
	        
	        // 4.쿼리문 생성객체 얻기
	        StringBuilder selectNotice = new StringBuilder();
	        selectNotice.append("SELECT COUNT(*) AS cnt ")
	                    .append("FROM notice ")
	                    .append("WHERE 1=1 ");

	        // 검색 조건 처리
	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            if ("notice_title".equals(fi.getSearchCategory())) {
	                selectNotice.append("  AND notice_title LIKE ? ");
	            } else if ("notice_content".equals(fi.getSearchCategory())) {
	                selectNotice.append("  AND REGEXP_REPLACE(notice_content, '<[^>]*>', '') LIKE ? ");
	            }
	        }

	        // 날짜 필터링 (시간을 무시하고 날짜만 비교)
	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            selectNotice.append("  AND TRUNC(notice_reg_date) BETWEEN TRUNC(?) AND TRUNC(?) ");
	        } else if (fi.getStartDate() != null) {
	            selectNotice.append("  AND TRUNC(notice_reg_date) >= TRUNC(?) ");
	        } else if (fi.getEndDate() != null) {
	            selectNotice.append("  AND TRUNC(notice_reg_date) <= TRUNC(?) ");
	        }

	        pstmt = con.prepareStatement(selectNotice.toString());

	        int paramIndex = 1;

	        // 검색 텍스트 바인딩
	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            pstmt.setString(paramIndex++, "%" + fi.getSearchText() + "%");
	        }

	        // 날짜 바인딩
	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        } else if (fi.getStartDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	        } else if (fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        }

	        // 6.쿼리문 수행 후 결과 얻기
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            cnt = rs.getInt("cnt");
	        }

	    } finally {
	        // 7.연결 끊기
	        db.dbClose(rs, pstmt, con);
	    }

	    return cnt;
	}//selectTotalNoticeCount

	
	
	
	
	public NoticeDTO selectOneNotice(int num) throws SQLException {
		NoticeDTO nDTO = null;
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체얻기( DataSource )
		//3.Connection얻기
			con = db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectOneNotice = new StringBuilder();
			selectOneNotice
			.append("	select notice_num, notice_title, notice_content, notice_views, notice_reg_date		")	
			.append("	from   notice				")
			.append("	where	notice_num=?				");	
			
			pstmt = con.prepareStatement(selectOneNotice.toString());
			pstmt.setInt(1, num);
		//5.바인드변수에 값 할당
			//pstmt.setString(1, id);
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				nDTO = new NoticeDTO();
				nDTO.setNotice_num(rs.getInt("notice_num"));
				nDTO.setNotice_title(rs.getString("notice_title"));
				nDTO.setNotice_views(rs.getInt("notice_views"));
				nDTO.setNotice_regDate(rs.getDate("notice_reg_date"));
				
				//bDTO.setContent(rs.getString("content"));
				//CLOB은 아주 긴 문자열을 저장하므로 별도의 Stream을 연겨랗여 값을 읽어들인다.
				StringBuilder tempContent = new StringBuilder();
				String lineData="";
				
				
				Clob clob= rs.getClob("notice_content");
				if (clob !=null) {
				
				//try ~ with ~ resources
				try( BufferedReader br = new BufferedReader(clob.getCharacterStream())) {
						
					while((lineData = br.readLine()) != null) {
						tempContent.append(lineData).append("\n");
					}//end while
				} catch (IOException e) {
					e.printStackTrace();
					tempContent.append("글 내용 읽기 실패");
				}//end catch
				nDTO.setNotice_content(tempContent.toString());
					
			}//end if
			}
			
		}finally {
		//7.연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return nDTO;
	}//selectOneNotice
	
	
	
	
	
	
	
	
	public List<NoticeDTO> selectNotice(FilteringInfo fi) throws SQLException{
			
			List<NoticeDTO> list = new ArrayList<NoticeDTO>();
			
			DbConnection db=DbConnection.getInstance();
			
			ResultSet rs = null;
			PreparedStatement pstmt = null;
			Connection con = null;
			
			try {
			//1.JNDI 사용객체 생성
			//2.DBCP에서 연결객체얻기( DataSource )
			//3.Connection얻기
				con = db.getDbConn();
			//4.쿼리문 생성객체 얻기
				StringBuilder selectNotice = new StringBuilder();
				selectNotice.append("select notice_num, notice_title, notice_content, notice_views, notice_reg_date ")
				            .append("from ( ")
				            .append("  select notice_num, notice_title, notice_content, notice_views, notice_reg_date, ")
				            .append("  ROW_NUMBER() OVER (ORDER BY notice_reg_date DESC, notice_num DESC) rnum ")
				            .append("  from notice ")
				            .append("  where 1=1 "); // 기본 조건을 설정 (추후 필터링에 조건 추가)

				if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
				    // 검색 카테고리가 '제목'이면 title로 검색
				    if ("notice_title".equals(fi.getSearchCategory())) {
				        selectNotice.append("  and notice_title like ? ");
				    } else if ("notice_content".equals(fi.getSearchCategory())) {
				        // 검색 카테고리가 '내용'이면 HTML 태그를 제거하고 내용 검색
				        selectNotice.append("  and REGEXP_REPLACE(notice_content, '<[^>]*>', '') like ? ");
				    }
				}

				// 날짜 필터링 (시간을 무시하고 날짜만 비교)
				if (fi.getStartDate() != null && fi.getEndDate() != null) {
				    // TRUNC를 사용하여 날짜만 비교
				    selectNotice.append("  and TRUNC(notice_reg_date) between TRUNC(?) and TRUNC(?) ");
				} else if (fi.getStartDate() != null) {
				    selectNotice.append("  and TRUNC(notice_reg_date) >= TRUNC(?) ");
				} else if (fi.getEndDate() != null) {
				    selectNotice.append("  and TRUNC(notice_reg_date) <= TRUNC(?) ");
				}

				// 페이지네이션을 위한 rownum 필터
				selectNotice.append(") where rnum between ? and ? ");







				
				
				
				pstmt = con.prepareStatement(selectNotice.toString());
				
				int paramIndex = 1;

				// 검색 텍스트 바인딩 (검색 필드와 텍스트가 있을 경우)
				if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
					pstmt.setString(paramIndex++, "%" + fi.getSearchText() + "%");
				}

				// 날짜 바인딩 (시간을 무시하고 날짜만 비교)
				if (fi.getStartDate() != null && fi.getEndDate() != null) {
				    // startDate 바인딩 (날짜만)
					pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
				    
				    // endDate 바인딩 (날짜만)
					pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
				} else if (fi.getStartDate() != null) {
					pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
				} else if (fi.getEndDate() != null) {
					pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
				}

				// 페이지네이션 바인딩
				pstmt.setInt(paramIndex++, fi.getStartNum());
				pstmt.setInt(paramIndex++, fi.getEndNum());



				
				
				//6.쿼리문 수행 후 결과 얻기
				rs=pstmt.executeQuery();
				
				NoticeDTO nDTO = null;
				while( rs.next() ) {
					nDTO = new NoticeDTO();
					nDTO.setNotice_num(rs.getInt("notice_num"));
					nDTO.setNotice_title(rs.getString("notice_title"));
					nDTO.setNotice_views(rs.getInt("notice_views"));
					nDTO.setNotice_regDate(rs.getDate("notice_reg_date"));
					
					list.add(nDTO);
				}//end while
			}finally {
			//7.연결 끊기
				db.dbClose(rs, pstmt, con);
			}//end finally
			
			
			return list;
		}//selectNotice
	


	
	
	
	
	
	
	
	
	public NoticeDTO selectOneBoard(int num) throws SQLException {
		NoticeDTO nDTO = null;
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체얻기( DataSource )
		//3.Connection얻기
			con = db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectOneBoard = new StringBuilder();
			selectOneBoard
			.append("	select notice_num, notice_title, notice_content, notice_views, notice_reg_date 	")	
			.append("	from   board				")
			.append("	where	num=?				");	
			
			pstmt = con.prepareStatement(selectOneBoard.toString());
			pstmt.setInt(1, num);
		//5.바인드변수에 값 할당
			//pstmt.setString(1, id);
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				nDTO = new NoticeDTO();
				nDTO.setNotice_num(rs.getInt("notice_num"));
				nDTO.setNotice_title(rs.getString("notice_title"));
				nDTO.setNotice_views(rs.getInt("notice_views"));
				nDTO.setNotice_regDate(rs.getDate("notice_reg_date"));
				
				//bDTO.setContent(rs.getString("content"));
				//CLOB은 아주 긴 문자열을 저장하므로 별도의 Stream을 연겨랗여 값을 읽어들인다.
				StringBuilder tempContent = new StringBuilder();
				String lineData="";
				
				
				Clob clob= rs.getClob("notice_content");
				if (clob !=null) {
				
				//try ~ with ~ resources
				try( BufferedReader br = new BufferedReader(clob.getCharacterStream())) {
						
					while((lineData = br.readLine()) != null) {
						tempContent.append(lineData).append("\n");
					}//end while
				} catch (IOException e) {
					e.printStackTrace();
					tempContent.append("글 내용 읽기 실패");
				}//end catch
				nDTO.setNotice_content(tempContent.toString());
					
			}//end if
			}
			
		}finally {
		//7.연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return nDTO;
	}//selectOneNotice
	
	
	
	
	
	
	public int updateNotice(NoticeDTO nDTO) throws SQLException{
		int rowCnt = 0;
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			//1.JNDI 사용객체 생성
			//2.DBCP에서 연결객체얻기( DataSource )
			//3.Connection얻기
			con = db.getDbConn();
			//4.쿼리문 생성객체 얻기
			StringBuilder updateNotice = new StringBuilder();
			updateNotice
			.append("	update notice	")	
			.append("	set notice_title = ?, notice_content = ?	")	
			.append("	where notice_num = ? ");	
			
			pstmt = con.prepareStatement(updateNotice.toString());
			//5.바인드변수에 값 할당
			pstmt.setString(1, nDTO.getNotice_title());
			pstmt.setString(2, nDTO.getNotice_content());
			pstmt.setInt(3, nDTO.getNotice_num());
			//6.쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
		}finally {
			//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
		return rowCnt;
	}//updateNotice
	
	
	public void insertNotice(NoticeDTO nDTO) throws SQLException {
		DbConnection db=DbConnection.getInstance();
				
				PreparedStatement pstmt = null;
				Connection con = null;
				
				try {
				//1.JNDI 사용객체 생성
				//2.DBCP에서 연결객체얻기( DataSource )
				//3.Connection얻기
					con = db.getDbConn();
				//4.쿼리문 생성객체 얻기
					StringBuilder insertBoard = new StringBuilder();
					insertBoard
					.append("	insert into NOTICE( notice_num, notice_title, notice_content)		")	
					.append("	values( notice_seq.nextval,?,?)	");	
					
					
					pstmt = con.prepareStatement(insertBoard.toString());
				//5.바인드변수에 값 할당
					
					pstmt.setString(1, nDTO.getNotice_title());
					pstmt.setString(2, nDTO.getNotice_content());
				//6.쿼리문 수행 후 결과 얻기
					pstmt.executeQuery();
				}finally {
				//7.연결 끊기
					db.dbClose(null, pstmt, con);
				}//end finally
		
	}//insertNotice
	
	public int deleteNotices(List<Integer> noticeNums) throws SQLException{
		int rowCnt = 0;
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체얻기( DataSource )
		//3.Connection얻기
			con = db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder placeholders = new StringBuilder();
	        for (int i = 0; i < noticeNums.size(); i++) {
	            placeholders.append("?");
	            if (i < noticeNums.size() - 1) {
	                placeholders.append(", ");
	            }
	        }
	        // SQL 쿼리 생성
	        String deleteQuery = "DELETE FROM notice WHERE notice_num IN (" + placeholders.toString() + ")";
	        
	        pstmt = con.prepareStatement(deleteQuery);
	        
	        //5.바인드변수에 값 할당
	        for (int i = 0; i < noticeNums.size(); i++) {
	        	pstmt.setInt(i + 1, noticeNums.get(i)); // 1부터 시작하는 인덱스
            }
			
		//6.쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
		return rowCnt;
	}
	
	
	//===========================================================================================================================================================================================
	//===========================================================================================================================================================================================
	
//	FAQ
	
	public int selectTotalFaqCount(FilteringInfo fi) throws SQLException {
	    int cnt = 0;

	    DbConnection db = DbConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        // 1.JNDI 사용객체 생성
	        // 2.DBCP에서 연결객체 얻기(DataSource)
	        // 3.Connection 얻기
	        con = db.getDbConn();
	        
	        // 4.쿼리문 생성객체 얻기
	        StringBuilder selectFaq = new StringBuilder();
	        selectFaq.append("SELECT COUNT(*) AS cnt ")
	                 .append("FROM faq ")
	                 .append("WHERE 1=1 ");

	        // 검색 조건 처리
	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            if ("faq_title".equals(fi.getSearchCategory())) {
	                selectFaq.append("  AND faq_title LIKE ? ");
	            } else if ("faq_content".equals(fi.getSearchCategory())) {
	                selectFaq.append("  AND REGEXP_REPLACE(faq_content, '<[^>]*>', '') LIKE ? ");
	            }
	        }

	        // 날짜 필터링 (시간을 무시하고 날짜만 비교)
	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) BETWEEN TRUNC(?) AND TRUNC(?) ");
	        } else if (fi.getStartDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) >= TRUNC(?) ");
	        } else if (fi.getEndDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) <= TRUNC(?) ");
	        }

	        pstmt = con.prepareStatement(selectFaq.toString());

	        int paramIndex = 1;

	        // 검색 텍스트 바인딩
	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            pstmt.setString(paramIndex++, "%" + fi.getSearchText() + "%");
	        }

	        // 날짜 바인딩
	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        } else if (fi.getStartDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	        } else if (fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        }

	        // 6.쿼리문 수행 후 결과 얻기
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            cnt = rs.getInt("cnt");
	        }

	    } finally {
	        // 7.연결 끊기
	        db.dbClose(rs, pstmt, con);
	    }

	    return cnt;
	}
	
	public FaqDTO selectOneFaq(int num) throws SQLException {
	    FaqDTO fDTO = null;

	    DbConnection db = DbConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();
	        StringBuilder selectOneFaq = new StringBuilder();
	        selectOneFaq
	        .append("SELECT faq_num, faq_title, faq_content, faq_reg_date ")
	        .append("FROM faq ")
	        .append("WHERE faq_num = ?");

	        pstmt = con.prepareStatement(selectOneFaq.toString());
	        pstmt.setInt(1, num);

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	        	fDTO = new FaqDTO();
	        	fDTO.setFaq_num(rs.getInt("faq_num"));
	        	fDTO.setFaq_title(rs.getString("faq_title"));
	        	fDTO.setFaq_regDate(rs.getDate("faq_reg_date"));

	            StringBuilder tempContent = new StringBuilder();
	            String lineData = "";

	            Clob clob = rs.getClob("faq_content");
	            if (clob != null) {
	                try (BufferedReader br = new BufferedReader(clob.getCharacterStream())) {
	                    while ((lineData = br.readLine()) != null) {
	                        tempContent.append(lineData).append("\n");
	                    }
	                } catch (IOException e) {
	                    e.printStackTrace();
	                    tempContent.append("글 내용 읽기 실패");
	                }
	                fDTO.setFaq_content(tempContent.toString());
	            }
	        }
	    } finally {
	        db.dbClose(rs, pstmt, con);
	    }

	    return fDTO;
	}
	
	public List<FaqDTO> selectFaq(FilteringInfo fi) throws SQLException {

	    List<FaqDTO> list = new ArrayList<>();

	    DbConnection db = DbConnection.getInstance();

	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();
	        StringBuilder selectFaq = new StringBuilder();
	        selectFaq.append("SELECT faq_num, faq_title, faq_content, faq_reg_date ")
	                 .append("FROM ( ")
	                 .append("  SELECT faq_num, faq_title, faq_content, faq_reg_date, ")
	                 .append("  ROW_NUMBER() OVER (ORDER BY faq_reg_date DESC, faq_num DESC) rnum ")
	                 .append("  FROM faq ")
	                 .append("  WHERE 1=1 ");

	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            if ("faq_title".equals(fi.getSearchCategory())) {
	                selectFaq.append("  AND faq_title LIKE ? ");
	            } else if ("faq_content".equals(fi.getSearchCategory())) {
	                selectFaq.append("  AND REGEXP_REPLACE(faq_content, '<[^>]*>', '') LIKE ? ");
	            }
	        }

	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) BETWEEN TRUNC(?) AND TRUNC(?) ");
	        } else if (fi.getStartDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) >= TRUNC(?) ");
	        } else if (fi.getEndDate() != null) {
	            selectFaq.append("  AND TRUNC(faq_reg_date) <= TRUNC(?) ");
	        }

	        selectFaq.append(") WHERE rnum BETWEEN ? AND ? ");

	        pstmt = con.prepareStatement(selectFaq.toString());

	        int paramIndex = 1;

	        if (fi.getSearchText() != null && !"".equals(fi.getSearchText())) {
	            pstmt.setString(paramIndex++, "%" + fi.getSearchText() + "%");
	        }

	        if (fi.getStartDate() != null && fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        } else if (fi.getStartDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getStartDate().getTime()));
	        } else if (fi.getEndDate() != null) {
	            pstmt.setDate(paramIndex++, new java.sql.Date(fi.getEndDate().getTime()));
	        }

	        pstmt.setInt(paramIndex++, fi.getStartNum());
	        pstmt.setInt(paramIndex++, fi.getEndNum());

	        rs = pstmt.executeQuery();

	        FaqDTO fDTO = null;
	        while (rs.next()) {
	        	fDTO = new FaqDTO();
	        	fDTO.setFaq_num(rs.getInt("faq_num"));
	        	fDTO.setFaq_title(rs.getString("faq_title"));
	        	fDTO.setFaq_content(rs.getString("faq_content"));
	        	fDTO.setFaq_regDate(rs.getDate("faq_reg_date"));

	            list.add(fDTO);
	        }
	    } finally {
	        db.dbClose(rs, pstmt, con);
	    }

	    return list;
	}
	
	public int updateFaq(FaqDTO fDTO) throws SQLException {
	    int rowCnt = 0;
	    DbConnection db = DbConnection.getInstance();

	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();
	        StringBuilder updateFaq = new StringBuilder();
	        updateFaq
	        .append("UPDATE faq ")
	        .append("SET faq_title = ?, faq_content = ? ")
	        .append("WHERE faq_num = ?");

	        pstmt = con.prepareStatement(updateFaq.toString());
	        pstmt.setString(1, fDTO.getFaq_title());
	        pstmt.setString(2, fDTO.getFaq_content());
	        pstmt.setInt(3, fDTO.getFaq_num());

	        rowCnt = pstmt.executeUpdate();
	    } finally {
	        db.dbClose(null, pstmt, con);
	    }
	    return rowCnt;
	}
	
	
	public void insertFaq(FaqDTO fDTO) throws SQLException {
	    DbConnection db = DbConnection.getInstance();

	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();
	        StringBuilder insertFaq = new StringBuilder();
	        insertFaq
	        .append("INSERT INTO faq (faq_num, faq_title, faq_content) ")
	        .append("VALUES (faq_seq.nextval, ?, ?)");

	        pstmt = con.prepareStatement(insertFaq.toString());
	        pstmt.setString(1, fDTO.getFaq_title());
	        pstmt.setString(2, fDTO.getFaq_content());

	        pstmt.executeQuery();
	    } finally {
	        db.dbClose(null, pstmt, con);
	    }
	}
	
	
	public int deleteFaqs(List<Integer> faqNums) throws SQLException {
	    int rowCnt = 0;
	    DbConnection db = DbConnection.getInstance();

	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();
	        StringBuilder placeholders = new StringBuilder();
	        for (int i = 0; i < faqNums.size(); i++) {
	            placeholders.append("?");
	            if (i < faqNums.size() - 1) {
	                placeholders.append(", ");
	            }
	        }
	        String deleteQuery = "DELETE FROM faq WHERE faq_num IN (" + placeholders.toString() + ")";

	        pstmt = con.prepareStatement(deleteQuery);

	        for (int i = 0; i < faqNums.size(); i++) {
	            pstmt.setInt(i + 1, faqNums.get(i));
	        }

	        rowCnt = pstmt.executeUpdate();
	    } finally {
	        db.dbClose(null, pstmt, con);
	    }

	    return rowCnt;
	}
	
	
	//===========================================================================================================================================================================================
	//===========================================================================================================================================================================================
	
//	Inquiry
	
	
	 // 총 문의 건수 조회 (필터링 가능)
	public int selectTotalInquiryCount(InquiryFilteringInfo ifi) throws SQLException {
	    int cnt = 0;

	    DbConnection db = DbConnection.getInstance();
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Connection con = null;

	    try {
	        con = db.getDbConn();

	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT COUNT(*) AS cnt FROM inquiry WHERE 1=1 ");

	        // 검색 텍스트 조건
	        if (ifi.getSearchText() != null && !"".equals(ifi.getSearchText())) {
	            if ("inquiry_content".equals(ifi.getSearchCategory())) {
	                sql.append(" AND inquiry_content LIKE ? ");
	            } else if ("member_id".equals(ifi.getSearchCategory())) {
	                sql.append(" AND member_id LIKE ? ");
	            }
	        }

	        // 날짜 조건
	        if (ifi.getStartDate() != null && ifi.getEndDate() != null) {
	            sql.append(" AND TRUNC(inquiry_reg_date) BETWEEN TRUNC(?) AND TRUNC(?) ");
	        } else if (ifi.getStartDate() != null) {
	            sql.append(" AND TRUNC(inquiry_reg_date) >= TRUNC(?) ");
	        } else if (ifi.getEndDate() != null) {
	            sql.append(" AND TRUNC(inquiry_reg_date) <= TRUNC(?) ");
	        }

	        // 답변 상태 필터링
	        if (ifi.getAnswerStatus() != null) {
	            sql.append(" AND answer_status = ? ");
	        }

	        pstmt = con.prepareStatement(sql.toString());

	        int idx = 1;

	        // 바인딩 순서 중요!
	        if (ifi.getSearchText() != null && !"".equals(ifi.getSearchText())) {
	            pstmt.setString(idx++, "%" + ifi.getSearchText() + "%");
	        }

	        if (ifi.getStartDate() != null && ifi.getEndDate() != null) {
	            pstmt.setDate(idx++, new java.sql.Date(ifi.getStartDate().getTime()));
	            pstmt.setDate(idx++, new java.sql.Date(ifi.getEndDate().getTime()));
	        } else if (ifi.getStartDate() != null) {
	            pstmt.setDate(idx++, new java.sql.Date(ifi.getStartDate().getTime()));
	        } else if (ifi.getEndDate() != null) {
	            pstmt.setDate(idx++, new java.sql.Date(ifi.getEndDate().getTime()));
	        }

	        if (ifi.getAnswerStatus() != null) {
	            pstmt.setString(idx++, ifi.getAnswerStatus() ? "Y" : "N");
	        }

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            cnt = rs.getInt("cnt");
	        }

	    } finally {
	        db.dbClose(rs, pstmt, con);
	    }

	    return cnt;
	}


    // 단건 조회
    public InquiryDTO selectOneInquiry(int inquiryNum) throws SQLException {
        InquiryDTO iDTO = null;

        DbConnection db = DbConnection.getInstance();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = db.getDbConn();

            String sql = "SELECT inquiry_num, member_id, inquiry_content, inquiry_answer, answer_status, inquiry_reg_date, inquiry_answer_date FROM inquiry WHERE inquiry_num = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, inquiryNum);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                iDTO = new InquiryDTO();
                iDTO.setInquiry_num(rs.getInt("inquiry_num"));
                iDTO.setMember_id(rs.getString("member_id"));
                iDTO.setInquiry_content(rs.getString("inquiry_content"));
                iDTO.setInquiry_answer(rs.getString("inquiry_answer"));
                iDTO.setAnswer_status("Y".equalsIgnoreCase(rs.getString("answer_status")));
                iDTO.setInquiry_regDate(rs.getTimestamp("inquiry_reg_date"));
                iDTO.setInquiry_answerDate(rs.getTimestamp("inquiry_answer_date"));
            }
        } finally {
            db.dbClose(rs, pstmt, con);
        }

        return iDTO;
    }

    // 목록 조회 (페이징 및 필터링 포함)
    public List<InquiryDTO> selectInquiries(InquiryFilteringInfo ifi) throws SQLException {
        List<InquiryDTO> list = new ArrayList<>();

        DbConnection db = DbConnection.getInstance();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = db.getDbConn();
            System.out.println(ifi);
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT inquiry_num, member_id, inquiry_content, inquiry_answer, answer_status, inquiry_reg_date, inquiry_answer_date ")
               .append("FROM ( ")
               .append("  SELECT inquiry_num, member_id, inquiry_content, inquiry_answer, answer_status, inquiry_reg_date, inquiry_answer_date, ")
               .append("  ROW_NUMBER() OVER (ORDER BY inquiry_reg_date DESC, inquiry_num DESC) rnum ")
               .append("  FROM inquiry WHERE 1=1 ");

            // 검색어 조건
            if (ifi.getSearchText() != null && !"".equals(ifi.getSearchText())) {
                if ("inquiry_content".equals(ifi.getSearchCategory())) {
                    sql.append(" AND inquiry_content LIKE ? ");
                } else if ("member_id".equals(ifi.getSearchCategory())) {
                    sql.append(" AND member_id LIKE ? ");
                }
            }

            // 날짜 조건
            if (ifi.getStartDate() != null && ifi.getEndDate() != null) {
                sql.append(" AND TRUNC(inquiry_reg_date) BETWEEN TRUNC(?) AND TRUNC(?) ");
            } else if (ifi.getStartDate() != null) {
                sql.append(" AND TRUNC(inquiry_reg_date) >= TRUNC(?) ");
            } else if (ifi.getEndDate() != null) {
                sql.append(" AND TRUNC(inquiry_reg_date) <= TRUNC(?) ");
            }

            // ** answer_status 필터링 조건 추가 **
            // ifi.getAnswerStatus()가 null이면 필터링 안 함
            // true -> answer_status = 'Y', false -> answer_status = 'N'
            if (ifi.getAnswerStatus() != null) {
                sql.append(" AND answer_status = ? ");
            }

            sql.append(") WHERE rnum BETWEEN ? AND ? ");

            pstmt = con.prepareStatement(sql.toString());

            int idx = 1;

            // 검색어 바인딩
            if (ifi.getSearchText() != null && !"".equals(ifi.getSearchText())) {
                pstmt.setString(idx++, "%" + ifi.getSearchText() + "%");
                System.out.println("검색어 바인딩");
                System.out.println("searchText: " + ifi.getSearchText()); 
            }

            // 날짜 바인딩
            if (ifi.getStartDate() != null && ifi.getEndDate() != null) {
                pstmt.setDate(idx++, new java.sql.Date(ifi.getStartDate().getTime()));
                pstmt.setDate(idx++, new java.sql.Date(ifi.getEndDate().getTime()));
                System.out.println("getStartDate, endDate 바인딩");
                
            } else if (ifi.getStartDate() != null) {
                pstmt.setDate(idx++, new java.sql.Date(ifi.getStartDate().getTime()));
                System.out.println("getStartDate 바인딩");
            } else if (ifi.getEndDate() != null) {
                pstmt.setDate(idx++, new java.sql.Date(ifi.getEndDate().getTime()));
                System.out.println("getEndDate 바인딩");
            }

            // answer_status 바인딩
            if (ifi.getAnswerStatus() != null) {
                pstmt.setString(idx++, ifi.getAnswerStatus() ? "Y" : "N");
                
                System.out.println("answer_status 바인딩");
            }
            
            System.out.println("SQL: " + sql.toString());

            // 페이징 번호 바인딩
            pstmt.setInt(idx++, ifi.getStartNum());
            System.out.println("startnum바인딩");
            pstmt.setInt(idx++, ifi.getEndNum());
            System.out.println("endnum바인딩");
            System.out.println("최종 idx = " + idx);
            
            
//            System.out.println("searchCategory: " + ifi.getSearchCategory());
//            System.out.println("searchText: " + ifi.getSearchText());
//            System.out.println("startDate: " + ifi.getStartDate());
//            System.out.println("endDate: " + ifi.getEndDate());
//            System.out.println("answerStatus: " + ifi.getAnswerStatus());
//            System.out.println("startNum: " + ifi.getStartNum());
//            System.out.println("endNum: " + ifi.getEndNum());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                InquiryDTO iDTO = new InquiryDTO();
                iDTO.setInquiry_num(rs.getInt("inquiry_num"));
                iDTO.setMember_id(rs.getString("member_id"));
                iDTO.setInquiry_content(rs.getString("inquiry_content"));
                iDTO.setInquiry_answer(rs.getString("inquiry_answer"));
                iDTO.setAnswer_status("Y".equalsIgnoreCase(rs.getString("answer_status")));
                iDTO.setInquiry_regDate(rs.getTimestamp("inquiry_reg_date"));
                iDTO.setInquiry_answerDate(rs.getTimestamp("inquiry_answer_date"));
                list.add(iDTO);
            }
        } finally {
            db.dbClose(rs, pstmt, con);
        }

        return list;
    }

    // 문의 수정 (답변 포함)
    public int updateInquiry(InquiryDTO iDTO) throws SQLException {
        int rowCnt = 0;

        DbConnection db = DbConnection.getInstance();
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = db.getDbConn();

            String sql = "UPDATE inquiry SET  inquiry_answer = ?, answer_status = ?, inquiry_answer_date = ? WHERE inquiry_num = ?";

            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, iDTO.getInquiry_answer());
            pstmt.setString(2, iDTO.isAnswer_status() ? "Y" : "N");
            if (iDTO.getInquiry_answerDate() != null) {
                pstmt.setDate(3, new java.sql.Date(iDTO.getInquiry_answerDate().getTime()));
            } else {
                pstmt.setNull(3, java.sql.Types.DATE);
            }
            pstmt.setInt(4, iDTO.getInquiry_num());

            rowCnt = pstmt.executeUpdate();

        } finally {
            db.dbClose(null, pstmt, con);
        }

        return rowCnt;
    }

    // 문의 등록
    public void insertInquiry(InquiryDTO iDTO) throws SQLException {
        DbConnection db = DbConnection.getInstance();
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = db.getDbConn();

            String sql = "INSERT INTO inquiry (inquiry_num, member_id, inquiry_content, inquiry_reg_date, answer_status) "
                       + "VALUES (inquiry_seq.nextval, ?, ?, SYSDATE, 'N')";

            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, iDTO.getMember_id());
            pstmt.setString(2, iDTO.getInquiry_content());

            pstmt.executeUpdate();

        } finally {
            db.dbClose(null, pstmt, con);
        }
    }

    // 문의 삭제 (복수 가능)
    public int deleteInquiries(List<Integer> inquiryNums) throws SQLException {
        int rowCnt = 0;

        DbConnection db = DbConnection.getInstance();
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = db.getDbConn();

            StringBuilder placeholders = new StringBuilder();
            for (int i = 0; i < inquiryNums.size(); i++) {
                placeholders.append("?");
                if (i < inquiryNums.size() - 1) {
                    placeholders.append(", ");
                }
            }

            String sql = "DELETE FROM inquiry WHERE inquiry_num IN (" + placeholders.toString() + ")";

            pstmt = con.prepareStatement(sql);

            for (int i = 0; i < inquiryNums.size(); i++) {
                pstmt.setInt(i + 1, inquiryNums.get(i));
            }

            rowCnt = pstmt.executeUpdate();

        } finally {
            db.dbClose(null, pstmt, con);
        }

        return rowCnt;
    }


	
	
	




	
	
	
}
