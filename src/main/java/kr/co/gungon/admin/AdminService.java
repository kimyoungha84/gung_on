package kr.co.gungon.admin;

import java.sql.SQLException;

import kr.co.gungon.member.MemberDAO;
import kr.co.gungon.member.MemberDTO;

public class AdminService {
    private AdminDAO adminDAO = AdminDAO.getInstance();

    public boolean loginCheck(String id, String pass) {
        return adminDAO.login(id, pass) != null;
    }
    
    private MemberDAO mDao = MemberDAO.getInstance();

    public MemberDTO getMemberDetail(String id) throws SQLException {
        return mDao.selectMemberById(id);
    }
    
}