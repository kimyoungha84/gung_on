package kr.co.gungon.admin;

import java.sql.*;
import kr.co.gungon.config.DbConnection;

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
}