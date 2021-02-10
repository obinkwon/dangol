package service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IinquiryDao;
import model.Inquiry;

@Service
public class inquiryService {

	@Autowired
	private IinquiryDao idao;
	
	public List<Inquiry> selectInquiryByMid(String mid) {
			List<Inquiry> inquiry = idao.selectInquiryByMid(mid);
		return inquiry;
	}
	public List<Inquiry> selectInquiryByBid (String bid){
		List<Inquiry> inquiry = idao.selectInquiryByBid(bid);
		return inquiry;
	}
	public void deleteInquiryOne(int inum){
		idao.deleteInquiryOne(inum);
		
	}
	public void insertInquiry(Inquiry inquiry) {
		idao.insertInquiry(inquiry);
	}
	public Inquiry selectInquiryOne(int inum){
		Inquiry inquiry=idao.selectInquiryOne(inum);
	return inquiry;
	}
	public List<Inquiry> searchInquiryListByMid (String mid ,String keyword){
		HashMap<String,Object> param= new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("keyword", keyword);
		List<Inquiry>inquiry= idao.searchInquiryListByMid(param);
		return inquiry;
	}
	public List<Inquiry>searchInquiryListByBid(String bid,String keyword){
		HashMap<String,Object> param= new HashMap<String, Object>();
		param.put("bid", bid);
		param.put("keyword", keyword);
		List<Inquiry>inquiry= idao.searchInquiryListByBid(param);
		return inquiry;
	}
}
