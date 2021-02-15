package dao;

import java.util.List;

import model.Admin;
import model.Inquiry;

public interface IAdminDao {
	
	//태그
	//메인 태그
	public Admin showMain(Admin admin);
	public int updateMain(Admin admin);
	
	//태그 추가
	public int insertTag(Admin admin);

	//태그 삭제
	public int deleteTag(Admin admin);
	
	//테마 태그
	public List<Admin> showThemeTags();
	
	//adminTasteTag 페이지
	public List<Admin> showTasteTags();
	
	//adminFoodTag 페이지
	public List<Admin> showFoodTags();
	
	
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
