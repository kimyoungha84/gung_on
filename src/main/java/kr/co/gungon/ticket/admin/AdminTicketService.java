package kr.co.gungon.ticket.admin;

import java.sql.SQLException;
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
	
	/**
	 * 입장 완료 했을 때, <br>
	 * ENTRY_STATUS, ENTRY_TIME 변경
	 * @param imgPath
	 */
	public void modifyStatus(String imgHash) {
		AdminTicketDAO adminDAO=AdminTicketDAO.getInstance();
		
		
		try {
			adminDAO.updateEntryStatus(imgHash);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end try~catch
		
		
	}//modifyStatus

}//class
