package kr.co.gungon.course;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CourseDTO {

    private int course_Num;        
    private String member_Id;      
    private String course_Title;   
    private String course_Content; 
    private double course_Rating;  
    private int course_Rating_Cnt;  
    private Date course_Reg_Date;   
    private int gung_Id;           
	
}//class
