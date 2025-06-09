package kr.co.gungon.file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class FilePathDTO {
	private int propertyId;
	private String path;
	private String targerType;
	private String targerNumber;
	private String imgName;
	
	// ✅ 웹에서 사용할 전체 경로 반환
	public String getFullWebPath() {
	    return path;
	}
}
