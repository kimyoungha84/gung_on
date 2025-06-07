package kr.co.gungon.ticket.admin;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	
	
	/**
	 * 예매관리 페이지에 있는 테이블에 데이터 뿌리기
	 */
	public List<TicketAdminDTO> showDefaultAdminPageData() {
		AdminTicketDAO adminDAO=AdminTicketDAO.getInstance();
		
		List<TicketAdminDTO> tlist=new ArrayList<TicketAdminDTO>();
		
		try {
			tlist=adminDAO.selectTicketManage();
		} catch (SQLException e) {
			e.printStackTrace();
		}//try~catch
		
		
		return tlist;
	}//showDefaultAdminPageData
	
	public String appendDashtoPhoneNumber(String phoneNumber) {
		StringBuilder appendDashPhoneNum=new StringBuilder();
		
		if(phoneNumber.length()==11) {
			//010 1234 5678 형태
			appendDashPhoneNum
			.append(phoneNumber.substring(0, 3)).append("-")
			.append(phoneNumber.substring(3,7)).append("-")
			.append(phoneNumber.substring(7));
		}
		
		if(phoneNumber.length()==10) {
			//010 123 5678 형태
			appendDashPhoneNum
			.append(phoneNumber.substring(0, 3)).append("-")
			.append(phoneNumber.substring(3,6)).append("-")
			.append(phoneNumber.substring(6));
		}
		
		return appendDashPhoneNum.toString();
	}//appendDashtoPhoneNumber
	

	public String changeCommentFlagToComment(String commentFlag) {
		String comment=null;
		
		Map<String, String> langMap=new HashMap<String, String>();
		langMap.put("0","선택 안함");
		langMap.put("1","한국어");
		langMap.put("2", "영어");
		
		comment=langMap.get(commentFlag);
		
		return comment;
	}//changeCommentFlagToComment
	
	
}//class
