package kr.co.gungon.ticket.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.ticket.TicketDTO;
import kr.co.gungon.ticket.TicketDetailDTO;

/**
 * 
 */
public class TicketDAO {

	private static TicketDAO ticketDAO;

	private TicketDAO() {

	}// TicketDAO

	public static TicketDAO getInstance() {
		if (ticketDAO == null) {
			ticketDAO = new TicketDAO();
		} // end if

		return ticketDAO;
	}// getInstance

	/*
	  DB에 데이터를 넣는 method //booking_num, program_id, payer, phone_number,
	  comment_flag, reserve_date, comment_lang, payment //근데 테스트에서 내가 임의로 넣을 값들은 /
	  program_id / payer / phone_number / 이 3개
	  */ 
	  public void insertReservationValue(TicketDTO ticketDTO) throws SQLException {
		  DbConnection db=DbConnection.getInstance();
		  System.out.println("insertReservationValue==============="+ticketDTO.getCompanies().size());
	  
		  ResultSet rs=null; PreparedStatement pstmt=null; Connection con=null;
		  
		  try { //1.JNDI 사용객체 생성 //2.DBCP에서 연결객체 얻기(DataSource) //3.Connection 얻기
		  con=db.getDbConn(); //4.쿼리문 생성객체 얻기 
		  StringBuilder insertQuery=new StringBuilder(); 
		  insertQuery.append("	insert into ticket_reservation	")
		  			.append("	values(?,?,?,?,?,?,?,?,?)	") ;
		  
		  
		  pstmt=con.prepareStatement(insertQuery.toString()); 
		  
		  
		  //5.바인드 변수에 값 할당
		  pstmt.setString(1, ticketDTO.getBookingNum());//예매번호 
		  pstmt.setInt(2, selectProgramId(ticketDTO.getProgramName()));//여기에는 select해서 가져온 "행사이름"이 들어가야 한다.//내가가지고 있는건 행사이름//근데 이게 foreign key 야 ....
		  pstmt.setString(3, ticketDTO.getMember_id());
		  pstmt.setString(4, ticketDTO.getPhoneNum());
		  pstmt.setInt(5, ticketDTO.getAuthenCnt());
		  pstmt.setObject(6, ticketDTO.getCommentFlag(), java.sql.Types.CHAR);
		  pstmt.setString(7, ticketDTO.getReserveDate());
		  pstmt.setInt(8, ticketDTO.getPayment());
		  pstmt.setString(9, ticketDTO.getPaymentTimeStamp());
		  
		  
		  //6.쿼리문 수행 후 결과를 얻기 
		  rs=pstmt.executeQuery();//아마 결과가 boolean으로 나올 텐테... 이걸받을까 말까
		  
		  }finally { 
			  //7.연결 끊기 
			  db.dbClose(rs, pstmt, con); 
		  }//try~finally
	  	
		  
		  insertCalcReservationDetail(ticketDTO.getBookingNum(), ticketDTO.getCompanies());
	 
	 }//end insertReservationValue

	
	/**
	 * 프로그램 이름을 가지고 프로그램 아이디를 가져오기
	 * 
	 * @return
	 * @throws SQLException
	 */
	private int selectProgramId(String ProgramName) throws SQLException {
		int programId = 0;

		DbConnection db = DbConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append("	select program_id from program	").append("	where program_name=?	");

			pstmt = con.prepareStatement(selectQuery.toString());
			// 5.바인드 변수에 값 할당
//				pstmt.setString(1, ticketDTO.getProgramName());
			pstmt.setString(1, ProgramName);

			// 6.쿼리문 수행 후 결과를 얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				programId = rs.getInt("program_id");
			} // end if
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // try~finally

