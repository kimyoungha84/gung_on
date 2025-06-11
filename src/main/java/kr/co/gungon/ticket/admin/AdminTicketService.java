package kr.co.gungon.ticket.admin;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import kr.co.gungon.ticket.TicketDetailDTO;

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
	

	/**
	 * Flag를 String으로 변경
	 * @param commentFlag
	 * @return
	 */
	public String changeCommentFlagToComment(String commentFlag) {
		String comment=null;
		
		Map<String, String> langMap=new HashMap<String, String>();
		langMap.put("0","선택 안함");
		langMap.put("1","한국어");
		langMap.put("2", "영어");
		
		
		
		comment=langMap.get(commentFlag);
		
		return comment;
	}//changeCommentFlagToComment
	
	
	
	
	/**
	 * 관리자 예매 상세 화면에 데이터 뿌리기
	 * @return
	 */
	public TicketAdminDTO showDetailAdminPageData(String bookingNum){
		TicketAdminDTO tDTO=new TicketAdminDTO();
		AdminTicketDAO dDAO=AdminTicketDAO.getInstance();
		List<TicketAdminDTO> tadminList=showDefaultAdminPageData();
		List<TicketDetailDTO> ticketDetailList=new ArrayList<TicketDetailDTO>();
		
		for(int i=0; i< tadminList.size(); i++) {
			if(tadminList.get(i).getBooking_num().equals(bookingNum)) {
				tDTO=tadminList.get(i);
				try {
					ticketDetailList=dDAO.selectTicketManageDetail(bookingNum);
					tDTO.setCompanies(ticketDetailList);
				} catch (SQLException e) {
					e.printStackTrace();
				}//end try~catch
			}//end if
		}//end for
			
		
		return tDTO;
	}//showDetailAdminPageData\
	
	
	
	public String getProgramNameByprogramId(int programId) {
		AdminTicketDAO dao=AdminTicketDAO.getInstance();
		String programName=null;
		
		try {
			programName=dao.selectProgramNameByProgramId(programId);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end try~catch
		
		
		return programName;
	}//getProgramNameByprogramId
	
	
	
	public String getProgramStartTimeByProgramId(int programId) {
		Timestamp programStartTime=null;
		AdminTicketDAO dao=AdminTicketDAO.getInstance();
		SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
		String startTimeStr=null;
		
		try {
			programStartTime=dao.selectProgramStartTimeByProgramId(programId);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end try~catch
		
		startTimeStr=sdf.format(programStartTime);
	
		return startTimeStr;
	}//end getProgramStartTimeByProgramId
	
	
	public String changePersonClassificationStr(String classificationNum) {
		Map<String, String> classification=new HashMap<String, String>();
		String classificationStr=null;
		
		classification.put("1", "대인");
		classification.put("2", "소인");
		
		classificationStr=classification.get(classificationNum);
		
		
		return classificationStr;
	}//changePersonClassificationStr
	
	
	public String outputPersonalCount(String adultCount, String kidCount) {
		StringBuilder sb=new StringBuilder();
		
		int adultCnt=Integer.parseInt(adultCount);
		int kidCnt=Integer.parseInt(kidCount);
		
		if(adultCnt != 0) {
			sb.append("대인 ").append(adultCnt).append("명");
			
			if(kidCnt != 0) {
				sb.append("<br>");
				
			}//end if
			
		}//end if
		
		if(kidCnt != 0) {
			sb.append("소인 ").append(kidCnt).append("명");
		}//end if
		
		
		
		return sb.toString();
	}//end outputPersonalCount
	
	
	/* 5000을  5,000형태로 변환 */
	public String changeCosttoStr(int cost) {
		String resultStr=null;
	//	int cost=Integer.parseInt(cost);

		DecimalFormat df=new DecimalFormat("#,###,###");
		resultStr=df.format(cost);
		
		return resultStr;
	}// chageStrToInt
	
	
	//총 list 개수 주면, ,내가 원하는 갯수만큼 잘라서 list 전송(startNum, endNum)을 받아서 전송하면 되겠지
	public List<TicketAdminDTO> cutList(int startNum, int endNum, List<TicketAdminDTO> totalList){
		//1.totalList한테 numbering을 해줘야해		
		List<TicketAdminDTO> list=new LinkedList<TicketAdminDTO>();
		startNum-=1;
		endNum-=1;
		
		
		if(endNum > totalList.size()) {
			endNum=(totalList.size());
		}//end if
		
		for(int i=startNum; i<endNum;i++) {
			list.add(totalList.get(i));
		}//end for
		
		return list;
	}//end cutList
	
	
	//총 list 개수 주면, ,내가 원하는 갯수만큼 잘라서 list 전송(startNum, endNum)을 받아서 전송하면 되겠지
	public List<TicketDetailDTO> cutListDetail(int startNum, int endNum, List<TicketDetailDTO> totalList){
		//1.totalList한테 numbering을 해줘야해		
		List<TicketDetailDTO> list=new LinkedList<TicketDetailDTO>();
		startNum-=1;
		endNum-=1;
		
		
		if(endNum > totalList.size()) {
			endNum=(totalList.size());
		}//end if
		
		for(int i=startNum; i<endNum;i++) {
			list.add(totalList.get(i));
		}//end for
		
		return list;
	}//end cutList
	
	
	public String returnStatusByQRHash(String QRHash) {
		AdminTicketDAO tDAO=AdminTicketDAO.getInstance();
		String entryStatus=null;
		
		try {
			entryStatus=tDAO.selectStatucByQrHash(QRHash);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end try~catch
		
		return entryStatus;
	}//returnStatusByQRHash
	
	
}//class
