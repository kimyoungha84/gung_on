package kr.co.gungon.program;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.program.ProgramDTO;
import kr.co.gungon.pagination.PageParam;

public class ProgramDAO {

    private static ProgramDAO pDAO = null;

    private ProgramDAO() {}

    public static ProgramDAO getInstance() {
        if (pDAO == null) {
            pDAO = new ProgramDAO();
        }
        return pDAO;
    }

    public ArrayList<ProgramDTO> selectProgramsByDate(Date date) throws SQLException {
        ArrayList<ProgramDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM program WHERE ? BETWEEN start_date AND end_date";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            pstmt = con.prepareStatement(sql);
            pstmt.setDate(1, date);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProgramDTO dto = new ProgramDTO(
                    rs.getInt("program_id"),
                    rs.getString("program_place"),
                    rs.getString("program_name"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getTimestamp("reservation_start_date"),
                    rs.getTimestamp("reservation_end_date"),
                    rs.getTimestamp("open_time"),
                    rs.getTimestamp("close_time"),
                    rs.getInt("price_adult"),
                    rs.getInt("price_child"),
                    rs.getString("language_korean"),
                    rs.getString("contact_person"),
                    rs.getString("prog_img_name")
                );
                list.add(dto);
            }

        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, con);
        }

        return list;
    }
    
    public ArrayList<ProgramDTO> selectAllPrograms() throws SQLException {
        ArrayList<ProgramDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM program ORDER BY program_id";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProgramDTO dto = new ProgramDTO(
                    rs.getInt("program_id"),
                    rs.getString("program_place"),
                    rs.getString("program_name"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getTimestamp("reservation_start_date"),
                    rs.getTimestamp("reservation_end_date"),
                    rs.getTimestamp("open_time"),
                    rs.getTimestamp("close_time"),
                    rs.getInt("price_adult"),
                    rs.getInt("price_child"),
                    rs.getString("language_korean"),
                    rs.getString("contact_person"),
                    rs.getString("prog_img_name")
                );
                list.add(dto);
            }

        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, con);
        }

        return list;
    }

    public ProgramDTO selectProgramByName(String programName) throws SQLException {
        ProgramDTO dto = null;
        String sql = "SELECT program_id, program_place, program_name, start_date, end_date, " +
                     "reservation_start_date, reservation_end_date, open_time, close_time, " +
                     "price_adult, price_child, language_korean, contact_person, prog_img_name " +
                     "FROM program WHERE program_name = ?";

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, programName);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new ProgramDTO(
                        rs.getInt("program_id"),
                        rs.getString("program_place"),
                        rs.getString("program_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getTimestamp("reservation_start_date"),
                        rs.getTimestamp("reservation_end_date"),
                        rs.getTimestamp("open_time"),
                        rs.getTimestamp("close_time"),
                        rs.getInt("price_adult"),
                        rs.getInt("price_child"),
                        rs.getString("language_korean"),
                        rs.getString("contact_person"),
                        rs.getString("prog_img_name")
                    );
                }
            }
        }

        return dto;
    }
    
    public ProgramDTO selectProgramByProgramName(String programName) throws SQLException {
        ProgramDTO dto = null;
        String sql = "SELECT program_id, program_name, program_place, open_time, close_time, " +
                "price_adult, price_child, contact_person, language_korean, start_date, end_date, prog_img_name, " +
                "CAST(start_date - 7 + (12/24) AS TIMESTAMP) AS reservation_start_date, " +
                "CAST(end_date - 1 + (18/24) AS TIMESTAMP) AS reservation_end_date " +
                "FROM program WHERE program_name = ?";

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, programName);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new ProgramDTO();
                    dto.setProgramId(rs.getInt("program_id"));
                    dto.setProgramName(rs.getString("program_name"));
                    dto.setProgramPlace(rs.getString("program_place"));
                    dto.setOpenTime(rs.getTimestamp("open_time"));
                    dto.setCloseTime(rs.getTimestamp("close_time"));
                    dto.setPriceAdult(rs.getInt("price_adult"));
                    dto.setPriceChild(rs.getInt("price_child"));
                    dto.setContactPerson(rs.getString("contact_person"));
                    dto.setLanguageKorean(rs.getString("language_korean"));
                    dto.setStartDate(rs.getDate("start_date"));
                    dto.setEndDate(rs.getDate("end_date"));
                    dto.setReservationStartDate(rs.getTimestamp("reservation_start_date"));
                    dto.setReservationEndDate(rs.getTimestamp("reservation_end_date"));
                    dto.setProgImgName(rs.getString("prog_img_name"));
                }
            }
        }

        return dto;
    }

    public List<ProgramDTO> selectProgramsByProgramPlace(String programPlace) throws SQLException {
        List<ProgramDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM program WHERE program_place = ? ORDER BY open_time";

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, programPlace);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProgramDTO dto = new ProgramDTO(
                        rs.getInt("program_id"),
                        rs.getString("program_place"),
                        rs.getString("program_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getTimestamp("reservation_start_date"),
                        rs.getTimestamp("reservation_end_date"),
                        rs.getTimestamp("open_time"),
                        rs.getTimestamp("close_time"),
                        rs.getInt("price_adult"),
                        rs.getInt("price_child"),
                        rs.getString("language_korean"),
                        rs.getString("contact_person"),
                        rs.getString("prog_img_name")
                    );
                    list.add(dto);
                }
            }
        }
        return list;
    }
    
    public int insertProgram(ProgramDTO dto) throws SQLException {
        int result = 0;
        String sql = "INSERT INTO program (" +
                "program_place, program_name, " +
                "start_date, end_date, open_time, close_time, " +
                "price_adult, price_child, language_korean, contact_person, " +
                "prog_img_name" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getProgramPlace());
            pstmt.setString(2, dto.getProgramName());
            pstmt.setDate(3, dto.getStartDate());
            pstmt.setDate(4, dto.getEndDate());
            pstmt.setTimestamp(5, dto.getOpenTime());
            pstmt.setTimestamp(6, dto.getCloseTime());
            pstmt.setInt(7, dto.getPriceAdult());
            pstmt.setInt(8, dto.getPriceChild());
            pstmt.setString(9, dto.getLanguageKorean());
            pstmt.setString(10, dto.getContactPerson());
            pstmt.setString(11, dto.getProgImgName());

            result = pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }

        return result;
    }
    
    public int updateProgram(ProgramDTO dto) throws SQLException {
        int result = 0;
        String sql = "UPDATE program SET " +
                "program_place = ?, program_name = ?, " +
                "start_date = ?, end_date = ?, open_time = ?, close_time = ?, " +
                "price_adult = ?, price_child = ?, language_korean = ?, " +
                "contact_person = ?, prog_img_name = ? " +
                "WHERE program_name = ?";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, dto.getProgramPlace());
            pstmt.setString(2, dto.getProgramName());
            pstmt.setDate(3, dto.getStartDate());
            pstmt.setDate(4, dto.getEndDate());
            pstmt.setTimestamp(5, dto.getOpenTime());
            pstmt.setTimestamp(6, dto.getCloseTime());
            pstmt.setInt(7, dto.getPriceAdult());
            pstmt.setInt(8, dto.getPriceChild());
            pstmt.setString(9, dto.getLanguageKorean());
            pstmt.setString(10, dto.getContactPerson());
            pstmt.setString(11, dto.getProgImgName());
            pstmt.setString(12, dto.getProgramName());

            result = pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }

        return result;
    }
    
    public int deleteProgram(int programId) throws SQLException {
        int result = 0;
        String sql = "DELETE FROM program WHERE program_id = ?";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, programId);

            result = pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(null, pstmt, con);
        }

        return result;
    }
    
    public List<ProgramDTO> selectProgramsByPage(PageParam pageParam) throws SQLException {
        List<ProgramDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM ("
                   + " SELECT ROWNUM rnum, a.* FROM ("
                   + "   SELECT * FROM program ORDER BY program_id DESC"
                   + " ) a WHERE ROWNUM <= ?"
                   + ") WHERE rnum >= ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pageParam.getEndRow());
            pstmt.setInt(2, pageParam.getStartRow());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProgramDTO dto = new ProgramDTO();
                dto.setProgramId(rs.getInt("program_id"));
                dto.setProgramName(rs.getString("program_name"));
                dto.setProgramPlace(rs.getString("program_place"));
                dto.setStartDate(rs.getDate("start_date"));
                dto.setEndDate(rs.getDate("end_date"));
                dto.setContactPerson(rs.getString("contact_person"));
                list.add(dto);
            }
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, conn);
        }

        return list;
    }
    
    public int selectTotalCount() throws SQLException {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM program";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, conn);
        }

        return total;
    }
    
}