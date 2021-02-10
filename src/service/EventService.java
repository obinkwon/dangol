package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IEventDao;
import model.Event;
import model.Store;

@Service
public class EventService {

	@Autowired
	private IEventDao eDao;
	
	private String imagePath = "C:\\eclipse-workspace\\dangol\\WebContent\\images\\";
	
	//일반 사용자의 이벤트 보기
	public Store selectStoreBySnum(int snum){
		return eDao.selectStoreBySnum(snum);
	}
	
	//(사장님)가게 목록 드롭다운
	public List<Store> selectStoresByBid(String bid){
		return eDao.selectStoresByBid(bid);
	}
	
	//일반 사용자의 이벤트 보기
	public List<Event> selectEventsByStatus(Event event) {
		return eDao.selectEventList(event);
	}

	//전체 이벤트 목록 출력
	public List<Event> selectEventsByStatusAndSnums(String status, int[] snums){
		List<Event> events = new ArrayList<Event>();
		HashMap<String, int[]> hm = new HashMap<String, int[]>();
		hm.put("snums", snums);
		
			switch (status) {
			case "ing":
				events = eDao.selectIngEventsBySnums(hm);
				break;

			case "ed":
				events = eDao.selectEdEventsBySnums(hm);
				break;
				
			default:
				events = eDao.selectAllEventsBySnums(hm);
				break;
			}
		return events;
	}
	
	//전체 이벤트 중 하나의 이벤트 상세내용 보기
	public Event selectOneEvent(int eid) {
		return eDao.selectOneEvent(eid);
	}
	
	//ed (사장님) 이벤트 내 추가
	public void insertEvent(Event event, MultipartFile efile) throws Exception{
		String path = imagePath+"event\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String eimage = efile.getOriginalFilename();
		File attachFile = new File(path+eimage);
		
		efile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
		event.setEimage(eimage); //db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		eDao.insertEvent(event);
	}
	
	//(사장님) 이벤트 수정
	public int updateEvent(Event event
			, MultipartFile efile) throws Exception{
		String path = imagePath+"event\\";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		String eimage = efile.getOriginalFilename();
		if(!eimage.equals(event.getEimage()) && eimage != "") {
			File attachFile = new File(path+eimage);
			efile.transferTo(attachFile);  //웹으로 받아온 파일을 복사
			event.setEimage(eimage); //db에 파일 정보 저장을 하기위해 모델객체에 setting하기
		}else {
			event.setEimage(event.getEimage());
		}
		return eDao.updateEvent(event);
	}
	
	//(사장님) 이벤트 삭제
	public int deleteEvent(int eid) {
		return eDao.deleteEvent(eid);
	}
	
	//사장님에 따라 수정, 삭제 버튼생성
	public boolean checkAuthority(String bid, int eid) {
		List<Store> stores = eDao.selectStoresByBid(bid);
		int snum= eDao.selectOneEvent(eid).getSnum();
		boolean authority = false;
		//사장님 권한 확인
		
		for (Store store : stores) {
			int snum_temp = store.getSnum();
			
			if (snum == snum_temp) {
				authority = true;
				break;
			}
			else {
				authority = false;
				continue;
			}
		}
		return authority;
	}
	
	//파일 경로 생성
	public File getAttachedFile(int eid) {
		Event event = eDao.selectOneEvent(eid);
		String fileName = event.getEimage();
		String path = imagePath+"event\\";
		return new File(path+fileName);
	}

}
