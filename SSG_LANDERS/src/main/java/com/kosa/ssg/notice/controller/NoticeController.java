package com.kosa.ssg.notice.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.ssg.notice.domain.Notice;
import com.kosa.ssg.notice.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	@ResponseBody
	@RequestMapping(value = "/notice/detailNotice.do", produces = "application/text; charset=UTF-8")
	public String detailNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("detailNotice()");
		
		noticeService.increaseViews(notice.getNoticeid());
		
		return noticeService.getNoticeByNoticeid(notice.getNoticeid(), notice.getOrder()).toString();
	}

	@RequestMapping(value = "/notice/listNotice.do")
	public String listNotice(Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listNotice()");
		
		request.setAttribute("result", noticeService.getAllNoticePageList(notice));
		
		return "notice/listNotice";
	}

	@RequestMapping(value = "/notice/listNoticeForAdmin.do")
	public String listNoticeForAdmin(Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listNoticeForAdmin()");
		
		request.setAttribute("result", noticeService.getAllNoticePageList(notice));
		
		return "notice/listNoticeForAdmin";
	}

	@ResponseBody
	@RequestMapping(value = "/notice/moreListNotice.do", produces = "application/text; charset=UTF-8")
	public String moreListNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("moreListNotice()");
		
		return noticeService.getMoreNoticePageList(notice).toString();
	}

	@RequestMapping(value = "/notice/listNoticeByViewCount.do")
	public String listNoticeByViewCount(Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listNoticeByViewCount()");
		
		request.setAttribute("result", noticeService.getAllNoticePageListByViewCount(notice));
		
		return "notice/listNoticeByViewCount";
	}

	@RequestMapping(value = "/notice/listNoticeByViewCountForAdmin.do")
	public String listNoticeByViewCountForAdmin(Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listNoticeByViewCountForAdmin()");
		
		request.setAttribute("result", noticeService.getAllNoticePageListByViewCount(notice));
		
		return "notice/listNoticeByViewCountForAdmin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/notice/writeNotice.do", produces = "application/text; charset=UTF-8")
	public String writeNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("writeNotice()");
		
		return noticeService.write(notice).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/notice/getBeforeNotice.do", produces = "application/text; charset=UTF-8")
	public String getBeforeNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getBeforeNotice()");

		return noticeService.getBeforeNotice(notice).toString();
	}


	@ResponseBody
	@RequestMapping(value = "/notice/updateNotice.do", produces = "application/text; charset=UTF-8")
	public String updateNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateNotice()");

		return noticeService.update(notice).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/notice/deleteNotice.do", produces = "application/text; charset=UTF-8")
	public String deleteNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deleteNotice()");

		return noticeService.delete(notice).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/notice/deleteNotices.do", produces = "application/text; charset=UTF-8")
	public String deleteNotices(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deletesNotice()");

		return noticeService.deletes(notice).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/notice/fixNotice.do", produces = "application/text; charset=UTF-8")
	public String fixNotice(@RequestBody Notice notice, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("fixNotice()");
		
		return noticeService.fix(notice.getNoticeid(), notice.getDoYN()).toString();
	}
}
