package service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IAdminDao;
import dao.ICategoryDao;
import dao.IMemberDao;
import dao.IMyPageDao;
import dao.IOwnerDao;
import model.Admin;
import model.Comment;
import model.Details;
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
	private IAdminDao adao;
	
	@Autowired
	private IOwnerDao oDao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";
	
	public int insertGrade(Grade grade) {//등급 정보 등록
		return icdao.insertGrade(grade);
	}
	
	public int insertDetail(Details detail) {//예약하기 기능
		return icdao.insertDetail(detail);
	}
	
	//음식종류별 가게 리스트 가져오기
	public List<Store> getStoreListFood(Admin admin){ 
		return icdao.selectStoreListFood(admin);
	}
	
	//테마종류별 가게 리스트 가져오기
	public List<Store> getStoreListTheme(Admin admin){ 
		return icdao.selectStoreListTheme(admin);
	}
	
	//지역별 가게 리스트 가져오기
	public List<Store> getStoreListArea(Admin admin){ 
		return icdao.selectStoreListArea(admin);
	}
	
	//추천별 가게 리스트 가져오기
	public List<Store> getStoreListRecommend(Admin admin){ 
		return icdao.selectStoreListRecommend(admin);
	}
	
	//신규 가게 리스트 가져오기
	public List<Store> getStoreListNew(Admin admin){ 
		return icdao.selectStoreListNew(admin);
	}
	
	//음식 종류별 가게 갯수
	public int getStoreListCountFood(Admin admin) {
		return icdao.getStoreListCountFood(admin);
	}
	
	//테마 종류별 가게 갯수
	public int getStoreListCountTheme(Admin admin) {
		return icdao.getStoreListCountTheme(admin);
	}
	
	//지역별 가게 갯수
	public int getStoreListCountArea(Admin admin) {
		return icdao.getStoreListCountArea(admin);
	}
	
	//추천별 가게 갯수
	public int getStoreListCountRecommend(Admin admin) {
		return icdao.getStoreListCountRecommend(admin);
	}
	
	//신규 가게 갯수
	public int getStoreListCountNew(Admin admin) {
		return icdao.getStoreListCountNew(admin);
	}
	
	//가게 후기 총 평점 평균 리스트
	public List<Store> etcCount(List<Store> sList) {
		for(Store store : sList) {
			String stag= "";
			int total = icdao.selectCommentTotal(store); //가게별 리뷰 총점
			int totalCnt = icdao.selectCommentTotalCnt(store); //가게별 리뷰 갯수
			if(total > 0 && totalCnt > 0) {
				store.setCommentTotal(total/totalCnt);
			}else {
				store.setCommentTotal(0);
			}
			List<Store> stagList = oDao.selectStagList(store);
			for(Store st : stagList) {
				stag = stag+" #"+st.getAvalue();
			}
			store.setStag(stag);
		}
		return sList;
	}
	
	//가게 태그 세팅
	public List<Store> stagSetting(List<Store> sList){
		for(Store store : sList) {
			String stag= "";
			List<Store> stagList = oDao.selectStagList(store);
			for(Store st : stagList) {
				stag = stag+" #"+st.getAvalue();
			}
			store.setStag(stag);
		}
		return sList;
	}
	
	//해당가게 내 등급
	public Grade selectMyGradeInfo(Grade grade) {
		return icdao.selectGradeAtStore(grade);
	}
	
	//후기 작성 정보 가져오기
	public Details getCommentInfo(Details details) {
		return icdao.selectCommentInfo(details);
	}
	
	
	
	
	
	
	
	
	
	
	
	public List<Order> selectOrderList(Store store) {
		return icdao.selectOrderList(store);
	}
	
	
	public Map<String, Object> selectDangolList(Store store) {
		List<Grade> dangolList = icdao.selectStoreGlevel(store);
		HashMap<String, Object> dangolMap = new HashMap<String, Object>();
		dangolMap.put("glevel0", 0);
		dangolMap.put("glevel1", 0);
		dangolMap.put("glevel2", 0);
		dangolMap.put("glevel3", 0);
		for(Grade dangol : dangolList) {
			if(dangol.getGlevel() == 0) {
				dangolMap.put("glevel0", dangol.getDangolCnt());
			}else if(dangol.getGlevel() == 1) {
				dangolMap.put("glevel1", dangol.getDangolCnt());
			}else if(dangol.getGlevel() == 2) {
				dangolMap.put("glevel2", dangol.getDangolCnt());
			}else {
				dangolMap.put("glevel3", dangol.getDangolCnt());
			}
		}
		return dangolMap;
	}
	
	
	
	
	
	public List<String[]> selectStagList(List<Store> sList) {//해당 가게 태그 리스트
		List<String[]> stagList = new ArrayList<String[]>();
		for(Store s : sList) {
			List<Store> stList = oDao.selectStagList(s);
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
	
	
	
	public List<Comment> storeCommentList(Store store) {
		return icdao.selectCommentListBySnum(store);
	}
	
	public List<Comment> storeMyCommentList(Grade grade) {
		return icdao.selectMyCommentListByGrade(grade);
	}
	
	public Grade commentMid(int dnum) {
		return icdao.selectGradeByDnum(dnum);
	}
	
	public List<Details> todayReserve(Details detail){//예약 리스트 가져오기
		return icdao.selectDetailReserveByDdate(detail);
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
	
	public Details selectDetail(Details details) {
		return icdao.selectDetail(details);
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
		Store store = new Store();
		store.setSnum(snum);
		Store s = oDao.selectStoreOne(store);
		String fileName = "";
		File file = null;
		if(s != null) {
			String path = imagePath+"store\\";
			fileName = s.getSimage();
			file = new File(path+fileName);
		}
		return file;
	}
	
	public File getAttachedFileMenu(Order order) throws Exception{
		Order ord = icdao.selectOrderOne(order);
		File file = null;
		if(ord != null) {
			String fileName = ord.getOimage();
			String path = imagePath+"order\\";
			file = new File(path+fileName);
		}
		return file;
	}
	
	public Order selectOrderOne(Order order) {
		return icdao.selectOrderOne(order);
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
			oDao.insertOrder(o);
		}
	}
	
	public int selectDetailsList(Grade grade) {
		List<Details> dList = icdao.selectDetailsListGnum(grade);
		return dList.size();
	}
	
}
