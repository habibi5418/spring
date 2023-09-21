package com.kosa.ssg.board.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.ssg.board.dao.AttachFileDAO;
import com.kosa.ssg.board.dao.BoardDao;
import com.kosa.ssg.board.domain.AttachFile;
import com.kosa.ssg.board.domain.Board;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private AttachFileDAO attachFileDao;
	
	// 최근 게시물 5개 가져오기
	public List<Board> recent() {
		return boardDao.findRecent5();
	}
	
	// 업데이트 폼용 게시물 정보 가져오기
	public JSONObject getBeforeBoard(Board board) {
		JSONObject result = new JSONObject();
		Board updateBoard = boardDao.getBoardByBoardid(board.getBoardid());
		
		result.put("title", updateBoard.getTitle());
		result.put("contents", updateBoard.getContents());
		
		return result;
	}
	
	// 특정 게시물 가져오기 (boardid)
	public JSONObject getBoardByBoardid(int boardid, String order) {
		JSONObject result = new JSONObject();
		Board board = boardDao.getBoardByBoardid(boardid);
		List<Board> boardList = new ArrayList<>();

		if (board.getBoardid() == 0) {
			result.put("message", "삭제된 게시물입니다.");
			result.put("status", false);
		}
		else {
			if (order.equals("recent")) boardList = boardDao.getAllBoardList();
			else if (order.equals("view")) boardList = boardDao.getAllBoardListByViewCount();
			
	    	int idx = boardList.indexOf(board);
	    	int size = boardList.size();

			result.put("boardid", board.getBoardid());
			result.put("title", board.getTitle());
			result.put("contents", board.getContents());
			result.put("writer_uid", board.getWriter_uid());
			result.put("reg_date", board.getReg_date());
			result.put("mod_date", board.getMod_date());
			result.put("view_count", board.getView_count());
			result.put("status", true);
			result.put("first", false);
			result.put("last", false);
    		result.put("prevBoardid", 0);
			result.put("nextBoardid", 0);
			
	    	if (idx == 0) {
				result.put("last", true);
	    		result.put("prevBoardid", boardList.get(idx + 1).getBoardid());
	    	} else if (idx == size - 1) {
				result.put("first", true);
				result.put("nextBoardid", boardList.get(idx - 1).getBoardid());
	    	} else {
	    		result.put("prevBoardid", boardList.get(idx + 1).getBoardid());
				result.put("nextBoardid", boardList.get(idx - 1).getBoardid());
	    	}
		}
		System.out.println("상세페이지 : " + result);
		return result;
	}
	
	// 게시물 조회수 증가
	public void increaseViews(int boardid) {
		boardDao.increaseViews(boardid);
	}
	
	// 페이지용 게시물 가져오기 (최신순)
	public Map<String, Object> getAllBoardPageList(Board board) {
		Map<String, Object> result = new HashMap<>();
		board.setPageInfo(boardDao.getTotalCount(board));
		System.out.println(board);
		result.put("board", board);
		result.put("boardList", boardDao.getAllBoardPageList(board));
		
		return result;
	}
	
	// 페이지용 게시물 더보기 (최신순, 조회순)
	public JSONObject getMoreBoardPageList(Board board) {
		JSONObject result = new JSONObject();
		board.setPageInfo(boardDao.getTotalCount(board));
		System.out.println(board);
		
		switch (board.getOrder()) {
		case "recent": {
			result.put("boardList", boardDao.getMoreBoardPageList(board));
			break;
		}
		case "view": {
			result.put("boardList", boardDao.getMoreBoardPageListByViewCount(board));
			break;
		}
		}
		
		return result;
	}
	
	// 페이지용 게시물 가져오기 (조회순)
	public Map<String, Object> getAllBoardPageListByViewCount(Board board) {
		Map<String, Object> result = new HashMap<>();
		board.setPageInfo(boardDao.getTotalCount(board));
		System.out.println(board);
		result.put("board", board);
		result.put("boardList", boardDao.getAllBoardPageListByViewCount(board));
		
		return result;
	}

	// 글 작성
	public JSONObject write(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.writeBoard(board) > 0) {
			result.put("message", "글 작성이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 작성에 실패하였습니다.");
			result.put("status", false);
		}
		
		if (board.getAttacheFileList() != null) {
			for (AttachFile attachFile : board.getAttacheFileList()) {
				attachFile.setBoardid(board.getBoardid());
				attachFileDao.insert(attachFile);
			}
		}
		
		return result;
	}

	// 글 수정
	public JSONObject update(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.updateBoard(board) > 0) {
			result.put("message", "글 수정이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 수정에 실패하였습니다.");
			result.put("status", false);
		}
		
		if (board.getAttacheFileList() != null) {
			for (AttachFile attachFile : board.getAttacheFileList()) {
				attachFile.setBoardid(board.getBoardid());
//				attachFileDao.update(attachFile);
			}
		}
		
		return result;
	}
	
	// 글 삭제
	public JSONObject delete(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.deleteBoard(board) > 0) {
			result.put("message", "글 삭제가 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 선택 글 삭제 (관리자)
	public JSONObject deletes(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.deleteBoards(board) > 0) {
			result.put("message", "선택한 글 삭제가 완료되었습니다.");
			result.put("status", true);
		}
		else {
			result.put("message", "선택한 글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}

	// 답글 작성
	public JSONObject reply(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.replyBoard(board) > 0) {
			result.put("message", "답글 작성이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "답글 작성에 실패하였습니다.");
			result.put("status", false);
		}
		
		if (board.getAttacheFileList() != null) {
			for (AttachFile attachFile : board.getAttacheFileList()) {
				attachFile.setBoardid(board.getBoardid());
				attachFileDao.insert(attachFile);
			}
		}
		
		return result;
	}

	// 댓글 작성
	public JSONObject comment(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.commentBoard(board) > 0) {
			result.put("message", "댓글 작성이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "댓글 작성에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 댓글 정보 가져오기
	public JSONObject getComment(Board board) {
		JSONObject result = new JSONObject();
		
		List<Board> commnetList = boardDao.getCommentBoard(board);
		
		result.put("commentList", commnetList);
		result.put("cnt", commnetList.size());
		result.put("check", commnetList.size() != 0 ? true : false);
		System.out.println(result);
		return result;
	}
	
	// 작성한 댓글 정보 가져오기
	public JSONObject getWriteComment(Board board) {
		JSONObject result = new JSONObject();
		
		List<Board> commnetList = boardDao.getWriteComment(board);
		
		result.put("commentList", commnetList);
		
		return result;
	}

	// 댓글 수정
	public JSONObject updateComment(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.updateComment(board) > 0) {
			result.put("message", "댓글 수정이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "댓글 수정에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}

	// 댓글 삭제
	public JSONObject deleteComment(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.deleteComment(board) > 0) {
			result.put("message", "댓글 삭제가 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "댓글 삭제를 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
}
