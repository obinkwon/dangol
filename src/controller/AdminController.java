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
		Admin admin = new Admin();
		admin.setAtype("main1");
		Admin main1 = aService.showMain(admin);
		admin.setAtype("main2");
		Admin main2 = aService.showMain(admin);
		mav.addObject("main1", main1);
		mav.addObject("main2", main2);
		// 드롭다운에 들어갈 themetags 출력
		List<Admin> themeList =  aService.showThemeTags();
		mav.addObject("themes", themeList);
		mav.addObject("themesCnt", themeList.size());
		mav.setViewName("Admin/adminRecommandTag");
		return mav;
	}

	//관리자가 메인추천 태그 적용
	@RequestMapping("selectMain.do")
	public String selectMain(Admin admin) {
		if(admin.getAtype() != null) {
			Admin tag = aService.showMain(admin);
			if(tag == null) { //insert
				System.out.println(admin);
				aService.insertTag(admin);
			}else { //update
				aService.updateMain(admin);
			}
		}
		return "redirect:adminRecommandTag.do";
	}
	
	//관리자 태그 삭제
	@RequestMapping("deleteTag.do")
	public String deleteTag(Admin admin, String returnUrl) {
		aService.deleteTag(admin);
		return "redirect:"+returnUrl;
	}
	
	//관리자 태그 추가
	@RequestMapping("insertTag.do")
	public String insertTag(Admin admin, String returnUrl) {
		aService.insertTag(admin);
		return "redirect:"+returnUrl;
	}

	//관리자 테마 페이지 로드
	@RequestMapping("adminThemeTag.do")
	public ModelAndView adminThemeTag() {
		ModelAndView mav = new ModelAndView();
		// themeTags 출력
		mav.addObject("themeTags", aService.showThemeTags());
		mav.setViewName("Admin/adminThemeTag");
		return mav;
	}
	
	//관리자 음식 페이지 로드
	@RequestMapping("adminFoodTag.do")
	public ModelAndView adminFoodTag() {
		ModelAndView mav = new ModelAndView();
		// FoodTags 출력
		mav.addObject("foodTags", aService.showFoodTags());
		mav.setViewName("Admin/adminFoodTag");
		return mav;
	}

	//관리자 태그 추가(파일)
	@RequestMapping("insertTagFile.do")
	public String insertTagFile(Admin admin,
			@RequestParam(value="afile") MultipartFile afile) throws Exception{
		aService.insertTagFile(admin, afile);
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

	// 1:1문의
	//1:1문의 전체 글 불러오기
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