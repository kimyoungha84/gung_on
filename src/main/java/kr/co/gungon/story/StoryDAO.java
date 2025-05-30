package kr.co.gungon.story;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;

public class StoryDAO {
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
	        String sql = "SELECT * FROM story WHERE story_name LIKE ?";
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
	            list.add(dto);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	    	try {
				DbConnection.getInstance().dbClose(rs, pstmt, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    }

	    return list;
	}//findByTitle
	
	
    public List<StoryDTO> selectAllStory() {
        List<StoryDTO> list = new ArrayList();
        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM story ORDER BY story_id");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                StoryDTO sDTO = new StoryDTO();
                sDTO.setStory_id(rs.getInt("story_id"));
                sDTO.setStory_name(rs.getString("story_name"));
                sDTO.setStory_info(rs.getString("story_info"));
                sDTO.setStory_reg_date(rs.getDate("story_reg_date"));
                list.add(sDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }//selectAllStory

    
}//class

