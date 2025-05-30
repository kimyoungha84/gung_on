package kr.co.gungon.admin;

public class AdminService {
    private AdminDAO adminDAO = AdminDAO.getInstance();

    public boolean loginCheck(String id, String pass) {
        return adminDAO.login(id, pass) != null;
    }
}