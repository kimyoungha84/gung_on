package kr.co.gungon.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import kr.co.gungon.config.DbConnection;

public class AdminDashboardDAO {

    private static AdminDashboardDAO instance = null;

    private AdminDashboardDAO() {}
    

    public static AdminDashboardDAO getInstance() {
        if (instance == null) {
            instance = new AdminDashboardDAO();
        }
        return instance;
    }

    private int getCount(String sql) throws SQLException {
        int count = 0;
        
        DbConnection db = DbConnection.getInstance();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getDbConn();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return count;
    }

    // 오늘 가입자 수
    public int getTodayJoinMembers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM member WHERE TRUNC(member_reg_date) = TRUNC(SYSDATE)";
        return getCount(sql);
    }

    // 전체 회원 수
    public int getTotalMembers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM member WHERE member_flag = 'N'";
        return getCount(sql);
    }

    // 탈퇴 회원 수
    public int getWithdrawnMembers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM member WHERE member_flag = 'Y'";
        return getCount(sql);
    }

    // 공지사항 수
    public int getNoticeCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM notice";
        return getCount(sql);
    }

    // 미답변 문의 수
    public int getUnansweredInquiryCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM inquiry WHERE answer_status = 'N'";
        return getCount(sql);
    }

    // 답변 완료 문의 수
    public int getAnsweredInquiryCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM inquiry WHERE answer_status = 'Y'";
        return getCount(sql);
    }
    
 // 행사별 예매
    public Map<String, Integer> getReservationCountByProgram() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT p.program_name, COUNT(t.booking_num) AS reservation_count " +
                     "FROM program p " +
                     "LEFT JOIN ticket_reservation t ON p.program_id = t.program_id " +
                     "GROUP BY p.program_name " +
                     "ORDER BY p.program_name ASC";

        DbConnection db = DbConnection.getInstance();
        try (
            Connection conn = db.getDbConn();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            while (rs.next()) {
                result.put(rs.getString("program_name"), 
                		rs.getInt("reservation_count"));
            }
        }

        return result;
    }
    
    
}