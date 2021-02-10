package controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Inquiry;
import model.Member;
import service.AdminService;
import service.MemberService;

@Controller
public class AdminController {

	@Autowired
	private AdminService aService;
	
	@Autowired
	private MemberService mService;

	// 태그
	//메인추천 화면 로딩
	@RequestMapping("adminRecommandTag.do")
	public ModelAndView adminRecommandTag() {
		ModelAndView mav = new ModelAndView();
		// 현재 설정된 메인추천 1, 2
		mav.addObject("main1", aService.showMain1());
		mav.addObject("main2", aService.showMain2());
		// 드롭다운에 들어갈 themetags 출력
		List<Admin> themeList =  aService.showThemeTags();
		mav.addObject("themes", themeList);
		mav.addObject("themesCnt", themeList.size());
		mav.setViewName("Admin/adminRecommandTag");
		return mav;
	}

	// ed 관리자가 메인추천 태그 적용
	@RequestMapping("selectMain1.do")
	public String selectMain1(String type, String keyword) {
		// 업데이트하기
		aService.updateMains(type, keyword);
		return "redirect:adminRecommandTag.do";
	}
	
	// ed 관리자가 메인추천 태그 적용
	@RequestMapping("selectMain2.do")
	public String selectMain2(String type, String keyword) {
		// 업데이트하기
		aService.updateMains(type, keyword);
		return "redirect:adminRecommandTag.do";
	}

	// ed 관리자 테마 페이지 로드
	@RequestMapping("adminThemeTag.do")
	public ModelAndView adminThemeTag() {
		ModelAndView mav = new ModelAndView();
		// themeTags 출력
		mav.addObject("themeTags", aService.showThemeTags());
		mav.setViewName("Admin/adminThemeTag");
		return mav;
	}

	// ed 관리자 테마 페이지 테마태그 추가
	@RequestMapping("insertThemeTag.do")
	public String insertThemeTag(String keyword) {
		aService.insertThemeTag(keyword);
		return "redirect:adminThemeTag.do";
	}

	// ed 관리자 음식 페이지 로드
	@RequestMapping("adminFoodTag.do")
	public ModelAndView adminFoodTag() {
		ModelAndView mav = new ModelAndView();
		// FoodTags 출력
		mav.addObject("foodTags", aService.showFoodTags());
		mav.setViewName("Admin/adminFoodTag");
		return mav;
	}

	// ed 관리자 음식 페이지 테마태그 추가
	@RequestMapping("insertFoodTag.do")
	public String insertFoodTag(String keyword,
			@RequestParam(value="afile") MultipartFile afile) {
		aService.insertFoodTag(keyword, afile);
		return "redirect:adminFoodTag.do";
	}

	// ed 관리자 맛 페이지 로드
	@RequestMapping("adminTasteTag.do")
	public ModelAndView adminTasteTag() {
		ModelAndView mav = new ModelAndView();
		// TasteTags 출력
		mav.addObject("tasteTags", aService.showTasteTags());
		mav.setViewName("Admin/adminTasteTag");
		return mav;
	}

	// ed 관리자 맛 페이지 테마태그 추가
	@RequestMapping("insertTasteTag.do")
	public String insertTasteTag(String keyword) {
		aService.insertTasteTag(keyword);
		return "redirect:adminTasteTag.do";
	}

	// ed 태그삭제
	@RequestMapping("deleteTag.do")
	public String deleteTag(int anum) {
		aService.deleteTag(anum);
		return "redirect:adminRecommandTag.do";
	}
	
	// 맛 태그삭제
	@RequestMapping("deleteTasteTag.do")
	public String deleteTasteTag(int anum) {
		aService.deleteTag(anum);
		return "redirect:adminTasteTag.do";
	}
	
	// 테마 태그삭제
	@RequestMapping("deleteThemeTag.do")
	public String deleteThemeTag(int anum) {
		aService.deleteTag(anum);
		return "redirect:adminThemeTag.do";
	}
	
	// 음식 태그삭제
	@RequestMapping("deleteFoodTag.do")
	public String deleteFoodTag(int anum) {
		aService.deleteTag(anum);
		return "redirect:adminFoodTag.do";
	}

