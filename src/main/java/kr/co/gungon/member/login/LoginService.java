package kr.co.gungon.member.login;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import kr.co.gungon.member.MemberDTO;
import kr.co.sist.cipher.DataEncryption;

public class LoginService {

	public boolean loginProcess( LoginDTO lDTO, HttpSession session) {
		
		boolean flag = false;
		
		LoginDAO lDAO = LoginDAO.getInstance();
		try {
			//비밀번호를 일방향 hash
			lDTO.setPass(DataEncryption.messageDigest("SHA-256", lDTO.getPass() ));
			MemberDTO mDTO=lDAO.selectId(lDTO);
			flag=mDTO!=null;//검색결과가 있을 때에는 true
			if(flag) {//로그인 성공
				session.setAttribute("userData", mDTO);
			}//end if
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
		
	}//loginProcess
	
}//class
