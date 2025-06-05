package kr.co.gungon.program;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.program.ProgramDTO;
import kr.co.gungon.config.DbConnection;
import kr.co.gungon.program.PageParam;

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
                    rs.getString("contact_person")
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
                    rs.getString("contact_person")
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
                     "price_adult, price_child, language_korean, contact_person " +
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
                        rs.getString("contact_person")
                    );
                }
            }
        }

        return dto;
    }
    
    public ProgramDTO selectProgramByProgramName(String programName) throws SQLException {
        ProgramDTO dto = null;
        String sql = "SELECT program_id, program_name, program_place, open_time, close_time, " +
                "price_adult, price_child, contact_person, language_korean, start_date, end_date, " +
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
                        rs.getString("contact_person")
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
                "program_id, program_place, program_name, " +
                "start_date, end_date, open_time, close_time, " +
                "price_adult, price_child, language_korean, contact_person, " +
                "reservation_start_date, reservation_end_date" +
                ") VALUES (program_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DbConnection.getInstance().getDbConn();
            // GENERATED_KEYS 설정
            pstmt = con.prepareStatement(sql, new String[] {"program_id"});

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
            
            // 예약 시작일: 행사 시작일 7일 전 + 12시간
            long startMillis = dto.getStartDate().getTime() - 7L * 24 * 60 * 60 * 1000 + 12L * 60 * 60 * 1000;
            Timestamp reservationStart = new Timestamp(startMillis);

            // 예약 종료일: 행사 종료일 1일 전 + 18시간
            long endMillis = dto.getEndDate().getTime() - 1L * 24 * 60 * 60 * 1000 + 18L * 60 * 60 * 1000;
            Timestamp reservationEnd = new Timestamp(endMillis);

            pstmt.setTimestamp(11, reservationStart);
            pstmt.setTimestamp(12, reservationEnd);

            result = pstmt.executeUpdate();
            
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                result = rs.getInt(1);
                dto.setProgramId(result);
            }
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, con);
        }

        return result;
    }
    
    public int updateProgram(ProgramDTO dto) throws SQLException {
        int result = 0;
        String sql = "UPDATE program SET " +
                "program_place = ?, program_name = ?, " +
                "start_date = ?, end_date = ?, open_time = ?, close_time = ?, " +
                "price_adult = ?, price_child = ?, language_korean = ?, " +
                "contact_person = ?, " +
                "reservation_start_date = ?, reservation_end_date = ? " +
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
            
            // 예약 시작일: 행사 시작일 7일 전 + 12시간
            long startMillis = dto.getStartDate().getTime() - 7L * 24 * 60 * 60 * 1000 + 12L * 60 * 60 * 1000;
            Timestamp reservationStart = new Timestamp(startMillis);

            // 예약 종료일: 행사 종료일 1일 전 + 18시간
            long endMillis = dto.getEndDate().getTime() - 1L * 24 * 60 * 60 * 1000 + 18L * 60 * 60 * 1000;
            Timestamp reservationEnd = new Timestamp(endMillis);

            pstmt.setTimestamp(11, reservationStart);
            pstmt.setTimestamp(12, reservationEnd);
            
            pstmt.setString(13, dto.getProgramName()); // WHERE 조건

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
        
        String baseSql = "SELECT * FROM program";
        String condition = "";
        if (pageParam.getSearchPlace() != null && !pageParam.getSearchPlace().isEmpty()) {
            condition = " WHERE program_place LIKE ?";
        }

        String sql = "SELECT * FROM ("
                   + " SELECT ROWNUM rnum, a.* FROM ("
                   + "   " + baseSql + condition + " ORDER BY program_id DESC"
                   + " ) a WHERE ROWNUM <= ?"
                   + ") WHERE rnum >= ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();
            pstmt = conn.prepareStatement(sql);

            int paramIndex = 1;
            if (!condition.isEmpty()) {
                pstmt.setString(paramIndex++, "%" + pageParam.getSearchPlace() + "%");
            }
            pstmt.setInt(paramIndex++, pageParam.getEndRow());
            pstmt.setInt(paramIndex, pageParam.getStartRow());

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
    
    public int selectTotalCount(String searchPlace) throws SQLException {
        int total = 0;

        String sql = "SELECT COUNT(*) FROM program";
        boolean hasSearch = searchPlace != null && !searchPlace.isEmpty();

        if (hasSearch) {
            sql += " WHERE program_place LIKE ?";
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();
            pstmt = conn.prepareStatement(sql);
            if (hasSearch) {
                pstmt.setString(1, "%" + searchPlace + "%");
            }
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