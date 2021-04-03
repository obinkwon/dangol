package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IAdminDao;
import dao.IMemberDao;
import model.Admin;
import model.Event;
import model.Member;
import model.Mtag;
import model.Store;

@Service
public class MemberService {

	@Autowired
	private IMemberDao mdao;
	@Autowired
	private IAdminDao adao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";

	public int loginMembers(String id, String pwd) throws Exception{
		Member member = new Member();
		member.setMid(id);
		member = mdao.selectMember(member);

		if (member != null) {
			if (member.getMpw().equals(pwd) && member.getMtype().equals("user")) {
				return 0; // 사용자 로그인 성공
			} else if (member.getMpw().equals(pwd) && member.getMtype().equals("admin")) {
				return 1; // 관리자 로그인 성공
			} else {
				return 2; // 비밀번호 틀림
			}
		} else { //등록된 id 없음
			return 3;
		}
	}

	public List<Member> findId(String phone) throws Exception{
		Member member = new Member();
		member.setMphone(phone);
		return mdao.findId(member);
	}

	public Member findPw(String id, String phone) throws Exception{
		Member member = new Member();
		member.setMid(id);
		member.setMphone(phone);
		return mdao.findPw(member);
	}

	// 회원 id로 조회
	public Member checkId(Member member) throws Exception{
		return mdao.selectMember(member);
	}

	//회원 가입
	public int insertMember(Member member
			, MultipartFile mfile) throws Exception{
		String path = imagePath +"member\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String mimage = "";
		if(mfile != null) {
			System.out.println("mfile is not null");
			mimage = mfile.getOriginalFilename();
			File attachFile = new File(path+mimage);
			mfile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
		}
		member.setMimage(mimage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		return mdao.insertMember(member);
	}
	
	// 회원 태그 리스트 가져오기
	public List<Member> selectMtag(Member member) {
		return mdao.selectMtag(member);
	}
	
	//회원 태그 등록
	public int insertMtag(Member member) {
		int result = 0;
		String mtag = member.getMtag();
		String mid = member.getMid();
		String[] mtagArr = mtag.split(",");
		for(String mt : mtagArr){
			Member m = new Member();
			m.setMtag(mt);
			m.setMid(mid);
			result += mdao.insertMtag(m);
		}
		return result;
	}
	
	//회원 정보 가져오기
	public Member selectMember(Member member){
		return mdao.selectMember(member);
	}
	
	//회원 파일 경로 생성
	public File getAttachedFile(String mid) throws Exception{
		Member member = new Member();
		member.setMid(mid);
		member = mdao.selectMember(member);
		String fileName = member.getMimage();
		String path = imagePath + "member\\";
		return new File(path+fileName);
	}

}