		return programId;
	}// end selectProgramId

	
	public void insertCalcReservationDetail(String bookingNum, List<TicketDetailDTO> ticketDetailList) throws SQLException {
		/*여기서 list 처리도 해야함*/
		
		
		DbConnection db=DbConnection.getInstance();
		
		TicketService ts=new TicketService();
		  
		ResultSet rs=null; PreparedStatement pstmt=null; Connection con=null;
		
		  
		  
		  try { 
			  //1.JNDI 사용객체 생성 
			  //2.DBCP에서 연결객체 얻기(DataSource) 
			  //3.Connection 얻기
			  con=db.getDbConn(); 
			  TicketDetailDTO ticketDetailDto=new TicketDetailDTO();
			  for(int i=0;i<ticketDetailList.size();i++) {
			  
				  //4.쿼리문 생성객체 얻기 
				  StringBuilder insertQuery=new StringBuilder(); 
				  ticketDetailDto=ticketDetailList.get(i);
				  
				  
				  insertQuery.append("	insert into ticket_reservation_detail (IDENTIFICATION_NUM, BOOKING_NUM, AGE_CLASSIFICATION, NUM_CLASSIFICATION ,QR_HASH, QR_COUNT, ENTRY_STATUS)	")
				  			.append("	values(?,?,?,?,?,?,?)	") ;
				  
				  
				  pstmt=con.prepareStatement(insertQuery.toString()); 
				  
				  
				  //5.바인드 변수에 값 할당
				  pstmt.setString(1,"1");//IdentificationNum
				  pstmt.setString(2, bookingNum);//booking_num, 여기서 생성해서 넣어야해 
				  pstmt.setObject(3, ts.makeClassificationStr(ticketDetailDto.getAgeClassification()), java.sql.Types.CHAR);//age_classification, 대인 1, 소인 2 
				  pstmt.setInt(4, ticketDetailDto.getNumClassification());//num_classification
				  pstmt.setString(5, ticketDetailDto.getQRHash());//QR_Hash
				  pstmt.setInt(6, ticketDetailDto.getQRCount());//QR_Count
				  pstmt.setObject(7, ticketDetailDto.getEntryStatus(),java.sql.Types.CHAR);//Entry_Status
				 
				  
				  //6.쿼리문 수행 후 결과를 얻기 
				  rs=pstmt.executeQuery();//아마 결과가 boolean으로 나올 텐테... 이걸받을까 말까
			  }//end for
		  
		  }finally { 
			  //7.연결 끊기 
			  db.dbClose(rs, pstmt, con); 
		  }//try~finally
		  
		  
	}//end insertReservationDetail
	
	
	//행사 이름으로, 시작날짜, 끝날짜 받기
	public String selectProgramDate(String programName) throws SQLException {
		String programDate=null;
		StringBuilder sb=new StringBuilder();
		
		DbConnection db = DbConnection.getInstance();

		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;

		try {
			// 1.JNDI 사용객체 생성
			// 2.DBCP에서 연결객체 얻기(DataSource)
			// 3.Connection 얻기
			con = db.getDbConn();
			// 4.쿼리문 생성객체 얻기
			StringBuilder selectQuery = new StringBuilder();
			selectQuery.append("	select start_Date, end_date from program where program_name=?");

			pstmt = con.prepareStatement(selectQuery.toString());
			// 5.바인드 변수에 값 할당
//				pstmt.setString(1, ticketDTO.getProgramName());
			pstmt.setString(1, programName);

			// 6.쿼리문 수행 후 결과를 얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
			sb.append(rs.getString("start_date")).append(",").append(rs.getString("end_date"));
			} // end if
		} finally {
			// 7.연결 끊기
			db.dbClose(rs, pstmt, con);
		} // try~finally
		
		programDate=sb.toString();
		
		return programDate;
	}//selectProgramDate
	
	// 행사 이름으로 프로그램 삭제하기
	public int deleteTicket(String booking_num) throws SQLException {
	    DbConnection db = DbConnection.getInstance();

	    PreparedStatement pstmt = null;
	    Connection con = null;
	    int deletedRowCount = 0;

	    try {
	        con = db.getDbConn();

	        String deleteQuery = "DELETE FROM ticket_reservation WHERE booking_num = ?";
	        pstmt = con.prepareStatement(deleteQuery);
	        pstmt.setString(1, booking_num);

	        // 삭제된 행 수 반환
	        deletedRowCount = pstmt.executeUpdate();

	    } finally {
	        db.dbClose(null, pstmt, con);
	    }

	    return deletedRowCount; // 몇 개 삭제됐는지 리턴
	}
	
	
}// class
