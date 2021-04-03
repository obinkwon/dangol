package dao;

import java.util.HashMap;
import java.util.List;

import model.Boss;
import model.Order;
import model.Stag;
import model.Store;

public interface IBossDao {
	//점장 정보 하나만 검색
	public Boss selectBossOne (Boss boss);
	public List<Boss> findId (String phone);
	public Boss findPw (HashMap<String, Object> params);
	//점장 가입
	public int insertBoss (Boss boss);
	public int insertStores(Store store);
	public int selectAnumByStag (String tag);
	public void insertStag(Stag stag);
	public void insertOrder(Order order);
}
