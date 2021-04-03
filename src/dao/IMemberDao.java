package dao;

import java.util.HashMap;
import java.util.List;
import model.Member;
import model.Mtag;

public interface IMemberDao {

	public List<Member> findId(String phone) throws Exception;
	
	public Member findPw(HashMap<String, Object>params) throws Exception;
	
	public int insertMember(Member member);
	
	public int selectAnumByMtag (String tag) throws Exception;
	//회원 태그 등록
	public int insertMtag(Member member);
	//회원 태그 조회
	public List<Member> selectMtag(Member member);
	//회원 정보 조회
	public Member selectMember(Member member);
	
	public void updateMpenalty(String mid) throws Exception;
	
	public void resetMpenalty(String mid) throws Exception;
}
