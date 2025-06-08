package kr.co.gungon.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;


public class MemberDAO {

	private static MemberDAO mDAO;

	private MemberDAO() {

	}// MemberDAO

	public static MemberDAO getInstance() {
		if (mDAO == null) {
			mDAO = new MemberDAO();
		} // end if
		return mDAO;
	}// getInstance

	/**
	 * 입력받은 아이디를 검색하는 일
	 * 
	 * @param id 검색할 아이디
	 * @return 검색된 아이디
	 * @throws SQLException
	 */
	public boolean selectId(String id) throws SQLException {
		boolean flag = false;

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
			StringBuilder selectIdQuery = new StringBuilder();
			selectIdQuery
			.append("	select member_id	")
			.append("	from member	")
			.append("	where member_id=?	");

			pstmt = con.prepareStatement(selectIdQuery.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, id);
			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			flag = rs.next();// 검색결과 있으면 true | false
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally

		return flag;
	}// selectId

	public void insertMember(MemberDTO mDTO) throws SQLException {

		DbConnection db = DbConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder insertWebMember = new StringBuilder();
			insertWebMember.append("	insert into member	")
					.append("	(member_id, member_pass, member_name, member_tel, member_email, member_ip)	")
					.append("	values(?,?,?,?,?,?)	");

			pstmt = con.prepareStatement(insertWebMember.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, mDTO.getId());
			pstmt.setString(2, mDTO.getPass());
			pstmt.setString(3, mDTO.getName());
			pstmt.setString(4, mDTO.getTel());
			pstmt.setString(5, mDTO.getUseEmail());
			pstmt.setString(6, mDTO.getIp());
			// 6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
		} finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally

	}// insertMember

	public List<MemberDTO> selectAllMember() throws SQLException {

		List<MemberDTO> list = new ArrayList<MemberDTO>();
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
			StringBuilder selectIdQuery = new StringBuilder();
			selectIdQuery
			.append("	select member_id, member_name, member_tel, member_email, member_ip,member_reg_date	")
			.append("	from member	");

			pstmt = con.prepareStatement(selectIdQuery.toString());
			// 5.바인드변수에 값 할당
			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			MemberDTO mDTO =null;
			while(rs.next()) {
				mDTO=new MemberDTO();
				mDTO.setId(rs.getString("member_id"));
				mDTO.setName(rs.getString("member_name"));
				mDTO.setTel(rs.getString("member_tel"));
				mDTO.setUseEmail(rs.getString("member_email"));
				mDTO.setIp(rs.getString("member_ip"));
				mDTO.setInput_date(rs.getDate("member_reg_date"));
				
				list.add(mDTO);
			}//end while
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally
		return list;

	}// selectAllMember

	public MemberDTO selectOneMember(String id) throws SQLException {

		MemberDTO mDTO = null;
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
			StringBuilder selectIdQuery = new StringBuilder();
			selectIdQuery
			.append("	select member_id, member_name, member_tel, member_email, member_ip,member_reg_date, member_flag	")
			.append("	from member	")
			.append("	where member_id=?	")
			;

			pstmt = con.prepareStatement(selectIdQuery.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, id);
			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mDTO=new MemberDTO();
				mDTO.setId(rs.getString("member_id"));
				mDTO.setName(rs.getString("member_name"));
				mDTO.setTel(rs.getString("member_tel"));
				mDTO.setUseEmail(rs.getString("member_email"));
				mDTO.setIp(rs.getString("member_ip"));
				mDTO.setInput_date(rs.getDate("member_reg_date"));
				mDTO.setFlag(rs.getString("member_flag"));
				
			}//end if
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally
		return mDTO;

	}// selectOneMember
	
	public String selectMemberName(String name, String email) throws SQLException {

		
		String id = "";
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
			StringBuilder selectIdQuery = new StringBuilder();
			selectIdQuery
			.append("	select member_id	")
			.append("	from member	")
			.append("	where member_email=? and member_name=?	")
			;

			pstmt = con.prepareStatement(selectIdQuery.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("member_id");
				
			}//end if
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally
		return id;

	}// selectOneMember
	
	public void updateMember(MemberDTO mDTO) throws SQLException {

		DbConnection db = DbConnection.getInstance();

		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder updateWebMember = new StringBuilder();
			updateWebMember
					.append("	update member	")
					.append("	set member_tel=?,member_email=?	")
					.append("	where member_id=?	");

			pstmt = con.prepareStatement(updateWebMember.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, mDTO.getTel());
			pstmt.setString(2, mDTO.getUseEmail());
			pstmt.setString(3, mDTO.getId());
			// 6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
		} finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally

	}// updateMember
	
	
	public void updateMemberPass(String id, String pass) throws SQLException {
		
		DbConnection db = DbConnection.getInstance();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder updateWebMember = new StringBuilder();
			updateWebMember
			.append("	update member	")
			.append("	set member_pass=?	")
			.append("	where member_id=?	");
			
			pstmt = con.prepareStatement(updateWebMember.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, pass);
			pstmt.setString(2, id);
			// 6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
		} finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally
		
	}// updateMember
	
	public void deleteMember(MemberDTO mDTO) throws SQLException {
		
		DbConnection db = DbConnection.getInstance();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder updateWebMember = new StringBuilder();
			updateWebMember
			.append("	update member	")
			.append("	set member_flag=?	")
			.append("	where member_id=?	");
			
			pstmt = con.prepareStatement(updateWebMember.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, "Y");
			pstmt.setString(2, mDTO.getId());
			// 6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
		} finally {
			// 7.연결 끊기
			db.dbClose(null, pstmt, con);
		} // end finally
		
	}// updateMember
	
	//관리자 id로 개별정보 조회
		public MemberDTO selectMemberById(String id) throws SQLException {
			
			DbConnection db = DbConnection.getInstance();
			
		    MemberDTO dto = null;
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;

		    try {
		        // 커넥션 얻기
		        conn = db.getDbConn();

		        String sql = "SELECT * FROM member WHERE member_id = ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, id);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            dto = new MemberDTO();
		            dto.setId(rs.getString("member_id"));
		            dto.setPass(rs.getString("member_pass"));
		            dto.setName(rs.getString("member_name"));
		            dto.setTel(rs.getString("member_tel"));
		            dto.setEmail(rs.getString("member_email"));
		            dto.setIp(rs.getString("member_ip"));
		            dto.setFlag(rs.getString("member_flag"));
		            dto.setInput_date(rs.getDate("member_reg_date"));
		        }
		    } finally {
		        db.dbClose(rs, pstmt, conn);
		    }

		    return dto;
		}
		
		//관리자 회원정보 수정
		public void updateMemberInfo(MemberDTO mDTO) throws SQLException {

		    DbConnection db = DbConnection.getInstance();
		    PreparedStatement pstmt = null;
		    Connection con = null;

		    try {
		        con = db.getDbConn();

		        StringBuilder updateQuery = new StringBuilder();
		        updateQuery
		            .append(" UPDATE member ")
		            .append(" SET member_name = ?, member_tel = ?, member_email = ? ")
		            .append(" WHERE member_id = ? ");

		        pstmt = con.prepareStatement(updateQuery.toString());
		        pstmt.setString(1, mDTO.getName());
		        pstmt.setString(2, mDTO.getTel());
		        pstmt.setString(3, mDTO.getUseEmail());
		        pstmt.setString(4, mDTO.getId());

		        pstmt.executeUpdate();
		    } finally {
		        db.dbClose(null, pstmt, con);
		    }
		}
		
		public List<MemberDTO> selectAllMemberAdmin() throws SQLException {

			List<MemberDTO> list = new ArrayList<MemberDTO>();
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
				StringBuilder selectIdQuery = new StringBuilder();
				selectIdQuery
				.append("	select member_id, member_name, member_tel, member_email, member_ip,member_reg_date,member_flag	")
				.append("	from member	");

				pstmt = con.prepareStatement(selectIdQuery.toString());
				// 5.바인드변수에 값 할당
				// 6.쿼리문 수행 후 결과 얻기
				rs = pstmt.executeQuery();
				
				MemberDTO mDTO =null;
				while(rs.next()) {
					mDTO=new MemberDTO();
					mDTO.setId(rs.getString("member_id"));
					mDTO.setName(rs.getString("member_name"));
					mDTO.setTel(rs.getString("member_tel"));
					mDTO.setUseEmail(rs.getString("member_email"));
					mDTO.setIp(rs.getString("member_ip"));
					mDTO.setInput_date(rs.getDate("member_reg_date"));
					mDTO.setFlag(rs.getString("member_flag"));
					
					list.add(mDTO);
				}//end while
			} finally {
				// 7.연결 끊기
				db.dbClose(rs, pstmt, con);
			} // end finally
			return list;

		}// selectAllMember
	
}// class
