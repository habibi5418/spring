package com.kosa.ssg.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.ssg.notice.domain.Notice;


// 오라클 DAO
@Repository("NoticeDao")
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 전체 테이블 고정 제외
	@Override
	public List<Notice> getAllNoticeListNoFix() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		sqlSession.selectList("mapper.notice.getAllNoticeListNoFix", map);
		
		@SuppressWarnings("unchecked")
		List<Notice> list = (List<Notice>) map.get("out_cursor");
		
		return list;
	}
	
	// 조회순 전체 조회 고정 제외
	@Override
	public List<Notice> getAllNoticeListByViewCountNoFix() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		sqlSession.selectList("mapper.notice.getAllNoticeListByViewCountNoFix", map);
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 2. Notice 조건 조회 where noticeid = ?
	@Override
	public Notice getNoticeByNoticeid(int noticeid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeid", noticeid);
		
		sqlSession.selectList("mapper.notice.getNoticeByNoticeid", map);
		
		List<Notice> list = (List<Notice>) map.get("out_cursor");
		
		return list.get(0);
	}
		
	// 3. insert (noticeid, title, contents, writer_uid)
	@Override
	public int writeNotice(Notice notice) {
		Map<String, Object> map = new HashMap<>();
        map.put("title", notice.getTitle());
        map.put("contents", notice.getContents());
        map.put("writer_uid", notice.getWriter_uid());
		
		sqlSession.selectOne("mapper.notice.writeNotice", map);
		
		return (int) map.get("p_result");
	}
	
	// 4. update (title, contents, mod_date) 조건 where noticeid = ?
	@Override
	public int updateNotice(Notice notice) {
		Map<String, Object> map = new HashMap<>();
        map.put("noticeid", notice.getNoticeid());
        map.put("title", notice.getTitle());
        map.put("contents", notice.getContents());
		
		sqlSession.selectOne("mapper.notice.updateNotice", map);
		
		return (int) map.get("p_result");
	}

	// 5. update set delete_yn = ? (실질적 삭제 X)
	@Override
	public int deleteNotice(Notice notice) {
		Map<String, Object> map = new HashMap<>();
        map.put("noticeid", notice.getNoticeid());
		
		sqlSession.selectOne("mapper.notice.deleteNotice", map);
		
		return (int) map.get("p_result");
	}

	// 5-2. 선택 글 삭제 update set delete_yn = ? (실질적 삭제 X)
	@Override
	public int deleteNotices(Notice notice) {
		return sqlSession.update("mapper.notice.deleteNotices", notice);
	}
	
	// 최근 글 5개 조회
	@Override
	public List<Notice> findRecent5() {
		Map<String, Object> map = new HashMap<>();
		
		sqlSession.selectList("mapper.notice.findRecent5", map);
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 전체 게시물 수 구하기
	@Override
	public int getTotalCount(Notice notice) {
		Map<String, Object> map = new HashMap<>();
		map.put("searchText", notice.getSearchText());

		switch (notice.getSearchType()) {
			case "": {
				sqlSession.selectList("mapper.notice.getTotalCount", map);
				break;
			}
			case "title": {
				sqlSession.selectList("mapper.notice.getTotalCountT", map);
				break;
			}
			case "contents": {
				sqlSession.selectList("mapper.notice.getTotalCountC", map);
				break;
			}
			case "writer_uid": {
				sqlSession.selectList("mapper.notice.getTotalCountW", map);
				break;
			}
		}
		
		return (int) map.get("p_cnt");
	}
	
	// 고정 글 5개 조회
	@Override
	public List<Notice> findFixed5() {
		Map<String, Object> map = new HashMap<>();
		
		sqlSession.selectList("mapper.notice.findFixed5", map);
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 페이지용 게시물 가져오기
	@Override
	public List<Notice> getAllNoticePageList(Notice notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", notice.getSearchText());
		map.put("startNo", notice.getStartNo());
		map.put("endNo", notice.getEndNo());
		
		switch (notice.getSearchType()) {
			case "": {
				sqlSession.selectList("mapper.notice.getAllNoticePageList", map);
				break;
			}
			case "title": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListT", map);
				break;
			}
			case "contents": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListC", map);
				break;
			}
			case "writer_uid": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListW", map);
				break;
			}
		}
		
		return (List<Notice>) map.get("out_cursor");
	}

	// 페이지용 게시물 더보기 (최신순)
	@Override
	public List<Notice> getMoreNoticePageListByViewCount(Notice notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("view_count", notice.getView_count());
		map.put("searchText", notice.getSearchText());
		map.put("startNo", notice.getStartNo());
		map.put("endNo", notice.getEndNo());
		
		switch (notice.getSearchType()) {
		case "": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListByViewCount", map);
			break;
		}
		case "title": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListByViewCountT", map);
			break;
		}
		case "contents": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListByViewCountC", map);
			break;
		}
		case "writer_uid": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListByViewCountW", map);
			break;
		}
		}
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 페이지용 게시물 더보기 (조회순)
	@Override
	public List<Notice> getMoreNoticePageList(Notice notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeid", notice.getNoticeid());
		map.put("searchText", notice.getSearchText());
		map.put("startNo", notice.getStartNo());
		map.put("endNo", notice.getEndNo());
		
		switch (notice.getSearchType()) {
		case "": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageList", map);
			break;
		}
		case "title": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListT", map);
			break;
		}
		case "contents": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListC", map);
			break;
		}
		case "writer_uid": {
			sqlSession.selectList("mapper.notice.getMoreNoticePageListW", map);
			break;
		}
		}
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 고정 글 5개 조회 (조회순)
	@Override
	public List<Notice> findFixed5ByView() {
		Map<String, Object> map = new HashMap<>();
		
		sqlSession.selectList("mapper.notice.findFixed5ByView", map);
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 페이지용 게시물 가져오기 (조회순)
	@Override
	public List<Notice> getAllNoticePageListByViewCount(Notice notice) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", notice.getSearchText());
		map.put("startNo", notice.getStartNo());
		map.put("endNo", notice.getEndNo());
		
		switch (notice.getSearchType()) {
			case "": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListByViewCount", map);
				break;
			}
			case "title": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListByViewCountT", map);
				break;
			}
			case "contents": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListByViewCountC", map);
				break;
			}
			case "writer_uid": {
				sqlSession.selectList("mapper.notice.getAllNoticePageListByViewCountW", map);
				break;
			}
		}
		
		return (List<Notice>) map.get("out_cursor");
	}
	
	// 조회수 증가
	@Override
	public void increaseViews(int noticeid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeid", noticeid);
		
		sqlSession.update("mapper.notice.increaseViews", map);
	}

	// 글 고정 update set fixed_yn = ? (실질적 삭제 X)
	@Override
	public int fixNotice(int noticeid, String doYN) {
		Map<String, Object> map = new HashMap<>();
        map.put("noticeid", noticeid);
        map.put("doYN", doYN);
		
		sqlSession.selectOne("mapper.notice.fixNotice", map);
		
		return (int) map.get("p_result");
	}

}
