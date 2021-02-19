package controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Inquiry;
import service.AdminService;

@Controller
public class AdminController {

	@Autowired
	private AdminService aService;

	//태그 관련
	//메인추천 화면 로딩
	@RequestMapping("adminRecommandTag.do")
	public ModelAndView adminRecommandTag() {
		ModelAndView mav = new ModelAndView();
		// 현재 설정된 메인추천 1, 2
		Admin admin = new Admin();
		admin.setAtype("main1");
		Admin main1 = aService.selectAdminTypeOne(admin);
		admin.setAtype("main2");
		Admin main2 = aService.selectAdminTypeOne(admin);
		mav.addObject("main1", main1);
		mav.addObject("main2", main2);
		// 드롭다운에 들어갈 themetags 출력
		admin.setAtype("theme");
		List<Admin> themeList =  aService.selectAdminTypeList(admin);
		mav.addObject("themes", themeList);
		mav.addObject("themesCnt", themeList.size());
		mav.setViewName("Admin/adminRecommandTag");
		return mav;
	}

	//관리자가 메인추천 태그 적용
	@RequestMapping("selectMain.do")
	public String selectMain(Admin admin) {
		if(admin.getAtype() != null) {
			Admin tag = aService.selectAdminOne(admin);
			if(tag == null) { //insert
				aService.insertTag(admin);
			}else { //update
				aService.updateAdmin(admin);
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
	
	//관리자 태그 추가(파일)
	@RequestMapping("insertTagFile.do")
	public String insertTagFile(Admin admin,
			@RequestParam(value="afile") MultipartFile afile) throws Exception{
		aService.insertTagFile(admin, afile);
		return "redirect:adminFoodTag.do";
	}

	//관리자 테마 페이지 로드
	@RequestMapping("adminThemeTag.do")
	public ModelAndView adminThemeTag() {
		ModelAndView mav = new ModelAndView();
		// themeTags 출력
		Admin admin = new Admin();
		admin.setAtype("theme");
		mav.addObject("themeTags", aService.selectAdminTypeList(admin));
		mav.setViewName("Admin/adminThemeTag");
		return mav;
	}
	
	//관리자 음식 페이지 로드
	@RequestMapping("adminFoodTag.do")
	public ModelAndView adminFoodTag() {
		ModelAndView mav = new ModelAndView();
		// FoodTags 출력
		Admin admin = new Admin();
		admin.setAtype("food");
		mav.addObject("foodTags", aService.selectAdminTypeList(admin));
		mav.setViewName("Admin/adminFoodTag");
		return mav;
	}

	//관리자 맛 페이지 로드
	@RequestMapping("adminTasteTag.do")
	public ModelAndView adminTasteTag() {
		ModelAndView mav = new ModelAndView();
		// TasteTags 출력
		Admin admin = new Admin();
		admin.setAtype("taste");
		mav.addObject("tasteTags", aService.selectAdminTypeList(admin));
		mav.setViewName("Admin/adminTasteTag");
		return mav;
	}

	// 1:1문의
	//1:1문의 전체 글 불러오기
	@RequestMapping("selectAllInquirys.do")
	public ModelAndView selectAllInquirys(Inquiry inquiry) throws Exception{
		ModelAndView mav = new ModelAndView();
		String state = inquiry.getIstate();
		if(state == null) {
			state = "all";
		}
		// 모든 1:1문의 글 출력
		List<Inquiry> iList = aService.selectInquiryList(inquiry);
		mav.addObject("iList", iList);
		mav.addObject("cntList", aService.inquiryListCount());
		mav.addObject("state", state);
		mav.setViewName("Admin/adminInquiry");
		return mav;
	}
	
	//1:1문의 상세 글 불러오기
	@RequestMapping("selectInquiryDetail.do")
	public ModelAndView selectInquiryDetail(Inquiry inquiry) throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.addObject("inquiry", aService.selectInquiry(inquiry));
		mav.setViewName("Admin/adminInquiryDetail");
		return mav;
	}
	
	//답변등록
	@RequestMapping("insertInquiryAnswer.do")
	public String insertInquiryAnswer(Inquiry inquiry
			, HttpServletResponse response) throws Exception{
		int result = aService.insertInquiryAnswer(inquiry);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		if(result > 0) {
			str += "alert('답변이 등록되었습니다.');";
		}else {
			str += "alert('등록하는데 실패했습니다. 다시 시도해주세요.');";
		}
		str += "location.href='selectAllInquirys.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}
	
	//저장된 이미지 불러오기
	@RequestMapping("downloadAimage.do")
	public View download(int anum) {
		File attachFile= aService.getAttachedFile(anum);
		View view = new DownloadView(attachFile);
		
		return view;
	}
}