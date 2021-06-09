package service;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IEventDao;
import dao.IMemberDao;
import dao.IOwnerDao;
import model.Details;
import model.Grade;
import model.Member;
import model.Order;
import model.Store;

@Service
public class OwnerService {
	@Autowired
	private IOwnerDao oDao;
	
	@Autowired
	private IMemberDao mDao;
	
	@Autowired
	private IEventDao eDao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";

	//점장 로그인
	public int loginBoss(String id, String pwd) {
		Store store = new Store();
		store.setBid(id);
		store = oDao.selectBossOne(store);
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
	
	//점장 ID 조회
	public List<Store> findId(String phone) {
		Store store = new Store();
		store.setBphone(phone);
		return oDao.findOwnerId(store);
	}
	
	//점장 PWD 조회
	public Store findPw(Store store) {
		return oDao.findOwnerPw(store);
	}
	
	//점장 정보 조회
	public Store selectBossOne(Store store) {
		return oDao.selectBossOne(store);
	}
	
	//점장 회원가입
	public int insertOwner(Store store) { 
		return oDao.insertOwner(store);
	}

	//내 정보
	public Store ownerInfo(Store store) {
		return oDao.selectBossOne(store);
	}

	public int deleteOwner(Store store) {
		return oDao.deleteOwner(store);
	}
	//사장님 정보 수정
	public int updateOwner(Store store) {
		return oDao.updateOwner(store);
	}
	
	//사장님 가게 목록 조회
	public List<Store> selectStoreList(Store store) {
		return oDao.selectStoreList(store);
	}
	
	//가게에 등록된 등급 정보
	public List<Grade> selectGradeListBid(Store store) {
		return oDao.selectGradeListBid(store);
	}
	
	//예약 리스트 (전체)
	public List<Details> selectReserveListTotal(Store store){
		return oDao.selectDetailListTotal(store);
	}
	
	//예약 리스트 (하나만)
	public List<Details> selectReserveListOne(Store store) {
		return oDao.selectDetailListOne(store);
	}
	
	
	//ed snum에 일치하는 Gnums 구하기
	public int[] selectGnums(Grade grade) {
		//snum에 일치하는 현재등급 목록 불러오기
		int i =0;
		List<Grade> gradeList = oDao.selectGradeListSnum(grade);
		int[] Gnums = new int[gradeList.size()];
		
		//Grades에서 gnum만 추출해서 Gnums에 저장
		for (Grade gr : gradeList) {
			Gnums[i] = gr.getGnum();
			i++;
		}
		return Gnums;
	}
	
	
	
	public List<Grade> selectGradesCurrentYByMids(String[] mids) {
		HashMap<String, String[]> hm = new HashMap<String, String[]>();
		hm.put("mids", mids);
		return oDao.selectGradesCurrentYByMids(hm);
	}
	
	
	
	//ed bid로 snums 구하기
	public int[] selectsnumsByBid(String bid) {
		//bid에 일치하는 stores 조회
		Store store = new Store();
		store.setBid(bid);
		List<Store> stores = oDao.selectStoreList(store);
		
		int i = 0;
		int[] snums = new int[stores.size()];
		//stores에서 snum 추출
		for (Store s : stores) {
			snums[i] = s.getSnum();
			i++;
		}
		return snums;
	}
	
	//ed Gnums와 ddate에 해당하는 details 구하기
	public List<Details> selectDetailsByGnumsDdate(int[] Gnums, Date Ddate){
		//Gnums, ddate 담기
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("Gnums", Gnums);
		hm.put("Ddate", Ddate);
		//ddate로 details 조회
		return oDao.selectDetailsByGnumsDdate(hm);
	}

	// 가게 등록
	public int insertStore(Store store
		, MultipartFile sfile) throws Exception{
		String path = imagePath +"store\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String simage = sfile.getOriginalFilename();
		if(!simage.equals("")) {
			File attachFile = new File(path+simage);
			sfile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			store.setSimage(simage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		}
		return oDao.insertStore(store);
	}
	
	// 메뉴 등록
	public int insertMenu(Order order
			, MultipartFile ofile) throws Exception{
		String path = imagePath +"order\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String oimage = ofile.getOriginalFilename();
		if(!oimage.equals("")) {
			File attachFile = new File(path+oimage);
			ofile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			order.setOimage(oimage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		}
		return oDao.insertMenu(order);
	}
	
	// 메뉴 삭제
	public int deleteMenu(Order order) throws Exception{
		return oDao.deleteMenu(order);
	}
	
	// 메뉴 수정
	public int updateMenu(Order order
			, MultipartFile ofile) throws Exception{
		String path = imagePath +"order\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String oimage = ofile.getOriginalFilename();
		if(!oimage.equals("")) {
			File attachFile = new File(path+oimage);
			ofile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			order.setOimage(oimage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		}
		return oDao.updateMenu(order);
	}
	
	//가게 태그 등록
	public int insertStag(Store store) {
		int result = 0;
		String stag = store.getStag();
		int snum = store.getSnum();
		String[] stagArr = stag.split(",");
		for(String st : stagArr){
			Store s = new Store();
			s.setStag(st);
			s.setSnum(snum);
			result += oDao.insertStag(s);
		}
		return result;
	}
	
	//가게 태그 수정
	public int updateStag(Store store) {
		int result = 0;
		String stag = store.getStag();
		oDao.deleteStag(store); //가게 태그 삭제
		int snum = store.getSnum();
		String[] stagArr = stag.split(",");
		for(String st : stagArr){
			Store s = new Store();
			s.setStag(st);
			s.setSnum(snum);
			result += oDao.insertStag(s);
		}
		return result;
	}
	
	//가게 태그 리스트 조회
	public List<Store> selectStagList(Store vo) {
		return oDao.selectStagList(vo);
	}

	//가게 정보 조회
	public Store selectStoreOne(Store vo) {
		return oDao.selectStoreOne(vo);
	}
	
	//가게 정보 수정
	public int updateStore(Store store
		, MultipartFile sfile) throws Exception{
		String path = imagePath +"store\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String simage = sfile.getOriginalFilename();
		if(!simage.equals("")) {
			File attachFile = new File(path+simage);
			sfile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			store.setSimage(simage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		}
		return oDao.updateStore(store);
	}

	//가게 정보 삭제
	public int deleteStore(Store store) {
		oDao.deleteStag(store); //가게 태그 삭제
		return oDao.deleteStore(store);
	}

	public int[] selectRatesByMids(String[] mids) {
		 //mid로 grades구하기
		 List<Grade> grades = selectGradesCurrentYByMids(mids);
		 
		 int i = 0;
		 int[] snums = new int[grades.size()];
		 int[] glevels = new int[grades.size()];
		 
//		 for (int j = 0; j < mids.length; j++) {
//			System.out.println("mids"+mids[j]);
//		}
//		 
//		 System.out.println(grades.size());
		 //grades에서 snums, glevels 구하기
		 for (Grade grade : grades) {
			 System.out.println(i);
			 System.out.println("snums"+i+snums[i]);
			 System.out.println("glevels"+i+glevels[i]);
			 snums[i] = grade.getSnum();
			 glevels[i] = grade.getGlevel();
			 i++;
		 }
		HashMap<String, int[]> hm = new HashMap<String, int[]>();
		hm.put("snums", snums);
		
		List<Store> stores = eDao.selectStoresBySnums(hm);
		
		
		int[] rates = new int[stores.size()];
		int j=0;
		for (Store store : stores) {
			switch (glevels[j]) {
			//범골
			case 0:
				rates[j] = store.getSratelv0();
				break;
			//진골
			case 1:
				rates[j] = store.getSratelv1();
				break;
			//성골
			case 2:
				rates[j] = store.getSratelv2();
				break;
			//단골
			case 3:
				rates[j] = store.getSratelv3();
				break;
			//오류 시 
			default:
				rates[j] = -1;
				break;
			}
			j++;
		}
		return rates;
	}

	public List<Details> selectDetailsByMids(String[] mids) {
		 //mid로 grades구하기
		HashMap<String, String[]> hm = new HashMap<String, String[]>();
		hm.put("mids", mids);
		return oDao.selectDetailsCurrentYByMids(hm);
	}
	
	//keyword에 일치하는 회원정보 구하기
	public List<Member> selectMembersByKeyword(String keyword) {
		return oDao.selectMembersByKeyword(keyword);
	}

}