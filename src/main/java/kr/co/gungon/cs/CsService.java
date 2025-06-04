package kr.co.gungon.cs;

import java.sql.SQLException;
import java.util.List;




public class CsService {

	public boolean addNotice(NoticeDTO nDTO) {
		boolean flag = false;
		
		try {
			CsDAO.getInstance().insertNotice(nDTO);
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		return flag;
	}
	
	public boolean modifyNotice(NoticeDTO nDTO) {
		
		boolean flag = false;
		
		try {
			flag = CsDAO.getInstance().updateNotice(nDTO) == 1;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	
	
	
	public int totalNoticeCount( FilteringInfo fi ) {
		
		int cnt = 0;
		var csDAO = CsDAO.getInstance();
		try {
			cnt = csDAO.selectTotalNoticeCount(fi);
		} catch (SQLException e) {
			e.printStackTrace();
		}//catch
		return cnt;
	}//totalCount
	
	
	public NoticeDTO searchOneNotice(int num) {
		NoticeDTO bDTO = null;
		try {
			bDTO = CsDAO.getInstance().selectOneNotice(num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bDTO;
	}//searchOneBoard
	
	
	
	
	public List<NoticeDTO> searchNotice(FilteringInfo fi){
		List<NoticeDTO> list = null;
		
		try {
			list = CsDAO.getInstance().selectNotice(fi);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	public boolean removeNotices(List<Integer> noticeNums) {
		
		boolean flag = false;
		
		try {
			flag = CsDAO.getInstance().deleteNotices(noticeNums) > 0;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public void addViews(int num) {
		try {
		CsDAO.getInstance().updateNoticeView(num);
				
		} catch (SQLException e) {
				e.printStackTrace();
		}
	
	}
		
	
	//===========================================================================================================================================================================================
		//===========================================================================================================================================================================================
		
//		FAQ
	
	public boolean addFaq(FaqDTO fDTO) {
	    boolean flag = false;

	    try {
	        CsDAO.getInstance().insertFaq(fDTO);
	        flag = true;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}
	
	public boolean modifyFaq(FaqDTO fDTO) {
	    boolean flag = false;

	    try {
	        flag = CsDAO.getInstance().updateFaq(fDTO) == 1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}
	
	public int totalFaqCount(FilteringInfo fi) {
	    int cnt = 0;
	    var csDAO = CsDAO.getInstance();
	    try {
	        cnt = csDAO.selectTotalFaqCount(fi);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return cnt;
	}
	
	public FaqDTO searchOneFaq(int num) {
		FaqDTO fDTO = null;
	    try {
	    	fDTO = CsDAO.getInstance().selectOneFaq(num);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return fDTO;
	}

	
	public List<FaqDTO> searchFaq(FilteringInfo fi) {
	    List<FaqDTO> list = null;

	    try {
	        list = CsDAO.getInstance().selectFaq(fi);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public boolean removeFaqs(List<Integer> faqNums) {
	    boolean flag = false;

	    try {
	        flag = CsDAO.getInstance().deleteFaqs(faqNums) > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}

	
	//===========================================================================================================================================================================================
	//===========================================================================================================================================================================================
	
//	Inquiry


	public boolean addInquiry(InquiryDTO iDTO) {
	    boolean flag = false;
	    try {
	        CsDAO.getInstance().insertInquiry(iDTO);
	        flag = true;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}

	public boolean modifyInquiry(InquiryDTO iDTO) {
	    boolean flag = false;
	    try {
	        flag = CsDAO.getInstance().updateInquiry(iDTO) == 1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}

	public int totalInquiryCount(InquiryFilteringInfo ifi) {
	    int cnt = 0;
	    var csDAO = CsDAO.getInstance();
	    try {
	        cnt = csDAO.selectTotalInquiryCount(ifi);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return cnt;
	}

	public InquiryDTO searchOneInquiry(int num) {
	    InquiryDTO iDTO = null;
	    try {
	        iDTO = CsDAO.getInstance().selectOneInquiry(num);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return iDTO;
	}

	public List<InquiryDTO> searchInquiry(InquiryFilteringInfo ifi) {
	    List<InquiryDTO> list = null;
	    try {
	        list = CsDAO.getInstance().selectInquiries(ifi);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public boolean removeInquiries(List<Integer> inquiryNums) {
	    boolean flag = false;
	    try {
	        flag = CsDAO.getInstance().deleteInquiries(inquiryNums) > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return flag;
	}
	
	public List<InquiryDTO> searchUserInquiries(InquiryFilteringInfo ifi, String userId){
		
		List<InquiryDTO> list = null;
		  try {
		      list = CsDAO.getInstance().selectUserInquiries(ifi, userId);
		  } catch (SQLException e) {
		      e.printStackTrace();
		  }
		  return list;
	}
	
	public int totalUserInquiries( String userId ) {
		int cnt = 0;
		try {
			cnt = CsDAO.getInstance().CountUserInquiries(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	
	
}//class
