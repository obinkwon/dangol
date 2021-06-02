package dao;

import java.util.HashMap;
import java.util.List;

import model.Details;
import model.Grade;
import model.Member;
import model.Order;
import model.Store;

public interface IOwnerDao {
	/* 점장 */
	public Store selectBossOne(Store store);//점장 정보 조회
	public List<Store> findOwnerId(Store store);//점장 ID 조회
	public Store findOwnerPw(Store store);//점장 PWD 조회
	public int insertOwner(Store store);//점장 가입
	public int deleteOwner(Store store);//점장 탈퇴
	public int updateOwner(Store store);//점장 수정
	public void insertOrder(Order order);//메뉴 등록
	
	//예약현황
	public List<Member> selectMembersByKeyword(String keyword);
	public List<Grade> selectGradesCurrentYBySnum(int snum);
	public List<Grade> selectGradesCurrentYBysnums(HashMap<String, int[]> hm);
	public List<Grade> selectGradesCurrentYByMids(HashMap<String, String[]> hm);
	public List<Details> selectDetailsByGnums(HashMap<String, int[]> hm);
	public List<Details> selectDetailsByGnumsDdate(HashMap hm);
	public List<Store> selectStoresBySnums(int[] snum);
	
	public List<Grade> selectGradeList(Grade grade);
	public List<Details> selectDetailsList(Grade grade);
	
	/* 점장 가게*/
	public List<Store> selectStoreList(Store store); //가게 리스트 가져오기
	public int insertStore(Store store); //가게 등록
	public int insertStag(Store store); //가게 태그 등록
	public int deleteStag(Store store); //가게 태그 등록
	public List<Store> selectStag(Store store); //가게 태그 가져오기
	public Store selectStoreOne(Store store); //가게 정보 가져오기
	public int updateStore(Store store); //가게 수정하기
	public int deleteStore(Store store); //가게 삭제하기
	public int insertMenu(Order order); //메뉴 등록
	public int deleteMenu(Order order); //메뉴 삭제
	public int updateMenu(Order order); //메뉴 수정

	
	 
}
