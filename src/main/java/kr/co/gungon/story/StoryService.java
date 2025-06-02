package kr.co.gungon.story;

import java.util.List;


public class StoryService {
    private StoryDAO sdao = new StoryDAO();

    public StoryDTO getStoryByName(String name) {
        return sdao.getStoryByName(name);  // ★ 꼭 이렇게 위임해야 함
    }
    public List<StoryDTO> searchStoryByTitle(String title) {
        return sdao.findByTitle(title);
    }
    public List<StoryDTO> selectAllStory() {
        return sdao.selectAllStory();
    }
    public int registerStory(StoryDTO sDTO) throws Exception {
        return sdao.insertStory(sDTO);
    }

    public void saveStoryImage(int storyId, String filePath, String originalFileName) throws Exception {
        sdao.insertFilePath(storyId, filePath, originalFileName);
    }
    public StoryDTO getStoryById(int id) {
        return sdao.getStoryById(id);
    }


    
}