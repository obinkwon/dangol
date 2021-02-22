package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
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
import model.Boss;
import model.Member;
import service.AdminService;
import service.BossService;
import service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	@Autowired
	private BossService bService;
	@Autowired
	private AdminService aService;

	@RequestMapping("loginForm.do")
	public String loginForm() {
		return "jsp/loginForm";
	}

	@RequestMapping("login.do")
	public String login(HttpServletResponse resp
			, HttpSession session
			, String loginUser
			, String id
			, String pwd) throws Exception{

		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		int memberCnt = mService.loginMembers(id, pwd);
		if (loginUser.equals("user")) {
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

		} else {
			if (bService.loginBoss(id, pwd) == 0) {
				session.setAttribute("bid", id);
		//		System.out.println("bid");
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

	@RequestMapping("findIdPwForm.do")
	public String findIdPwForm() {
		return "jsp/findIdPwForm";
	}

	@RequestMapping("findId.do")
	public @ResponseBody List<String> checkById(String loginUser, String phone) throws Exception{
	//	System.out.println(phone);
		int i = 0;
		List<Member> mlist = mService.findId(phone);
		List<Boss> blist = bService.findId(phone);
		List<String> str = new ArrayList<String>();

		if (loginUser.equals("user")) {
			if (mService.findId(phone) != null) {
				for (i = 0; i < mlist.size(); i++) {
					str.add(mlist.get(i).getMid());
					// System.out.println(mlist.get(i).getMid());
				}
			} else {
				str = null;
			}
		} else {
			// System.out.println("sdf");
			if (bService.findId(phone) != null) {
				for (i = 0; i < blist.size(); i++) {
					str.add(blist.get(i).getBid());
				}
			} else {
				str = null;
			}
		}
		for (String s : str) {
			//System.out.println(s);
		}
		return str;
	}

	@RequestMapping("findIdResult.do")
	public String FindIdResult(int result) {
		if (result == 0) {
			return "jsp/findIdResult0";
		} else {
			return "jsp/findIdResult1";
		}

	}

	@RequestMapping("findPw.do")
	public @ResponseBody String checkByPw(String loginUser, String id, String phone) throws Exception{
		// System.out.println(id);
		//System.out.println(phone);
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("phone", phone);

		// System.out.println(mService.findPw(params).getMpw());

		String result = "";

		if (loginUser.equals("user")) {
			if (mService.findPw(params) != null) {
				result = mService.findPw(params).getMpw();
			} else {
				result = "";
			}
		} else {
			if (bService.findPw(params) != null) {
				result = bService.findPw(params).getBid();
			} else {
				result = "";
			}
		}
		return result;
	}

	@RequestMapping("findPwResult.do")
	public String findPwResult(int result) {
		if (result == 0) {
			return "jsp/findPwResult0";
		} else {
			return "jsp/findIdResult1";
		}
	}

	@RequestMapping("signUpForm.do")
	public String signUpForm() {
		return "jsp/signUpForm";
	}

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

	// 회원가입시 id 중복체크
	@RequestMapping("checkIdMember.do")
	public @ResponseBody boolean checkId(String id) throws Exception{
		// System.out.println(id);
		if (mService.checkId(id) == null)
			return true;
		else {
			return false;
		}
	}
	// 회원가입
	@RequestMapping("signUp.do")
	public String signUp(HttpServletResponse resp, Member member, String[] tag, @RequestParam("mfile") MultipartFile mfile) throws Exception {
		mService.insertMember(member, tag, mfile);
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		str += "alert('회원가입이 완료되었습니다.');";
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
	
	@RequestMapping("jusoPopup.do")
	public ModelAndView jusoPopup(int index) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("index", index);
		mav.setViewName("jsp/jusoPopup");
		return mav;
	}

}
