package com.kosa.ssg.notice.dao;

import java.util.List;

import com.kosa.ssg.notice.domain.Notice;


public interface NoticeDao {
	List<Notice> getAllNoticeListNoFix();
	List<Notice> getAllNoticeListByViewCountNoFix();
	Notice getNoticeByNoticeid(int noticeid);
	int writeNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(Notice notice);
	int deleteNotices(Notice notice);
	List<Notice> findRecent5();
	int getTotalCount(Notice notice);
	List<Notice> findFixed5();
	List<Notice> getAllNoticePageList(Notice notice);
	List<Notice> getMoreNoticePageList(Notice notice);
	List<Notice> getMoreNoticePageListByViewCount(Notice notice);
	List<Notice> findFixed5ByView();
	List<Notice> getAllNoticePageListByViewCount(Notice notice);
	void increaseViews(int noticeid);
	int fixNotice(int noticeid, String doYN);
}
