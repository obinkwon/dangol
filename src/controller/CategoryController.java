package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Member;
import model.Order;
import model.Store;
import service.AdminService;
import service.CategoryService;
import service.EventService;
import service.MainService;
import service.MemberService;
import service.MyPageService;
import service.OwnerService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService cService;
	
	@Autowired
	private MainService maService;
	
	@Autowired
	private MyPageService mypageService;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private AdminService aService;
	
	@Autowired
	private OwnerService oService;
	
	//카테고리 - 음식별
	@RequestMapping("foodSort.do")
	public ModelAndView foodSort(Admin admin ,ModelAndView mav
			,@RequestParam(defaultValue="1") int page) {
		if(admin.getType() == null){
			admin.setType("new");
		}
		
		admin.setAtype("food");
		List<Admin> aList = aService.selectAdminTypeList(admin); // admin type 리스트
		List<Store> sList = null;
		
		if(aList.size() > 0) { //음식 종류가 하나라도 있을때
			if(admin.getAnum() == 0) {
				admin = aList.get(0);
			}
			admin.setStoresPerPage(12);
			admin.setPage(page);
			int resultSize = cService.getStoreListCountFood(admin);
			admin = maService.getPaging(admin,resultSize);
			
			sList = cService.getStoreListFood(admin); //음식종류별 가게 리스트 가져오기
			sList = cService.stagSetting(sList);//가게 태그 세팅
		}
		mav.addObject("viewInfo", admin); //조회 정보
		mav.addObject("adminList", aList); //음식 태그 리스트
		mav.addObject("storeList", sList); //가게 리스트
		mav.setViewName("category/foodSort");
		return mav;
	}
	
	//카테고리 - 테마별
	@RequestMapping("themeSort.do")
	public ModelAndView themeSort(Admin admin , ModelAndView mav
			,@RequestParam(defaultValue="1") int page) {
		if(admin.getType() == null){
			admin.setType("new");
		}
		
		admin.setAtype("theme");
		List<Admin> aList = aService.selectAdminTypeList(admin); // admin type 리스트
		List<Store> sList = null;
		
		if(aList.size() > 0) { //테마 종류가 하나라도 있을때
			if(admin.getAnum() == 0) {
				admin = aList.get(0);
			}
			admin.setStoresPerPage(12);
			admin.setPage(page);
			int resultSize = cService.getStoreListCountTheme(admin);
			admin = maService.getPaging(admin,resultSize);
			
			sList = cService.getStoreListTheme(admin); //음식종류별 가게 리스트 가져오기
			sList = cService.stagSetting(sList);//가게 태그 세팅
		}
		mav.addObject("viewInfo", admin); //조회 정보
		mav.addObject("adminList", aList); //테마 태그 리스트
		mav.addObject("storeList", sList); //가게 리스트
		mav.setViewName("category/themeSort");
		return mav;
	}
	
	//카테고리 - 지역별
	@RequestMapping("areaSort.do")
	public ModelAndView areaSort(Admin admin , ModelAndView mav
			,@RequestParam(defaultValue="1") int page) {
		if(admin.getType() == null){
			admin.setType("new");
		}
		if(admin.getAreaName() == null) {
			admin.setAreaName("서울특별시");
		}
		
		List<Store> areaList = maService.getAreaInfo();
		admin.setStoresPerPage(12);
		admin.setPage(page);
		int resultSize = cService.getStoreListCountTheme(admin);
		admin = maService.getPaging(admin,resultSize);
		List<Store> sList = cService.getStoreListArea(admin); //음식종류별 가게 리스트 가져오기
		sList = cService.stagSetting(sList);//가게 태그 세팅
		
		mav.addObject("viewInfo", admin); //조회 정보
		mav.addObject("storeList", sList); //가게 리스트
		mav.addObject("areaList", areaList); //지역 리스트
		mav.setViewName("category/areaSort");
		return mav;
	}
	
	//지역 상세 정보
	@ResponseBody
	@RequestMapping("areaInfoDetail.do")
	public List<Store> areaInfoDetail(Store store) {
		return maService.getAreaInfoDetail(store);
	}
	
	//카테고리 - 추천별
	@RequestMapping("recommendSort.do")
	public ModelAndView recommendSort(Admin admin , ModelAndView mav
			, HttpSession session
			, Member member
			, HttpServletResponse resp
			, @RequestParam(defaultValue="1") int page) throws Exception {
		resp.setContentType("text/html; charset=UTF-8");
		String mid = (String)session.getAttribute("mid");
		if(mid != null) {//일반 회원 로그인이 되어 있을때 
			member.setMid(mid);
			member = mService.selectMember(member);
			if(member != null) {
				admin.setMid(member.getMid());
				List<Admin> aList = aService.selectAdminMtagList(admin); // admin type 리스트
				List<Integer> anumList = new ArrayList<Integer>();
				for(Admin ad : aList) {
					anumList.add(ad.getAnum());
				}
				admin.setAnumList(anumList);
				admin.setMaddress(member.getMaddress());
				admin.setMarea1(member.getMarea1());
				admin.setMarea2(member.getMarea2());
				admin.setStoresPerPage(12);
				admin.setPage(page);
				int resultSize = cService.getStoreListCountRecommend(admin);
				admin = maService.getPaging(admin,resultSize);
				
				List<Store> sList = cService.getStoreListRecommend(admin);//추천별 가게 리스트 가져오기
				sList = cService.stagSetting(sList);//가게 태그 세팅
				
				mav.addObject("viewInfo", admin); //조회 정보
				mav.addObject("mtagList", aList);
				mav.addObject("storeList", sList);
				mav.setViewName("category/recommendSort");
				return mav;
			}else {
				mav.setViewName("redirect:loginForm.do");
				return mav;
			}
		}else if(session.getAttribute("bid") != null){//사장님이 로그인이 되어 있을때 
			PrintWriter pw = resp.getWriter();
			String str = "";
			str = "<script language='javascript'>";
			str += "alert('일반회원만 이용 가능 합니다.');";
			str += "location.href='main.do';";
			str += "</script>";
			pw.print(str);
			return null;
		}else {//아무것도 로그인이 안되어 있을때
			mav.setViewName("redirect:loginForm.do");
			return mav;
		}
	}
	
	//카테고리 - 신규매장
	@RequestMapping("newStoreAll.do")
	public ModelAndView newStoreAll(Admin admin, ModelAndView mav 
			, @RequestParam(defaultValue="1") int page) {
		if(admin.getType() == null){
			admin.setType("new");
		}
		
		admin.setStoresPerPage(12);
		admin.setPage(page);
		int resultSize = cService.getStoreListCountNew(admin);
		admin = maService.getPaging(admin,resultSize);
		
		List<Store> sList = cService.getStoreListNew(admin);//신규 가게 리스트 가져오기
		sList = cService.stagSetting(sList);//가게 태그 세팅
		
		mav.addObject("viewInfo", admin);
		mav.addObject("storeList", sList);
		mav.setViewName("category/newStoreAll");
		return mav;
	}
	
	@RequestMapping("storeView.do")//가게 상세보기 요청 부분
	public ModelAndView storeView(@RequestParam(defaultValue="new") String type
			, Grade grade
			, Store store
			, HttpSession session) throws Exception{
		//현재 날짜
		String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		String mid = (String)session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		if(mid != null && !mid.equals("")) { //일반 사용자 로그인 되어있을때
			grade.setMid(mid);
			grade = cService.selectMyGradeInfo(grade);//내 등급 정보
		}
		store = oService.selectStoreOne(store);//가게 정보
		
		//휴무일 쪼개서 보내기
		String[] holiday = store.getSholiday().split(",");
		
		//메뉴 가져오기
		List<Order> menuList = cService.selectOrderList(store);
		//후기가져오기(ing)
		List<Comment> cList = null;
		if(type.equals("new")){ //전체 리뷰
			cList = cService.storeCommentList(store);
		}else if(type.equals("my")) { //내 리뷰
			if(mid.equals("")) {
				cList = cService.storeMyCommentList(grade);
			}
		}
		//가게 단골 정보(ing)
		Map<String, Object> dangolMap = cService.selectDangolList(store);
		//가게 태그 가져오기
		List<Store> tagList = oService.selectStagList(store);
		
		mav.addObject("menuSize",menuList.size());//메뉴 개수
		mav.addObject("listSize",cList.size());//리뷰 리스트 갯수
		mav.addObject("commentMapList",cList);//리뷰 리스트 가져오기
		mav.addObject("dangolMap",dangolMap);//단골 정보
		mav.addObject("grade",grade);//등급 정보
		mav.addObject("store",store);//가게 정보
		mav.addObject("hoList",holiday);//휴일 정보
		mav.addObject("menuList",menuList);//메뉴 리스트 가져오기
		mav.addObject("tagList",tagList);//가게 태그 리스트 가져오기
		mav.addObject("currentDate",currentDate);//현재 날짜
		mav.setViewName("category/storeView");
		return mav;
	}
	
	//가게 즐겨찾기 등록
	@RequestMapping("likes.do")
	@ResponseBody
	public int likes(Member member
		,@RequestParam(defaultValue="0") String like) {
		int glike = 0;
		if(like.equals("0")) {
			glike = 1;
		}else {
			glike = 0;
		}
		member.setGlike(glike);
		mypageService.updateLike(member);
		return glike;
	}
	
	//예약 하기
	@RequestMapping("reserveStore.do")
	public void reserveStore(Details detail
			,Grade grade 
			,Store store
			,HttpSession session
			,HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "<script language='javascript'>";
		
		String mid = (String)session.getAttribute("mid");
		grade.setMid(mid);
		int snum = detail.getSnum();
		int result = 0;
		store = oService.selectStoreOne(store);//가게정보 가져오기
		grade = cService.selectMyGradeInfo(grade);//등급정보 가져오기
		if(grade == null) {
			grade = new Grade();
			grade.setMid(mid);
			grade.setSnum(snum);
			cService.insertGrade(grade);
		}
		
		List<Details> dList = cService.todayReserve(detail);//예약 리스트 가져오기
		int maxPerson = 0;
		int todayLimit = store.getSlimit();//하루 예약 가능한 최대 인원수
		for(Details dd : dList) { //하루 총 예약한 인원수
			maxPerson += dd.getDperson();
		}
		
		if(todayLimit >= maxPerson && todayLimit >= detail.getDperson()) {//예약 가능 인원 체크
			detail.setGnum(grade.getGnum());
			detail.setDlimit(store.getSlimit());
			result = cService.insertDetail(detail);//예약하기
		}
		
		if(result > 0) {
			str += "alert('예약이 완료 되었습니다.');";
			str += "location.href='storeView.do?snum="+snum+"'";
		}else {
			str += "alert('예약인원이 다 찼습니다. 다른 날짜로 이용 해주세요.');";
			str += "history.go(-1);";
		}
		str += "</script>";
		pw.print(str);
	}
	
	@RequestMapping("removeComment.do")
	public String removeComment(int snum,int cnum) {
		cService.deleteComment(cnum);
		return "redirect:storeView.do?snum="+snum;
	}
	
	@RequestMapping("modifyCommentForm.do")
	public ModelAndView modifyCommentForm(HttpSession session
			, @RequestParam(defaultValue="0") int cnum 
			, @RequestParam(defaultValue="0") int dnum) throws Exception{
		ModelAndView mav = new ModelAndView();
		String mid = (String)session.getAttribute("mid");
		Member member = new Member();
		member.setMid(mid);
		Member m = mService.selectMember(member);
		Comment c = cService.selectComment(cnum,dnum);
		Details detail = new Details();
		detail.setDnum(c.getDnum());
		Details d = cService.getDetailOne(detail);
		String[] menuList = null;
		if(d.getDmenu()!=null) menuList = d.getDmenu().split(",");
		Grade g = cService.getGradeComment(d);
		Store store = new Store();
		store.setSnum(g.getSnum());
		Store s = oService.selectStoreOne(store);
		List<Admin> tasteTag = cService.selectTasteTagList();
		if(dnum==0) mav.addObject("type","m");
		else mav.addObject("type","h");
		mav.addObject("menuList",menuList);
		mav.addObject("tasteTag",tasteTag);
		mav.addObject("grade",g);
		mav.addObject("store",s);
		mav.addObject("details",d);
		mav.addObject("comment",c);
		mav.addObject("mimage",m.getMimage());
		mav.setViewName("category/modifyComment");
		return mav;
	}
	
	@RequestMapping("modifyComment.do")
	public String modifyComment(Comment comment,String[] tag,String type,String snum) {
		String ctaste = "#"+tag[0]+",#"+tag[1];
		comment.setCtaste(ctaste);
		cService.updateComment(comment);
		System.out.println(comment);
		if(type.equals("h")) return "redirect:historyView.do?snum="+snum;
		else return "redirect:storeView.do?snum="+snum;
	}
	
	@RequestMapping("downloadStoreImg.do")
	public View downloadStoreImg(int snum) {
		File attachFile= cService.getAttachedFile(snum);
		View view = null;
		if(attachFile != null) {
			view = new DownloadView(attachFile);
		}
		return view;
	}
	
	@RequestMapping("downloadStoreMenuImg.do")
	public View downloadStoreMenuImg(Order order) throws Exception{
		File attachFile = cService.getAttachedFileMenu(order);
		View view = null;
		if(attachFile != null) {
			view = new DownloadView(attachFile);
		}
		return view;
	}
	
	@RequestMapping("insertStoreMenu.do")//메뉴 입력 요청
	public void insertStoreMenu() {
		cService.insertStoreMenu();
	}
		
}

class MapComparatorInt implements Comparator<HashMap<String, Object>> {//HashMap<String, int> comparator
	private final String key;
	public MapComparatorInt(String key) {
		this.key = key;
	}
	@Override
	public int compare(HashMap<String, Object> first, HashMap<String, Object> second) {
		int result = ((Integer) first.get(key)).compareTo((Integer) second.get(key));
		return result;
	}
}
class MapComparatorDouble implements Comparator<HashMap<String, Object>> {//HashMap<String, Double> comparator
	private final String key;
	public MapComparatorDouble(String key) {
		this.key = key;
	}
	@Override
	public int compare(HashMap<String, Object> first, HashMap<String, Object> second) {
		int result = ((Double) first.get(key)).compareTo((Double) second.get(key));
		return result;
	}
}
