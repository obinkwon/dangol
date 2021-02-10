package dao;

import java.util.HashMap;
import java.util.List;
import model.Member;
import model.Mtag;

public interface IMemberDao {

	public Member loginMembers(String id) throws Exception;
	
	public List<Member> findId(String phone) throws Exception;
	
	public Member findPw(HashMap<String, Object>params) throws Exception;
	
	public void insertMember(Member member) throws Exception;
	
	public int selectAnumByMtag (String tag) throws Exception;
	
	public void insertMtag(Mtag mtag) throws Exception;
	
	public Member selectMember(String mid) throws Exception;
	
	public void updateMpenalty(String mid) throws Exception;
	
	public void resetMpenalty(String mid) throws Exception;
}
