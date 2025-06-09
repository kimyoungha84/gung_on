package kr.co.gungon.gung;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.file.FilePathDTO;

public class GungDAO {

    // 🔥 이미지 경로까지 조인해서 가져오는 메서드
    public GungDTO getGungByName(String gungName) {
        GungDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();

            String sql = """
                SELECT 
                    g.gung_id,
                    g.gung_name,
                    g.gung_info,
                    g.gung_history,
                    g.gung_reg_date,
                    f.path AS img_path
                FROM gung g
                LEFT JOIN file_path f
                    ON f.targer_type = 'gung'
                    AND f.targer_number = TO_CHAR(g.gung_id)
                WHERE g.gung_name = ?
            """;

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, gungName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new GungDTO();
                dto.setGung_id(rs.getInt("gung_id"));
                dto.setGung_name(rs.getString("gung_name"));
                dto.setGung_info(rs.getString("gung_info"));
                dto.setGung_history(rs.getString("gung_history"));
                dto.setGung_reg_date(rs.getDate("gung_reg_date"));
                dto.setImg_path(rs.getString("img_path"));  // ✅ 이 줄 꼭 추가
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                DbConnection.getInstance().dbClose(rs, pstmt, conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return dto;
    }

    public List<GungDTO> selectAll() {
        List<GungDTO> list = new ArrayList<>();
        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM gung ORDER BY gung_id");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                GungDTO dto = new GungDTO();
                dto.setGung_id(rs.getInt("gung_id"));
                dto.setGung_name(rs.getString("gung_name"));
                dto.setGung_info(rs.getString("gung_info"));
                dto.setGung_reg_date(rs.getDate("gung_reg_date"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public GungDTO selectById(int gungId) {
        GungDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();
            String sql = "SELECT \r\n"
            		+ "    g.*, \r\n"
            		+ "    f.path AS gung_img \r\n"
            		+ "FROM gung g\r\n"
            		+ "LEFT JOIN file_path f\r\n"
            		+ "  ON f.targer_type = 'gung'\r\n"
            		+ " AND f.targer_number = TO_CHAR(g.gung_id)\r\n"
            		+ "WHERE g.gung_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, gungId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new GungDTO();
                dto.setGung_id(rs.getInt("gung_id"));
                dto.setGung_name(rs.getString("gung_name"));
                dto.setGung_info(rs.getString("gung_info"));
                dto.setGung_history(rs.getString("gung_history"));
                dto.setGung_reg_date(rs.getDate("gung_reg_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                DbConnection.getInstance().dbClose(rs, pstmt, conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return dto;
    }

    /**
     * 궁 수정
     */
    public boolean modifyGung(GungDTO dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            conn = DbConnection.getInstance().getDbConn();
            String sql = "UPDATE gung SET gung_name = ?, gung_info = ?, gung_history = ? WHERE gung_id = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getGung_name());
            pstmt.setString(2, dto.getGung_info());
            pstmt.setString(3, dto.getGung_history());
            pstmt.setInt(4, dto.getGung_id());

            int count = pstmt.executeUpdate();
            result = count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                DbConnection.getInstance().dbClose(null, pstmt, conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    /**
     * 궁 삭제
     */
    public boolean deleteGung(int gungId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;

        try {
            conn = DbConnection.getInstance().getDbConn();
            String sql = "DELETE FROM gung WHERE gung_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, gungId);

            int count = pstmt.executeUpdate();
            result = count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                DbConnection.getInstance().dbClose(null, pstmt, conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }
    public boolean insertGung(GungDTO dto) {
        boolean result = false;
        String sql = "INSERT INTO gung (gung_id, gung_name, gung_info, gung_reg_date) VALUES (?, ?, ?, SYSDATE)";

        try (Connection conn = DbConnection.getInstance().getDbConn()) {
            // gung_id 자동 생성 (예: MAX + 1 방식)
            String idSql = "SELECT NVL(MAX(gung_id), 0) + 1 FROM gung";
            int gungId = 0;

            try (PreparedStatement idPstmt = conn.prepareStatement(idSql);
                 ResultSet rs = idPstmt.executeQuery()) {
                if (rs.next()) {
                    gungId = rs.getInt(1);
                }
            }

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, gungId);
                pstmt.setString(2, dto.getGung_name());
                pstmt.setString(3, dto.getGung_info());
                int affected = pstmt.executeUpdate();
                result = affected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }



}
