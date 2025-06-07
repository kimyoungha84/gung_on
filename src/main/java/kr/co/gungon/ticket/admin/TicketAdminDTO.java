package kr.co.gungon.ticket.admin;

import java.util.List;

import kr.co.gungon.ticket.TicketDetailDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Setter
@Getter
@NoArgsConstructor
public class TicketAdminDTO {
	private String booking_num, member_name, member_id, adult_person,kid_person, total_person, 
				phone_number, comment_flag, reserve_date,startTime,paymentTimeStamp, program_name, person,paymentStr;
	private List<TicketDetailDTO> companies;
	private int programId,payment;
	
}//class
