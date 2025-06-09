package kr.co.gungon.ticket.ticketConfig;

import lombok.Getter;

public class SitePropertyVO {
	private static SitePropertyVO spVO;
	
	@Getter
	private String gungPicturePath, gabiaPath, authenPhoneNum, QRStorePath,
	uploadQRPathInCom,gabiaIP,gabiaId,gabiaPass,coolsmsAPI1, coolsmsAPI2, defaultIP,gabiaUsedComplete;
	
	/*매개변수 없는 생성자 Override*/
	private SitePropertyVO() {
		setConfig();
	}//SitePropertyVO
	
	
	
	
	/*Singletone*/
	public static SitePropertyVO getInstance() {
		if(spVO == null) {
			spVO=new SitePropertyVO();
		}//end if
		
		return spVO;
	}//getInstance
	
	
	private void setConfig() {
		//ticket 첫 화면에 나오는 궁 사진들
		gungPicturePath="http://211.63.89.140/Gung_On/ticket/images/";
		
		//외부 웹서버 경로
		gabiaPath="http://gungon.gabia.io/ticket/QR/";
		gabiaIP="211.47.74.55";
		gabiaId="gungon";
		gabiaPass="gungon123*";
		gabiaUsedComplete="http://gungon.gabia.io/ticket/usedComplete.png";
		
		//핸드폰 인증 관리자 번호
		authenPhoneNum="01055111702";
		coolsmsAPI1="NCSJU2XVPMNHA9UX";
		coolsmsAPI2="C7VEZUMZLWOQXDQGFKU7DWU80VPPTZJP";
		
		//QR코드에 넣어서 만들 링크, QR 코드를 찍으면 이 링크가 나온다.
		QRStorePath="http://211.63.89.140/Gung_On/ticket/ticketProcess/qr_process.jsp";
		
		//내부 컴퓨터의 저장 경로
		uploadQRPathInCom="/Gung_On/common/images/upload/QR/";
		
		defaultIP="211.63.89.140";
		
		
	}//setConfig
	
}//class
