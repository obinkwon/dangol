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

@Controller
public class MyPageController {

	@Autowired
	private MyPageService mypageService;
	@Autowired
	private MemberService mService;
	@Autowired
	private AdminService aService;
	@Autowired
	private CategoryService cService;

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
		String str = "";
		int result = mypageService.updateMemberOne(member, mfile);
		if(member.getMtag() != null) {
			mypageService.updateMtag(member);
		}
		str = "<script language='javascript'>";
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
		mypageService.deleteMemberOne(member);
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
			List<Details> bookmarkList = mypageService.selectBookmarkList(member);

			for (Details detail : bookmarkList) {
				int dcount = detail.getDcount();
				int count = 0;
				if (dcount < 12) {
					count = (12 - dcount);
				} else if (dcount < 24) {
					count = (24 - dcount);
				} else if (dcount < 48) {
					count = (48 - dcount);
				} else {
					count = 100;
				}
				detail.setDcount(count);
			}

			mav.addObject("bookmarkList", bookmarkList);
			mav.setViewName("mypage/bookmark");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}

	@RequestMapping("bookmarkLikes.do") //즐겨찾기 목록에서 즐겨찾기 제거
	public String bookmarkLikes(Member member) {
		mypageService.updateLike(member);
		return "redirect:bookmark.do";
	}

	@RequestMapping("historyList.do")
	public ModelAndView history(HttpSession session) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<HashMap<String, Object>> historyList = new ArrayList<HashMap<String, Object>>();
		List<List<Details>> detailslist = mypageService.selectdcountHistory(mid);// 리뷰
		if(detailslist !=null) {
			
			for (List<Details> dlist : detailslist) {
				System.out.println(dlist);
				
			if(dlist.size()!=0) {
				
				HashMap<String, Object> history = new HashMap<String, Object>();
		
				Grade grade = mypageService.selectgradeByGnum(dlist.get(0).getGnum());
				Store store = mypageService.selectStoreBySnum(grade.getSnum());
				history.put("snum", store.getSnum());
				history.put("simage", store.getSimage());
				history.put("sname", store.getSname());
				history.put("saddress", store.getSaddress()); 
				Grade grades = mypageService.selectgrade(grade.getMid(),grade.getSnum());
				history.put("glevel", grades.getGlevel());
				history.put("glike", grades.getGlike());
				String date = dlist.get(0).getDdate();
				history.put("ddate", date);
				List<Details> details= mypageService.selectdcount(grade.getMid(), grade.getSnum());
				int dcount = details.get(0).getDcount();
				Object count = null;
				if (dcount < 12) {
					count = (12 - dcount);
				} else if (dcount < 24) {
					count = (24 - dcount);
				} else if (dcount < 48) {
					count = (48 - dcount);
				} else {
					count = ("최고등급입니다.");
				}
				history.put("dcount", count);
				historyList.add(history);
				mav.addObject("historylist", historyList);
				
			}
		}
			
			}
	
	mav.setViewName("mypage/historyList");
		return mav;

	}

	@RequestMapping("historyLike.do")
	public String insertLikes(Member member) {//방문 내역 즐겨찾기 추가
		mypageService.updateLike(member);
		return "redirect:historyList.do";
	}

	@RequestMapping("historyView.do")
	public ModelAndView historyView(HttpSession session, int snum) {
		String mid=(String)session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<Details> detailslist = mypageService.selectHistoryList(mid, snum);
		List<String> commentlist = new ArrayList<String>();
		for (int i = 0; i < detailslist.size(); i++) {
			Comment comments = mypageService.selectcomments(detailslist.get(i).getDnum());
			if (comments == null) {
				commentlist.add("작성");

			} else {
				commentlist.add("수정");

			}
		}

		List<String> level = new ArrayList<String>();
		List<Integer> sratelv = new ArrayList<Integer>();
		List<Integer> snumlist = new ArrayList<Integer>();
		int count = 0;
		for (int i = 0; i < detailslist.size(); i++) {
			count = detailslist.get(i).getDcount();
			Store store = mypageService.selectStoreBySnum(snum);
			snumlist.add(store.getSnum());
			if (count < 12) {
				sratelv.add(store.getSratelv0());
				level.add("범골");
			} else if (count < 24) {
				sratelv.add(store.getSratelv1());
				level.add("진골");
			} else if (count < 48) {
				sratelv.add(store.getSratelv2());
				level.add("성골");
			} else {
				sratelv.add(store.getSratelv3());
				level.add("단골");
			}
		}

		List<HashMap<String, Object>> historyview = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < detailslist.size(); i++) {
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("dnum", detailslist.get(i).getDnum());
			params.put("ddate", detailslist.get(i).getDdate());
			params.put("dperson", detailslist.get(i).getDperson());
			params.put("dmenu", detailslist.get(i).getDmenu());
			params.put("dtype", detailslist.get(i).getDtype());
			params.put("sratelv", sratelv.get(i));
			params.put("level", level.get(i));
			params.put("snum", snumlist.get(i));
			params.put("comment", commentlist.get(i));

			historyview.add(params);
		}

		mav.addObject("sname", mypageService.selectStoreBySnum(snum).getSname());
		mav.addObject("historyview", historyview);
		mav.setViewName("mypage/historyView");

		return mav;
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
			List<Details> reserveList = mypageService.selectReserveState(member);//예약 리스트
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
		File attachFile = mypageService.getAttachedFile(store);
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
		detail = cService.selectDetail(detail);//예약 정보 조회
		if(ddate <= today) {//예약 날짜가 당일인 경우
			member.setMid(detail.getMid());
			member = mService.checkId(member);
			
			int penalty = member.getMpenalty();
			member.setMpenalty(penalty+1);
			str += "alert('당일 취소로 인해 패널티가 부과되었습니다.');";
			if (penalty >= 3) {//패널티 3번이상인경우
				mypageService.updateGrade(member);//등급 강등 및 포인트 절감
				member.setMpenalty(0);
				str += "alert('최대  패널티가 부과되어 등급이 강등됩니다.');";
			}
			mypageService.updatePenalty(detail);//패널티 추가
			mypageService.deleteReserve(detail);//예약 취소
		}else {
			mypageService.deleteReserve(detail);//예약 삭제
			str += "alert('예약이 취소되었습니다.');";
		}
		str += "location.href='reserveState.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}

	@RequestMapping("createCommentForm.do")
	public ModelAndView createCommentForm(HttpSession session, int dnum, int snum) throws Exception{
		String mid = (String) session.getAttribute("mid");
		Member member = new Member();
		member.setMid(mid);
		ModelAndView mav = new ModelAndView();
		member = mService.selectMember(member);
		Store store = mypageService.selectStoreBySnum(snum);
		Details details = mypageService.selectDetailsByDnum(dnum);
		String str = details.getDmenu();
		if (str != null) {
			String[] menu = str.split(",");
			mav.addObject("menulist", menu);
		}
		Grade grade = mypageService.selectgradeByGnum(details.getGnum());
		Admin admin = new Admin();
		admin.setAtype("taste");
		mav.addObject("mimage", member.getMimage());
		mav.addObject("tasteTag", aService.selectAdminTypeList(admin));
		mav.addObject("store", store);
		mav.addObject("glevel", grade.getGlevel());
		mav.addObject("details", mypageService.selectDetailsByDnum(dnum));
		mav.setViewName("mypage/createCommentForm");
		return mav;

	}

	@RequestMapping("createComment")
	public String createComment(int dnum, Comment comment, String[] tag) {
		int snum = mypageService.insertComment(dnum, comment, tag);
		return "redirect:historyView.do?snum="+snum;
		
	}
	

}