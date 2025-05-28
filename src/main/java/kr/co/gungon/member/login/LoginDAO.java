package kr.co.gungon.member.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.member.MemberDTO;

public class LoginDAO {

		private static LoginDAO lDAO;
		private LoginDAO() {
		}
		
		public static LoginDAO getInstance() {
			if(lDAO==null) {
				lDAO = new LoginDAO();
			}//end if
			return lDAO;
		}//getInstance
		
	public MemberDTO selectId(LoginDTO lDTO) throws SQLException {
		MemberDTO mDTO=null;

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
			StringBuilder selectLoginInfo = new StringBuilder();
			selectLoginInfo
			.append("	select member_name,member_email,member_tel,member_flag ")
			.append("	from member	")
			.append("	where member_id=? and member_pass=?	");

			pstmt = con.prepareStatement(selectLoginInfo.toString());
			// 5.바인드변수에 값 할당
			pstmt.setString(1, lDTO.getId());
			pstmt.setString(2, lDTO.getPass());
			// 6.쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mDTO= new MemberDTO();
				mDTO.setId(lDTO.getId()); //parameter로 입력된 아이디 사용.
				mDTO.setName(rs.getString("member_name")); //암호화된 데이터
				mDTO.setUseEmail(rs.getString("member_email")); //암호화된 데이터
				mDTO.setTel(rs.getString("member_tel")); //암호화된 데이터
				mDTO.setFlag(rs.getString("member_flag")); //암호화된 데이터
				
			}// 검색결과가 있다면 DTO객체에 값을 생성
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // end finally

		return mDTO;
	}// selectId
}//class
