package kr.co.gungon.cs;

import java.sql.Date;

public class InquiryFilteringInfo extends FilteringInfo {

	private Boolean answerStatus;

	
	public InquiryFilteringInfo() {
		super();
	}

	public InquiryFilteringInfo(String searchCategory, String searchText, Date startDate, Date endDate, int currentPage,
			int startNum, int endNum, Boolean answerStatus) {
		super(searchCategory, searchText, startDate, endDate, currentPage, startNum, endNum);
		this.answerStatus = answerStatus;
	}

	
	

	public Boolean getAnswerStatus() {
		return answerStatus;
	}

	public void setAnswerStatus(Boolean answerStatus) {
		this.answerStatus = answerStatus;
	}

	@Override
	public String toString() {
		return "InquiryFilteringInfo [answerStatus=" + answerStatus + ", getSearchCategory()=" + getSearchCategory()
				+ ", getSearchText()=" + getSearchText() + ", getStartDate()=" + getStartDate() + ", getEndDate()="
				+ getEndDate() + ", getCurrentPage()=" + getCurrentPage() + ", getStartNum()=" + getStartNum()
				+ ", getEndNum()=" + getEndNum() + ", toString()=" + super.toString() + "]";
	}


	
	
	
	
	
}
