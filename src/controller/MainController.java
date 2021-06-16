package controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.Event;
import model.Store;
import service.CategoryService;
import service.MainService;
import service.OwnerService;

@Controller
public class MainController {
	
	@Autowired
	private MainService maService;
	
	@Autowired
	private CategoryService cservice;
	
	@Autowired
	private OwnerService oService;
	
	//메인 페이지 요청부분
	@RequestMapping("main.do")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object>	params = cservice.selectNewStoreList(1,3);
//		List<Store> sList = (List<Store>)params.get("sList");
		List<Store> sList = new ArrayList<Store>();
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cservice.gradeCount(sList);
		double[] commentCount = cservice.commentCount(sList);
		List<String[]> stagList = cservice.selectStagList(sList);
		for(int i=0; i<sList.size();i++) {
			HashMap<String, Object> storeMap = new HashMap<String, Object>();
			storeMap.put("snum", sList.get(i).getSnum());
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
		mav.addObject("storeNewList", storeMapList);
		//
		storeMapList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Integer> mainTagMap = maService.selectMainTagNum();
		if(mainTagMap.get("main1") != null) {
			params = cservice.selectThemeStoreList(1, 3, mainTagMap.get("main1"));
		}
		sList = (List<Store>)params.get("sList");
		gradeCount = cservice.gradeCount(sList);
		commentCount = cservice.commentCount(sList);
		stagList = cservice.selectStagList(sList);
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
		if(maService.selectMainTag().get("main1") != null) {
			mav.addObject("maintag1",maService.selectMainTag().get("main1"));
		}
		if(maService.selectMainTagNum().get("main1") != null) {
			mav.addObject("mainnum1",maService.selectMainTagNum().get("main1"));
		}
		mav.addObject("storeThemeList1", storeMapList);
		//
		storeMapList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Integer> mainMap = maService.selectMainTagNum();
		if(mainMap.containsKey("main2")) {
			params = cservice.selectThemeStoreList(1, 3, maService.selectMainTagNum().get("main2"));
			sList = (List<Store>)params.get("sList");
		}
		gradeCount = cservice.gradeCount(sList);
		commentCount = cservice.commentCount(sList);
		stagList = cservice.selectStagList(sList);
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
		//이벤트 배너
		Event e = maService.selectEventBanner();
		int eventBanner = 0;
		if(e!=null) eventBanner = e.getEid();
		//올해의 매장
		List<HashMap<String, Object>> yearStoreList = maService.selectYearStore();
		MapComparatorDouble comp = new MapComparatorDouble("ctotalAvg");
		Collections.sort(yearStoreList, comp);
		Collections.reverse(yearStoreList);
		int yearStore = 127255;
		if(yearStoreList.size()!=0) {
			Store store = new Store();
			int snum = (int)yearStoreList.get(0).get("snum");
			store.setSnum(snum);
			yearStore = oService.selectStoreOne(store).getSnum();
		}	
		//이달의 매장
		List<HashMap<String, Object>> monthStoreList = maService.selectMonthStore();
		comp = new MapComparatorDouble("ctotalAvg");
		Collections.sort(monthStoreList, comp);
		Collections.reverse(monthStoreList);
		int monthStore = 127255;
		if(monthStoreList.size()!=0) {
			Store store = new Store();
			int snum = (int)monthStoreList.get(0).get("snum");
			store.setSnum(snum);
			monthStore = oService.selectStoreOne(store).getSnum();
		}
		mav.addObject("bestStore",maService.selectBestStore());
		mav.addObject("monthStore",monthStore);
		mav.addObject("yearStore",yearStore);
		mav.addObject("eventBanner",eventBanner);
		mav.addObject("maintag2",maService.selectMainTag().get("main2"));
		mav.addObject("mainnum2",maService.selectMainTagNum().get("main2"));
		mav.addObject("storeThemeList2", storeMapList);
		mav.setViewName("jsp/main");
		return mav;
	}
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:main.do";
	}

	@RequestMapping("search.do")
	public ModelAndView search(String keyword, 
			@RequestParam(defaultValue="new") String type, @RequestParam(defaultValue="1") int page) {//검색 가게 리스트
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object>	params = maService.searchMain(keyword, page, 12);
		List<Store> sList = (List<Store>)params.get("sList");
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		int[] gradeCount = cservice.gradeCount(sList);
		double[] commentCount = cservice.commentCount(sList);
		List<String[]> stagList = cservice.selectStagList(sList);
		cservice.selectStagList(sList);
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
		mav.setViewName("jsp/searchStore");
		return mav;
	}
	
	//회사소개 요청 부분
	@RequestMapping("infoCompany.do")
	public String infoCompany() {
		return "companyInfo/infoCompany";
	}
	
	//서비스 소개 요청 부분
	@RequestMapping("infoService.do")
	public String infoService() {	
		return "companyInfo/infoService";
	}
	
	//등급별 혜택 부분
	@RequestMapping("infoBenefit.do")
	public String infoBenefit() {
		return "companyInfo/infoBenefit";
	}
	
	//가맹점 현황 부분
	@RequestMapping("infoStore.do")
	public ModelAndView infoStore(@RequestParam(defaultValue="전체")String address,
			@RequestParam(defaultValue="1")int page,
			Store store) {
		ModelAndView mav = new ModelAndView();
		String year = new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime());
		String month = new SimpleDateFormat("MM").format(Calendar.getInstance().getTime());
		mav.addObject("year", year);//현재 년도
		mav.addObject("month", month);//현재 월
		if(address.equals("전체")) {
			address = "";//기본값을 전체로 한다
		}
		int offset = maService.getOffset(page, 12);
		int startPage = maService.getStartPage(page);
		int endPage = maService.getEndPage(page);
		store.setSaddress(address);
		store.setStoresPerPage(12);
		store.setOffset(offset);
		store.setPage(page);
		store.setStartPage(startPage);
		store.setEndPage(endPage);
		
		List<Store> storeList = maService.areaStoreList(store);
		int storeListCnt = maService.areaStoreListCnt(store);
		int lastPage = maService.getLastPage(12,storeListCnt);
		store.setLastPage(lastPage);
		
		mav.addObject("infoVO", store);
		mav.addObject("storeList", storeList);//해당 지역 가게 리스트
		mav.addAllObjects(maService.infoStoreCount());//총 카운트 리스트
		mav.setViewName("companyInfo/infoStore");
		return mav;
	}
	
