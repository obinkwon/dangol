package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ICategoryDao;
import dao.IMainDao;
import model.Admin;
import model.Comment;
import model.Details;
import model.Event;
import model.Grade;
import model.Store;

@Service
public class MainService {
	
	@Autowired
	private IMainDao imdao;
	
	public HashMap<String, Integer> infoStoreCount() {
		HashMap<String, Integer> infoMap = new HashMap<String, Integer>();
		infoMap.put("storeCount", imdao.selectTotalStores());
		infoMap.put("userCount", imdao.selectTotalMembers());
		infoMap.put("reviewCount", imdao.selectTotalComments());
		return infoMap;
	}
	public HashMap<String, Object> infoStoreList(int page, String address, int storesPerPage) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		params.put("address", address);
		result.put("sList", imdao.selectStoreByArea(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,imdao.getStoreByAreaCount(params)));
		result.put("totalBoard", imdao.getStoreByAreaCount(params));
		return result;
	}
	public int[] storeMemberCount(List<Store> sList) {
		int i = 0;
		int[] memberCount = new int[sList.size()];
		for(Store s : sList) {
			memberCount[i] = imdao.selectStoreMembers(s.getSnum());
			i++;
		}
		return memberCount;
	}
	
	public int selectBestStore() {
		int[] snumList = imdao.selectStoreMemberBySnum();
		if(snumList.length!=0) {
			Store store = new Store();
			store.setSnum(snumList[0]);
			Store s = imdao.selectStoreOne(store);
			if(s.getSimage()==null) return 758059;
			else return s.getSnum();
		}
		else return 758059;
	}
	
	public List<HashMap<String, Object>> selectMonthStore() {//이달의 별점 평균이 제일 높은 매장
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		List<Store> sList = imdao.selectStoreAll();
		for(Store s: sList) {
			int sum = 0;
			double ctotalAvg = 0;
			HashMap<String, Object> storeMap = new HashMap<String, Object>();
			storeMap.put("snum", s.getSnum());
			List<Grade> gList = imdao.selectGradeBySnum(s.getSnum());
			if(gList.size()!=0) {
				for(Grade g : gList) {
					List<Details> dList = imdao.selectDetailAllByGnum(g.getGnum());
					for(Details d : dList) {
						Comment c = imdao.selectCommentMonthByDnum(d.getDnum());
						if(c!=null) sum += c.getCtotal();
					}
				}
				ctotalAvg = sum/gList.size();
				storeMap.put("ctotalAvg", ctotalAvg);
				storeMapList.add(storeMap);
			}
		}
		return storeMapList;
	}
	
	public List<HashMap<String, Object>> selectYearStore() {//올해의 별점 평균이 제일 높은 매장
		List<HashMap<String, Object>> storeMapList = new ArrayList<HashMap<String, Object>>();
		List<Store> sList = imdao.selectStoreAll();
		for(Store s: sList) {
			int sum = 0;
			double ctotalAvg = 0;
			HashMap<String, Object> storeMap = new HashMap<String, Object>();
			storeMap.put("snum", s.getSnum());
			List<Grade> gList = imdao.selectGradeBySnum(s.getSnum());
			if(gList.size()!=0) {
				for(Grade g : gList) {
					List<Details> dList = imdao.selectDetailAllByGnum(g.getGnum());
					for(Details d : dList) {
						Comment c = imdao.selectCommentYearByDnum(d.getDnum());
						if(c!=null) sum += c.getCtotal();
					}
				}
				ctotalAvg = sum/gList.size();
				storeMap.put("ctotalAvg", ctotalAvg);
				storeMapList.add(storeMap);
			}
		}
		return storeMapList;
	}
	
	public Event selectEventBanner() {
		List<Event> eList = imdao.selectEventAll();
		if(eList.size()!=0) return eList.get(0);
		else return null;
	}
	
	public HashMap<String, Object> searchMain(String keyword, int page, int storesPerPage) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		params.put("keyword", keyword);
		result.put("sList", imdao.selectSearchStoreAll(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,imdao.getSearchStoreAllCount(params)));
		result.put("totalBoard", imdao.getSearchStoreAllCount(params));
		return result;
	}
	
	public Store selectStore(int snum) {
		Store store = new Store();
		store.setSnum(snum);
		return imdao.selectStoreOne(store);
	}
	
	public Store selectStoreOne(Store store) {
		return imdao.selectStoreOne(store);
	}
	
	public HashMap<String, String> selectMainTag(){
		HashMap<String, String> mainTagMap = new HashMap<String, String>();
		List<Admin> aList = imdao.selectAdminMainTag();
		if(aList != null && aList.size() > 0) {
			mainTagMap.put("main1", aList.get(0).getAvalue());
			mainTagMap.put("main2", aList.get(1).getAvalue());
		}
		return mainTagMap; 
	}
	
	public HashMap<String, Integer> selectMainTagNum(){
		HashMap<String, Integer> mainTagMap = new HashMap<String, Integer>();
		List<Admin> aList = imdao.selectAdminMainTag();
		if(aList != null && aList.size() > 0) {
			Admin a = imdao.selectAdminByAvlaue(aList.get(0).getAvalue());
			mainTagMap.put("main1", a.getAnum());
			a = imdao.selectAdminByAvlaue(aList.get(1).getAvalue());
			if(a!=null) mainTagMap.put("main2", a.getAnum());
		}
		return mainTagMap;
	}
	
	public int getStartPage(int page) {
		// 현재페이지-((현재페이지-1)%네비게이터 블록 크기)
		return page-((page-1)%10);
		
	}

	public int getEndPage(int page) {
		// 네비게이터의 첫번째 페이지 번호 + (네비게이터 블록 크기 -1)
		return page-((page-1)%10) + (10-1);

	}

	public int getLastPage(int storesPerPage, int storeCount) {
		return (storeCount-1)/storesPerPage + 1;
	}

	public int getOffset(int page, int boardsPerPage) {
		//offset : 해당 페이지에서 가져올 게시물의 시작점
		return (page-1)*boardsPerPage + 1;
	}
	
}
