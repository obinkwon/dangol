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

	public Member selectMember(String mid);
	public List<Mtag> selectMtag (String mid);
	public void updateMemberOne (Member member);
	public Admin selectAvalue(int anum);
	public void deleteMtag(int mtnum);
	public int countMtag(String mid);
	public void updateMtag (Mtag mtag);
	public void deleteMemberOne (String mid);
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
