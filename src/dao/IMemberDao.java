package dao;

import java.util.List;

import model.Member;

public interface IMemberDao {
	//ID 찾기
	public List<Member> findId(Member member) throws Exception;
	//비밀번호 찾기
	public Member findPw(Member member) throws Exception;
	//회원 등록
	public int insertMember(Member member);
	
	public int selectAnumByMtag (String tag) throws Exception;
	//회원 태그 등록
	public int insertMtag(Member member);
	//회원 태그 조회
	public List<Member> selectMtag(Member member);
	//회원 정보 조회
	public Member selectMember(Member member);
	//패널티 추가
	public int updateMpenalty(Member member) throws Exception;
	
	public void resetMpenalty(String mid) throws Exception;
}
