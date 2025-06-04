package kr.co.gungon.program;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.program.ProgramDAO;
import kr.co.gungon.program.ProgramDTO;
import kr.co.gungon.program.PageParam;

public class ProgramService {

    private ProgramDAO pDAO = ProgramDAO.getInstance();

    public ProgramService() {
        // 기본 생성자
    }

    // 1) 특정 날짜에 진행되는 행사 목록 조회 (달력에서 날짜 선택 시 사용)
    public ArrayList<ProgramDTO> getProgramsByDate(Date date) {
        try {
            return pDAO.selectProgramsByDate(date);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // 2) 프로그램 이름으로 단일 행사 조회
    public ProgramDTO getProgramByName(String programName) {
        try {
            return pDAO.selectProgramByName(programName);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // 3) 행사장소(programPlace)로 행사 목록 조회
    public ArrayList<ProgramDTO> getProgramsByProgramPlace(String programPlace) {
        try {
            return (ArrayList<ProgramDTO>) pDAO.selectProgramsByProgramPlace(programPlace);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    // 4) 모든 행사 목록 조회
    public ArrayList<ProgramDTO> getAllPrograms() {
    	try {
    		return pDAO.selectAllPrograms();
    	} catch (Exception e) {
    		e.printStackTrace();
    		return new ArrayList<>();
    	}
    }
    
    // 5) 행사 등록
    public int insertProgram(ProgramDTO dto) {
        try {
            int result = pDAO.insertProgram(dto);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 6) 행사 수정
    public int updateProgram(ProgramDTO dto) {
        try {
            int result = pDAO.updateProgram(dto);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 7) 행사 삭제
    public int deleteProgram(int programId) {
        try {
            int result = pDAO.deleteProgram(programId);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    // 페이지네이션
    public List<ProgramDTO> getProgramsByPage(int pageNo, int rowPerPage) {
        int startRow = (pageNo - 1) * rowPerPage + 1;
        int endRow = startRow + rowPerPage - 1;

        PageParam pp = new PageParam();
        pp.setStartRow(startRow);
        pp.setEndRow(endRow);

        try {
            return pDAO.selectProgramsByPage(pp);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // 총 프로그램 수 조회
    public int getTotalCount() {
        try {
            return pDAO.selectTotalCount();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}