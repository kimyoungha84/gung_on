package kr.co.gungon.gung;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class GungDTO {
    private int gung_id;
    private String gung_name;
    private String gung_info;
    private String gung_history;
    private Date gung_reg_date;
    

 // GungDTO.java
    private String img_path;


}
