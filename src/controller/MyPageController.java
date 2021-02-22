package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
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
import model.Mtag;
import model.Store;
import service.AdminService;
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

	@RequestMapping("myPage.do")
	public ModelAndView myPage(HttpSession session) throws Exception{
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		Admin admin = new Admin();
		admin.setAtype("theme");
		if (session.getAttribute("mid") != null) {
			mav.addObject("Member", mypageService.selectMember(mid));
			mav.addObject("themeList", aService.selectAdminTypeList(admin));
			if(mypageService.selectMtag(mid) !=null) {
				mav.addObject("mTag", mypageService.selectMtag(mid));
			}
			mav.setViewName("mypage/myPage");
		} else if (session.getAttribute("bid") != null) {
			mav.setViewName("Owner/ownerInfoForm");
		} else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}

	@RequestMapping("modifyMember.do")
	public String modifyMember(HttpServletResponse resp, Member member
		, @RequestParam(required = false) String[] tag
		, @RequestParam(value = "mfile", required = false) MultipartFile mfile) throws Exception {
		System.out.println(member.getMphone());
		mypageService.updateMemberOne(member, tag, mfile);

		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		str += "alert('회원정보가 수정되었습니다.');";
		str += "location.href='myPage.do'";
		str += "</script>";
		pw.print(str);
		return null;

	}

	@RequestMapping("removeMember.do")
	public String removeMember(HttpSession session) {
		String mid = (String) session.getAttribute("mid");
		mypageService.deleteMemberOne(mid);
		session.invalidate();
		return "redirect:main.do";
	}

	@RequestMapping("bookmark.do")
	public ModelAndView bookmark(HttpSession session) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<HashMap<String, Object>> bookmarkList = new ArrayList<HashMap<String, Object>>();
		List<List<Details>> detailslist = mypageService.selectGlikeList(mid);

		if(detailslist!=null) {
			for (List<Details> dlist : detailslist) {
				if(dlist.size()!=0) {	
					HashMap<String, Object> bookmark = new HashMap<String, Object>();
					Grade grade = mypageService.selectgradeByGnum(dlist.get(0).getGnum());
					Store store = mypageService.selectStoreBySnum(grade.getSnum());
					bookmark.put("snum", store.getSnum());
					bookmark.put("simage", store.getSimage());
					bookmark.put("sname", store.getSname());
					bookmark.put("saddress", store.getSaddress());
					Grade grades = mypageService.selectgrade(grade.getMid(),grade.getSnum());
					bookmark.put("glevel", grades.getGlevel());
					bookmark.put("glike", grades.getGlike());
					Date date = dlist.get(0).getDdate();
					bookmark.put("ddate", date);
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
					bookmark.put("dcount", count);
					
					bookmarkList.add(bookmark);
				}
			}
				
			}

		mav.addObject("bookmarkList", bookmarkList);
		mav.setViewName("mypage/bookmark");
		return mav;
	}

	@RequestMapping("deleteLikes.do") // 즐겨찾기 목록
	public String deleteLikes(String mid, int snum) {
		mypageService.deleteLikes(mid, snum);
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
				Date date = dlist.get(0).getDdate();
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

	@RequestMapping("insertLikes.do")
	public String insertLikes(String mid, int snum) {
		mypageService.insertLikes(mid, snum);
		return "redirect:historyList.do";
	}

	@RequestMapping("deleteLikesHistory.do") // 방문내역 목록
	public String deleteLikesHistory(String mid, int snum) {
		mypageService.deleteLikes(mid, snum);
		return "redirect:historyList.do";
	}

	@RequestMapping("historyView.do")
	public ModelAndView historyView(HttpSession session, int snum) {
		String mid=(String)session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<Details> detailslist = mypageService.selectHistoryOne(mid, snum);
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

	@RequestMapping("reserveState.do")
	public ModelAndView reserveState(HttpSession session) {
		String mid = (String) session.getAttribute("mid");

		ModelAndView mav = new ModelAndView();
		List<Details> details = mypageService.selectReserveState(mid);

		List<HashMap<String, Object>> reservationList = new ArrayList<HashMap<String, Object>>();
		for (int i = 0; i < details.size(); i++) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("ddate", details.get(i).getDdate());
			param.put("dtime", details.get(i).getDtime());
			param.put("dperson", details.get(i).getDperson());
			param.put("dmenu", details.get(i).getDmenu());
			param.put("dtype", details.get(i).getDtype());
			param.put("dask", details.get(i).getDask());
			param.put("dnum", details.get(i).getDnum());
			Grade g = mypageService.selectgradeByGnum(details.get(i).getGnum());
			param.put("glevel", g.getGlevel());
			Store store = mypageService.selectStoreBySnum(g.getSnum());
			param.put("snum", store.getSnum());
			param.put("simage", store.getSimage());
			param.put("sname", store.getSname());
			param.put("sratelv0", store.getSratelv0());
			param.put("sratelv1", store.getSratelv1());
			param.put("sratelv2", store.getSratelv2());
			param.put("sratelv3", store.getSratelv3());
			reservationList.add(param);
		}
		mav.addObject("reservationList", reservationList);
		mav.setViewName("mypage/reserveState");

		return mav;
	}

	// 저장된 이미지 불러오기
	@RequestMapping("downloadSImage.do")
	public View download(int snum) {
		File attachFile = mypageService.getAttachedFile(snum);
		View view = new DownloadView(attachFile);
		return view;
	}

	@RequestMapping("cancelReserve.do")
	public String cancelReserve(HttpServletResponse resp, int dnum, HttpSession session) throws Exception {
		String mid=(String)session.getAttribute("mid");
		int num=mypageService.deleteReserve(dnum,mid);
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		if(num==1) {
			str = "<script language='javascript'>";
			str += "alert('예약이 취소되었습니다.');";
			str += "location.href='reserveState.do'";
			str += "</script>";
			pw.print(str);
			return null;	
		}else if(num==3) {
			str = "<script language='javascript'>";
			str += "alert('당일 취소로 인해 패널티가 부과되었습니다.');";
			str += "location.href='reserveState.do'";
			str += "</script>";
			pw.print(str);
			return null;
		}else {
			str = "<script language='javascript'>";
			str += "alert('최대  패널티가 부과되어 등급이 강등됩니다.');";
			str += "location.href='reserveState.do'";
			str += "</script>";
			pw.print(str);
			return null;
			
		}
		
		
	}

	@RequestMapping("createCommentForm.do")
	public ModelAndView createCommentForm(HttpSession session, int dnum, int snum) throws Exception{
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		Member member = mService.selectMember(mid);
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