package kr.co.gungon.ticket;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class TicketDetailDTO {
	String ageClassification, entryTime, QRHash, QRData, imgPath,EntryStatus;

	int authenCount, QRCount,numClassification;
	
}//class


