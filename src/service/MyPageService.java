package service;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.ICategoryDao;
import dao.IMemberDao;
import dao.IMyPageDao;
import dao.IOwnerDao;
import model.Admin;
import model.Comment;
import model.Details;
import model.Grade;
import model.Member;
import model.Mtag;
import model.Store;

@Service
public class MyPageService {

	@Autowired
	private IMyPageDao mypagedao;
	@Autowired
	private IMemberDao mdao;
	@Autowired
	private IOwnerDao oDao;
	@Autowired
	private ICategoryDao cDao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";

	public int updateMemberOne(Member member, MultipartFile mfile) throws Exception{//회원 수정
		String path = imagePath+"member\\";
		File dir = new File(path);
		if (!dir.exists()) dir.mkdirs();
		
		String mimage = mfile.getOriginalFilename();
		if(!mimage.equals("")){
			File attachFile = new File(path + mimage);
			mfile.transferTo(attachFile); // 웹으로 받아온 파일을 복사
			member.setMimage(mimage);
		}
		return mypagedao.updateMemberOne(member);
	}
	
	public int updateMtag(Member member) {//회원 태그 수정
		int result = 0;
		String mtag = member.getMtag();
		String mid = member.getMid();
		String[] mtagArr = mtag.split(",");
		//회원 태그 초기화
		mypagedao.deleteMtag(member);
		for(String mt : mtagArr) {
			Member mem = new Member();
			mem.setMid(mid);
			mem.setAnum(mt);
			result += mdao.insertMtag(mem);
		}
		return result;
	}
	
	public int updateLike(Member member) {//즐겨찾기 수정
		return mypagedao.updateLike(member);
	}

	public int deleteMemberOne(Member member) {//회원 탈퇴
		return mypagedao.deleteMemberOne(member);
	}
	
	public List<Details> selectBookmarkList(Member member){
		return mypagedao.selectBookmarkList(member);
	}

//	public List<List<Details>> selectGlikeList(Member member) {
//		List<Grade> grade = mypagedao.selectGlikeList(member);
//		List<List<Details>> detailList = new ArrayList<List<Details>>();
//		for (Grade g : grade) {
//			Details det = new Details();
//			det.setMid(g.getMid());
//			det.setSnum(g.getSnum());
//			detailList.add(mypagedao.selectHistoryList(det));
//		}
//		return detailList;
//	}

	public List<List<Details>> selectdcountHistory(String mid) {
		Member member = new Member();
		member.setMid(mid);
		List<Grade> grade = mypagedao.selectGradeList(member);

		List<List<Details>>details = new ArrayList<>();
		
		for (Grade g : grade) {
			Details det = new Details();
			det.setMid(g.getMid());
			det.setSnum(g.getSnum());
			details.add(mypagedao.selectHistoryList(det));
		
		}
		return details;
	}
	
	public List<Details> selectdcount(String mid, int snum){
		HashMap<String, Object> param= new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("snum", snum);
		List<Details> details=mypagedao.selectdcount(param);
		return details;
	}
	

	public Store selectStoreBySnum(int snum) {
		Store store = mypagedao.selectStoreBySnum(snum);
		return store;
	}

	public List<Details> selectHistoryList(String mid, int snum) {
		Details det = new Details();
		det.setMid(mid);
		det.setSnum(snum);
		List<Details> d = mypagedao.selectHistoryList(det);
		return d;
	}

	public Comment selectcomments(int dnum) {
		return mypagedao.selectcomments(dnum);
	}

	//예약 리스트
	public List<Details> selectReserveState(Member member) {
		return mypagedao.selectReserveState(member);
	}

	public Grade selectgradeByGnum(int gnum) {
		return mypagedao.selectgradeByGnum(gnum);
	}

