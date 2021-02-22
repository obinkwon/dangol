package service;

import java.io.File;
import java.io.IOException;
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

@Service
public class MemberService {

	@Autowired
	private IMemberDao mdao;
	@Autowired
	private IAdminDao adao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";

	public int loginMembers(String id, String pwd) throws Exception{
		Member m = mdao.loginMembers(id);

		if (m != null) {
			if (m.getMpw().equals(pwd) && m.getMtype().equals("user")) {
				return 0; // 사용자 로그인 성공
			} else if (m.getMpw().equals(pwd) && m.getMtype().equals("admin")) {
				return 1; // 관리자 로그인 성공
			} else {
				return 2; // 비밀번호 틀림

			}

		} else {
			return 3;
		}
	}

	public List<Member> findId(String phone) throws Exception{
		// System.out.println(phone);
		List<Member> m = mdao.findId(phone);
		return m;
	}

	public Member findPw(HashMap<String, Object> params) throws Exception{
		// System.out.println(params);
		// System.out.println(mdao.findPw(params));
		return mdao.findPw(params);
	}

	// id 중복체크
	public Member checkId(String id) throws Exception{
		Member m = mdao.loginMembers(id);
		// System.out.println(m);
		return m;
	}

	//회원가입
	public void insertMember(Member member, String[] tag, MultipartFile mfile) throws Exception{
		String path = imagePath +"member\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String mimage = mfile.getOriginalFilename();
		File attachFile = new File(path+mimage);
		try {
			mfile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			member.setMimage(mimage);//db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mdao.insertMember(member);

		String mtag = "";
		Mtag mt = new Mtag();
		if (tag != null) {
			for (int i = 0; i < tag.length; i++) {
				mtag = tag[i];
				mt.setAnum(mdao.selectAnumByMtag(mtag));
				mt.setMid(member.getMid());
				mdao.insertMtag(mt);
			}
		}
	}
	
	public Member selectMember(String mid) throws Exception{
		Member m = mdao.selectMember(mid);
		return m;
	}
	
	//ed 파일 경로 생성
	public File getAttachedFile(String mid) throws Exception{
		Member member = mdao.loginMembers(mid);
		String fileName = member.getMimage();
		String path = imagePath + "member\\";
		return new File(path+fileName);
	}

}
