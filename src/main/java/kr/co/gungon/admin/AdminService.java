package kr.co.gungon.admin;

import java.sql.SQLException;

import kr.co.gungon.member.MemberDAO;
import kr.co.gungon.member.MemberDTO;
import kr.co.gungon.util.EncryptUtil;

public class AdminService {
    private AdminDAO adminDAO = AdminDAO.getInstance();
    private MemberDAO mDao = MemberDAO.getInstance();

    public boolean loginCheck(String id, String pass) {
        String hashedPw = EncryptUtil.sha256(pass); 
       System.out.println("입력된 해시값: " + hashedPw); 
        return adminDAO.login(id, hashedPw) != null;
    }

    public MemberDTO getMemberDetail(String id) throws SQLException {
        return mDao.selectMemberById(id);
    }
}