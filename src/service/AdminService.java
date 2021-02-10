package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dao.IAdminDao;
import dao.IBossDao;
import dao.IMemberDao;
import model.Admin;
import model.Boss;
import model.Event;
import model.Inquiry;
import model.Member;

@Service
public class AdminService {
	
	@Autowired
	private IAdminDao aDao;

	@Autowired
	private IMemberDao mdao;
	
	@Autowired
	private IBossDao bdao;
	
	//main1 출력
	public Admin showMain1(){
		if(aDao.showMain1()!=null) {
			return aDao.showMain1();
		}else {
			return null;
		}
	}
	
	//main2 출력
	public Admin showMain2(){
		if(aDao.showMain2()!=null) {
			return aDao.showMain2();
		}else {
			return null;
		}
	}
	
	//메인태그 적용하기
	public void updateMains(String type, String keyword) {
		switch (type) {
		case "main1":
			aDao.updateMain1(keyword);
			break;

		default:
			aDao.updateMain2(keyword);
			break;
		}
	}
	
	//테마태그
	public List<Admin> showThemeTags() {
		return aDao.showThemeTags();
	}
	
	public void insertThemeTag(String keyword) {
		aDao.insertThemeTag(keyword);
	}

	//음식 태그
	public List<Admin> showFoodTags() {
		return aDao.showFoodTags();
	}

	public void insertFoodTag(String keyword, MultipartFile afile) {
		String path = "C:\\Users\\obin0\\git\\FinalProject\\FinalProject\\WebContent\\images\\admin\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String aimage = afile.getOriginalFilename();
		File attachFile = new File(path+aimage);
		
		Admin admin = new Admin();
		admin.setAvalue(keyword);
		admin.setAtype("food");
		
		try {
			afile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			admin.setAimage(aimage); //db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		aDao.insertFoodTag(admin);
	}
	
	//맛 태그
	public List<Admin> showTasteTags() {
		return aDao.showTasteTags();
	}

	public void insertTasteTag(String keyword) {
		aDao.insertTasteTag(keyword);
	}
	
	//태그 삭제
	public void deleteTag(int anum) {
		aDao.deleteTag(anum);
	}

	
	
	//1:1문의 
	//전체 글 로드
	public List<Inquiry> selectAllInquirys() {
		return aDao.selectAllInquirys();
	}

	//답변 완료 글 로드
	public List<Inquiry> selectYesInquirys() {
		return aDao.selectYesInquirys();
	}

	//답변 미완료 글 로드
	public List<Inquiry> selectNoInquirys() {
		return aDao.selectNoInquirys();
	}
	
	//ed 글 상세보기
	public Inquiry selectOneInquiry(int inum) {
		return aDao.selectOneInquiry(inum);
	}
	
	//ed 답변 등록하기
	public void insertInquiryAnswer(int inum, String ianswer) {
		Inquiry inquiry = new Inquiry();
		inquiry.setInum(inum);
		inquiry.setIanswer(ianswer);
		aDao.insertInquiryAnswer(inquiry);
	}
	
	//ed 글 등록 회원의 정보 불러오기
	public HashMap<String, String[]> selectIdsAndPhones() throws Exception{
		//ed 기본정보 셋팅
		HashMap<String, String[]> hm = new HashMap<String, String[]>(); 
		List<Inquiry> inquirys = aDao.selectAllInquirys();
		int i = 0;
		String[] ids = new String[inquirys.size()];
		String[] phones = new String[inquirys.size()];
		
		//ed members에 추가하기
		for (Inquiry I: inquirys) {
			if (I.getMid() == null) {
				ids[i] = I.getBid();
				phones[i] = bdao.loginBoss(I.getBid()).getBphone();
			}else {
				ids[i] = I.getMid();
				phones[i] = mdao.loginMembers(I.getMid()).getMphone();
			}
			i++;
		}
		hm.put("ids", ids);
		hm.put("phones", phones);
		
		return hm;
	}
	
	//ed 글 등록 회원의 정보 불러오기
	public List<Member> selectYesMemberInfo() throws Exception{
		//ed 기본정보 셋팅
		List<Member> members = new ArrayList<Member>();
		List<Inquiry> inquirys = aDao.selectYesInquirys();
		
		//ed members에 추가하기
		for (Inquiry I: inquirys) {
			members.add(mdao.loginMembers(I.getMid()));
		}
		
		return members;
	}

	//ed 글 등록 회원의 정보 불러오기
	public List<Member> selectNoMemberInfo() throws Exception{
		//ed 기본정보 셋팅
		List<Member> members = new ArrayList<Member>();
		List<Inquiry> inquirys = aDao.selectNoInquirys();
		
		//ed members에 추가하기
		for (Inquiry I: inquirys) {
			members.add(mdao.loginMembers(I.getMid()));
		}
		
		return members;
	}

	public int countAllInquirys() {
		return aDao.countAllInquirys();
	}
	
	public int countYesInquirys() {
		return aDao.countYesInquirys();
	}
	
	public int countNoInquirys() {
		return aDao.countNoInquirys();
	}
	
	
	//글 검색하기
	public HashMap<String, List<Inquiry>> searchInquirys(String type, String keyword) {
		HashMap<String, List<Inquiry>> hm = new HashMap<String, List<Inquiry>>();
		
		switch (type) {
		//제목 검색
		case "title":
			hm.put("allInquirys", aDao.selectInquirysByTitle(keyword));
			hm.put("yesInquirys", aDao.selectYesInquirysByTitle(keyword));
			hm.put("noInquirys", aDao.selectNoInquirysByTitle(keyword));
			break;

		//내용 검색			
		case "content":
			hm.put("allInquirys", aDao.selectInquirysByContent(keyword));
			hm.put("yesInquirys", aDao.selectInquirysByContent(keyword));
			hm.put("noInquirys", aDao.selectInquirysByContent(keyword));
			break;
			
		//id 검색			
		case "mid":
			hm.put("allInquirys", aDao.selectInquirysByMid(keyword));
			hm.put("yesInquirys", aDao.selectInquirysByMid(keyword));
			hm.put("noInquirys", aDao.selectInquirysByMid(keyword));
			break;
		}
		return hm;

	}

	//ed 파일 경로 생성
	public File getAttachedFile(int anum) {
		Admin admin= aDao.selectOneAdmin(anum);
		String fileName = admin.getAimage();
		String path = "C:\\Users\\obin0\\git\\FinalProject\\FinalProject\\WebContent\\images\\admin\\";
		return new File(path+fileName);
	}


}
