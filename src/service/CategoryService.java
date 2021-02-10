package service;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IBossDao;
import dao.ICategoryDao;
import dao.IMemberDao;
import dao.IMyPageDao;
import model.Admin;
import model.Boss;
import model.Comment;
import model.Details;
import model.Event;
import model.Grade;
import model.Member;
import model.Mtag;
import model.Order;
import model.Stag;
import model.Store;
import model.Storedb;

@Service
public class CategoryService {
	@Autowired
	private ICategoryDao icdao;
	@Autowired
	private IMemberDao mdao;
	@Autowired
	private IMyPageDao mydao;
	@Autowired
	private IBossDao bdao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";
	
	public List<Admin> sortFoodList() {//음식태그 리스트
		List<Admin> aList = icdao.selectAdminAllByFood();
		return aList;
	}
	
	public List<Admin> sortThemeList() {//테마태그 리스트
		List<Admin> aList = icdao.selectAdminAllByTheme();
		return aList;
	}
	
	public int[] gradeCount(List<Store> sList) {//단골수 리스트
		int i = 0;
		int[] gradeCount = new int[sList.size()];
		for(Store s : sList) {
			gradeCount[i] = icdao.selectGradeCountBySnum(s.getSnum());
			i++;
		}
		return gradeCount;
	}
	
	public HashMap<String, Object> selectFoodStoreList(int page, int storesPerPage, String foodName) {//음식별 가게 리스트
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		params.put("foodName", foodName);
		result.put("sList", icdao.selectStoreAllByStype(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,icdao.getStoreAllByStypeCount(foodName)));
		result.put("totalBoard", icdao.getStoreAllByStypeCount(foodName));
		return result;
	}
	
	public HashMap<String, Object> selectThemeStoreList(int page, int storesPerPage, int anum) {//테마별 가게 리스트
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		params.put("anum", anum);
		result.put("sList", icdao.selectStoreAllByAnum(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,icdao.getStoreAllByAnumCount(anum)));
		result.put("totalBoard", icdao.getStoreAllByAnumCount(anum));
		return result;
	}
	
	public HashMap<String, Object> selectNewStoreList(int page,int storesPerPage) {//신규 가게 리스트
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		result.put("sList", icdao.selectStoreNew(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,icdao.getStoreNewCount()));
		result.put("totalBoard", icdao.getStoreNewCount());
		return result;
	}
	
	public HashMap<String, Object> selectAreaStoreList(int page,int storesPerPage,String areaName) {//지역별 가게 리스트
		HashMap<String, Object> params = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int offset = getOffset(page, storesPerPage);
		params.put("offset",offset);
		params.put("storesPerPage", storesPerPage);
		params.put("areaName", areaName);
		result.put("sList", icdao.selectStoreAllByArea(params));
		result.put("current",page);
		result.put("start", getStartPage(page));
		result.put("end", getEndPage(page));
		result.put("last", getLastPage(storesPerPage,icdao.getStoreAllByAreaCount(params)));
		result.put("totalBoard", icdao.getStoreAllByAreaCount(params));
		return result;
	}
	
	public double[] commentCount(List<Store> sList) {//가게 후기 총 평점 평균 리스트
		int i = 0;
		List<List<Grade>> gListAll = new ArrayList<List<Grade>>();
		double[] commentCount = new double[sList.size()];
		for(Store s : sList) {
			List<Grade> gList = icdao.selectGradeBySnum(s.getSnum());
			gListAll.add(gList);
			i++;
		}
		i = 0;
		int count = 0;
		List<Details> dList = null;
		for(List<Grade> gl : gListAll) {
			double sum = 0;
			for(Grade g : gl) {
				dList = icdao.selectDetailAllByGnum(g.getGnum());
				for(Details d : dList) {
					Comment c = icdao.selectCommentOneByDnum(d.getDnum());
					if(c!=null) {
						sum += c.getCtotal();
						count++;
					}
				}
			}
			if(count==0) commentCount[i] = 0;
			else commentCount[i] = sum/count;
			i++;
		}
		return commentCount;
	}
	
	public List<String> selectStagOne(int snum) {
		List<Stag> stList = icdao.selectStagBySnum(snum);
		List<String> tagList = new ArrayList<String>();
		for(Stag st : stList) {
			Admin a = icdao.selectAdminOne(st.getAnum());
			if(a!=null) tagList.add(a.getAvalue());
		}
		return tagList;
	}
	
	public List<Order> selectMenuList(int snum) {
		return icdao.selectOrderAllBySnum(snum);
	}
	
	public Grade selectMyGradeInfo(int snum,String mid) {
		Grade grade = new Grade();
		grade.setMid(mid);
		grade.setSnum(snum);
		return icdao.selectGradeBySnumAndMid(grade);
	}
	
