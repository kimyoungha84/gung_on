package kr.co.gungon.story;

import java.sql.SQLException;
import java.util.List;

public class StoryService {

    private final StoryDAO sdao = StoryDAO.getInstance();  // ✅ 싱글톤 DAO 인스턴스

    // 등록
    public int registerStory(StoryDTO sDTO) throws Exception {
        return sdao.insertStory(sDTO);
    }

    // 이미지 저장
    public void saveStoryImage(int storyId, String filePath, String originalFileName) throws Exception {
        sdao.insertFilePath(storyId, filePath, originalFileName);
    }

    // 전체 조회
    public List<StoryDTO> selectAllStory() {
        return sdao.selectAllStory();
    }

    // 제목으로 검색
    public List<StoryDTO> searchStoryByTitle(String title) {
        return sdao.findByTitle(title);
    }

    // 키워드 검색
    public List<StoryDTO> searchStoryByKeyword(String keyword) {
        return sdao.searchStoryByKeyword(keyword);
    }

    // 궁 ID로 전각 리스트 가져오기
    public List<StoryDTO> getStoriesByGungId(int gungId) {
        return sdao.selectStoriesByGungId(gungId);  // ✅ 중복 호출 제거
    }

    // 단건 조회 (ID, Name)
    public StoryDTO getStoryById(int id) {
        return sdao.getStoryById(id);
    }

    public StoryDTO getStoryByName(String name) {
        return sdao.getStoryByName(name);
    }

    // 수정
    public void updateStory(StoryDTO dto) throws SQLException {
        sdao.updateStory(dto);
    }

    // 삭제
    public boolean deleteStory(int storyId) {
        return sdao.deleteStory(storyId);
    }
}
