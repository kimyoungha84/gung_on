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
                return dto.getPath() + "/" + dto.getImgName(); // 전체 경로 리턴
            }
        } catch (Exception e) {
            e.printStackTrace(); // 실제 서비스에서는 로깅 처리
        }
        return null;
    }
    
}
