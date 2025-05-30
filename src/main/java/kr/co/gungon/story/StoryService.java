package kr.co.gungon.story;

import java.util.List;

public class StoryService {
    private StoryDAO dao = new StoryDAO();

    public StoryDTO getStoryByName(String name) {
        return dao.getStoryByName(name);  // ★ 꼭 이렇게 위임해야 함
    }
    public List<StoryDTO> searchStoryByTitle(String title) {
        return dao.findByTitle(title);
    }
    public List<StoryDTO> selectAllStory() {
        return dao.selectAllStory();
    }
}
