package kr.co.gungon.file;

import kr.co.gungon.file.FilePathDAO;
import kr.co.gungon.file.FilePathDTO;

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
    
}
