package kr.co.gungon.program;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ProgramDTO {
    private int programId;         // 행사번호
    private String programPlace;   // 행사장소
    private String programName;    // 행사이름
    private Date startDate;        // 행사시작일
    private Date endDate;          // 행사종료일
    private Timestamp reservationStartDate; // 예약시작일
    private Timestamp reservationEndDate;   // 예약종료일
    private Timestamp openTime;    // 행사시작시간
    private Timestamp closeTime;   // 행사종료시간
    private int priceAdult;        // 대인 요금
    private int priceChild;        // 소인 요금
    private String languageKorean; // 언어 ('선택안함', '한국어', '영어')
    private String contactPerson;  // 담당자
    private String progImgName;    // 이미지 파일명
}