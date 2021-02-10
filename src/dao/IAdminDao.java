package dao;

import java.util.List;

import model.Admin;
import model.Inquiry;

public interface IAdminDao {
	
	//태그
	//adminRecommand 페이지
	public Admin showMain1();
	public Admin showMain2();
//	public List<Admin> showThemeTags(); 드롭다운 구현할 때
	public void updateMain1(String main1);
	public void updateMain2(String main2);

	//adminThemeTag 페이지 로드
	public List<Admin> showThemeTags();
	public void insertThemeTag(String keyword);
	
	//adminTasteTag 페이지
	public List<Admin> showTasteTags();
	public void insertTasteTag(String keyword);
	
	//adminFoodTag 페이지
	public List<Admin> showFoodTags();
	public void insertFoodTag(Admin admin);
	
	//태그 삭제할 때
	public void deleteTag(int anum);
	
	//사진추가 관련
	public Admin selectOneAdmin(int anum);
	
	//1:1문의
	//전체 글, 답변완료, 미완료 글 조회
	public List<Inquiry> selectAllInquirys();
	public int countAllInquirys();
	public List<Inquiry> selectYesInquirys();
	public int countYesInquirys();
	public List<Inquiry> selectNoInquirys();
	public int countNoInquirys();
	
	//글 상세보기
	public Inquiry selectOneInquiry(int inum);
	
	//답변등록하기
	public void insertInquiryAnswer(Inquiry inquiry);
	
//	글 검색하기
	//제목으로 글 검색하기
	public List<Inquiry> selectInquirysByTitle(String keyword);
	public List<Inquiry> selectYesInquirysByTitle(String keyword);
	public List<Inquiry> selectNoInquirysByTitle(String keyword);

	//내용으로 글 검색하기
	public List<Inquiry> selectInquirysByContent(String keyword);
	public List<Inquiry> selectYesInquirysByContent(String keyword);
	public List<Inquiry> selectNoInquirysByContent(String keyword);

	//아이디로 글 검색하기
	public List<Inquiry> selectInquirysByMid(String keyword);
	public List<Inquiry> selectYesInquirysByMid(String keyword);
	public List<Inquiry> selectNoInquirysByMid(String keyword);
	
}