	// 파일 경로 생성
	public File getAttachedFile(Store vo) {
		Store store = oDao.selectStoreOne(vo);
		String fileName = store.getSimage();
		String path = imagePath+"store\\";
		return new File(path + fileName);
	}

//	//예약 취소
//	public int deleteReserve(int dnum, String mid) throws Exception{
//
//		if (mypagedao.selectddate(dnum) == null) {
//
//			mypagedao.deleteReserve(dnum);
//			return 1;
//		} else {
//			mdao.updateMpenalty(mid);// penalty+1
//			mypagedao.deleteReserve(dnum);
//			Member m = new Member();
//			m.setMid(mid);
//			Member member = mdao.selectMember(m);
//			if (member.getMpenalty() == 3) {
//				List<Grade> grade = mypagedao.selectHistoryAll(mid); //현재등급리스트
//				for (Grade g : grade) {
//					if(g.getGlevel()!=0) {mypagedao.deletegrade(g.getGnum());} //등급강등
//					List<Details> detailList=mypagedao.selectDetailsByGnum(g.getGnum());
//					if(g.getGlevel()==0||g.getGlevel()==1) {	//dcount 수정
//						for (Details d : detailList) {
//							Details detail = selectDetailsByDnum(d.getDnum());
//							detail.setDcount(0);
//							mypagedao.updatedetails(detail);
//						}
//					}else if (g.getGlevel() == 2) {
//						for (Details d : detailList) {
//							Details detail = selectDetailsByDnum(d.getDnum());
//							detail.setDcount(12);
//							mypagedao.updatedetails(detail);
//					}
//					//	System.out.println("요기는 lv2");
//				}else {
//					for (Details d : detailList) {
//						Details detail = selectDetailsByDnum(d.getDnum());
//						detail.setDcount(24);
//						mypagedao.updatedetails(detail);
//					}
//				}
//				}
//				mdao.resetMpenalty(mid);
//				return 2; // 패널티 3
//			}
//			return 3; // 당일예약취소 패널티 3미만
//		}
//
//	}
	
	//예약 취소
	public int deleteReserve(Details details) {
		return mypagedao.deleteReserve(details);
	}
	
	//패널티 추가
	public int updatePenalty(Details details) throws Exception{
		Member member = new Member();
		member.setMid(details.getMid());
		return mdao.updateMpenalty(member);// penalty+1
	}
	
	//등급 강등 및 포인트 절감
	public int updateGrade(Member member) throws Exception{
		int result = 0;
		List<Grade> gradeList = mypagedao.selectGradeList(member); //현재등급리스트
		for(Grade grade : gradeList) {
			if(grade.getGlevel() > 0) {
				grade.setGlevel(grade.getGlevel()-1);
			}
			grade.setGcount(grade.getGcount()/2);
			result += mypagedao.updateGrade(grade);
		}
		return result;
	}

	public Details selectDetailsByDnum(int dnum) {
		Details details = mypagedao.selectDetailsByDnum(dnum);
		return details;
	}

	public int insertComment(int dnum, Comment comment, String[] tag) {
		comment.setDnum(dnum);
		String ctaste = "#" + tag[0] + "," + "#" + tag[1];
		comment.setCtaste(ctaste);
		mypagedao.insertComment(comment);
		
		Details details=mypagedao.selectDetailsByDnum(comment.getDnum());
		Grade grade=mypagedao.selectgradeByGnum(details.getGnum());
		HashMap<String,Object> param= new HashMap<String, Object>();
		param.put("mid",grade.getMid());
		param.put("snum",grade.getSnum());
		
		List<Details> dlist=mypagedao.selectdcount(param);
		HashMap<String, Object> param1= new HashMap<String, Object>();
		param1.put("dcount", dlist.get(0).getDcount());
		param1.put("dnum", dnum);
		mypagedao.updateDcount(param1);
		
		Details detail = mypagedao.selectDetailsByDnum(dnum);
		if(detail.getDcount()==12 || detail.getDcount()==24 ||detail.getDcount()==48)
		{
			mypagedao.updategrade(detail.getGnum()); // 기존의 등급 gcurrent 'no'로 바꾸기
			Grade g =mypagedao.selectgradeByGnum(detail.getGnum());
			Grade newgrade = new Grade();
			newgrade.setMid(g.getMid());
			newgrade.setSnum(g.getSnum());
			newgrade.setGlevel(g.getGlevel());
			newgrade.setGlike(g.getGlike());
			mypagedao.updateNewGrade(newgrade);
		}
	
		return grade.getSnum();
	}
	public Grade selectgrade(String mid, int snum) {
		HashMap<String, Object> param= new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("snum", snum);
		return mypagedao.selectgrade(param);
	}
	
}