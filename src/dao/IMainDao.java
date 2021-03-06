package dao;

import java.util.HashMap;
import java.util.List;

import model.Admin;
import model.Comment;
import model.Details;
import model.Event;
import model.Grade;
import model.Store;

public interface IMainDao {
	public int selectTotalStores();
	public int selectTotalMembers();
	public int selectTotalComments();
	public int selectStoreMembers(int snum);
	public List<Store> selectStoreByArea(HashMap<String, Object> params);
	public List<Store> selectSearchStoreAll(HashMap<String, Object> searchMap);
	public List<Store> selectStoreAll();
	public int[] selectStoreMemberBySnum();
	//가게 정보 하나 검색
	public Store selectStoreOne(Store store);
	public int[] selectCommentMonth();
	public List<Grade> selectGradeBySnum(int snum);
	public List<Details> selectDetailAllByGnum(int gnum);
	public Comment selectCommentMonthByDnum(int dnum);
	public Comment selectCommentYearByDnum(int dnum);
	public List<Event> selectEventAll();
	public List<Admin> selectAdminMainTag();
	public Admin selectAdminByAvlaue(String avalue);
	public int getSearchStoreAllCount(HashMap<String, Object> params);
	public int getStoreByAreaCount(HashMap<String, Object> params);
}
