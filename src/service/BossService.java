package service;

import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IAdminDao;
import dao.IBossDao;
import model.Admin;
import model.Boss;

import model.Order;
import model.Stag;
import model.Store;

@Service
public class BossService {

	@Autowired
	private IBossDao bdao;
	
	@Autowired
	private IAdminDao adao;
	
	public int loginBoss(String id, String pwd) {
		Boss boss = new Boss();
		boss.setBid(id);
		Boss b = bdao.selectBossOne(boss);
		if (b != null) {
			if (b.getBpw().equals(pwd)) {
				return 0; // 로그인 성공
			} else {
				return 1; // 비밀번호 불일치
			}
		} else {
			return 2;
		}
	}

	public List<Boss> findId(String phone) {
		return bdao.findId(phone);
	}

	public Boss findPw(HashMap<String, Object> params) {
//		System.out.println(bdao.findPw(params));
		return bdao.findPw(params);
	}
	//점장 정보 하나만 검색
	public Boss selectBossOne(Boss boss) {
		return bdao.selectBossOne(boss);
	}
	public List<Admin> showFoodTagList(){
		Admin admin = new Admin();
		admin.setAtype("food");
		List<Admin> foodTagList = adao.selectAdminTypeList(admin);
		return foodTagList;
	}
	public void insertBoss(Boss boss, Store store, String[] tag, List<Order> order) {
		//System.out.println("여기");
		bdao.insertBoss(boss);
	if(store !=null) {
		String str = store.getSaddress();
	
		//System.out.println(str);
		String [] ss=new String[2];
		StringTokenizer tokens = new StringTokenizer( str, "," );
		String saddress="";
		for( int x = 0; tokens.hasMoreElements(); x++ ){ 
			ss[x]=tokens.nextToken();
		//	System.out.println(saddress);
		} 
		saddress=ss[0]+" "+ss[1];
		
		String time=store.getStime();
		//System.out.println(store);
		StringTokenizer tokens1 = new StringTokenizer( time, "," );
		String stime="";
		for( int x = 0; tokens1.hasMoreElements(); x++ ){ 
			stime+=tokens1.nextToken();
		//	System.out.println(stime);
		} 
		store.setSaddress(saddress);
		store.setStime(stime);
		store.setBid(boss.getBid());
	//	System.out.println(store);
		
		bdao.insertStores(store);
	}
		
		String stag = "";
		if (tag != null) {

			for (int i = 0; i < tag.length; i++) {
				Stag st = new Stag();
				stag = tag[i];
				st.setAnum(bdao.selectAnumByStag(stag));
				st.setSnum(store.getSnum());
				//System.out.println(st);
				bdao.insertStag(st);
			}

		}
	
	if(order!=null) {
		for(Order o:order) {
			o.setSnum(store.getSnum());
			System.out.println(o);
			bdao.insertOrder(o);
		}
	}
		
	}

	
}
