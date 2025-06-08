package kr.co.gungon.admin;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DashboardInfoDTO {
    private int totalMembers;
    private int withdrawnMembers;
    private int todayJoinMembers;
    
    private int noticeCount;
    private int unansweredCount;
    private int answeredCount;

}