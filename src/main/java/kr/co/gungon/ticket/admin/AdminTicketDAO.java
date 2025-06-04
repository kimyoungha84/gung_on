package kr.co.gungon.ticket.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.gungon.config.DbConnection;

public class AdminTicketDAO {

	 public void updateEntryStatus(String imgHash) throws SQLException {
		  DbConnection db=DbConnection.getInstance();
	  
		  ResultSet rs=null; PreparedStatement pstmt=null; Connection con=null;
		  AdminTicketService ats=new AdminTicketService();
		  
		  try { 
			 //1.JNDI 사용객체 생성 
			  //2.DBCP에서 연결객체 얻기(DataSource) 
			  //3.Connection 얻기
			  con=db.getDbConn(); 
			  //4.쿼리문 생성객체 얻기 
			  StringBuilder insertQuery=new StringBuilder(); 
			  insertQuery.append("	update  ticket_reservation_detail	")
			  			.append("	set entry_status='O', entry_time=?	")
			  			.append(	"where     qr_hash=?");
			  
			  
			  pstmt=con.prepareStatement(insertQuery.toString()); 
			  
			  
			  //5.바인드 변수에 값 할당
			  pstmt.setString(1, ats.nowTimestamp());
			  pstmt.setString(2, imgHash);
		
			  
			  //6.쿼리문 수행 후 결과를 얻기 
			  rs=pstmt.executeQuery();//아마 결과가 boolean으로 나올 텐테... 이걸받을까 말까
		  
		  }finally { 
			  //7.연결 끊기 
			  db.dbClose(rs, pstmt, con); 
		  }//try~finally
	  	
	 }//end insertReservationValue
	

	
}//class
