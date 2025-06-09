package kr.co.gungon.file;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;

public class FilePathDAO {
	
	private static FilePathDAO fpDAO = null;
	
    private FilePathDAO() {}

    public static FilePathDAO getInstance() {
        if (fpDAO == null) {
            fpDAO = new FilePathDAO();
        }
        return fpDAO;
    }

    public FilePathDTO selectImagePath(String targerType, String targerNumber) throws SQLException {
        FilePathDTO dto = null;
        String sql = "SELECT property_id, path, targer_type, targer_number, img_name "
                   + "FROM file_path "
                   + "WHERE targer_type = ? AND targer_number = ?";
        try (Connection con = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
        	
                pstmt.setString(1, targerType);
                pstmt.setString(2, targerNumber);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        dto = new FilePathDTO(
                            rs.getInt("property_id"),
                            rs.getString("path"),
                            rs.getString("targer_type"),
                            rs.getString("targer_number"),
                            rs.getString("img_name")
                        );
                    }
                }
            }

            return dto;
        }
    
    public int insertImagePath(FilePathDTO dto) throws SQLException {
        String sql = "INSERT INTO file_path (" +
        		"property_id, path, targer_type, targer_number, img_name" +
        		") VALUES (file_seq.nextval, ?, ?, ?, ?)";
        
        try (Connection con = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, dto.getPath());
            pstmt.setString(2, dto.getTargerType());
            pstmt.setString(3, dto.getTargerNumber());
            pstmt.setString(4, dto.getImgName());

            return pstmt.executeUpdate();
        }
    }
    
    public int updateImagePath(FilePathDTO dto) throws SQLException {
        String sql = "UPDATE file_path SET path = ?, img_name = ? " +
                     "WHERE property_id = ?";

        try (Connection con = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, dto.getPath());
            pstmt.setString(2, dto.getImgName());
            pstmt.setInt(3, dto.getPropertyId());

            return pstmt.executeUpdate();
        }
    }
    
    public List<FilePathDTO> selectStoryImagesByTargetNumber(String targerType, String targerNumber) throws SQLException {
        List<FilePathDTO> list = new ArrayList<>();
        String sql = "SELECT property_id, path, targer_type, targer_number, img_name "
                   + "FROM file_path "
                   + "WHERE targer_type = ? AND targer_number = ? "
                   + "ORDER BY img_name";

        try (Connection con = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, targerType);        // 예: "story"
            pstmt.setString(2, targerNumber);      // 예: "광화문"

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    FilePathDTO dto = new FilePathDTO(
                        rs.getInt("property_id"),
                        rs.getString("path"),
                        rs.getString("targer_type"),
                        rs.getString("targer_number"),
                        rs.getString("img_name")
                    );
                    list.add(dto);
                }
            }
        }

        return list;
    }
    	
    public void insertFilePath(FilePathDTO dto) throws SQLException {
        String sql = """
            INSERT INTO file_path (property_id, path, targer_type, targer_number, img_name)
            VALUES (FILE_SEQ.NEXTVAL, ?, ?, ?, ?)
        """;

        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getPath());
            pstmt.setString(2, dto.getTargerType());
            pstmt.setString(3, dto.getTargerNumber());
            pstmt.setString(4, dto.getImgName());

            pstmt.executeUpdate();
        }
    }
    public void deleteFilePath(FilePathDTO dto) throws SQLException {
        String sql = "DELETE FROM file_path WHERE targer_type = ? AND targer_number = ? AND img_name = ?";
        try (Connection conn = DbConnection.getInstance().getDbConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTargerType());
            pstmt.setString(2, dto.getTargerNumber());
            pstmt.setString(3, dto.getImgName());
            pstmt.executeUpdate();
        }
    }


    
  




}
