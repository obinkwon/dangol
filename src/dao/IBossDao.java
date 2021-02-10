package dao;

import java.util.HashMap;
import java.util.List;

import model.Boss;
import model.Order;
import model.Stag;
import model.Store;

public interface IBossDao {
public Boss loginBoss (String id);
public List<Boss> findId (String phone);
public Boss findPw (HashMap<String, Object> params);
public void insertBoss (Boss boss);
public int insertStores(Store store);
public int selectAnumByStag (String tag);
public void insertStag(Stag stag);
public void insertOrder(Order order);

}
