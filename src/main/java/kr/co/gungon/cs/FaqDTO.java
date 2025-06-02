package kr.co.gungon.cs;

import java.sql.Date;

public class FaqDTO {

	private int faq_num;
	private String faq_title, faq_content;
	private Date faq_regDate;
	
	
	public FaqDTO() {
		
		
	}
	
	public FaqDTO(int faq_num, String faq_title, String faq_content, Date faq_regDate) {
		super();
		this.faq_num = faq_num;
		this.faq_title = faq_title;
		this.faq_content = faq_content;
		this.faq_regDate = faq_regDate;
	}
	public int getFaq_num() {
		return faq_num;
	}
	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
	}
	public String getFaq_title() {
		return faq_title;
	}
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public Date getFaq_regDate() {
		return faq_regDate;
	}
	public void setFaq_regDate(Date faq_regDate) {
		this.faq_regDate = faq_regDate;
	}
	@Override
	public String toString() {
		return "FaqDTO [faq_num=" + faq_num + ", faq_title=" + faq_title + ", faq_content=" + faq_content
				+ ", faq_regDate=" + faq_regDate + "]";
	}
	
	
}
