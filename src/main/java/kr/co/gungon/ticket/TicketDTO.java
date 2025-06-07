package kr.co.gungon.ticket;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class TicketDTO {
	String bookingNum, programName,member_id, phoneNum, reserveDate, reserveTime,commentLang,commentFlag, paymentTimeStamp;
	int adultCount, kidCount ,authenCnt,payment;
	
	List<TicketDetailDTO> companies;
	
}//class
