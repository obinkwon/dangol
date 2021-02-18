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
	public List<Inquiry> selectInquiryList(Inquiry inquiry);
	//전체 글 갯수
	public List<Inquiry> inquiryListCount();
	//글 상세보기
	public Inquiry selectInquiry(Inquiry inquiry);
	//답변등록하기
	public int insertInquiryAnswer(Inquiry inquiry);
	
}
