package controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.Inquiry;
import service.inquiryService;


@Controller
public class inquiryController {
	
	@Autowired
	private inquiryService iService;

	@RequestMapping("faq.do")
	public String faqService(@RequestParam(defaultValue="all") String type) {
		if(type.equals("all")) {
			return "inquiry/faq";
		}else if(type.equals("service")) {
			return "inquiry/faqService";
		}else {
			return "inquiry/faqSite";
		}
		
	}
	
	@RequestMapping("inquiry.do")
	public ModelAndView inquiry (HttpSession session, HttpServletResponse resp) throws IOException {
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
		if(session.getAttribute("mid")!=null) {
			String mid = (String)session.getAttribute("mid");
		mav.addObject("inquirylist",iService.selectInquiryByMid(mid));
		mav.setViewName("inquiry/inquiry");
		return mav;
		}else if (session.getAttribute("bid")!=null) {
			String bid = (String) session.getAttribute("bid");
			mav.addObject("inquirylist",iService.selectInquiryByBid(bid));
			mav.setViewName("inquiry/inquiry");
			return mav;
		}else {
			str = "<script language='javascript'>";
			str += "alert('로그인 후 이용 가능 합니다.');";
			str += "location.href='loginForm.do';";
			str += "</script>";
			pw.print(str);
			return null;
			
		}
		
	}
	@RequestMapping("removeInquiry.do")
	public String removeInquiry(int inum) {
		iService.deleteInquiryOne(inum);
		return "redirect:inquiry.do";
		
	}
	@RequestMapping("registInquiryForm.do")
	public String registInquiryForm() {
		return "inquiry/registInquiryForm";
	}
	@RequestMapping("registInquiry.do")
	public String registInquiry(Inquiry inquiry, HttpSession session, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = resp.getWriter();
		String str = "";
		
	if(session.getAttribute("mid")!=null) {
		System.out.println("여기여기");
		String mid= (String) session.getAttribute("mid");
		inquiry.setMid(mid);
		System.out.println(inquiry);
		iService.insertInquiry(inquiry);
	}else {
		String bid=(String)session.getAttribute("bid");
		inquiry.setBid(bid);
		System.out.println(inquiry);
		iService.insertInquiry(inquiry);
	}
	str = "<script language='javascript'>";
	str += "alert('1:1문의가 등록되었습니다.');";
	str += "location.href='inquiry.do';";
	str += "</script>";
	pw.print(str);
	return null;
	
}
	@RequestMapping("inquiryView.do")
	public ModelAndView inquiryView(int inum) {
	ModelAndView mav = new ModelAndView();
		mav.addObject("inquiry",iService.selectInquiryOne(inum));
		mav.setViewName("inquiry/inquiryView");
		return mav;
		
	}
	@RequestMapping("searchInquiry.do")
	public ModelAndView searchInquiry(HttpSession session,String keyword) {
		ModelAndView mav= new ModelAndView();
		if(session.getAttribute("mid")!=null) {
			String mid= (String) session.getAttribute("mid");
			mav.addObject("inquirylist",iService.searchInquiryListByMid(mid,keyword));
			mav.setViewName("inquiry/inquiry");
			return mav;
		}else {
			String bid=(String) session.getAttribute("bid");
			mav.addObject("inquirylist",iService.searchInquiryListByBid(bid,keyword));
			mav.setViewName("inquiry/inquiry");
			return mav;
		}
		
	}
}
