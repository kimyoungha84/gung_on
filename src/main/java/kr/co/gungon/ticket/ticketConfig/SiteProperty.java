package kr.co.gungon.ticket.ticketConfig;

public class SiteProperty {
	private static SitePropertyVO sVO=SitePropertyVO.getInstance();
	static {
		
	}//static
	
	private SiteProperty() {
		
	}//SiteProperty
	
	
	public static String gungPicturePath=sVO.getGungPicturePath();
	
	public static String gabiaPath=sVO.getGabiaPath();
	public static String gabiaIP=sVO.getGabiaIP();
	public static String gabiaId=sVO.getGabiaId();
	public static String gabiaPass=sVO.getGabiaPass();
	public static String gabiaUsedCompleteImg=sVO.getGabiaUsedComplete();
	
	
	public static String authenPhoneNum=sVO.getAuthenPhoneNum();
	public static String coolsmsAPI1=sVO.getCoolsmsAPI1();
	public static String coolsmsAPI2=sVO.getCoolsmsAPI2();
	
	public static String qrStorePath=sVO.getQRStorePath();
	public static String uploadQRPathInCom=sVO.getUploadQRPathInCom();
	
	public static String defaultIP=sVO.getDefaultIP();
	
}//class
