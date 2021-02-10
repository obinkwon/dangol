package controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import model.Event;
import model.Store;
import service.EventService;

@Controller
public class EventController {
	
	@Autowired
	private EventService eService;
	
	//이벤트 화면 출력
	@RequestMapping("selectEvents.do")
	public ModelAndView selectEvents(HttpSession session
			,Event eventVO) {
		ModelAndView mav = new ModelAndView();
		String bid = (String) session.getAttribute("bid");
		if(eventVO.getStatus() == null || eventVO.getStatus() == "") {
			eventVO.setStatus("all");
		}
		//사장님일 때
		if (bid != null) {
			List<Store> stores = eService.selectStoresByBid(bid);
			//사장님이면 가게목록 드롭다운 버튼 생성
			mav.addObject("Stores", stores);
			
			switch (eventVO.getSnum()) {
				//내 모든가게 이벤트 선택
				case -1:
	//				int i = 0;
	//				int size = stores.size();
	//				int[] snums = new int[size];
	//				//사장님 가게가 있을 때
	//				if (size !=0) {
	//					// 사장님 가게번호 구하기
	//					for (Store s: stores) {
	//							snums[i] = s.getSnum();
	//							i++;
	//					}
	//					//조건에 맞는 이벤트 검색하기
	//					mav.addObject("eventList", eService.selectEventsByStatusAndSnums(status, snums));
	//					//가게 이름 조회
	//					for (Event event : eService.selectEventsByStatusAndSnums(status, snums)) {
	//						stores_new1.add(eService.selectStoreBySnum(event.getSnum()));
	//					}
	//
	//					mav.addObject("Stores_user", stores_new1);	
	//					break;
	//				}
	//				//사장님 가게가 없다면
	//				else {
	//					mav.addObject("eventList", eService.selectEventsByStatus(eventVO));
	//					//가게이름 조회
	//					for (Event event : eService.selectEventsByStatus(eventVO)) {
	//						stores_new1.add(eService.selectStoreBySnum(event.getSnum()));
	//					}
	//
	//					mav.addObject("Stores_user", stores_new1);
	//					break;
	//				}
					break;
	//
	//			//가게 하나 선택 시 case other
	//			default:
	//				snums = new String[1];
	//				snums[0] = snum;
	//
	//				mav.addObject("eventList", eService.selectEventsByStatusAndSnums(status, snums));
	//				
	//				//가게 이름 조회
	//				for (Event event : eService.selectEventsByStatusAndSnums(status, snums)) {
	//					stores_new1.add(eService.selectStoreBySnum(event.getSnum()));
	//				}
	//
	//				mav.addObject("Stores_user", stores_new1);	
	//				break;
				
				//모든 가게 이벤트 선택
				default:
					mav.addObject("eventList", eService.selectEventsByStatus(eventVO));
					break;
			}
		}else {//사장님이 아닐 때 조건에 따라 이벤트 조회
			//모든 사용자들이 가게 이름 조회할 수 있게
			mav.addObject("eventList", eService.selectEventsByStatus(eventVO));
		}
		mav.addObject("status", eventVO.getStatus());
		mav.setViewName("Event/eventsAll");
		return mav;
	}

	//이벤트 상세보기
	@RequestMapping("selectOneEvent.do")
	public ModelAndView selectOneEvent(HttpSession session
			, Event event) {
		ModelAndView mav= new ModelAndView();
		Event eventVO = eService.selectOneEvent(event.getEid());
		if(eventVO != null) {
			String bid = (String) session.getAttribute("bid");
			if (bid != null) {
				mav.addObject("Authority", eService.checkAuthority(bid, eventVO.getEid()));
			}
			else {
				mav.addObject("Authority", "false");
			}
			mav.addObject("event", eventVO);
			mav.setViewName("Event/eventView");
		}
		return mav;
	}
	
	//(사장님)이벤트 등록 폼 이동
	@RequestMapping("eventAddForm.do")
	public ModelAndView eventAddForm(HttpSession session){
		String bid = "";
		ModelAndView mav= new ModelAndView();
		if(session.getAttribute("bid") != null) {
			bid = (String) session.getAttribute("bid");
			//사장님 가게 드롭다운 버튼
			mav.addObject("Stores", eService.selectStoresByBid(bid));
			mav.setViewName("Event/eventAddForm");
		}else {
			mav.setViewName("jsp/loginForm");
		}
		return mav;
	}

	//이벤트 등록
	@RequestMapping("insertEvent.do")
	public String insertEvent(Event event
			, String etarget1
			, String etarget2
			, @RequestParam("efile") MultipartFile efile) throws Exception{
		eService.insertEvent(event, efile);
		return "redirect:selectEvents.do?status=ing&snum=-1";
	}
	
	//이벤트 수정 폼 이동
	@RequestMapping("eventUpdateForm.do")
	public ModelAndView eventUpdateForm(HttpSession session, int eid) {
		ModelAndView mav = new ModelAndView();
		String bid = (String) session.getAttribute("bid");
		Event event = eService.selectOneEvent(eid);
		
		mav.addObject("event", event);
		mav.setViewName("Event/eventUpdateForm");
		return mav;
	}
	
	//이벤트 수정
	@RequestMapping("updateEvent.do")
	public String updateEvent(Event event
			, String etarget1
			, String etarget2 
			, @RequestParam("efile") MultipartFile efile) throws Exception{
		
		eService.updateEvent(event, efile);
		return "redirect:selectOneEvent.do?eid="+event.getEid();
	}
	
	//이벤트 삭제
	@RequestMapping("deleteEvent.do")
	public String deleteEvent(int eid
			, HttpServletResponse response) throws Exception{
		int result = eService.deleteEvent(eid);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		if(result > 0) {
			str += "alert('이벤트가 삭제되었습니다.');";
		}else {
			str += "alert('삭제하는데 실패했습니다. 다시 시도해주세요.');";
		}
		str += "location.href='selectEvents.do?status=all&snum=-1'";
		str += "</script>";
		pw.print(str);
		return null;
	}
	
	//저장된 이미지 불러오기
	@RequestMapping("download.do")
	public View download(int eid) {
		File attachFile= eService.getAttachedFile(eid);
		View view = new DownloadView(attachFile);
		
		return view;
	}
}
