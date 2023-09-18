package com.kosa.ssg.notice.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.ssg.notice.dao.NoticeDao;
import com.kosa.ssg.notice.domain.Notice;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	// 최근 게시물 5개 가져오기
	public List<Notice> recent() {
		return noticeDao.findRecent5();
	}
	
	// 업데이트 폼용 게시물 정보 가져오기
	public JSONObject getBeforeNotice(Notice notice) {
		JSONObject result = new JSONObject();
		Notice updateNotice = noticeDao.getNoticeByNoticeid(notice.getNoticeid());
		
		result.put("title", updateNotice.getTitle());
		result.put("contents", updateNotice.getContents());
		
		return result;
	}
	
	// 특정 게시물 가져오기 (noticeid)
	public JSONObject getNoticeByNoticeid(int noticeid, String order) {
		JSONObject result = new JSONObject();
		Notice notice = noticeDao.getNoticeByNoticeid(noticeid);
		List<Notice> noticeList = new ArrayList<>();

		if (notice.getNoticeid() == 0) {
			result.put("message", "삭제된 게시물입니다.");
			result.put("status", false);
		}
		else {
			if (order.equals("recent")) noticeList = noticeDao.getAllNoticeListNoFix();
			else if (order.equals("view")) noticeList = noticeDao.getAllNoticeListByViewCountNoFix();
			
	    	int idx = noticeList.indexOf(notice);
	    	int size = noticeList.size();

			result.put("noticeid", notice.getNoticeid());
			result.put("title", notice.getTitle());
			result.put("contents", notice.getContents());
			result.put("writer_uid", notice.getWriter_uid());
			result.put("reg_date", notice.getReg_date());
			result.put("mod_date", notice.getMod_date());
			result.put("view_count", notice.getView_count());
			result.put("fixed_yn", notice.getFixed_yn());
			result.put("status", true);
			result.put("first", false);
			result.put("last", false);
    		result.put("prevNoticeid", 0);
			result.put("nextNoticeid", 0);
			
	    	if (idx == 0) {
				result.put("last", true);
	    		result.put("prevNoticeid", noticeList.get(idx + 1).getNoticeid());
	    	} else if (idx == size - 1) {
				result.put("first", true);
				result.put("nextNoticeid", noticeList.get(idx - 1).getNoticeid());
	    	} else {
	    		result.put("prevNoticeid", noticeList.get(idx + 1).getNoticeid());
				result.put("nextNoticeid", noticeList.get(idx - 1).getNoticeid());
	    	}
		}
		
		return result;
	}
	
	// 게시물 조회수 증가
	public void increaseViews(int noticeid) {
		noticeDao.increaseViews(noticeid);
	}
	
	// 페이지용 게시물 가져오기 (최신순)
	public Map<String, Object> getAllNoticePageList(Notice notice) {
		Map<String, Object> result = new HashMap<>();
		notice.setPageInfo(noticeDao.getTotalCount(notice));
		System.out.println(notice);
		result.put("notice", notice);
		result.put("fixedNoticeList", noticeDao.findFixed5());
		result.put("noticeList", noticeDao.getAllNoticePageList(notice));
		
		return result;
	}
	
	// 페이지용 게시물 더보기 (최신순, 조회순)
	public JSONObject getMoreNoticePageList(Notice notice) {
		JSONObject result = new JSONObject();
		notice.setPageInfo(noticeDao.getTotalCount(notice));
		System.out.println(notice);
		
		switch (notice.getOrder()) {
		case "recent": {
			result.put("noticeList", noticeDao.getMoreNoticePageList(notice));
			break;
		}
		case "view": {
			result.put("noticeList", noticeDao.getMoreNoticePageListByViewCount(notice));
			break;
		}
		}
		
		return result;
	}
	
	// 페이지용 게시물 가져오기 (조회순)
	public Map<String, Object> getAllNoticePageListByViewCount(Notice notice) {
		Map<String, Object> result = new HashMap<>();
		notice.setPageInfo(noticeDao.getTotalCount(notice));
		System.out.println(notice);
		result.put("notice", notice);
		result.put("fixedNoticeList", noticeDao.findFixed5ByView());
		result.put("noticeList", noticeDao.getAllNoticePageListByViewCount(notice));
		
		return result;
	}

	// 글 작성
	public JSONObject write(Notice notice) {
		JSONObject result = new JSONObject();
		
		if (noticeDao.writeNotice(notice) > 0) {
			result.put("message", "글 작성이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 작성에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}

	// 글 수정
	public JSONObject update(Notice notice) {
		JSONObject result = new JSONObject();
		
		if (noticeDao.updateNotice(notice) > 0) {
			result.put("message", "글 수정이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 수정에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 글 삭제
	public JSONObject delete(Notice notice) {
		JSONObject result = new JSONObject();
		
		if (noticeDao.deleteNotice(notice) > 0) {
			result.put("message", "글 삭제가 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 선택 글 삭제 (관리자)
	public JSONObject deletes(Notice notice) {
		JSONObject result = new JSONObject();
		
		if (noticeDao.deleteNotices(notice) > 0) {
			result.put("message", "선택한 글 삭제가 완료되었습니다.");
			result.put("status", true);
		}
		else {
			result.put("message", "선택한 글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 글 고정 (관리자)
	public JSONObject fix(int noticeid, String doYN) {
		JSONObject result = new JSONObject();
		
		if (noticeDao.fixNotice(noticeid, doYN) > 0) {
			result.put("status", true);
			if (doYN.equals("Y")) result.put("message", "글 고정이 완료되었습니다.");
			else if (doYN.equals("N")) result.put("message", "글 고정 해제가 완료되었습니다.");
		}
		else {
			result.put("status", false);
			if (doYN.equals("Y")) result.put("message", "글 고정에 실패하였습니다.");
			else if (doYN.equals("N")) result.put("message", "글 고정 해제에 실패하였습니다.");
		}
		
		return result;
	}
}
