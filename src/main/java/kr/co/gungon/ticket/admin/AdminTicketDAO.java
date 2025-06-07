package kr.co.gungon.ticket.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.gungon.config.DbConnection;
import kr.co.gungon.ticket.TicketDTO;

public class AdminTicketDAO {
	private static AdminTicketDAO atDAO;
	
	private AdminTicketDAO() {
		
	}//AdminTicketDAO
	
	
	public static AdminTicketDAO getInstance() {
		if(atDAO==null) {
			atDAO=new AdminTicketDAO(); 
		}//end if
		
		return atDAO;
	}//getInstance
	
	
	

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
			  rs=pstmt.executeQuery();
		  
		  }finally { 
			  //7.연결 끊기 
			  db.dbClose(rs, pstmt, con); 
		  }//try~finally
	  	
	 }//end insertReservationValue
	
	 
	 public List<TicketAdminDTO> selectTicketManage() throws SQLException {
		 DbConnection db=DbConnection.getInstance();
		 
		 List<TicketAdminDTO> tlist=new ArrayList<TicketAdminDTO>();
		 TicketAdminDTO ticketAdminDTO=null;
		 
		 AdminTicketService ats=new AdminTicketService();
		  
		  ResultSet rs=null; PreparedStatement pstmt=null; Connection con=null;
		  
		  try { 
			 //1.JNDI 사용객체 생성 
			  //2.DBCP에서 연결객체 얻기(DataSource) 
			  //3.Connection 얻기
			  con=db.getDbConn(); 
			  //4.쿼리문 생성객체 얻기 
			  StringBuilder selectQuery=new StringBuilder(); 
			  selectQuery.append("	select t.booking_num,	")
			  			.append("	(select member_name from member where member_id=t.member_id) member_name,	")
			  			.append("	t.member_id,	")
			  			.append("	(select count(booking_num) from TICKET_RESERVATION_DETAIL where booking_num=t.booking_num) total_person,	")
			  			.append("	t.phone_number, t.comment_flag	")
			  			.append("	from  ticket_reservation t	")
			  			.append("	order by t.booking_num desc	")
			  			;
			  
			  pstmt=con.prepareStatement(selectQuery.toString()); 
			  
			  
			  //5.바인드 변수에 값 할당
		
			  
			  //6.쿼리문 수행 후 결과를 얻기 
			  rs=pstmt.executeQuery();
		  
			  while(rs.next()) {
				  ticketAdminDTO=new TicketAdminDTO();
				  ticketAdminDTO.setBooking_num(rs.getString("booking_num"));//booking_num
				  ticketAdminDTO.setMember_name(rs.getString("member_name"));//member_name
				  ticketAdminDTO.setMember_id(rs.getString("member_id"));//member_id
				  ticketAdminDTO.setTotal_person(rs.getString("total_person"));//total_person
				  ticketAdminDTO.setPhone_number(ats.appendDashtoPhoneNumber(rs.getString("phone_number")));//phone_number
				  ticketAdminDTO.setComment_flag(ats.changeCommentFlagToComment(rs.getString("comment_flag")));//comment_flag
				 
				  tlist.add(ticketAdminDTO);
			  }//end if
			  
		  }finally { 
			  //7.연결 끊기 
			  db.dbClose(rs, pstmt, con); 
		  }//try~finally
		
		  
		  return tlist;
	 }//end selectTicketManage

	
}//class
