package kr.co.gungon.cs;

import java.sql.Timestamp;

public class InquiryDTO {

	private int inquiry_num;
	private String inquiry_content, inquiry_answer, member_id;
	private boolean answer_status;
	private Timestamp inquiry_regDate, inquiry_answerDate;
	
	
	
	public InquiryDTO() {
		
		
	}

	
	


	public InquiryDTO(int inquiry_num, String inquiry_content, String inquiry_answer, String member_id,
			boolean answer_status, Timestamp inquiry_regDate, Timestamp inquiry_answerDate) {
		super();
		this.inquiry_num = inquiry_num;
		this.inquiry_content = inquiry_content;
		this.inquiry_answer = inquiry_answer;
		this.member_id = member_id;
		this.answer_status = answer_status;
		this.inquiry_regDate = inquiry_regDate;
		this.inquiry_answerDate = inquiry_answerDate;
	}



	@Override
	public String toString() {
		return "InquiryDTO [inquiry_num=" + inquiry_num + ", inquiry_content=" + inquiry_content + ", inquiry_answer="
				+ inquiry_answer + ", member_id=" + member_id + ", answer_status=" + answer_status
				+ ", inquiry_regDate=" + inquiry_regDate + ", inquiry_answerDate=" + inquiry_answerDate + "]";
	}








	public int getInquiry_num() {
		return inquiry_num;
	}



	public void setInquiry_num(int inquiry_num) {
		this.inquiry_num = inquiry_num;
	}



	public String getInquiry_content() {
		return inquiry_content;
	}



	public void setInquiry_content(String inquiry_content) {
		this.inquiry_content = inquiry_content;
	}



	public String getInquiry_answer() {
		return inquiry_answer;
	}



	public void setInquiry_answer(String inquiry_answer) {
		this.inquiry_answer = inquiry_answer;
	}



	public String getMember_id() {
		return member_id;
	}



	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}



	public boolean isAnswer_status() {
		return answer_status;
	}



	public void setAnswer_status(boolean answer_status) {
		this.answer_status = answer_status;
	}



	public Timestamp getInquiry_regDate() {
		return inquiry_regDate;
	}



	public void setInquiry_regDate(Timestamp inquiry_regDate) {
		this.inquiry_regDate = inquiry_regDate;
	}



	public Timestamp getInquiry_answerDate() {
		return inquiry_answerDate;
	}



	public void setInquiry_answerDate(Timestamp inquiry_answerDate) {
		this.inquiry_answerDate = inquiry_answerDate;
	}

	

	
	
	
}
