package kr.co.gungon.admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.member.MemberDTO;

public class AdminDAO {
    private static AdminDAO instance = new AdminDAO();
    private AdminDAO() {}
    public static AdminDAO getInstance() {
        return instance;
    }

    private DbConnection dbConn = DbConnection.getInstance();

    
     //로그인 시도: admin_id로 조회 후 SHA-256으로 암호화한 비밀번호 비교
     
    public AdminDTO login(String admin_id, String hashedPw) {
        AdminDTO admin = null;
        String sql = "SELECT * FROM admin WHERE admin_id=?";

        try (
            Connection conn = dbConn.getDbConn();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, admin_id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPass = rs.getString("admin_pass");

                if (storedPass.equals(hashedPw)) {
                    admin = new AdminDTO();
                    admin.setAdmin_id(admin_id);
                    admin.setAdmin_pass(storedPass);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }

    
     //관리자 비밀번호 업데이트
     
    public void updatePassword(String admin_id, String hashedPassword) {
        String sql = "UPDATE admin SET admin_pass=? WHERE admin_id=?";
        try (
            Connection conn = dbConn.getDbConn();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, admin_id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int getMemberCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM member";
        try (
            Connection conn = DbConnection.getInstance().getDbConn();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public List<MemberDTO> getMemberList(int start, int end) throws SQLException {
    	
    	DbConnection db = DbConnection.getInstance();
		
	    MemberDTO mDTO = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<MemberDTO> list = new ArrayList<>();
    	
	    try {
	    	conn = db.getDbConn();
	    	
	    	String sql = "SELECT * FROM (SELECT ROWNUM rnum, A.* FROM " +
                     "(SELECT * FROM member ORDER BY member_reg_date DESC) A) " +
                     "WHERE rnum BETWEEN ? AND ?";
	    	
	    	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, end);
            pstmt.executeQuery();
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	mDTO = new MemberDTO();
            	mDTO.setId(rs.getString("member_id"));
            	mDTO.setPass(rs.getString("member_pass"));
            	mDTO.setName(rs.getString("member_name"));
            	mDTO.setTel(rs.getString("member_tel"));
            	mDTO.setUseEmail(rs.getString("member_email"));
            	mDTO.setIp(rs.getString("member_ip"));
            	mDTO.setFlag(rs.getString("member_flag"));
            	mDTO.setInput_date(rs.getDate("member_reg_date"));
                list.add(mDTO);
            }
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return list;
    }
    
}