package service;

import java.io.File;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IAdminDao;
import dao.IBossDao;
import dao.IMemberDao;
import model.Admin;
import model.Inquiry;

@Service
public class AdminService {
	
	@Autowired
	private IAdminDao aDao;

	@Autowired
	private IMemberDao mdao;
	
	@Autowired
	private IBossDao bdao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";
	
	private final Logger logger = Logger.getAnonymousLogger();
	
	//메인 태그 검색
	public Admin showMain(Admin admin){
		return aDao.showMain(admin);
	}
	
	//메인 태그 수정
	public int updateMain(Admin admin) {
		return aDao.updateMain(admin);
	}
	
	//태그 추가
	public int insertTag(Admin admin) {
		return aDao.insertTag(admin);
	}
	
	//태그 삭제
	public int deleteTag(Admin admin) {
		return aDao.deleteTag(admin);
	}
	
	//테마 태그 리스트
	public List<Admin> showThemeTags() {
		return aDao.showThemeTags();
	}

	//음식 태그
	public List<Admin> showFoodTags() {
		return aDao.showFoodTags();
	}

	//태그 추가(파일)
	public int insertTagFile(Admin admin, MultipartFile afile) throws Exception{
		File attachFile = insertFile(afile);
		String aimage = afile.getOriginalFilename();
		afile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
		admin.setAimage(aimage); //db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		return aDao.insertTag(admin);
	}
	
	//맛 태그
	public List<Admin> showTasteTags() {
		return aDao.showTasteTags();
	}
	
	//1:1문의 
	//전체 글 로드
	public List<Inquiry> selectInquiryList(Inquiry inquiry) {
		return aDao.selectInquiryList(inquiry);
	}
	//전체 글 갯수
	public List<Inquiry> inquiryListCount() {
		return aDao.inquiryListCount();
	}
	
	//글 상세보기
	public Inquiry selectInquiry(Inquiry inquiry) {
		return aDao.selectInquiry(inquiry);
	}
	
	//답변 등록하기
	public int insertInquiryAnswer(Inquiry inquiry) {
		return aDao.insertInquiryAnswer(inquiry);
	}

	//파일 경로 생성
	public File getAttachedFile(int anum) {
		Admin admin= aDao.selectOneAdmin(anum);
		String fileName = admin.getAimage();
		String path = imagePath+"admin\\";
		return new File(path+fileName);
	}
	
	public File insertFile(MultipartFile afile) {
		String path = imagePath+"admin\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String aimage = afile.getOriginalFilename();
		File attachFile = new File(path+aimage);
		return attachFile;
	}

}