	public HashMap<String, Object> selectDangolList(int snum) {
		List<HashMap<String, Object>> dangolList = icdao.selectGlevelBySnum(snum);
		HashMap<String, Object> dangolMap = new HashMap<String, Object>();
		dangolMap.put("glevel0", 0);
		dangolMap.put("glevel1", 0);
		dangolMap.put("glevel2", 0);
		dangolMap.put("glevel3", 0);
		for(HashMap<String, Object> dangol : dangolList) {
			if(String.valueOf(dangol.get("GLEVEL")).equals("0")) dangolMap.put("glevel0", dangol.get("DANGOL"));
			else if(String.valueOf(dangol.get("GLEVEL")).equals("1")) dangolMap.put("glevel1", dangol.get("DANGOL"));
			else if(String.valueOf(dangol.get("GLEVEL")).equals("2")) dangolMap.put("glevel2", dangol.get("DANGOL"));
			else dangolMap.put("glevel3", dangol.get("DANGOL"));
		}
		return dangolMap;
	}
	
	public List<String[]> selectStagList(List<Store> sList) {//해당 가게 태그 리스트
		List<String[]> stagList = new ArrayList<String[]>();
		for(Store s : sList) {
			List<Stag> stList = icdao.selectStagBySnum(s.getSnum());
			String[] stag = new String[3]; 
			if(stList.size()<3) {
				for(int i=0;i<stList.size();i++) {
					Admin a = icdao.selectAdminOne(stList.get(i).getAnum());
					if(a!=null) stag[i] = a.getAvalue();
				}
			}else {
				for(int i=0;i<3;i++) {
					Admin a = icdao.selectAdminOne(stList.get(i).getAnum());
					if(a!=null) stag[i] = a.getAvalue();
				}
			}
			stagList.add(stag);
		}
		return stagList;
	}
	
	public HashMap<String, Object> selectRecommendList(String mid) throws Exception{//추천 별 가게 리스트
		Member m = mdao.loginMembers(mid);
		List<Mtag> mtagList = icdao.selectMtagByMid(mid);
		List<Admin> aList = new ArrayList<Admin>();
		ArrayList<Integer> snumList = new ArrayList<Integer>();
		HashMap<String, Object> recommendMap = new HashMap<>();
		for(Mtag mt : mtagList) {
			List<Stag> stags = icdao.selectStagByAnum(mt.getAnum());
			aList.add(icdao.selectAdminOne(mt.getAnum()));
			if(stags!=null) {
				for(Stag s : stags) {//해시태그에 맞는 snum을 모두 가져와 List에 담는다
					snumList.add(s.getSnum());
				}
			}
		}
		HashMap<Integer, Integer> snumMap = new HashMap<Integer, Integer>();
		for(int n : snumList) {//key value 형태로 snum에 갯수를 카운트 한다
			if(snumMap.containsKey(n))
				snumMap.put(n, snumMap.get(n)+1);
			else 
				snumMap.put(n, 1);
		}
		System.out.println();
		List<Store> sList = new ArrayList<Store>();
		
		if(m.getMarea1()!=null || m.getMarea2()!=null) {//선호지역이 있을때
			for(int h=3;h>0;h--) {
				for(int snum : snumMap.keySet()) {
					if(snumMap.get(snum)==h) {
						HashMap<String, Object> rMap = new HashMap<String, Object>();
						rMap.put("snum", snum);
						rMap.put("marea1", m.getMarea1());
						rMap.put("marea2", m.getMarea2());
						Store s = icdao.selectStoreOneByRecommendPre(rMap);
						if(s!=null) sList.add(s);
					}
				}
			}
			recommendMap.put("sList", sList);
			recommendMap.put("mtagList", aList);
		}else {//없을때 자신의 주소
			for(int h=3;h>0;h--) {
				for(int snum : snumMap.keySet()) {
					if(snumMap.get(snum)==h) {
						HashMap<String, Object> rMap = new HashMap<String, Object>();
						rMap.put("snum", snum);
						rMap.put("maddress", m.getMaddress());
						Store s = icdao.selectStoreOneByRecommend(rMap);
						if(s!=null) sList.add(s);
					}
				}
			}
			recommendMap.put("sList", sList);
			recommendMap.put("mtagList", aList);
		}
		return recommendMap;
	}
	
	public List<Comment> storeCommentList(int snum) {
		return icdao.selectCommentListBySnum(snum);
	}
	
	public List<Comment> storeMyCommentList(HashMap<String, Object> gMap) {
		return icdao.selectMyCommentListByGrade(gMap);
	}
	
