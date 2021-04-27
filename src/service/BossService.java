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
		Boss boss = new Boss();
		boss.setBphone(phone);
		return bdao.findId(boss);
	}

	public Boss findPw(Boss boss) {
		return bdao.findPw(boss);
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
	//지점장 회원가입
	public int insertBoss(Boss boss) { 
		return bdao.insertBoss(boss);
	}

	
}
