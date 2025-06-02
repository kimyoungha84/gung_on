package kr.co.gungon.cs;

import java.sql.Date;

public class NoticeDTO {
private int notice_num, notice_views;
private String notice_title, notice_content;
private Date notice_regDate;



public NoticeDTO() {
	
}






public NoticeDTO(int notice_num, int notice_views, String notice_title, String notice_content, Date notice_regDate) {
	super();
	this.notice_num = notice_num;
	this.notice_views = notice_views;
	this.notice_title = notice_title;
	this.notice_content = notice_content;
	this.notice_regDate = notice_regDate;
}






public int getNotice_num() {
	return notice_num;
}



public void setNotice_num(int notice_num) {
	this.notice_num = notice_num;
}



public int getNotice_views() {
	return notice_views;
}



public void setNotice_views(int notice_views) {
	this.notice_views = notice_views;
}



public String getNotice_title() {
	return notice_title;
}



public void setNotice_title(String notice_title) {
	this.notice_title = notice_title;
}



public String getNotice_content() {
	return notice_content;
}



public void setNotice_content(String notice_content) {
	this.notice_content = notice_content;
}



public Date getNotice_regDate() {
	return notice_regDate;
}



public void setNotice_regDate(Date notice_regDate) {
	this.notice_regDate = notice_regDate;
}



@Override
public String toString() {
	return "NoticeDTO [notice_num=" + notice_num + ", notice_views=" + notice_views + ", notice_title=" + notice_title
			+ ", notice_content=" + notice_content + ", notice_regDate=" + notice_regDate + "]";
}





}