	// 1:1문의
	// ed 1:1문의 전체 글 불러오기
	@RequestMapping("selectAllInquirys.do")
	public ModelAndView selectAllInquirys() throws Exception{
		ModelAndView mav = new ModelAndView();
		// 모든 1:1문의 글 출력
		mav.addObject("Inquirys", aService.selectAllInquirys());
		mav.addObject("CountAll", aService.countAllInquirys());
		mav.addObject("CountYes", aService.countYesInquirys());
		mav.addObject("CountNo", aService.countNoInquirys());
		mav.addObject("Ids", aService.selectIdsAndPhones().get("ids"));
		mav.addObject("Phones", aService.selectIdsAndPhones().get("Phones"));
		mav.setViewName("Admin/adminInquirys");
		return mav;
	}

	// ed 1:1문의 답변완료 글 불러오기
	@RequestMapping("selectYesInquirys.do")
	public ModelAndView selectYesInquirys() throws Exception{
		ModelAndView mav = new ModelAndView();
		// 답변완료 1:1문의 글 출력
		mav.addObject("Inquirys", aService.selectYesInquirys());
		mav.addObject("CountAll", aService.countAllInquirys());
		mav.addObject("CountYes", aService.countYesInquirys());
		mav.addObject("CountNo", aService.countNoInquirys());
		mav.addObject("Ids", aService.selectIdsAndPhones().get("ids"));
		mav.addObject("Phones", aService.selectIdsAndPhones().get("Phones"));
		mav.setViewName("Admin/adminInquirys");
		return mav;
	}

	// ed 1:1문의 페이지 로드
	@RequestMapping("selectNoInquirys.do")
	public ModelAndView selectNoInquirys() throws Exception{
		ModelAndView mav = new ModelAndView();
		// 답변 미완료 1:1문의 글 출력
		mav.addObject("Inquirys", aService.selectNoInquirys());
		mav.addObject("CountAll", aService.countAllInquirys());
		mav.addObject("CountYes", aService.countYesInquirys());
		mav.addObject("CountNo", aService.countNoInquirys());
		mav.addObject("Ids", aService.selectIdsAndPhones().get("ids"));
		mav.addObject("Phones", aService.selectIdsAndPhones().get("Phones"));
		mav.setViewName("Admin/adminInquirys");
		return mav;
	}

	//ed 키워드로 글 검색
	@RequestMapping("searchInquirys.do")
	public @ResponseBody HashMap<String, Object> searchInquirys(String type, String keyword) throws Exception{
		HashMap<String, Object> hm = new HashMap<String, Object>();
//		검색글 출력
		hm.put("inquiry", aService.searchInquirys(type, keyword).get("allInquirys"));
		List<Member> member = new ArrayList<Member>();
		
//		회원정보 구하기
		for (Inquiry inquiry: aService.searchInquirys(type, keyword).get("allInquirys")) {
			member.add(mService.checkId(inquiry.getMid()));
		}
		
		hm.put("allSize", aService.searchInquirys(type, keyword).get("allInquirys").size());
		hm.put("yesSize", aService.searchInquirys(type, keyword).get("yesInquirys").size());
		hm.put("noSize", aService.searchInquirys(type, keyword).get("noInquirys").size());
		hm.put("member", member);
		//검색결과 출력
		return hm;
	}
	
	/*
	 * // ed 1:1문의 답변완료 글 불러오기
	 * 
	 * @RequestMapping("selectYesInquirys.do") public ModelAndView
	 * selectYesInquirys() { ModelAndView mav = new ModelAndView(); // 답변완료 1:1문의 글
	 * 출력 mav.addObject("Inquirys", aService.selectYesInquirys());
	 * mav.addObject("CountAll", aService.countAllInquirys());
	 * mav.addObject("CountYes", aService.countYesInquirys());
	 * mav.addObject("CountNo", aService.countNoInquirys());
	 * mav.addObject("Members", aService.selectYesMemberInfo());
	 * mav.setViewName("Admin/adminInquirys"); return mav; }
	 */
	
	//ed 글 상세보기
	@RequestMapping("selectOneInquiry.do")
	public @ResponseBody Inquiry selectOneInquiry(int inum) {
		return aService.selectOneInquiry(inum);
	}
	
	//ed 답변등록
	@RequestMapping("insertInquiryAnswer.do")
	public @ResponseBody void insertInquiryAnswer(int inum, String ianswer) {
		aService.insertInquiryAnswer(inum, ianswer);
	}
	
	//ed 저장된 이미지 불러오기
	@RequestMapping("downloadAimage.do")
	public View download(int anum) {
		File attachFile= aService.getAttachedFile(anum);
		View view = new DownloadView(attachFile);
		
		return view;
	}
}