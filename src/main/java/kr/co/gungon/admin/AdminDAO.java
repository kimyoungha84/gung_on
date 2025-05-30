package kr.co.gungon.admin;

import java.sql.*;
import kr.co.gungon.config.DbConnection;
import kr.co.gungon.util.PasswordHasher;

public class AdminDAO {
    private static AdminDAO instance = new AdminDAO();
    private AdminDAO() {}
    public static AdminDAO getInstance() {
        return instance;
    }

    private DbConnection dbConn = DbConnection.getInstance();

    public AdminDTO login(String admin_id, String input_pass) {
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
                boolean isHashed = storedPass.length() == 64;
                String toCompare = isHashed ? PasswordHasher.hashPassword(input_pass) : input_pass;

                if (storedPass.equals(toCompare)) {
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