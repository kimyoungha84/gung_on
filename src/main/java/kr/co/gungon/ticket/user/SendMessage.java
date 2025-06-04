package kr.co.gungon.ticket.user;

import kr.co.gungon.ticket.ticketConfig.SiteProperty;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

public class SendMessage {
	
	public void sendMessage(String phoneNumber, String sendMsg) {
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize(SiteProperty.coolsmsAPI1, SiteProperty.coolsmsAPI2, "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		Message message=new Message();
	
		message.setFrom(SiteProperty.authenPhoneNum);
		message.setTo(SiteProperty.authenPhoneNum);
		
		
		if(sendMsg.matches("^[0-9]{6}$")) {
			message.setText("인증번호를 입력해주세요.\n"+sendMsg);//인증번호(String) 넣기 - 6자리 RandomNumber
		}else {
			//URL 전송~~!!
			message.setText(sendMsg);
			
			System.out.println(sendMsg);
			
		}//end if~else
		
	/*
		try {
		  // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
			//messageService.send(message);
			messageService.send(message);
		} catch (NurigoMessageNotReceivedException ne) {
		  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		  System.out.println(ne.getFailedMessageList()); 
		  System.out.println(ne.getMessage());
		} catch (Exception ex) {
		  System.out.println(ex.getMessage());
		}//end try~catch
		
		*/
	}//makeMessage
	
}//class
