package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IAdminDao;
import dao.IOwnerDao;
import model.Admin;
import model.Store;

@Service
public class BossService {

	@Autowired
	private IOwnerDao odao;
	
	@Autowired
	private IAdminDao adao;
	
	public int loginBoss(String id, String pwd) {
		Store store = new Store();
		store.setBid(id);
		store = odao.selectBossOne(store);
		if (store != null) {
			if (store.getBpw().equals(pwd)) {
				return 0; // 로그인 성공
			} else {
				return 1; // 비밀번호 불일치
			}
		} else {
			return 2;
		}
	}

	public List<Store> findId(String phone) {
		Store store = new Store();
		store.setBphone(phone);
		return odao.findId(store);
	}

	public Store findPw(Store store) {
		return odao.findPw(store);
	}
	//점장 정보 하나만 검색
	public Store selectBossOne(Store store) {
		return odao.selectBossOne(store);
	}
	public List<Admin> showFoodTagList(){
		Admin admin = new Admin();
		admin.setAtype("food");
		List<Admin> foodTagList = adao.selectAdminTypeList(admin);
		return foodTagList;
	}
	//점장 회원가입
	public int insertBoss(Store store) { 
		return odao.insertOwner(store);
	}

	
}
