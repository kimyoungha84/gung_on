package kr.co.gungon.member;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {

	private String id,pass,name,tel,email,domain,useEmail,ip;
	private Date input_date;
	
}//class
