package kr.co.gungon.ticket.admin;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Setter
@Getter
@NoArgsConstructor
public class TicketAdminDTO {
	private String booking_num, member_name, member_id, total_person, phone_number, comment_flag;
	
	
}//class
