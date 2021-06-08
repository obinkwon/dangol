package controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Member;
import model.Store;
import service.AdminService;
import service.MemberService;
import service.OwnerService;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	
	@Autowired
	private OwnerService oService;
	
	@Autowired
	private AdminService aService;
	
	//로그인 폼 이동
	@RequestMapping("loginForm.do")
	public String loginForm() { 
		return "jsp/loginForm";
	}
	
	//회원가입 폼 이동
	@RequestMapping("signUpForm.do")
	public String signUpForm() {
		return "jsp/signUpForm";
	}
	
	//id, pwd 찾기 폼 이동
	@RequestMapping("findIdPwForm.do")
	public ModelAndView findIdPwForm(String type) { 
		ModelAndView mav = new ModelAndView();
		mav.addObject("type",type);
		mav.setViewName("jsp/findIdPwForm");
		return mav;
	}
	
	//회원 가입 폼 이동
	@RequestMapping("signUpMembersForm.do")
	public ModelAndView signUpMembersForm() throws Exception{
		// 회원가입시 해시태그 리스트 가져오기
		ModelAndView mav = new ModelAndView();
		Admin admin = new Admin();
		admin.setAtype("theme");
		mav.addObject("themeList", aService.selectAdminTypeList(admin));
		mav.setViewName("jsp/signUpMembersForm");
		return mav;
	}

	//로그인
	@RequestMapping("login.do")
	public String login(HttpServletResponse resp
			, HttpSession session
			, String loginUser
			, String id
			, String pwd) throws Exception{

		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		if (loginUser.equals("user")) { //사용자 로그인일때
			int memberCnt = mService.loginMembers(id, pwd);
			if (memberCnt == 0) {
				session.setAttribute("mid", id);
				return "redirect:main.do";
			} else if (memberCnt == 1) {
				session.setAttribute("loginAdmin", id);
				return "redirect:adminRecommandTag.do";
			} else {
				str = "<script language='javascript'>";
				str += "alert('회원정보가 일치하지 않습니다.');";
				str += "history.go(-1);";
				str += "</script>";
				pw.print(str);
				return null;
			}
		} else { //점장 로그인일때
			if (oService.loginBoss(id, pwd) == 0) {
				session.setAttribute("bid", id);
				return "redirect:main.do";
			} else {
				str = "<script language='javascript'>";
				str += "alert('회원정보가 일치하지 않습니다.');";
				str += "history.go(-1);";
				str += "</script>";
				pw.print(str);
				return null;
			}
		}
	}

	//id 찾기
	@RequestMapping("findId.do")
	@ResponseBody
	public List<String> checkById(String loginUser
			, String phone) throws Exception{ 
		List<String> str = new ArrayList<String>();

		if (loginUser.equals("user")) { //사용자 일때
			List<Member> mlist = mService.findId(phone);
			if (mlist.size() > 0) {
				for (int i = 0; i < mlist.size(); i++) {
					str.add(mlist.get(i).getMid());
				}
			}
		} else { //점장 일때
			List<Store> blist = oService.findId(phone);
			if (blist.size() > 0) {
				for (int i = 0; i < blist.size(); i++) {
					str.add(blist.get(i).getBid());
				}
			}
		}
		return str;
	}

	//비밀번호 찾기
	@RequestMapping("findPw.do")
	@ResponseBody
	public String checkByPw(String loginUser
			, String id
			, String phone) throws Exception{
		String result = "";
		
		if (loginUser.equals("user")) { //사용자 일때
			Member member = new Member();
			member.setMid(id);
			member.setMphone(phone);
			
			member = mService.findPw(member);
			if (member != null) {
				result = member.getMpw();
			}
		} else { //점장 일때
			Store store = new Store();
			store.setBid(id);
			store.setBphone(phone);
			store = oService.findPw(store);
			if (store != null) {
				result = store.getBid();
			}
		}
		return result;
	}

	// 회원가입시 id 중복체크
	@RequestMapping("checkIdMember.do")
	@ResponseBody
	public boolean checkId(Member member) throws Exception{
		if (mService.checkId(member) == null) {
			return true;
		}else {
			return false;
		}
	}
	
	// 회원가입
	@RequestMapping("signUp.do")
	public String signUp(HttpServletResponse resp
			, Member member
			, @RequestParam("mfile") MultipartFile mfile) throws Exception {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "<script language='javascript'>";
		int result = mService.insertMember(member, mfile);
		if(member.getMtag() != null) {
			mService.insertMtag(member);
		}
		if(result > 0) {
			str += "alert('가입이 완료되었습니다.');";
		}else {
			str += "alert('가입에 실패하였습니다.');";
		}
		str += "location.href='loginForm.do'";
		str += "</script>";
		pw.print(str);
		return null;

	}
	
	//저장된 이미지 불러오기
	@RequestMapping("downloadMImage.do") 
	public View download(String mid) throws Exception{
		File attachFile= mService.getAttachedFile(mid);
		View view = new DownloadView(attachFile);
		return view;
	}
	
	//도로명 주소 api
	@RequestMapping("jusoPopup.do")
	public ModelAndView jusoPopup(int index) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("index", index);
		mav.setViewName("jsp/jusoPopup");
		return mav;
	}

}
