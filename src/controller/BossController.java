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
	
	@RequestMapping("signUpBossForm.do")
	public String signUpBossForm() {
		return "jsp/signUpBossForm";
	}
	
	//사장님 회원가입시 id 중복체크
	@RequestMapping("checkId.do")
	@ResponseBody
	public boolean checkId(String id) {
		Boss boss = new Boss();
		boss.setBid(id);
		if(bservice.selectBossOne(boss)==null)
			return true;
		else {
			return false;
		}
	}
	//지점장 회원가입	
	@RequestMapping("insertBoss.do")
	public String insertBoss(Boss boss
			, HttpSession session
			, HttpServletResponse response) throws Exception {
		int result = bservice.insertBoss(boss);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		String str = "";
		str = "<script language='javascript'>";
		if(result > 0) {
			str += "alert('가입이 완료되었습니다.');";
		}else {
			str += "alert('가입이 실패하였습니다.');";
		}
		str += "location.href='loginForm.do'";
		str += "</script>";
		pw.print(str);
		return null;
	}	
}
