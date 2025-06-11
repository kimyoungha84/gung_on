package kr.co.gungon.admin;

import java.sql.SQLException;
import java.util.Collections;
import java.util.Map;

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

    // 행사별 예매 수 통계 
    public Map<String, Integer> getReservationChartData() {
        try {
            return dao.getReservationCountByProgram();
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyMap();
        }
    }
}