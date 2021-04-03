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
	private IOwnerDao odao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";

	public Member selectMember(String mid) {
		return mypagedao.selectMember(mid);
	}

	public void updateMemberOne(Member member, String[] tag, MultipartFile mfile) throws Exception{

		String path = imagePath+"member\\";
		File dir = new File(path);
		if (!dir.exists())
			dir.mkdirs();
		String mimage = mfile.getOriginalFilename();
		File attachFile = new File(path + mimage);

		try {
			mfile.transferTo(attachFile); // 웹으로 받아온 파일을 복사
			if (mfile != null) {
				member.setMimage(mimage); // db에 파일 정보 저장을 하기위해 모델객체에 setting하기
			} else {
				member.setMimage("");
			}
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String str = member.getMaddress();

		StringTokenizer tokens = new StringTokenizer(str, ",");
		String maddress = "";
		String[] ss = new String[2];
		for (int x = 0; tokens.hasMoreElements(); x++) {
			ss[x] = tokens.nextToken();
		}
		maddress = ss[0] + " " + ss[1];

		String str1 = member.getMarea1();
		StringTokenizer tokens1 = new StringTokenizer(str1, ",");
		String marea1 = "";
		for (int x = 0; tokens1.hasMoreElements(); x++) {
			ss[x] = tokens1.nextToken();
		}
		marea1 = ss[0] + " " + ss[1];

		String str2 = member.getMarea2();
		StringTokenizer tokens2 = new StringTokenizer(str2, ",");
		String marea2 = "";
		for (int x = 0; tokens2.hasMoreElements(); x++) {
			ss[x] = tokens2.nextToken();
		}
		marea2 = ss[0] + " " + ss[1];

		member.setMaddress(maddress);
		member.setMarea1(marea1);
		member.setMarea2(marea2);
		member.setMtype("user");

		mypagedao.updateMemberOne(member);

		// 태그 수정
		String mtag = "";
		Mtag mt = new Mtag();

		if (tag != null) {
			List<Mtag> mtnum = mypagedao.selectMtag(member.getMid());
			if (mypagedao.countMtag(member.getMid()) == tag.length) {

				for (int i = 0; i < tag.length; i++) {
					mtag = tag[i];
					mt.setMtnum(mtnum.get(i).getMtnum());
					mt.setAnum(mdao.selectAnumByMtag(mtag));
					mt.setMid(member.getMid());

					mypagedao.updateMtag(mt);
				}
			} else {
				for (Mtag m : mtnum) {
					mypagedao.deleteMtag(m.getMtnum());

				}
				for (int i = 0; i < tag.length; i++) {
					member.setAnum(mdao.selectAnumByMtag(tag[i])+"");
					mdao.insertMtag(member);
				}

			}

		}else { System.out.println("여기"); 	
			List<Mtag> mtnum = mypagedao.selectMtag(member.getMid());
		for (Mtag m : mtnum) {
			mypagedao.deleteMtag(m.getMtnum());

		}
		}
	}

	public void deleteMemberOne(String mid) {
		mypagedao.deleteMemberOne(mid);
	}

	public List<List<Details>> selectGlikeList(String mid) {
		List<Grade> grade = mypagedao.selectGlikeList(mid);
		List<List<Details>> details = new ArrayList<List<Details>>();
		for (Grade g : grade) {
			HashMap<String, Object> param= new HashMap<String, Object>();
			param.put("mid", g.getMid());
			param.put("snum", g.getSnum());
			details.add(mypagedao.selectHistoryOne(param));
		}
		return details;
	}

	public void deleteLikes(String mid, int snum) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("snum", snum);
		mypagedao.deleteLikes(param);
	}

	public void insertLikes(String mid, int snum) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("snum", snum);
		mypagedao.insertLikes(param);
	}

	public List<List<Details>> selectdcountHistory(String mid) {
		List<Grade> grade = mypagedao.selectHistoryAll(mid);

		List<List<Details>>details = new ArrayList<>();
		
		for (Grade g : grade) {
			HashMap<String, Object> param= new HashMap<String, Object>();
			param.put("mid", g.getMid());
			param.put("snum", g.getSnum());
			
			details.add(mypagedao.selectHistoryOne(param));
		
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

	public List<Details> selectHistoryOne(String mid, int snum) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("mid", mid);
		param.put("snum", snum);
		List<Details> d = mypagedao.selectHistoryOne(param);
		return d;
	}

	public Comment selectcomments(int dnum) {
		return mypagedao.selectcomments(dnum);
	}

	public List<Details> selectReserveState(String mid) {
		List<Details> d = mypagedao.selectReserveState(mid);
		return d;
	}

	public Grade selectgradeByGnum(int gnum) {
		return mypagedao.selectgradeByGnum(gnum);
	}

	// 파일 경로 생성
	public File getAttachedFile(Store vo) {
		Store store = odao.selectStore(vo);
		String fileName = store.getSimage();
		String path = imagePath+"store\\";
		return new File(path + fileName);
	}

	public int deleteReserve(int dnum, String mid) throws Exception{

		if (mypagedao.selectddate(dnum) == null) {

			mypagedao.deleteReserve(dnum);
			return 1;
		} else {
			mdao.updateMpenalty(mid);// penalty+1
			mypagedao.deleteReserve(dnum);
			Member m = new Member();
			m.setMid(mid);
			Member member = mdao.selectMember(m);
			if (member.getMpenalty() == 3) {
				List<Grade> grade = mypagedao.selectHistoryAll(mid); //현재등급리스트
				for (Grade g : grade) {
					if(g.getGlevel()!=0) {mypagedao.deletegrade(g.getGnum());} //등급강등
					List<Details> detailList=mypagedao.selectDetailsByGnum(g.getGnum());
					if(g.getGlevel()==0||g.getGlevel()==1) {	//dcount 수정
						for (Details d : detailList) {
							Details detail = selectDetailsByDnum(d.getDnum());
							detail.setDcount(0);
							mypagedao.updatedetails(detail);
						}
					}else if (g.getGlevel() == 2) {
						for (Details d : detailList) {
							Details detail = selectDetailsByDnum(d.getDnum());
							detail.setDcount(12);
							mypagedao.updatedetails(detail);
					}
					//	System.out.println("요기는 lv2");
				}else {
					for (Details d : detailList) {
						Details detail = selectDetailsByDnum(d.getDnum());
						detail.setDcount(24);
						mypagedao.updatedetails(detail);
					}
				}
				}
				mdao.resetMpenalty(mid);
				return 2; // 패널티 3
			}
			return 3; // 당일예약취소 패널티 3미만
		}

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