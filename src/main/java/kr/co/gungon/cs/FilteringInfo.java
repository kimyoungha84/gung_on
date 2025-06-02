package kr.co.gungon.cs;

import java.sql.Date;

public class FilteringInfo {

	private String searchCategory, searchText;
	private Date startDate, endDate;
	private int CurrentPage = 1, StartNum, endNum;
	
	public FilteringInfo() {
		
	}
	
	
	
	

	public FilteringInfo(String searchCategory, String searchText, Date startDate, Date endDate, int currentPage,
			int startNum, int endNum) {
		super();
		this.searchCategory = searchCategory;
		this.searchText = searchText;
		this.startDate = startDate;
		this.endDate = endDate;
		CurrentPage = currentPage;
		StartNum = startNum;
		this.endNum = endNum;
	}





	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getCurrentPage() {
		return CurrentPage;
	}

	public void setCurrentPage(int currentPage) {
		CurrentPage = currentPage;
	}

	public int getStartNum() {
		return StartNum;
	}

	public void setStartNum(int startNum) {
		StartNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	@Override
	public String toString() {
		return "FilteringInfo [searchCategory=" + searchCategory + ", searchText=" + searchText + ", startDate="
				+ startDate + ", endDate=" + endDate + ", CurrentPage=" + CurrentPage + ", StartNum=" + StartNum
				+ ", endNum=" + endNum + "]";
	}
	
	
	
	
	
	
	
}
