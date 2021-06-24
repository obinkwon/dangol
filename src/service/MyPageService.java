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
	private IMyPageDao myDao;
	@Autowired
	private IMemberDao mDao;
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
		return myDao.updateMemberOne(member);
	}
	
	public int updateMtag(Member member) {//회원 태그 수정
		int result = 0;
		String mtag = member.getMtag();
		String mid = member.getMid();
		String[] mtagArr = mtag.split(",");
		//회원 태그 초기화
		myDao.deleteMtag(member);
		for(String mt : mtagArr) {
			Member mem = new Member();
			mem.setMid(mid);
			mem.setAnum(mt);
			result += mDao.insertMtag(mem);
		}
		return result;
	}
	
	public int updateLike(Member member) {//즐겨찾기 수정
		return myDao.updateLike(member);
	}

	public int deleteMemberOne(Member member) {//회원 탈퇴
		return myDao.deleteMemberOne(member);
	}
	
	public List<Details> selectBookmarkList(Member member){
		return myDao.selectBookmarkList(member);
	}
	
	//방문 내역 리스트
	public List<Details> selectHistoryListMid(Member member) {
		return myDao.selectHistoryList(member);
	}
	
	public List<Details> selectHistoryList(String mid, int snum) {
//		Details det = new Details();
//		det.setMid(mid);
//		det.setSnum(snum);
		Member member = new Member();
		member.setMid(mid);
		List<Details> d = myDao.selectHistoryList(member);
		return d;
	}

	//예약 리스트
	public List<Details> selectReserveState(Member member) {
		return myDao.selectReserveState(member);
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
		return myDao.deleteReserve(details);
	}
	
	//패널티 추가
	public int updatePenalty(Details details) throws Exception{
		Member member = new Member();
		member.setMid(details.getMid());
		return mDao.updateMpenalty(member);// penalty+1
	}
	
	//등급 강등 및 포인트 절감
	public int updateGrade(Member member) throws Exception{
		int result = 0;
		List<Grade> gradeList = myDao.selectGradeList(member); //현재등급리스트
		for(Grade grade : gradeList) {
			if(grade.getGlevel() > 0) {
				grade.setGlevel(grade.getGlevel()-1);
			}
			grade.setGcount(grade.getGcount()/2);
			result += myDao.updateGrade(grade);
		}
		return result;
	}

	//후기 작성
	public int insertComment(Comment comment) {
		Details details = new Details();
		details.setDnum(comment.getDnum());
		Grade grade = cDao.selectGradeComment(details);//후기 작성자 등급 정보
		int result = myDao.insertComment(comment);//후기 작성
		if(grade != null) {
			int cnt = grade.getGcount();
			if(result > 0) {
				details.setDnum(comment.getDnum());
				details.setDcount(1);
				myDao.updatedetailsComment(details);//후기 작성 여부 수정
				cnt++;
			}
			
			grade.setGcount(cnt);
			myDao.updateGradeCount(grade);//후기 카운트 증가
			if(grade.getGcount() > 0 && grade.getGcount()%12 == 0){//등급 업 기준 달성시
				grade.setGlevel(grade.getGcount()/12);
				myDao.updateGradeInfo(grade);//등급 업데이트
			}
		}
	
		return result;
	}
	
}