	public Grade commentMid(int dnum) {
		return icdao.selectGradeByDnum(dnum);
	}
	
	public List<Details> todayReserve(int snum, Date ddate){
		HashMap<String, Object> dMap = new HashMap<String, Object>();
		dMap.put("snum", snum);
		dMap.put("ddate", ddate);
		return icdao.selectDetailReserveByDdate(dMap);
	}
	
	public int insertBeginGrade(Grade grade) {
		return icdao.insertGradeBegin(grade);
	}
	
	public int insertDetailOne(Details detail) {//예약하기 기능
		return icdao.insertReserveDetail(detail);
	}
	public void deleteComment(int cnum) {//후기 삭제 기능
		Comment c = icdao.selectCommentByCnum(cnum);
		Grade g = icdao.selectGradeByDnum(c.getDnum());
		//grade로 details 불러와서 dcount 내림차순으로 정렬
		HashMap<String, Object> dMap = new HashMap<String, Object>();
		dMap.put("mid", g.getMid());
		dMap.put("snum", g.getSnum());
		int max = icdao.selectDetailMaxDcount(g);
		dMap.put("dcount", max);
		List<Details> dList = icdao.selectDetailByMidSnum(dMap);
		//dcount가 제일 큰 detail들의 dcount를 -1 한다
		for(Details dd : dList) {
			icdao.updateDcountMinusByDnum(dd.getDnum());
		}
		icdao.updateDetailByDnum(c.getDnum());//해당 details dcount 0으로 주기
		icdao.deleteCommentOneByCnum(cnum);//후기 삭제
	}
	
	public Comment selectComment(int cnum,int dnum) {
		if(dnum==0) return icdao.selectCommentByCnum(cnum);
		else return icdao.selectCommentByDnum(dnum);
	}
	
	public Details selectDetail(int dnum) {
		return icdao.selectDetailByDnum(dnum);
	}
	
	public List<Admin> selectTasteTagList() {
		return icdao.selectAdminTasteTag();
	}
	
	public void updateComment(Comment comment) {
		icdao.updateCommentOne(comment);
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
	
	public File getAttachedFile(int snum) {
		Store s = mydao.selectStoreBySnum(snum);
		String fileName = "";
		File file = null;
		if(s != null) {
			String path = imagePath+"store\\";
			fileName = s.getSimage();
			file = new File(path+fileName);
		}
		return file;
	}
	
	public File getAttachedFileMenu(int onum) {
		Order o = icdao.selectOrderOneByOnum(onum);
		String fileName = o.getOimage();
		String path = imagePath+"order\\";
		return new File(path+fileName);
	}
	
	public void insertStoreMenu() {//메뉴 입력 부분
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("keyword", "파파존스");
		List<Store> sList = icdao.selectKeywordStore(params);
		for(Store s : sList) {
			Order o = new Order();
			o.setSnum(s.getSnum());
			o.setOname("스파이시 치킨랜치(L) 피자");
			o.setOprice(27500);
			o.setOimage("spicychickenranch.png");
			bdao.insertOrder(o);
		}
	}
	
	public int likeTrueFalse(int gnum) {
		List<Details> dList = icdao.selectDetailAllByGnum(gnum);
		return dList.size();
	}
	
	public void insertNewStore() {//데이터 입력 부분 
		List<Storedb> sList = icdao.selectStoreDB();
		int i = 1;
		int count = 0;
		for(Storedb sdb : sList) {
			if(count==10) {
				count = 0;
				i++;
			}
			String address = sdb.getAddress();
			String saddress = address.split(" ")[0]+" "+address.split(" ")[1];
			String sdetailaddr = address.split(" ")[2]+" "+address.split(" ")[3];
			Store s = new Store();
			s.setSname(sdb.getName());
			s.setBid("boss"+i);
			s.setSintro("환영합니다");
			s.setSaddress(saddress);
			s.setSphone("02-1234-1234");
			s.setStime("10시00분21시00분");
			s.setSparking("yes");
			s.setSdetailaddr(sdetailaddr);
			s.setStype(sdb.getType());
			s.setSholiday("sun");
			s.setSratelv0(3);
			s.setSratelv1(5);
			s.setSratelv2(7);
			s.setSratelv3(10);
			s.setSlimit(20);
			s.setSlatitude(sdb.getLatitude());
			s.setSlongitude(sdb.getLongitude());
			System.out.println(s);
			icdao.insertStores(s);
			count++;
		}
//		for(int i=1;i<76000;i++) {
//			Boss b = new Boss();
//			b.setBid("boss"+i);
//			b.setBphone("010-1234-1234");
//			b.setBpw("1234");
//			bdao.insertBoss(b);
//		}
	}
}
