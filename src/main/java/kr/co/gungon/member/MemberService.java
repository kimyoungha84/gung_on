package kr.co.gungon.member;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.gungon.ticket.admin.AdminTicketService;
import kr.co.gungon.ticket.admin.TicketAdminDTO;
import kr.co.sist.cipher.DataEncryption;


public class MemberService {

	public boolean searchId(String id) {
		boolean flag = false;
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		try {
			flag=mDAO.selectId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
	}//searchId
	
	public boolean addMember(MemberDTO mDTO) {
		
		boolean flag=false;
		//mDTO객체의 값 중 email과 domain을 합쳐서 useEmail할당
		mDTO.setUseEmail(mDTO.getEmail()+"@"+mDTO.getDomain());
		try {
			mDTO.setPass(DataEncryption.messageDigest("SHA-256", mDTO.getPass()));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		MemberDAO mDAO = MemberDAO.getInstance();
		
		try {
			mDAO.insertMember(mDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		
		return flag;
	}//addMember
	
	public List<MemberDTO> searchAllMember(String role){
		
		List<MemberDTO> list = null;
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		
			try {
				list=mDAO.selectAllMember();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		
		return list;
	}//searchAllMember
	
	/**
	 * 하나의 회원을 검색
	 * @param id
	 * @return
	 */
	public MemberDTO searchOneMember(String id) {
		
		MemberDTO mDTO = null;
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
			try {
				mDTO = mDAO.selectOneMember(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		return mDTO;
		
	}//searchOneMember
	
	public String searchMemberName(String name, String email) {
		
		String id = "";
		
		MemberDAO mDAO = MemberDAO.getInstance();
		
		try {
			id = mDAO.selectMemberName(name,email);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return id;
		
	}//searchOneMember
	
	public boolean modifyMember(MemberDTO mDTO, HttpSession session) {
		boolean flag=false;
		mDTO.setUseEmail(mDTO.getEmail()+"@"+mDTO.getDomain());
		MemberDAO mDAO = MemberDAO.getInstance();
		try {
			mDAO.updateMember(mDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
	}//modifyMember
	
	public boolean modifyMemberPass(String id, String pass, HttpSession session) {
		boolean flag=false;
		MemberDAO mDAO = MemberDAO.getInstance();
		try {
			pass = (DataEncryption.messageDigest("SHA-256", pass));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		try {
			mDAO.updateMemberPass(id,pass);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
	}//modifyMemberPass
	
	public boolean removeMember(MemberDTO mDTO, HttpSession session) {
		boolean flag=false;
		MemberDAO mDAO = MemberDAO.getInstance();
		try {
			mDAO.deleteMember(mDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
	}//modifyMember
	
	
	public List<TicketAdminDTO> showMyTicketData(String id){
		AdminTicketService ats=new AdminTicketService();
		List<TicketAdminDTO> tlist = ats.showDefaultAdminPageData();
		List<TicketAdminDTO> myList=new ArrayList<TicketAdminDTO>();
		String programName=null, startTime=null, person=null;
		
		for(int i=0; i<tlist.size();i++) {
			if(tlist.get(i).getMember_id().equals(id)) {
				programName=ats.getProgramNameByprogramId(tlist.get(i).getProgramId());
				tlist.get(i).setProgram_name(programName); 
				tlist.get(i).setStartTime(ats.getProgramStartTimeByProgramId(tlist.get(i).getProgramId()));
				tlist.get(i).setPaymentStr(ats.changeCosttoStr(tlist.get(i).getPayment()));
				tlist.get(i).setPerson(ats.outputPersonalCount(tlist.get(i).getAdult_person(), tlist.get(i).getKid_person()));
				myList.add(tlist.get(i));
			}//end if
		}//end for
		
		return myList;
	}//end showMyTicketData
	
}//class
