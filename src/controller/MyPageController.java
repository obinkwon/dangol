package controller;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Member;
import model.Store;
import service.AdminService;
import service.CategoryService;
import service.MemberService;
import service.MyPageService;
import service.OwnerService;

@Controller
public class MyPageController {

	@Autowired
	private MyPageService myService;
	@Autowired
	private MemberService mService;
	@Autowired
	private AdminService aService;
	@Autowired
	private CategoryService cService;
	@Autowired
	private OwnerService oService;

	//마이페이지
	@RequestMapping("myPage.do")
	public ModelAndView myPage(HttpSession session) throws Exception{
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		Admin admin = new Admin();
		admin.setAtype("theme");
		if(mid != null) {
			Member member = new Member();
			member.setMid(mid);
			mav.addObject("Member", mService.selectMember(member));
			mav.addObject("themeList", aService.selectAdminTypeList(admin));
			mav.addObject("mtagList", mService.selectMtag(member));
			mav.setViewName("mypage/myPage");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}
	
	//회원 수정
	@RequestMapping("modifyMember.do")
	public String modifyMember(HttpServletResponse resp
		, Member member
		, @RequestParam(value = "mfile", required = false) MultipartFile mfile) throws Exception {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "<script language='javascript'>";
		int result = myService.updateMemberOne(member, mfile);
		if(member.getMtag() != null) {
			myService.updateMtag(member);
		}
		if(result > 0) {
			str += "alert('회원정보가 수정되었습니다.');";
		}else {
			str += "alert('수정에 실패하였습니다.');";
		}
		str += "location.href='myPage.do'";
		str += "</script>";
		pw.print(str);
		return null;

	}
	
	//회원 탈퇴
	@RequestMapping("removeMember.do")
	public String removeMember(HttpSession session
		, Member member) throws Exception {
		String mid = (String) session.getAttribute("mid");
		if(member.getMid().equals("")) {
			member.setMid(mid);
		}
		myService.deleteMemberOne(member);
		session.invalidate(); //세션 초기화
		return "redirect:main.do";
	}
	
	//즐겨찾기
	@RequestMapping("bookmark.do")
	public ModelAndView bookmark(HttpSession session
			,Member member) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		if (mid != null) {
			member.setMid(mid);
			List<Details> bookmarkList = myService.selectBookmarkList(member);

			mav.addObject("bookmarkList", bookmarkList);
			mav.setViewName("mypage/bookmark");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}

	//즐겨찾기 목록에서 즐겨찾기 제거
	@RequestMapping("bookmarkLikes.do") 
	public String bookmarkLikes(Member member) {
		myService.updateLike(member);
		return "redirect:bookmark.do";
	}

	//방문내역 리스트
	@RequestMapping("historyList.do")
	public ModelAndView history(Member member
			,HttpSession session) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		if (mid != null) {
			member.setMid(mid);
			List<Details> historyList = myService.selectHistoryListMid(member);//방문내역 리스트
				
			mav.addObject("historylist", historyList);
			mav.setViewName("mypage/historyList");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}
	
	//방문 내역 즐겨찾기 추가
	@RequestMapping("historyLike.do")
	public String insertLikes(Member member) {
		myService.updateLike(member);
		return "redirect:historyList.do";
	}

	//예약 현황
	@RequestMapping("reserveState.do")
	public ModelAndView reserveState(HttpSession session
			, Details details
			, Member member) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		if(mid != null) {
			member.setMid(mid);
			List<Details> reserveList = myService.selectReserveState(member);//예약 리스트
			mav.addObject("reserveList", reserveList);
			mav.setViewName("mypage/reserveState");
		}else {
			mav.setViewName("jsp/loginForm");
		}

		return mav;
	}

	// 저장된 이미지 불러오기
	@RequestMapping("downloadSImage.do")
	public View download(int snum) {
		Store store = new Store();
		store.setSnum(snum);
		File attachFile = myService.getAttachedFile(store);
		View view = new DownloadView(attachFile);
		return view;
	}

	//예약 취소
	@RequestMapping("cancelReserve.do")
	public String cancelReserve(HttpServletResponse resp
			, Details detail
			, Member member 
			, HttpSession session) throws Exception {
		String date = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());//현재 날짜
		String mid = (String)session.getAttribute("mid");
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "<script language='javascript'>";
		
		detail.setMid(mid);
		int ddate = Integer.parseInt(detail.getDdate());
		int today = Integer.parseInt(date);
		detail = cService.getDetailOne(detail);//예약 정보 조회
		if(ddate <= today) {//예약 날짜가 당일인 경우
			member.setMid(detail.getMid());
			member = mService.selectMember(member);
			
			int penalty = member.getMpenalty();
			member.setMpenalty(penalty+1);
			str += "alert('당일 취소로 인해 패널티가 부과되었습니다.');";
			if (penalty >= 3) {//패널티 3번이상인경우
				myService.updateGrade(member);//등급 강등 및 포인트 절감
				member.setMpenalty(0);
				str += "alert('최대  패널티가 부과되어 등급이 강등됩니다.');";
			}
			myService.updatePenalty(detail);//패널티 추가
			myService.deleteReserve(detail);//예약 취소
		}else {
			myService.deleteReserve(detail);//예약 삭제
			str += "alert('예약이 취소되었습니다.');";
		}
		str += "location.href='reserveState.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}

	//후기 작성 폼 이동
	@RequestMapping("createCommentForm.do")
	public ModelAndView createCommentForm(HttpSession session
			, HttpServletResponse resp
			, Details details
			, Member member
			, ModelAndView mav) throws Exception{
		String mid = (String) session.getAttribute("mid");
		if(mid != null) {
			member.setMid(mid);
			member = mService.selectMember(member);
			
			details = cService.getCommentInfo(details);
			
			Admin admin = new Admin();
			admin.setAtype("taste");
			mav.addObject("tasteList", aService.selectAdminTypeList(admin));
			mav.addObject("mimage", member.getMimage());
			mav.addObject("details", details);
			mav.setViewName("mypage/createCommentForm");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}

	//후기 작성
	@RequestMapping("createComment")
	public String createComment(Comment comment) {
		int result = myService.insertComment(comment);
		System.out.println("result ::: "+result);
		return "redirect:historyList.do";
		
	}
	

}