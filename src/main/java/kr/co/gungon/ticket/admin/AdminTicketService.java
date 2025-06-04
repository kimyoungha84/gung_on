package kr.co.gungon.ticket.admin;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class AdminTicketService {
	
	public String nowTimestamp() {
		String timeStamp=null;
		
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		timeStamp=sdf.format(timestamp);
		
		
		return timeStamp;
	}//nowTimestemp

}//class
