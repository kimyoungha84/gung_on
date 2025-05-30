package kr.co.gungon.story;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StoryDTO {
	private int story_id;
	private String story_name,story_info,story_img;
	private Date story_reg_date;
	private int gung_id;	
	private List<String> imageList;

}
