package dao;

import java.util.HashMap;
import java.util.List;

import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Member;
import model.Mtag;
import model.Store;

public interface IMyPageDao {
	//회원 수정
	public int updateMemberOne (Member member);
	//회원 태그 삭제
	public int deleteMtag(Member member);
	//회원 삭제
	public int deleteMemberOne (Member member);
	//즐겨찾기 리스트
	public List<Grade> selectGlikeList(Member member);
	//방문내역 리스트
	public List<Details> selectHistoryList(Member member);
	//즐겨찾기 리스트
	public List<Details> selectBookmarkList(Member member);
	//즐겨찾기 수정
	public int updateLike(Member member);
	//예약 날짜 조회
	public Details selectddate(Details details);
	//예약 삭제
	public int deleteReserve(Details details);
	//나의 등급 정보 리스트
	public List<Grade> selectGradeList(Member member);
	//등급 강등 and  포인트 절감
	public int updateGrade(Grade grade);
	//예약 리스트
	public List<Details> selectReserveState (Member member);
	
	
	public Store selectStoreBySnum(int snum);
	public List<Details> recentlyVisited(int gnum);
	public Comment selectcomments (int dnum);
	public Grade selectgradeByGnum (int gnum);
	public Details selectDetailsByDnum (int dnum);
	public void insertComment(Comment comment);
	public List<Details> selectdetailslist(HashMap<String, Object> param);
	public void updateDcount(HashMap<String, Object> param1);
	public void updategrade(int gnum);
	public void updateNewGrade(Grade grade);
	public List<Details>selectdcount(HashMap<String, Object> param);
	public Grade selectgrade(HashMap<String, Object> param);
	public void updatedetails(Details details);
	
}
