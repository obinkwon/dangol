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
	
	public List<Grade> selectGlikeList(String mid);
	public Store selectStoreBySnum(int snum);
	public List<Details> recentlyVisited(int gnum);
	public void deleteLikes(HashMap<String, Object> param);
	public List<Grade> selectHistoryAll(String mid);
	public void insertLikes (HashMap<String, Object> param);
	public List<Details> selectHistoryOne (HashMap<String, Object> param);
	public Comment selectcomments (int dnum);
	public List<Details> selectReserveState (String mid);
	public Grade selectgradeByGnum (int gnum);
	public void deleteReserve(int dnum);
	public Details selectDetailsByDnum (int dnum);
	public void insertComment(Comment comment);
	public List<Details> selectdetailslist(HashMap<String, Object> param);
	public void updateDcount(HashMap<String, Object> param1);
	public void updategrade(int gnum);
	public void updateNewGrade(Grade grade);
	public List<Details>selectdcount(HashMap<String, Object> param);
	public Grade selectgrade(HashMap<String, Object> param);
	public Details selectddate(int dnum);
	public void updatedetails(Details details);
	public void deletegrade(int gnum);
	public List<Details> selectDetailsByGnum(int gnum);
	
}
