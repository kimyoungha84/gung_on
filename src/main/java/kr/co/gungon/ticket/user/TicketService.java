package kr.co.gungon.ticket.user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.gungon.program.ProgramDAO;
import kr.co.gungon.program.ProgramDTO;
import kr.co.gungon.ticket.FileUploadFTP;
import kr.co.gungon.ticket.TicketDTO;
import kr.co.gungon.ticket.TicketDetailDTO;
import kr.co.gungon.ticket.ticketConfig.SiteProperty;
import kr.co.sist.cipher.DataDecryption;
import kr.co.sist.cipher.DataEncryption;

public class TicketService {

	/* 예약 추가 */
	public void addReservationValue(TicketDTO tDTO) {
		TicketDAO tDAO = TicketDAO.getInstance();

		try {
			tDAO.insertReservationValue(tDTO);
		} catch (SQLException e) {
			e.printStackTrace();
		} // end try~catch
	}// addReservationValue

	/* ￦5,000을 숫자 5000형태로 변환 */
	public int changeStrToInt(String costStr) {
		int costInt = 0;
		String tempStr = costStr.replace("￦", "").replace(",", "");
		costInt = Integer.parseInt(tempStr);

		return costInt;
	}// chageStrToInt

	/* 예매번호 만들기 */
	public String makeBookingNum() {
		String bookingNum = null;

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		// System.out.println(timestamp);//2025-05-30 15:50:41.847

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		// System.out.println(sdf.format(timestamp));//2025-05-30 03:50:41

		bookingNum = sdf.format(timestamp).replace("-", "").replace(":", "").replace(" ", "");
		System.out.println(bookingNum);

		return bookingNum;
	}// makeBookingNum
	
	
	/*결제일 생성*/
	public String makePaymentTimeStamp() {
		String paymentTimeStamp=null;
		
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		paymentTimeStamp=sdf.format(timestamp);
		
		return paymentTimeStamp;
	}//makePaymentTimeStamp
	
	
	

	/* 예약 날짜 가져오기 */
	public String getDate() {
		String todayDate = null;

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		todayDate = sdf.format(date);

		return todayDate;
	}// getDate

	/* 예약한 사람 있는지 체크 */
	private boolean reservePersonCount(int personCount) {
		boolean flag = false;

		if (personCount > 0) {
			flag = true;
		} // end if

		return flag;
	}// reservePersonCount

	/* 대인 1명 \n 소인 1명 이런식으로 출력하게끔. */
	public String personTotalString(int adultCount, int kidCount) {
		StringBuilder personString = new StringBuilder();

		if (reservePersonCount(adultCount)) {
			personString.append("대인 ").append(adultCount).append("명");
		} // end if

		if (reservePersonCount(kidCount)) {
			personString.append(System.lineSeparator()).append("소인 ").append(kidCount).append("명");
		}

		return personString.toString();
	}// personTotalString

	/**
	 * 행사명을 사용해 시작 시간 가져오기<br>
	 * ProgramDAO의 selectProgramByProgramName 사용<br>
	 * 
	 * @param programName //행사 이름
	 * @return timeStr // 11:00 형태의 문자열로 반환
	 */
	public String startTimeProgram(String programName) {
		ProgramDAO pDAO = ProgramDAO.getInstance();
		ProgramDTO pDTO = new ProgramDTO();

		String timeStr = null;

		try {
			pDTO = pDAO.selectProgramByProgramName(programName);
		} catch (SQLException e) {
			e.printStackTrace();
		} // end try~catch

		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		timeStr = sdf.format(pDTO.getOpenTime());

		return timeStr;
	}// startTimeProgram

	/* 알맞은 핸드폰 형식인지 확인 */
	public boolean checkPhoneNum(String phoneNum) {
		String phoneNumStr = phoneNum.replace("-", "");

		boolean flag = phoneNumStr.matches("010\\d{3,4}\\d{4}");

		return flag;
	}// checkPhoneNum

