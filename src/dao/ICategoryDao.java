package dao;

import java.util.HashMap;
import java.util.List;

import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Mtag;
import model.Order;
import model.Stag;
import model.Store;
import model.Storedb;

public interface ICategoryDao {
	//해당가게 내 등급
	public Grade selectGradeAtStore(Grade grade);
	//해당가게 메뉴 리스트
	public List<Order> selectOrderList(Store store);
	//해당가게 리뷰 리스트(ing)
	public List<Comment> selectCommentListBySnum(Store store);
	//해당가게 단골 정보
	public List<Grade> selectStoreGlevel(Store store);
	//해당가게 등급 등록
	public int insertGrade(Grade grade);
	//예약 리스트 가져오기
	public List<Details> selectDetailReserveByDdate(Details detail);
	//예약 하기
	public int insertDetail(Details details);
	//예약 정보 가져오기
	public Details selectDetail(Details details);
	//음식종류별 가게 리스트 가져오기
	public List<Store> selectStoreListType(Admin admin);
	//음식 종류별 가게 갯수
	public int getStoreListCount(Admin admin);
	//가게별 리뷰 총점
	public int selectCommentTotal(Store store);
	//가게별 리뷰 갯수
	public int selectCommentTotalCnt(Store store);
	
	
	public List<Admin> selectAdminAllByFood();
	public List<Admin> selectAdminAllByTheme();
	public List<Store> selectStoreNew(HashMap<String, Object> params);
	public List<Store> selectStoreAllByAnum(HashMap<String, Object> params);
	public List<Store> selectStoreAllByArea(HashMap<String, Object> params);
	//
	public int selectGradeCountBySnum(int snum);
	
	//
	public List<Details> selectDetailsListGnum(Grade grade);
	public List<Details> selectDetailAllByGnum(int gnum);
	public Comment selectCommentOneByDnum(int dnum);
	
	public List<Stag> selectStagByAnum(int anum);
	//
	public Admin selectAdminOne(int anum);
	public List<Mtag> selectMtagByMid(String mid);
	public Store selectStoreOneByRecommend(HashMap<String, Object> rMap);
	public Store selectStoreOneByRecommendPre(HashMap<String, Object> rMap);
	
	public Order selectOrderOne(Order order);
	
	
	//내 리뷰 가져오기
	public List<Comment> selectMyCommentListByGrade(Grade grade);
	public void deleteCommentOneByCnum(int cnum);
	public Comment selectCommentByCnum(int cnum);
	public Grade selectGradeByDnum(int dnum);
	public void updateDetailByDnum(int dnum);
	public List<Details> selectDetailByMidSnum(HashMap<String, Object> dMap);
	public void updateDcountMinusByDnum(int dnum);
	public int selectDetailMaxDcount(Grade grade);
	public List<Admin> selectAdminTasteTag();
	public void updateCommentOne(Comment comment);
	public Comment selectCommentByDnum(int dnum);
	public List<Storedb> selectStoreDB();
	public int getStoreNewCount();
	public int getStoreAllByAnumCount(int anum);
	public int getStoreAllByAreaCount(HashMap<String, Object> params);
	public int insertStores(Store store);
	public List<Store> selectKeywordStore(HashMap<String, Object> params);
}
