package com.kosa.ssg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kosa.ssg.board.service.BoardService;
import com.kosa.ssg.member.service.MemberService;
import com.kosa.ssg.notice.service.NoticeService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private MemberService memberService;

	@RequestMapping(value = {"/", "/main.do"}, method = RequestMethod.GET)
	public String index(Model model) {
		
		model.addAttribute("recentNoticeList", noticeService.recent());
		model.addAttribute("recentBoardList", boardService.recent());
		
		return "main";
	}
	@RequestMapping(value = {"/mainForAdmin.do"}, method = RequestMethod.GET)
	public String indexForAdmin(Model model) {
		
		model.addAttribute("recentNoticeList", noticeService.recent());
		model.addAttribute("recentBoardList", boardService.recent());
		model.addAttribute("memberList", memberService.allMemberPrint()); 
		
		return "mainForAdmin";
	}
}
