package kr.co.gungon.admin;

import java.sql.SQLException;

public class AdminDashboardService {

    private AdminDashboardDAO dao = AdminDashboardDAO.getInstance();

    public DashboardInfoDTO getDashboardInfo() {
        DashboardInfoDTO dto = new DashboardInfoDTO();

        try {
            // 회원 통계
            dto.setTotalMembers(dao.getTotalMembers());
            dto.setWithdrawnMembers(dao.getWithdrawnMembers());
            dto.setTodayJoinMembers(dao.getTodayJoinMembers());

            // 고객센터 통계
            dto.setNoticeCount(dao.getNoticeCount());
            dto.setUnansweredCount(dao.getUnansweredInquiryCount());
            dto.setAnsweredCount(dao.getAnsweredInquiryCount());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dto;
    }
}