package com.kosa.ssg.member.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.ssg.member.domain.Member;
import com.kosa.ssg.member.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@ResponseBody
	@RequestMapping(value="/member/existUid.do", produces = "application/text; charset=UTF-8")
	public String existUid(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("existUid()");
	 	System.out.println(member);
	 	
	 	JSONObject jsonResult = memberService.existMemid(member);
		
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/register.do", produces = "application/text; charset=UTF-8")
	public String register(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("register()");
	 	System.out.println(member);
	 	
	 	JSONObject jsonResult = memberService.insert(member);
	 	
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/login.do", produces = "application/text; charset=UTF-8")
	public String login(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("login()");
	 	System.out.println(member);
	 	
	 	JSONObject jsonResult = memberService.login(member);
	 	
	 	if (jsonResult.getBoolean("status")) {
	 		HttpSession session = request.getSession();
	 		session.setAttribute("loginMember", jsonResult.get("loginMember"));
	 	}
	 	
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/findMemid.do", produces = "application/text; charset=UTF-8")
	public String findMemid(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("findMemid()");
	 	System.out.println(member);
	 	
	 	JSONObject jsonResult = memberService.findMemid(member);
	 	
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/findPwd.do", produces = "application/text; charset=UTF-8")
	public String findPwd(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("findPwd()");
	 	System.out.println(member);
	 	
	 	JSONObject jsonResult = memberService.findPwd(member);
	 	
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/logout.do", produces = "application/text; charset=UTF-8")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("logout()");
		
		JSONObject jsonResult = new JSONObject();
		
		try {
			jsonResult.put("status", true);
			jsonResult.put("message", "로그아웃되었습니다.");
			
	 		HttpSession session = request.getSession();
	 		session.invalidate();
		} catch (Exception e) {
			jsonResult.put("status", false);
			jsonResult.put("message", "로그아웃에 실패하였습니다.");
			e.printStackTrace();
			return jsonResult.toString();
		} 

		return jsonResult.toString();
	}


	@ResponseBody
	@RequestMapping(value="/member/update.do", produces = "application/text; charset=UTF-8")
	public String update(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("update()");
	 	System.out.println(member);

 		HttpSession session = request.getSession();
 		Member oldMember = (Member) session.getAttribute("loginMember");
 		
	 	JSONObject jsonResult = memberService.update(member, oldMember);
	 	
	 	if (jsonResult.getBoolean("status")) session.setAttribute("loginMember", member);
	 	
		return jsonResult.toString();
	}

	@ResponseBody
	@RequestMapping(value="/member/delete.do", produces = "application/text; charset=UTF-8")
	public String delete(@RequestBody Member member, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		System.out.println("delete()");
	 	System.out.println(member);

 		HttpSession session = request.getSession();
 		
	 	JSONObject jsonResult = memberService.delete(member);
	 	
	 	if (jsonResult.getBoolean("status")) session.invalidate();
	 	
		return jsonResult.toString();
	}
	
}
