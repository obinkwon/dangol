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
	private MemberService memservice;
	
	@Autowired
	private AdminService aService;
	
	@Autowired
	private OwnerService oService;
	
	@RequestMapping("foodSort.do")//음식별 요청부분
	public ModelAndView foodSort(Admin admin ,ModelAndView mav) {
		int page = 0;
		if(admin.getType() == null){
			admin.setType("new");
		}
		if(admin.getPage() > 0){
			page = admin.getPage();
		}else {
			page = 1;
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
			int offset = maService.getOffset(page, 12);
			int startPage = maService.getStartPage(page);
			int endPage = maService.getEndPage(page);
			int lastPage = maService.getLastPage(12,resultSize);
			admin.setOffset(offset);
			admin.setStartPage(startPage);
			admin.setEndPage(endPage);
			admin.setLastPage(lastPage);
			
			sList = cService.getStoreListFood(admin); //음식종류별 가게 리스트 가져오기
			sList = cService.stagSetting(sList);//가게 태그 세팅
		}
		mav.addObject("viewInfo", admin); //조회 정보
		mav.addObject("adminList", aList); //음식 태그 리스트
		mav.addObject("storeList", sList); //가게 리스트
		mav.setViewName("category/foodSort");
		return mav;
	}
	
	@RequestMapping("themeSort.do")//테마별 요청부분
	public ModelAndView themeSort(Admin admin , ModelAndView mav) {
		int page = 0;
		if(admin.getType() == null){
			admin.setType("new");
		}
		if(admin.getPage() > 0){
			page = admin.getPage();
		}else {
			page = 1;
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
			int offset = maService.getOffset(page, 12);
			int startPage = maService.getStartPage(page);
			int endPage = maService.getEndPage(page);
			int lastPage = maService.getLastPage(12,resultSize);
			admin.setOffset(offset);
			admin.setStartPage(startPage);
			admin.setEndPage(endPage);
			admin.setLastPage(lastPage);
			
			sList = cService.getStoreListTheme(admin); //음식종류별 가게 리스트 가져오기
			sList = cService.stagSetting(sList);//가게 태그 세팅
		}
//			params = cService.selectThemeStoreList(page, 12, anum);
		
		mav.addObject("viewInfo", admin); //조회 정보
		mav.addObject("adminList", aList); //테마 태그 리스트
		mav.addObject("storeList", sList); //가게 리스트
		mav.setViewName("category/themeSort");
		return mav;
	}
	
	@RequestMapping("areaSort.do")//지역별 요청부분
	public ModelAndView areaSort(@RequestParam(defaultValue="서울특별시") String areaName,
			@RequestParam(defaultValue="new") String type,@RequestParam(defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> params = cService.selectAreaStoreList(page, 12, areaName);
		List<Store> sList = (List<Store>)params.get("sList"); 
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cService.gradeCount(sList);
		double[] commentCount = cService.commentCount(sList);
		List<String[]> stagList = cService.selectStagList(sList);
		for(int i=0; i<sList.size();i++) {
			HashMap<String, Object> storeMap = new HashMap<String, Object>();
			storeMap.put("snum", sList.get(i).getSnum()+"");
			storeMap.put("sname", sList.get(i).getSname());
			String[] str = sList.get(i).getSaddress().split(" ");
			String address=str[0]+" "+str[1];
			storeMap.put("saddress", address);
			storeMap.put("simage", sList.get(i).getSimage());
			storeMap.put("userCount", gradeCount[i]);
			storeMap.put("commentCount", commentCount[i]);
			String[] stag = stagList.get(i);
			for(int j=0;j<3;j++) {
				storeMap.put("stag"+(j+1), stag[j]);
			}
			storeMapList.add(storeMap);
		}
		if(type.equals("star")) {
			MapComparatorDouble comp = new MapComparatorDouble("commentCount");
			Collections.sort(storeMapList, comp);
			Collections.reverse(storeMapList);
		}else if(type.equals("dan")){
			MapComparatorInt comp = new MapComparatorInt("userCount");
			Collections.sort(storeMapList, comp);
			Collections.reverse(storeMapList);
		}
		mav.addObject("viewInfo", params);
		mav.addObject("storeMapList", storeMapList);
		mav.setViewName("category/areaSort");
		return mav;
	}
	
	@RequestMapping("recommendSort.do")//추천별 요청부분
	public ModelAndView recommendSort(HttpSession session,HttpServletResponse resp,
			@RequestParam(defaultValue="1") int page) throws Exception {
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		if(session.getAttribute("mid")!=null) {//일반 회원 로그인이 되어 있을때 
			String mid = (String)session.getAttribute("mid");
			HashMap<String, Object> recommendMap = cService.selectRecommendList(mid);
			List<Store> sList = (List<Store>)recommendMap.get("sList");
			List<Store> mtagList = (List<Store>)recommendMap.get("mtagList");
			List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
			int[] gradeCount = cService.gradeCount(sList);
			double[] commentCount = cService.commentCount(sList);
			List<String[]> stagList = cService.selectStagList(sList);
			for(int i=0; i<sList.size();i++) {
				HashMap<String, Object> storeMap = new HashMap<String, Object>();
				storeMap.put("snum", sList.get(i).getSnum()+"");
				storeMap.put("sname", sList.get(i).getSname());
				String[] string = sList.get(i).getSaddress().split(" ");
				String address=string[0]+" "+string[1];
				storeMap.put("saddress", address);
				storeMap.put("simage", sList.get(i).getSimage());
				storeMap.put("userCount", gradeCount[i]);
				storeMap.put("commentCount", commentCount[i]);
				String[] stag = stagList.get(i);
				for(int j=0;j<3;j++) {
					storeMap.put("stag"+(j+1), stag[j]);
				}
				storeMapList.add(storeMap);
			}
			mav.addObject("mtagList", mtagList);
			mav.addObject("storeMapList", storeMapList);
			mav.setViewName("category/recommendSort");
			return mav;
		}else if(session.getAttribute("bid")!=null){//사장님이 로그인이 되어 있을때 
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
	
	@RequestMapping("newStoreAll.do")//신규매장 요청 부분
	public ModelAndView newStoreAll(@RequestParam(defaultValue="new") String type,@RequestParam(defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> params = cService.selectNewStoreList(page, 12);
		List<Store> sList = (List<Store>)params.get("sList");
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cService.gradeCount(sList);
		double[] commentCount = cService.commentCount(sList);
		List<String[]> stagList = cService.selectStagList(sList);
		for(int i=0; i<sList.size();i++) {
			HashMap<String, Object> storeMap = new HashMap<String, Object>();
			storeMap.put("snum", sList.get(i).getSnum()+"");
			storeMap.put("sname", sList.get(i).getSname());
			String[] string = sList.get(i).getSaddress().split(" ");
			String address=string[0]+" "+string[1];
			storeMap.put("saddress", address);
			storeMap.put("simage", sList.get(i).getSimage());
			storeMap.put("userCount", gradeCount[i]);
			storeMap.put("commentCount", commentCount[i]);
			String[] stag = stagList.get(i);
			for(int j=0;j<3;j++) {
				storeMap.put("stag"+(j+1), stag[j]);
			}
			storeMapList.add(storeMap);
		}
		System.out.println("---------------------------------------------");
		if(type.equals("star")) {
			MapComparatorDouble comp = new MapComparatorDouble("commentCount");
			Collections.sort(storeMapList, comp);
			Collections.reverse(storeMapList);
		}else if(type.equals("dan")){
			MapComparatorInt comp = new MapComparatorInt("userCount");
			Collections.sort(storeMapList, comp);
			Collections.reverse(storeMapList);
		}
		mav.addObject("viewInfo", params);
		mav.addObject("storeMapList", storeMapList);
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
		
		//휴무일 쪼개서 보내기(ing)
		List<String> hoList = new ArrayList<String>();
		String[] holiday = store.getSholiday().split(",");
		for(String h : holiday) {
			switch (h) {
			case "mon":
				hoList.add("월요일");
				break;
			case "tue":
				hoList.add("화요일");
				break;
			case "wed":
				hoList.add("수요일");
				break;
			case "thu":
				hoList.add("목요일");
				break;
			case "fri":
				hoList.add("금요일");
				break;
			case "sat":
				hoList.add("토요일");
				break;
			default:
				hoList.add("일요일");
				break;
			}
		}
		
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
		mav.addObject("hoList",hoList);//휴일 정보
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
		Member m = memservice.selectMember(member);
		Comment c = cService.selectComment(cnum,dnum);
		Details detail = new Details();
		detail.setDnum(c.getDnum());
		Details d = cService.selectDetail(detail);
		String[] menuList = null;
		if(d.getDmenu()!=null) menuList = d.getDmenu().split(",");
		Grade g = cService.commentMid(d.getDnum());
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
	
	@RequestMapping("insertNewStoreDB.do")//데이터 입력 요청
	public void insertNewStoreDB() {
		cService.insertNewStore();
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
