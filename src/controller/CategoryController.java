package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Member;
import model.Order;
import model.Store;
import service.CategoryService;
import service.EventService;
import service.MainService;
import service.MemberService;
import service.MyPageService;

@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService cservice;
	
	@Autowired
	private MainService mservice;
	
	@Autowired
	private MyPageService mypageService;
	
	@Autowired
	private MemberService memservice;
	
	@Autowired
	private EventService eService;
	
	@RequestMapping("foodSort.do")//음식별 요청부분
	public ModelAndView foodSort(@RequestParam(defaultValue="new") String type
			, @RequestParam(defaultValue="1") int page
			, Admin admin) {
		ModelAndView mav = new ModelAndView();
		if(admin.getAtype() == null) {
			admin.setAtype("food");
		}
		List<Admin> aList = cservice.sortFoodList(admin); // 음식 종류 리스트
		HashMap<String, Object> params = null;
		List<HashMap<String, Object>> storeMapList = new ArrayList<>();
		List<Store> sList = null;
		
		if(aList.size() > 0) { //음식 종류가 하나라도 있을때
			if(admin.getAnum() == 0) {
				admin = (Admin)aList.get(0);
			}
			admin.setStoresPerPage(12);
			params = cservice.selectFoodStoreList(page,admin); // page번호 / admin (페이징)
			sList = cservice.getStoreList(admin); //음식종류별 가게 리스트 가져오기
			sList = cservice.etcCount(sList);
			
			if(type.equals("star")) { //별점순
				MapComparatorDouble comp = new MapComparatorDouble("commentCount");
				Collections.sort(storeMapList, comp);
				Collections.reverse(storeMapList);
			}else if(type.equals("dan")){ //단골순
				MapComparatorInt comp = new MapComparatorInt("userCount");
				Collections.sort(storeMapList, comp);
				Collections.reverse(storeMapList);
			}
		}
		mav.addObject("viewInfo", params);
		mav.addObject("adminList", aList); //음식 태그 리스트
		mav.addObject("storeList", sList); //가게 리스트
		mav.setViewName("category/foodSort");
		return mav;
	}
	
	@RequestMapping("themeSort.do")//테마별 요청부분
	public ModelAndView themeSort(@RequestParam(defaultValue="0") int anum, @RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="new") String type) {
		ModelAndView mav = new ModelAndView();
		List<Admin> aList = cservice.sortThemeList();
		HashMap<String, Object>	params = null;
		List<HashMap<String, Object>> storeMapList = new ArrayList<>();
		if(aList != null && aList.size() > 0) {
			if(anum==0) anum = aList.get(0).getAnum();
			params = cservice.selectThemeStoreList(page, 12, anum);
			List<Store> sList = (List<Store>)params.get("sList");
			int[] gradeCount = cservice.gradeCount(sList);
			double[] commentCount = cservice.commentCount(sList);
			List<String[]> stagList = cservice.selectStagList(sList);
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
		}
		mav.addObject("viewInfo", params);
		mav.addObject("adminList", aList);
		mav.addObject("storeMapList", storeMapList);
		mav.setViewName("category/themeSort");
		return mav;
	}
	
	@RequestMapping("areaSort.do")//지역별 요청부분
	public ModelAndView areaSort(@RequestParam(defaultValue="서울특별시") String areaName,
			@RequestParam(defaultValue="new") String type,@RequestParam(defaultValue="1") int page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> params = cservice.selectAreaStoreList(page, 12, areaName);
		List<Store> sList = (List<Store>)params.get("sList"); 
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cservice.gradeCount(sList);
		double[] commentCount = cservice.commentCount(sList);
		List<String[]> stagList = cservice.selectStagList(sList);
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
			HashMap<String, Object> recommendMap = cservice.selectRecommendList(mid);
			List<Store> sList = (List<Store>)recommendMap.get("sList");
			List<Store> mtagList = (List<Store>)recommendMap.get("mtagList");
			List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
			int[] gradeCount = cservice.gradeCount(sList);
			double[] commentCount = cservice.commentCount(sList);
			List<String[]> stagList = cservice.selectStagList(sList);
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
		HashMap<String, Object> params = cservice.selectNewStoreList(page, 12);
		List<Store> sList = (List<Store>)params.get("sList");
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cservice.gradeCount(sList);
		double[] commentCount = cservice.commentCount(sList);
		List<String[]> stagList = cservice.selectStagList(sList);
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
		String mid = (String)session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		Grade g = null;
		int snum = grade.getSnum();
		if(mid != null && mid.equals("")) { //로그인 되어있을때
			grade.setMid(mid);
			g = cservice.selectMyGradeInfo(grade);
		}
		Store s = mservice.selectStoreOne(store);
		
		//휴무일 쪼개서 보내기
		List<String> hoList = new ArrayList<String>();
		String[] holiday = s.getSholiday().split(",");
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
		List<Order> menuList = cservice.selectOrderList(s);
		//현재 날짜
		String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.sql.Date(System.currentTimeMillis()));
		//후기가져오기
		List<Comment> cList = null;
		if(type.equals("new")){ //전체 리뷰
			cList = cservice.storeCommentList(s);
		}else if(type.equals("my")) { //내 리뷰
			if(mid.equals("")) {
				cList = cservice.storeMyCommentList(g);
			}
		}
		//메뉴 개수
		mav.addObject("menuSize",menuList.size());
		//리뷰 리스트 갯수
		mav.addObject("listSize",cList.size());
		//리뷰 리스트 가져오기
		mav.addObject("commentMapList",cList);
		//단골수 가져오기
		mav.addAllObjects(cservice.selectDangolList(s));
		//등급 정보
		mav.addObject("grade",g);
		//거게 정보
		mav.addObject("store",s);
		//휴일 정보
		mav.addObject("hoList",hoList);
		//메뉴 리스트 가져오기
		mav.addObject("menuList",menuList);
		//가게 태그 가져오기
		mav.addObject("tagList",cservice.selectStagList1(s));
		//현재 날짜
		mav.addObject("currentDate",currentDate);
		mav.setViewName("category/storeView");
		return mav;
	}
	
	@RequestMapping("likes.do")//가게 상세보기 요청 부분
	public String likes(@RequestParam(required=false) String mid,@RequestParam(required=false) String like,int snum) {
		if(!like.equals("")) {
			if(like.equals("0")) mypageService.insertLikes(mid, snum);
			else mypageService.deleteLikes(mid, snum);
		}
		return "redirect:storeView.do?snum="+snum;
	}
	
	@RequestMapping("reserveStore.do")
	public void reserveStore(Details detail,int snum,HttpSession session,
			HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
		String mid = (String)session.getAttribute("mid");
		int result = 0;
		Grade g = cservice.selectMyGradeInfo1(snum, mid);
		if(g==null) {
			g= new Grade();
			g.setMid(mid);
			g.setSnum(snum);
			cservice.insertBeginGrade(g);
		}
		Store s = mservice.selectStore(snum);
		//System.out.println(detail);
		List<Details> dList = cservice.todayReserve(snum, detail.getDdate());
		detail.setGnum(g.getGnum());
		if(dList.size()==0) {//해당날짜에 예약이 없을때
			if(s.getSlimit() >= detail.getDperson()) {
				detail.setDlimit(s.getSlimit());
				result = cservice.insertDetailOne(detail);//예약하기
			}
		}else {//해당 날짜에 예약이 있을때
			int limit = 0;
			for(Details d : dList) {
				limit += d.getDperson();
			}
			detail.setDlimit(dList.get(0).getDlimit());
			if((dList.get(0).getDlimit()-limit) >= detail.getDperson()) {//예약 가능
				result = cservice.insertDetailOne(detail);//예약하기
			}else {}//예약 불가능
		}
		str = "<script language='javascript'>";
		if(result==1) {
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
		cservice.deleteComment(cnum);
		return "redirect:storeView.do?snum="+snum;
	}
	
	@RequestMapping("modifyCommentForm.do")
	public ModelAndView modifyCommentForm(HttpSession session
			, @RequestParam(defaultValue="0") int cnum 
			, @RequestParam(defaultValue="0") int dnum) throws Exception{
		ModelAndView mav = new ModelAndView();
		String mid = (String)session.getAttribute("mid");
		Member m = memservice.selectMember(mid);
		Comment c = cservice.selectComment(cnum,dnum);
		Details d = cservice.selectDetail(c.getDnum());
		String[] menuList = null;
		if(d.getDmenu()!=null) menuList = d.getDmenu().split(",");
		Grade g = cservice.commentMid(d.getDnum());
		Store s = mservice.selectStore(g.getSnum());
		List<Admin> tasteTag = cservice.selectTasteTagList();
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
		cservice.updateComment(comment);
		System.out.println(comment);
		if(type.equals("h")) return "redirect:historyView.do?snum="+snum;
		else return "redirect:storeView.do?snum="+snum;
	}
	
	@RequestMapping("downloadStoreImg.do")
	public View downloadStoreImg(int snum) {
		File attachFile= cservice.getAttachedFile(snum);
		View view = null;
		if(attachFile != null) {
			view = new DownloadView(attachFile);
		}
		return view;
	}
	
	@RequestMapping("downloadStoreMenuImg.do")
	public View downloadStoreMenuImg(int onum) {
		File attachFile= cservice.getAttachedFileMenu(onum);
		View view = new DownloadView(attachFile);
		return view;
	}
	
	@RequestMapping("insertNewStoreDB.do")//데이터 입력 요청
	public void insertNewStoreDB() {
		cservice.insertNewStore();
	}
	
	@RequestMapping("insertStoreMenu.do")//메뉴 입력 요청
	public void insertStoreMenu() {
		cservice.insertStoreMenu();
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
