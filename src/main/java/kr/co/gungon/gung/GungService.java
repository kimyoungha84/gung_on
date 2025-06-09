package kr.co.gungon.gung;

import java.util.List;

import kr.co.gungon.file.FilePathDAO;
import kr.co.gungon.file.FilePathDTO;



public class GungService {
    private GungDAO dao = new GungDAO();
    

    public GungDTO getGungDetail(String gungName) {
        return dao.getGungByName(gungName);
    }
    
    public List<GungDTO> selectAllGung() {
        return dao.selectAll();
      }
    public GungDTO selectGungById(int id) {
        return dao.selectById(id);
    }
    public boolean modifyGung(GungDTO dto) {
        return dao.modifyGung(dto); // DAO로 위임
    }
    
    public boolean deleteGung(int id) {
    	return dao.deleteGung(id);
    }
    public boolean insertGung(GungDTO dto) {
        return new GungDAO().insertGung(dto);
    }

}