	/* 6자리 렌덤값 생성해서 사용자 폰 번호로 전송 */
	public String makeRandomNum(String phoneNum, String sessionId, TicketDTO ticketDTO) {
		
		boolean loopFlag=true;
		int ranNum=0;
		while(loopFlag) {

		ranNum = (int) ((Math.random()) * 1000000);
		String ranNumStr=ranNum+"";
		
			if(ranNumStr.length() != 6) {
				continue;
			}else {
				loopFlag=false;
			}//end if~else
			
		}//end while
		
		
		System.out.println("TicketService.java ========"+ranNum);		
		
		String ranNumStr = ranNum+"";
		System.out.println("인증번호 이거 넣으면 된다아아아아----"+ranNumStr);
		/*통신사 핸드폰 번호 전송*/
		SendMessage aume = new SendMessage();
		aume.sendMessage(phoneNum, ranNum + "");

		String randNumSha256= encryptSHA256(ranNumStr);
		
		return randNumSha256;
	}// makeRandomNum

	
	/*sha256 암호화*/
	public String encryptSHA256(String ranNumStr) {
		String randNumSha256=null;
		
		
		/*ranNum을 SHA256으로 암호화*/
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update((ranNumStr).getBytes());
			randNumSha256 = new String(Base64.getEncoder().encode(md.digest()));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return randNumSha256;
	}//encryptSHA256

	
	/*해설 Flag 만들기*/
	public String makeCommentFlag(String chooseLanguage) {
		String commentFlag=null;
		Map<String, String> langMap=new HashMap<String, String>();
		langMap.put("선택 안함", "0");
		langMap.put("한국어", "1");
		langMap.put("영어", "2");
		
		
		commentFlag=langMap.get(chooseLanguage);
		
		return commentFlag;
	}//makeCommentFlag
	
	
	/*대인 -> 1, 소인 -> 2로 변경*/
	public String makeClassificationStr(String korstr) {
		String clficationStr=null;
		Map<String, String> map=new HashMap<String, String>();
		map.put("대인", "1");
		map.put("소인", "2");
		
		clficationStr=map.get(korstr);
		
		return clficationStr;
	}//makeClassificationStr
	
