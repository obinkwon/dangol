package controller;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.Admin;
import model.Boss;
import model.Details;
import model.Grade;
import model.Member;
import model.Store;
import service.AdminService;
import service.BossService;
import service.OwnerService;

@Controller
public class OwnerController {

	@Autowired
	private OwnerService oService;
	@Autowired
	private BossService bService;
	@Autowired
	private AdminService aService;
	
	//점장 정보
	//점장 정보 페이지 불러오기
	@RequestMapping("ownerInfoForm.do")
	public ModelAndView ownerInfoForm(HttpSession session
			,HttpServletResponse resp) throws Exception{
		String bid = (String) session.getAttribute("bid");
		Boss boss = new Boss();
		Store store = new Store();
		boss.setBid(bid);
		store.setBid(bid);
		
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
		if(bid != null && !bid.equals("") ) {
			mav.addObject("boss", bService.selectBossOne(boss));
			mav.addObject("stores", oService.selectStoreList(store));
			mav.setViewName("Owner/ownerInfoForm");
			return mav;
		}else {
			str = "<script language='javascript'>";
			str += "alert('세션이 만료되었습니다.');";
			str += "location.href='main.do'";
			str += "</script>";
			pw.print(str);
			return null;
		}
	}
	
	//사장님 정보 수정하기
	@RequestMapping("updateOwner.do")
	public String updateOwner(Boss boss
			,HttpServletResponse resp) throws Exception{
		resp.setContentType("text/html; charset=UTF-8");
		int result = -1;
		PrintWriter pw = resp.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		if(boss.getBid() != null && !boss.getBid().equals("")) {
			result = oService.updateOwner(boss);
		}
		
		if(result > 0) {
			str += "alert('수정 되었습니다.');";
		}else {
			str += "alert('오류가 발생했습니다.');";
		}
		str += "location.href='ownerInfoForm.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}

	//사장님 정보 탈퇴하기
	@RequestMapping("deleteOwner.do")
	public String deleteOwner(HttpSession session
			,Boss boss
			,HttpServletResponse resp) throws Exception{
		resp.setContentType("text/html; charset=UTF-8");
		int result = -1;
		PrintWriter pw = resp.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		if(!boss.getBpw().equals("") && !boss.getBid().equals("")) {
			result = oService.deleteOwner(boss);
		}
		if(result > 0) {
			str += "alert('그동안 단골의 희열 서비스를 \\n이용해주셔서 감사합니다');";
			session.invalidate();
		}else {
			str += "alert('오류가 발생했습니다.');";
		}
		str += "location.href='main.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}

	// 예약현황
	//snum에 일치하는 details 불러오기
	@RequestMapping("selectDetailsBySnum.do")
	public ModelAndView selectDetailsBySnum(HttpSession session
			, HttpServletResponse resp
			, Store store) throws Exception{
		//session bid에 일치하는 가게 목록 조회
		String bid = (String) session.getAttribute("bid");
		store.setBid(bid);
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
		if(bid != null && !bid.equals("") ) {
			List<Store> storeList = oService.selectStoreList(store);
			int snum = store.getSnum();
			mav.addObject("storeList", storeList);
			mav.addObject("snum", snum);
			if(snum > 0) { //특정 가게 하나
				//snum으로 gnums 추출
				Grade grade = new Grade();
				grade.setSnum(snum);
				grade.setGcurrent("yes");
//				int[] gnumsBySnum = oService.selectGnumsCurrentYBySnum(snum);
				int[] gnumsBySnum = oService.selectGnums(grade);
				//gnums이 null이면 예약은 없다.
				if (gnumsBySnum.length == 0) {
					mav.addObject("details", null);
					mav.addObject("reservers", null);
				}else {
					//gnums에 해당하는 details 불러오기
					mav.addObject("details", oService.selectDetailsList(grade));
					// 예약한 사람 정보 구하기
					mav.addObject("reservers", oService.selectReserversBySnum(snum));
				}
			}else { //내 가게 전체
				//bid에서 snums 추출
				int i=0;
				int[] snums = new int[storeList.size()];
				
				for (Store s : storeList) {
					snums[i] = s.getSnum();
					i++;
				}
				//snums로 gnums 추출
				int[] gnumsBySnums = oService.selectGnumsCurrentYBySnums(snums);
				//gnums이 null이면 예약은 없다.
				if (gnumsBySnums.length == 0) {
					mav.addObject("details", null);
					mav.addObject("reservers", null);
				}else {
					//gnums에 해당하는 details 불러오기
					mav.addObject("details", oService.selectDetailsByGnums(gnumsBySnums));
					// 예약한 사람 정보 구하기
					mav.addObject("reservers", oService.selectReserversBySnums(snums));
				}
			}
			mav.setViewName("Owner/ownerReserve");
			return mav;
		}else {
			str = "<script language='javascript'>";
			str += "alert('세션이 만료되었습니다.');";
			str += "location.href='main.do'";
			str += "</script>";
			pw.print(str);
			return null;
		}
	}

	// ed Gnums와 date에 일치하는 details 불러오기
	@RequestMapping("selectDetailsByGnumsDdate.do")
	public ModelAndView selectDetailsByGnumsDdate(HttpSession session, Date Ddate) throws Exception{
		/* test
		 * String bid = "boss01";
		 * Ddate = new Date(119, 7, 8);
	 	*/	
		//ed session에 저장된 아이디 추출
		String bid = (String)session.getAttribute("bid");

		ModelAndView mav = new ModelAndView();

		// ed bid에 일치하는 snum 불러오기
		int[] snums = oService.selectsnumsByBid(bid);

		// ed snums에 일치하는 Gnums(current=yes) 불러오기
		int[] Gnums = oService.selectGnumsCurrentYBySnums(snums);

		// ed date와 Gnums로 Details 구하기
		List<Details> Details = null;

		for (int i = 0; i < snums.length; i++) {
			// ed Gnums로 Details 조회하기
			Details = oService.selectDetailsByGnumsDdate(Gnums, Ddate);
		}
		mav.addObject("Details", Details);
		// 예약한 사람 정보 구하기
		mav.addObject("Reservers", oService.selectReserversBySnums(snums));
		// ed jsp로 결과 출력
		mav.setViewName("Owner/ownerReserve");
		return mav;
	}

	// ed snum과 ddate에 해당하는 details 불러오기
	@RequestMapping("selectDetailsByStoreDdate.do")
	public ModelAndView selectDetailsByStoreDdate(int snum, Date Ddate) throws Exception{
		ModelAndView mav = new ModelAndView();
		// ed 1. snum에 해당하는 Gnums 불러오기 2.Gnums와 Ddate에 해당하는 Details 불러오기
		mav.addObject("Details",
				oService.selectDetailsByGnumsDdate(oService.selectGnumsCurrentYBySnum(snum), Ddate));

		// ed snum으로 예약자 정보 출력
		mav.addObject("reserver", oService.selectReserversBySnum(snum));
		// ed jsp로 결과 출력
		mav.setViewName("Owner/ownerReserve");
		return mav;
	}

//	단골 검색
	 @RequestMapping("selectMembersByKeyword.do")
	 public @ResponseBody HashMap<String, Object> selectMembersByKeyword(String keyword) {
		 HashMap<String, Object> hm = new HashMap<String, Object>();
		 
		 //keyword에 일치하는 회원정보 구하기
		 List<Member> members = oService.selectMembersByKeyword(keyword);
		 hm.put("members", members);

		 //members에서 mid 구하기
		 //회원정보에 일치하는 등급 구하기
		 String[] mids = new String[members.size()];
		 int i = 0;
		 for (Member member : members) {
			mids[i] = member.getMid();
			i++;
		}
		 hm.put("grades", oService.selectGradesCurrentYByMids(mids));

		 //mid별 rate율 구하기
		 hm.put("rates", oService.selectRatesByMids(mids));
		 //mid별 rate율 구하기
		 hm.put("details", oService.selectDetailsByMids(mids));
		 return hm;
	 }
	 
	
	//가게 등록 폼으로 이동
	@RequestMapping("ownerStoreForm.do")
	public ModelAndView ownerStoreForm(HttpSession session
			, HttpServletResponse resp
			, @RequestParam(defaultValue="ADD") String mode
			, Store store) throws Exception{
		ModelAndView mav = new ModelAndView();
		String bid = (String) session.getAttribute("bid");
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		Admin admin = new Admin();
		if(bid != null && !bid.equals("") ) {
			//가게정보 업종 불러오기 mav.addObject(); 
			admin.setAtype("food");
			mav.addObject("foodTagList",aService.selectAdminTypeList(admin));
			//해시태그 불러오기 mav.addObject();
			admin.setAtype("theme");
			mav.addObject("themeTagList",aService.selectAdminTypeList(admin));
			if(mode.equals("MOD")){
				store = oService.selectStore(store);
				List<Store> stagList = oService.selectStag(store);
				String[] stime = new String[4];
				stime[0] = store.getStime_start().substring(0,2);
				stime[1] = store.getStime_start().substring(2,4);
				stime[2] = store.getStime_end().substring(0,2);
				stime[3] = store.getStime_end().substring(2,4);
				String[] sholiday = store.getSholiday().split(",");
				Map<String,Object> holiMap = new HashMap<String,Object>();
				for(String hol : sholiday) {
					holiMap.put(hol, true);
				}
				mav.addObject("stagList",stagList);
				mav.addObject("stime",stime);
				mav.addObject("sholiday",holiMap);
				mav.addObject("store",store);
			}
			mav.addObject("mode",mode);
			mav.setViewName("Owner/ownerStoreForm");
			return mav;
		}else {
			str = "<script language='javascript'>";
			str += "alert('세션이 만료되었습니다.');";
			str += "location.href='main.do'";
			str += "</script>";
			pw.print(str);
			return null;
		}
	}
	
	//가게 추가하기
	@RequestMapping("insertStore.do")
	public String insertStore(Store store
			, HttpServletResponse resp
			, @RequestParam("sfile") MultipartFile sfile) throws Exception{
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		int result = oService.insertStore(store,sfile);
		if(!store.getStag().equals("")) {
			oService.insertStag(store);
		}
		if(result > 0) {
			str = "<script language='javascript'>";
			str += "alert('가게가 등록되었습니다.');";
			str += "location.href='ownerStore.do'";
			str += "</script>";
		}else {
			str = "<script language='javascript'>";
			str += "alert('가게등록에 실패했습니다.');";
			str += "location.href='ownerStore.do'";
			str += "</script>";
		}
		pw.print(str);
		return null;
	}
	
	//ing 수정페이지 이동
	@RequestMapping("ownerStoreUpdateForm.do")
	public ModelAndView ownerStoreUpdateForm(int snum) {
		ModelAndView mav = new ModelAndView();
		
		//ing 가게업종 정보 //aservice로 구현해야함
//		mav.addObject("foodList", oService.selectStore(snum));
		//ing 해쉬태그 리스트 //aservice로 구현해야함
//		mav.addObject("themeList", oService.selectStore(snum));
		//ed 가게정보 불러오기
//		mav.addObject("store", oService.selectStore(snum));
		// jsp 출력
		mav.setViewName("Owner/ownerStoreForm");
		return mav;
	}
	
	//가게 수정하기
	@RequestMapping("updateStore.do")
	public String updateStore(Store store
			, HttpServletResponse resp
			, @RequestParam("sfile") MultipartFile sfile) throws Exception{
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		int result = oService.updateStore(store,sfile);
		if(!store.getStag().equals("")) {
			oService.updateStag(store);
		}
		if(result > 0) {
			str = "<script language='javascript'>";
			str += "alert('가게가 수정되었습니다.');";
			str += "location.href='ownerStore.do'";
			str += "</script>";
		}else {
			str = "<script language='javascript'>";
			str += "alert('가게수정에 실패했습니다.');";
			str += "location.href='ownerStore.do'";
			str += "</script>";
		}
		pw.print(str);
		return null;
	}
	
	//ed 가게 삭제하기
	@RequestMapping("deleteStore.do")
	public String deleteStore(int snum) {
		oService.deleteStore(snum);
		return "redirect:ownerStore.do";
	}
	
	//내 가게
	//가게 정보 페이지로 이동하기
	@RequestMapping("ownerStore.do")
	public ModelAndView	ownerStore(HttpSession session
			,HttpServletResponse resp) throws Exception{
		//session에 저장된 아이디 추출
		String bid = (String) session.getAttribute("bid");
		Boss boss = new Boss();
		Store store = new Store();
		boss.setBid(bid);
		store.setBid(bid);
		ModelAndView mav = new ModelAndView();
		//bid에 일치하는 stores 정보 추출
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
		if(bid != null && !bid.equals("") ) {
			mav.addObject("boss", bService.selectBossOne(boss));
			mav.addObject("stores", oService.selectStoreList(store));
			mav.setViewName("Owner/ownerStore");
			return mav;
		}else {
			str = "<script language='javascript'>";
			str += "alert('세션이 만료되었습니다.');";
			str += "location.href='main.do'";
			str += "</script>";
			pw.print(str);
			return null;
		}
	}
	

}