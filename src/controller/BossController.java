package controller;



import java.io.PrintWriter;
import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.Admin;
import model.Boss;
import model.Order;
import model.Store;
import service.AdminService;
import service.BossService;
import service.MemberService;

@Controller
public class BossController {

	@Autowired
	private BossService bservice;
	@Autowired
	private AdminService aService;
	
	@RequestMapping("signUpBossForm.do")
	public ModelAndView signUpBossForm() throws Exception{
		ModelAndView mav = new ModelAndView();
		Admin admin = new Admin();
		admin.setAtype("theme");
		//admin 에서 가게업종 가져오기
		mav.addObject("foodTagList",bservice.showFoodTagList());
		mav.addObject("themeList", aService.selectAdminTypeList(admin));
		mav.setViewName("jsp/signUpBossForm");
		return mav;
	}
	
	//사장님 회원가입시 id 중복체크
		@RequestMapping("checkId.do")
		public @ResponseBody boolean checkId(String id) {
			Boss boss = new Boss();
			boss.setBid(id);
			if(bservice.selectBossOne(boss)==null)
			return true;
			else {
				return false;
			}
		}
		//회원가입시 메뉴 등록
		@RequestMapping("addMenuList.do")
		public @ResponseBody List<Order> insertOrders(HttpSession session,Order order) {
		//	req.getParameterValues("onum[]");
			List<Order> oList=null;
			if(session.getAttribute("olist")==null) {
				oList =new ArrayList<Order>();
				oList.add(order);
				session.setAttribute("olist", oList);
			
			}else {
				oList=(List<Order>)session.getAttribute("olist");
				oList.add(order);
				session.setAttribute("olist", oList);	
			}
			
			return oList;
			
		}
	//지점장 회원가입	
	@RequestMapping("insertBoss.do")
	public String insertBoss(Boss boss,@RequestParam(required=false)Store store
			,@RequestParam(required=false)String[] tag
			,HttpSession session
			,HttpServletResponse response) throws Exception {
		List<Order> order = (List<Order>)session.getAttribute("olist");
		bservice.insertBoss(boss, store, tag, order);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		str += "alert('회원가입이 완료되었습니다.');";
		str += "location.href='loginForm.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}	
}
