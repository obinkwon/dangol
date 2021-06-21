package service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IAdminDao;
import model.Admin;
import model.Inquiry;

@Service
public class AdminService {
	
	@Autowired
	private IAdminDao aDao;
	
	//imagePath
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";
	
	//admin 하나만 검색
	public Admin selectAdminOne(Admin admin){
		return aDao.selectAdminOne(admin);
	}
	
	//admin 하나만 검색 (타입)
	public Admin selectAdminTypeOne(Admin admin){
		return aDao.selectAdminOne(admin);
	}
	
	//admin 여러개 검색 (타입)
	public List<Admin> selectAdminTypeList(Admin admin){
		return aDao.selectAdminTypeList(admin);
	}
	
	//admin 여러개 검색 (mtag)
	public List<Admin> selectAdminMtagList(Admin admin){
		return aDao.selectAdminMtagList(admin);
	}
	
	//메인 태그 수정
	public int updateAdmin(Admin admin) {
		return aDao.updateAdmin(admin);
	}
	
	//태그 추가
	public int insertTag(Admin admin) {
		return aDao.insertTag(admin);
	}
	
	//태그 삭제
	public int deleteTag(Admin admin) {
		return aDao.deleteTag(admin);
	}

	//태그 추가(파일)
	public int insertTagFile(Admin admin, MultipartFile afile) throws Exception{
		File attachFile = insertFile(afile);
		String aimage = afile.getOriginalFilename();
		afile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
		admin.setAimage(aimage); //db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		return insertTag(admin);
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
		Admin vo = new Admin();
		vo.setAnum(anum);
		Admin admin= aDao.selectAdminOne(vo);
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
