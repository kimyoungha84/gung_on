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
			.append("	select member_id, member_name, member_tel, member_email, member_ip,member_reg_date	")
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
				
			}//end if
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally
		return mDTO;

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
	
}// class
