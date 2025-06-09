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
	    String sql = """
	        SELECT s.*, g.gung_name
	        FROM story s
	        JOIN gung g ON s.gung_id = g.gung_id
	        WHERE s.story_id = ?
	    """;

	    try (Connection conn = DbConnection.getInstance().getDbConn();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, storyId);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                dto = new StoryDTO();
	                dto.setStory_id(rs.getInt("story_id"));
	                dto.setStory_name(rs.getString("story_name"));
	                dto.setStory_info(rs.getString("story_info"));
	                dto.setStory_reg_date(rs.getDate("story_reg_date"));
	                dto.setGung_id(rs.getInt("gung_id"));
	                dto.setGung_name(rs.getString("gung_name")); // ✅ 꼭 세팅!
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return dto;
	}


    public StoryDTO getStoryByName(String storyName) {
        StoryDTO sDTO = null;
        String sql = "SELECT * FROM story WHERE LOWER(TRIM(STORY_NAME)) = LOWER(TRIM(?))";

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, storyName);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    sDTO = new StoryDTO();
                    sDTO.setStory_id(rs.getInt("story_id"));
                    sDTO.setStory_name(rs.getString("story_name"));
                    sDTO.setStory_info(rs.getString("story_info"));
                    sDTO.setStory_reg_date(rs.getDate("story_reg_date"));
                    sDTO.setGung_id(rs.getInt("gung_id"));
                } else {
                    System.out.println("[DAO] 결과 없음: '" + storyName + "'");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sDTO;
    }

    public List<StoryDTO> findByTitle(String title) {
        List<StoryDTO> list = new ArrayList<>();
        String sql = """
            SELECT s.story_id, s.story_name, s.story_info, s.story_reg_date,
                   s.gung_id, g.gung_name
            FROM story s
            JOIN gung g ON s.gung_id = g.gung_id
            WHERE s.story_name LIKE ?
            ORDER BY s.story_id
        """;

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + title + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    StoryDTO dto = new StoryDTO();
                    dto.setStory_id(rs.getInt("story_id"));
                    dto.setStory_name(rs.getString("story_name"));
                    dto.setStory_info(rs.getString("story_info"));
                    dto.setStory_reg_date(rs.getDate("story_reg_date"));
                    dto.setGung_id(rs.getInt("gung_id"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
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
                dto.setGung_name(rs.getString("gung_name"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertStory(StoryDTO sDTO) throws SQLException {
        int storyId = 0;

        try (Connection conn = DbConnection.getInstance().getDbConn()) {
            String idSql = "SELECT NVL(MAX(story_id), 0) + 1 FROM story";
            try (PreparedStatement pstmt = conn.prepareStatement(idSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    storyId = rs.getInt(1);
                }
            }

            String insertSql = "INSERT INTO story (story_id, story_name, story_info, story_reg_date, gung_id) VALUES (?, ?, ?, SYSDATE, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setInt(1, storyId);
                pstmt.setString(2, sDTO.getStory_name());
                pstmt.setString(3, sDTO.getStory_info());
                pstmt.setInt(4, sDTO.getGung_id());
                pstmt.executeUpdate();
            }
        }
        return storyId;
    }

    public void insertFilePath(int storyId, String filePath, String originalFileName) throws SQLException {
        int propertyId = 0;

        try (Connection conn = DbConnection.getInstance().getDbConn()) {
            String idSql = "SELECT NVL(MAX(property_id), 0) + 1 FROM file_path";
            try (PreparedStatement pstmt = conn.prepareStatement(idSql);
                 ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    propertyId = rs.getInt(1);
                }
            }

            String insertSql = """
                INSERT INTO file_path (property_id, path, target_type, target_number, img_name)
                VALUES (?, ?, 'story', ?, ?)
            """;
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setInt(1, propertyId);
                pstmt.setString(2, filePath);
                pstmt.setInt(3, storyId);
                pstmt.setString(4, originalFileName);
                pstmt.executeUpdate();
            }
        }
    }

    public List<String> getImageNamesByStoryId(int storyId) {
        List<String> imgList = new ArrayList<>();
        String sql = "SELECT IMG_NAME FROM FILE_PATH WHERE target_type = 'story' AND target_number = ?";

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, storyId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    imgList.add(rs.getString("IMG_NAME"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imgList;
    }
    
    public boolean deleteStory(int storyId) {
        String sql = "DELETE FROM story WHERE story_id = ?";
        boolean result = false;

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, storyId);
            int affected = pstmt.executeUpdate();
            result = affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public List<StoryDTO> searchStoryByKeyword(String keyword) {
        List<StoryDTO> list = new ArrayList<>();
        String sql = """
            SELECT s.*, g.gung_name
            FROM story s
            JOIN gung g ON s.gung_id = g.gung_id
            WHERE LOWER(s.story_name) LIKE LOWER(?) 
               OR LOWER(g.gung_name) LIKE LOWER(?)
            ORDER BY s.story_id DESC
        """;

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String search = "%" + keyword + "%";
            pstmt.setString(1, search);
            pstmt.setString(2, search);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    StoryDTO dto = new StoryDTO();
                    dto.setStory_id(rs.getInt("story_id"));
                    dto.setStory_name(rs.getString("story_name"));
                    dto.setStory_info(rs.getString("story_info"));
                    dto.setStory_reg_date(rs.getDate("story_reg_date"));
                    dto.setGung_name(rs.getString("gung_name"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateStory(StoryDTO dto) throws SQLException {
        String sql = "UPDATE story SET story_name = ?, story_info = ? WHERE story_id = ?";
        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getStory_name());
            pstmt.setString(2, dto.getStory_info());
            pstmt.setInt(3, dto.getStory_id());

            pstmt.executeUpdate();
        }
    }


} // end class