	/*DES 암호화*/
	private String encryptDES(String plainText) {
		String key="icey3o5ugungonhi";
		String cipherText=null;
		boolean cipherFlag=true;
		
		DataEncryption de=new DataEncryption(key);
		try {
			
				cipherText=de.encrypt(plainText);
				System.out.println("cipherText="+cipherText);
		} catch (Exception e) {
			e.printStackTrace();
		}//end try~catch
		
		return cipherText;
	}//encryptDES

	
	/*DES 복호화*/
	private String decrpytDES(String cipherText) {
		String key="icey3o5ugungonhi";
		String plainText=null;
		
		DataDecryption dd=new DataDecryption(key);
		
		try {
			plainText=dd.decrypt(cipherText);
		} catch (Exception e) {
			e.printStackTrace();
		}//end try~catch
		
		return plainText;
	}//end decrpytDES
	
	
	/*QR 이미지명 생성 - DES 이용*/
	private String makeQRName(TicketDTO tDTO,  int personClassification,int cntId) {
		//이게 QR의 이미지명이 될거임.
		String qrImgName=null;
		boolean loopFlag=true;
		
		int ranNum=0;
		while(loopFlag) {

		ranNum = (int) ((Math.random()) * 1000);
		String ranNumStr=ranNum+"";
		
			if(ranNumStr.length() != 3) {
				continue;
			}else {
				loopFlag=false;
			}//end if~else
			
		}//end while
		
		
		StringBuilder sb=new StringBuilder();
		
		sb.append(tDTO.getBookingNum()).append(personClassification).append(ranNum).append(cntId).append(System.currentTimeMillis());
		System.out.println("흠 ...."+sb.toString());
		
		
		qrImgName=sb.toString();
		
		
		return qrImgName;
	}//makeQRHash
	
	
	public TicketDTO createQR(TicketDTO tDTO) {
		int adultCnt, kidCnt;
		int adult=1, kid=1;
		
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:MM:ss");
		String idenStr=sdf.format(timestamp);
		idenStr=idenStr.replace("-", "").replace(" ", "").replace(":", "");
		
		List<TicketDetailDTO> list=new ArrayList<TicketDetailDTO>();
		
		FileUploadFTP fileUpload=null;
		
		MakeQR maQR=new MakeQR();
		TicketDetailDTO tdetailDTO=null;
		
		//test해보자구... authenCnt가 잘.. 나오는지.
		System.out.println("authenCnt====service================="+tDTO.getAuthenCnt());
		
		//tDTO.getCompanies();

		try {
			
			fileUpload=new FileUploadFTP(SiteProperty.gabiaIP, SiteProperty.gabiaId, SiteProperty.gabiaPass);
			
			//몇 개를 생성할까요?! adultcount, kidcount
			
			
			//대인 
			if(tDTO.getAdultCount() != 0) {
				for(adultCnt=1; adultCnt <= tDTO.getAdultCount(); adultCnt++) {
					tdetailDTO=new TicketDetailDTO();
					//1. 암호화된 이미지명을 가져오기
					String imgName=makeQRName(tDTO,adult,adultCnt);
					System.out.println("adult image "+ imgName);
					maQR.makeQR(imgName);
					//DB에 저장
					tdetailDTO.setAgeClassification("대인");
					tdetailDTO.setNumClassification(adultCnt);
					tdetailDTO.setQRHash(imgName);
					tdetailDTO.setQRCount(1);
					tdetailDTO.setImgPath(imgName);
					tdetailDTO.setEntryStatus('X');
					
					//우선 tDTO에 추가해주고, DB에 넘겨야하는 코드가 피요해해해해해해
					list.add(tdetailDTO);
					
					//QR 코드 서버로 전송
					fileUpload.uploadFile(SiteProperty.uploadQRPathInCom+imgName+".png", imgName+".png", "ticket/");
				}//end for
			
			}//end if
			
			
			//소인
			if(tDTO.getKidCount() != 0) {
				for(kidCnt=1; kidCnt <= tDTO.getKidCount(); kidCnt++) {
					tdetailDTO=new TicketDetailDTO();
					//이미지명 가져오기.
					String imgName=makeQRName(tDTO,kid,kidCnt);
					maQR.makeQR(imgName);
					
					
					//DB에 저장
					tdetailDTO.setAgeClassification("소인");
					tdetailDTO.setNumClassification(kidCnt);
					tdetailDTO.setQRHash(imgName);
					tdetailDTO.setQRCount(1);
					tdetailDTO.setImgPath(imgName);
					
					//우선 tDTO에 추가해주고, DB에 넘겨야하는 코드가 피요해해해해해해
					list.add(tdetailDTO);
					
					
					//QR 코드 서버로 전송
					fileUpload.uploadFile(SiteProperty.uploadQRPathInCom+imgName+".png", imgName+".png", "ticket/");
					
				}//end for
				
				
				tDTO.setCompanies(list);
				
			}//end if
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			fileUpload.disconnect();
		}//end try~catch~finally
		
		
		return tDTO;
	}//createQR
	
	
	
	/*사용자에게 URL 보내기*/
	public void sendURL(TicketDTO tDTO) {
		System.out.println("===================sendURL=============================");
		SendMessage sendMsg=new SendMessage();
		StringBuilder sb=new StringBuilder();
		List<TicketDetailDTO> list=tDTO.getCompanies();
		TicketDetailDTO detailDTO=null;
		
		for(int i=0;i<list.size();i++) {
			detailDTO=new TicketDetailDTO();
			detailDTO=list.get(i);
			
			sb.append(detailDTO.getAgeClassification()).append(" ").append(detailDTO.getNumClassification()).append("\n")
			.append(SiteProperty.gabiaPath).append(detailDTO.getQRHash()).append(".png")
			.append("\n\n");
			
			System.out.println("sb--------------"+sb.toString());
		}//end for
		
		sendMsg.sendMessage(tDTO.getPhoneNum(), sb.toString());
		
	}//sendURL
	
	
}// class
