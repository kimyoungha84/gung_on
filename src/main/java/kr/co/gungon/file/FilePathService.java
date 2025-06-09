package kr.co.gungon.file;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FilePathService {

	private FilePathDAO fpDAO = FilePathDAO.getInstance();

	public FilePathService() {
		// 기본 생성자
	}

	public String getImageFullPath(String targerType, String targerNumber) {
		try {
			FilePathDTO dto = fpDAO.selectImagePath(targerType, targerNumber);
			if (dto != null) {
				return dto.getPath();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int insertImagePath(FilePathDTO dto) {
		try {
			return fpDAO.insertImagePath(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int updateImagePath(FilePathDTO dto) {
		try {
			return fpDAO.updateImagePath(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// FilePathService에서
	public List<FilePathDTO> getStoryImages(String targerType, String storyId) {
	    try {
	        return FilePathDAO.getInstance().selectStoryImagesByTargetNumber(targerType, storyId);
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}
	// ✨ JSP에서 사용할 메서드 정의
    public List<FilePathDTO> getStoryImagesByName(String targerType, String targerNumber) {
        try {
            return fpDAO.selectStoryImagesByTargetNumber(targerType, targerNumber);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public void insertFilePath(FilePathDTO dto) throws SQLException {
        fpDAO.insertFilePath(dto);
    }
    // ✅ 삭제 기능 추가
    public void deleteFilePath(FilePathDTO dto) throws SQLException {
        fpDAO.deleteFilePath(dto);
    }

}
