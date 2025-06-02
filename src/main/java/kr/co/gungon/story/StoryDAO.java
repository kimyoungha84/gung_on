package kr.co.gungon.story;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;

public class StoryDAO {
	public StoryDTO getStoryById(int storyId) {
	    StoryDTO dto = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DbConnection.getInstance().getDbConn();
	        String sql = """
	            SELECT s.*, g.gung_name
	            FROM story s
	            JOIN gung g ON s.gung_id = g.gung_id
	            WHERE s.story_id = ?
	        """;
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, storyId);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            dto = new StoryDTO();
	            dto.setStory_id(rs.getInt("story_id"));
	            dto.setStory_name(rs.getString("story_name"));
	            dto.setStory_info(rs.getString("story_info"));
	            dto.setStory_reg_date(rs.getDate("story_reg_date"));
	            dto.setGung_id(rs.getInt("gung_id"));
	            dto.setGung_name(rs.getString("gung_name"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { DbConnection.getInstance().dbClose(rs, pstmt, conn); } catch (Exception e) {}
	    }

	    return dto;
	}

	
	public StoryDTO getStoryByName(String storyName) {
	    StoryDTO sDTO = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DbConnection.getInstance().getDbConn();
	        String sql = "SELECT * FROM story WHERE LOWER(TRIM(STORY_NAME)) = LOWER(TRIM(?))";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, storyName);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            sDTO = new StoryDTO();
	            sDTO.setStory_id(rs.getInt("story_id"));
	            sDTO.setStory_name(rs.getString("story_name"));
	            sDTO.setStory_info(rs.getString("story_info"));
	            sDTO.setStory_img(rs.getString("story_img"));
	            sDTO.setStory_reg_date(rs.getDate("story_reg_date"));
	            sDTO.setGung_id(rs.getInt("gung_id"));
	        } else {
	            System.out.println("[DAO] 결과 없음: '" + storyName + "'");
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

	    return sDTO;
	}//getStoryByName
	public List<StoryDTO> findByTitle(String title) {
	    List<StoryDTO> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DbConnection.getInstance().getDbConn();
	        String sql = """
	            SELECT s.story_id, s.story_name, s.story_info, s.story_reg_date,
	                   s.gung_id, g.gung_name
	            FROM story s
	            JOIN gung g ON s.gung_id = g.gung_id
	            WHERE s.story_name LIKE ?
	            ORDER BY s.story_id
	        """;
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, "%" + title + "%");
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            StoryDTO dto = new StoryDTO();
	            dto.setStory_id(rs.getInt("story_id"));
	            dto.setStory_name(rs.getString("story_name"));
	            dto.setStory_info(rs.getString("story_info"));
	            dto.setStory_reg_date(rs.getDate("story_reg_date"));
	            dto.setGung_id(rs.getInt("gung_id"));
	            dto.setGung_name(rs.getString("gung_name")); // ✅ 꼭 필요
	            list.add(dto);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try { DbConnection.getInstance().dbClose(rs, pstmt, conn); } catch (Exception e) {}
	    }

	    return list;
	}

	
	
	public List<StoryDTO> selectAllStory() {
	    List<StoryDTO> list = new ArrayList<>();

	    String sql = """
	        SELECT s.story_id, s.story_name, s.story_info, s.story_reg_date,
	               s.gung_id, g.gung_name
	        FROM story s
	        JOIN gung g ON s.gung_id = g.gung_id
	        ORDER BY s.story_id
	    """;

	    try (Connection conn = DbConnection.getInstance().getDbConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            StoryDTO dto = new StoryDTO();
	            dto.setStory_id(rs.getInt("story_id"));
	            dto.setStory_name(rs.getString("story_name"));
	            dto.setStory_info(rs.getString("story_info"));
	            dto.setStory_reg_date(rs.getDate("story_reg_date"));
	            dto.setGung_id(rs.getInt("gung_id"));
	            dto.setGung_name(rs.getString("gung_name")); // ✅ 궁 이름 세팅
	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

    public int insertStory(StoryDTO sDTO) throws SQLException {
        int storyId = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getInstance().getDbConn();

            // 새 ID 생성
            String idSql = "SELECT NVL(MAX(story_id), 0) + 1 FROM story";
            pstmt = conn.prepareStatement(idSql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                storyId = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // INSERT 수행
            String insertSql = "INSERT INTO story (story_id, story_name, story_info, story_reg_date, gung_id) VALUES (?, ?, ?, SYSDATE, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setInt(1, storyId);
            pstmt.setString(2, sDTO.getStory_name());
            pstmt.setString(3, sDTO.getStory_info());
            pstmt.setInt(4, sDTO.getGung_id());

            pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, conn);
        }

        return storyId;
    }

    public void insertFilePath(int storyId, String filePath, String originalFileName) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int propertyId = 0;

        try {
            conn = DbConnection.getInstance().getDbConn();

            // 새 파일 ID 생성
            String idSql = "SELECT NVL(MAX(property_id), 0) + 1 FROM file_path";
            pstmt = conn.prepareStatement(idSql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                propertyId = rs.getInt(1);
            }
            rs.close();
            pstmt.close();

            // 파일 정보 저장
            String insertSql = "INSERT INTO file_path (property_id, path, targer_type, targer_number, img_name) VALUES (?, ?, 'story', ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setInt(1, propertyId);
            pstmt.setString(2, filePath);
            pstmt.setString(3, String.valueOf(storyId));
            pstmt.setString(4, originalFileName);

            pstmt.executeUpdate();
        } finally {
            DbConnection.getInstance().dbClose(rs, pstmt, conn);
        }
    }


    
}//class

