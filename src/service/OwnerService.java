package service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IBossDao;
import dao.IEventDao;
import dao.IMemberDao;
import dao.IOwnerDao;
import model.Boss;
import model.Details;
import model.Grade;
import model.Member;
import model.Store;

@Service
public class OwnerService {
	@Autowired
	private IOwnerDao oDao;
	
	@Autowired
	private IMemberDao mDao;
	
	@Autowired
	private IBossDao bDao;

	@Autowired
	private IEventDao eDao;

	//내 정보
	public Boss ownerInfo(Boss boss) {
		return bDao.selectBossOne(boss);
	}

	public int deleteOwner(Boss boss) {
		return oDao.deleteOwner(boss);
	}
	//사장님 정보 수정
	public int updateOwner(Boss boss) {
		return oDao.updateOwner(boss);
	}
	
	//사장님 가게 목록 조회
	public List<Store> selectStoreList(Store store) {
		return oDao.selectStoreList(store);
	}
	
	//ed snum으로 예약자의 아이디, 핸드폰 번호 구하기(gcurrent='yes')
	public List<Member> selectReserversBySnum(int snum) throws Exception{
		//변수 세팅
		List<Member> Reservers = new ArrayList<Member>();
		
		//snum에 일치하는 Grades 출력
		List<Grade> Grades = oDao.selectGradesCurrentYBySnum(snum);
		
		//Grades에 해당하는 mid와 mphone을 Reservers에 입력
		for (Grade grade: Grades) {
			Reservers.add(mDao.loginMembers(grade.getMid()));
		}
		
		return Reservers;
	}
	
	//ed snums으로 예약자의 아이디, 핸드폰 번호 구하기(gcurrent='yes')
	public List<Member> selectReserversBySnums(int[] snums) throws Exception{
		//snums 목록 담기
		HashMap<String, int[]> hm = new HashMap<String, int[]>();
		hm.put("snums", snums);

		//변수 세팅
		List<Member> Reservers = new ArrayList<Member>();
		List<Grade> Grades = oDao.selectGradesCurrentYBysnums(hm);
		
		
		//grades로 Reservers 담기
		for (Grade grade: Grades) {
			Reservers.add(mDao.loginMembers(grade.getMid()));
		}
		
		return Reservers;
	}
	//ed snum에 일치하는 Gnums 구하기
	public int[] selectGnumsCurrentYBySnum(int snum) {
		//snum에 일치하는 현재등급 목록 불러오기
		int i =0;
		int[] Gnums = new int[oDao.selectGradesCurrentYBySnum(snum).size()];
		List<Grade> grades = oDao.selectGradesCurrentYBySnum(snum);
		
		//Grades에서 gnum만 추출해서 Gnums에 저장
		for (Grade grade : grades) {
			Gnums[i] = grade.getGnum();
			i++;
		}
		return Gnums;
	}
	
	//ed snum에 일치하는 Gnums 구하기
	public int[] selectGnumsCurrentYBySnums(int[] snums) {
		//snums 목록 담기
		HashMap<String, int[]> hm = new HashMap<String, int[]>();
		hm.put("snums", snums);
		
		//snum에 일치하는 현재등급 목록 불러오기
		int i=0;
		int[] gnums = new int[oDao.selectGradesCurrentYBysnums(hm).size()];
		
		List<Grade> grades = oDao.selectGradesCurrentYBysnums(hm);
		//Grades에서 gnum만 추출해서 Gnums에 저장
		for (Grade grade : grades) {
			gnums[i] = grade.getGnum();
			i++;
		}
		return gnums;
	}
	
	public List<Grade> selectGradesCurrentYByMids(String[] mids) {
		HashMap<String, String[]> hm = new HashMap<String, String[]>();
		hm.put("mids", mids);
		return oDao.selectGradesCurrentYByMids(hm);
	}
	
	//ed gnum에 해당하는 details 구하기
	public List<Details> selectDetailsByGnums(int[] gnums){
		//gnum 목록 담기
		HashMap<String, int[]> hm = new HashMap<String, int[]>();
		hm.put("gnums", gnums);

		//gnum으로 details 조회
		return oDao.selectDetailsByGnums(hm);
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

	//ed
	public void insertStore(Store store) {
		oDao.insertStore(store);
	}

	public Store selectStore(int snum) {
		Store store = oDao.selectStore(snum);
		return store;
	}

	public void updateStore(Store store) {
		oDao.updateStore(store);
	}

	public void deleteStore(int snum) {
		oDao.deleteStore(snum);
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
		 List<Grade> grades = selectGradesCurrentYByMids(mids);
		 int i = 0;
		 int[] gnums = new int[grades.size()];

		 //grades에서 gnums 구하기
		 for (Grade grade : grades) {
			 gnums[i] = grade.getGnum();
			 i++;
		 }
		 return selectDetailsByGnums(gnums);
	}

	public List<Member> selectMembersByKeyword(String keyword) {
		return oDao.selectMembersByKeyword(keyword);
	}

}