//	@RequestMapping("bestStore.do")
//	public @ResponseBody String bestStore() {
//		String simage = mservice.selectBestStore();
//		if(simage==null) simage="image_ready.png";
//		return simage;
//	}
	
//	@RequestMapping("monthStore.do")
//	public @ResponseBody String monthStore() {
//		List<HashMap<String, Object>> storeMapList = mservice.selectMonthStore();
//		MapComparatorDouble comp = new MapComparatorDouble("ctotalAvg");
//		Collections.sort(storeMapList, comp);
//		Collections.reverse(storeMapList);
//		String simage = null;
//		if(storeMapList.size()!=0) {
//			int snum = (int)storeMapList.get(0).get("snum");
//			simage = mservice.selectStore(snum).getSimage();
//		}
//		return simage;
//	}
	
//	@RequestMapping("yearStore.do")
//	public @ResponseBody String yearStore() {
//		List<HashMap<String, Object>> storeMapList = mservice.selectYearStore();
//		MapComparatorDouble comp = new MapComparatorDouble("ctotalAvg");
//		Collections.sort(storeMapList, comp);
//		Collections.reverse(storeMapList);
//		int simage = 0;
//		if(storeMapList.size()!=0) {
//			int snum = (int)storeMapList.get(0).get("snum");
//			simage = mservice.selectStore(snum).getSnum();
//		}		
//		return simage;
//	}
	
//	@RequestMapping("eventBanner.do")
//	public @ResponseBody int eventBanner() {
//		Event e = mservice.selectEventBanner();
//		int simage = 0;
//		if(e!=null) simage = e.getEid();
//		return simage;
//	}
	
}
