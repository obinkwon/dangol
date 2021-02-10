package dao;

import java.util.HashMap;
import java.util.List;

import model.Boss;
import model.Details;
import model.Grade;
import model.Member;
import model.Store;

public interface IOwnerDao {
	//내 정보
	public void deleteOwner(String bid);
	public void updateOwner(Boss boss);
	
	//예약현황
	public List<Store> selectStores(String bid);
	public List<Member> selectMembersByKeyword(String keyword);
	public List<Grade> selectGradesCurrentYBySnum(int snum);
	public List<Grade> selectGradesCurrentYBysnums(HashMap<String, int[]> hm);
	public List<Grade> selectGradesCurrentYByMids(HashMap<String, String[]> hm);
	public List<Details> selectDetailsByGnums(HashMap<String, int[]> hm);
	public List<Details> selectDetailsByGnumsDdate(HashMap hm);
	public List<Store> selectStoresBySnums(int[] snum);
	
	
	//내 가게
	public void insertStore(Store store);
	public Store selectStore(int snum);
	public void updateStore(Store store);
	public void deleteStore(int snum);

	
	 
}
