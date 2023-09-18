package com.kosa.ssg.board.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.ssg.board.dao.BoardDao;
import com.kosa.ssg.board.domain.Board;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	// 최근 게시물 5개 가져오기
	public List<Board> recent() {
		return boardDao.findRecent5();
	}
	
	// 특정 게시물 가져오기 (boardid)
	public Map<String, Object> getBoardByBoardid(int boardid, String order) {
		Map<String, Object> result = new HashMap<>();
		Board board = boardDao.getBoardByBoardid(boardid);
		List<Board> boardList = new ArrayList<>();

    	result.put("location", "board/detailBoard.jsp");
		if (board.getBoardid() == 0) {
			result.put("message", "삭제된 게시물입니다.");
			result.put("status", false);
		}
		else {
			if (order.equals("recent")) boardList = boardDao.getAllBoardList();
			else if (order.equals("view")) boardList = boardDao.getAllBoardListByViewCount();
			
	    	int idx = boardList.indexOf(board);
	    	int size = boardList.size();

			result.put("board", board);
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
		
		return result;
	}
	
	// 게시물 조회수 증가
	public void increaseViews(int boardid) {
		boardDao.increaseViews(boardid);
	}
	
	// 전체 게시물 가져오기 (최신순)
	public List<Board> getAllBoardList() {
		return boardDao.getAllBoardList();
	}
	
	// 전체 게시물 가져오기 (조회순)
	public List<Board> getAllBoardListByViewCount() {
		return boardDao.getAllBoardListByViewCount();
	}

	// 글 작성
	public JSONObject write(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.writeBoard(board.getTitle(), board.getContents(), board.getWriter_uid()) > 0) {
			result.put("message", "글 작성이 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 작성에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 글 수정
	public JSONObject update(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.updateBoard(board.getBoardid(), board.getTitle(), board.getContents()) > 0) {
			result.put("message", "글 수정이 완료되었습니다.");
			result.put("location", "detailBoard.do?boardid=" + board.getBoardid());
			result.put("status", true);
		} else {
			result.put("message", "글 수정에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 글 삭제
	public JSONObject delete(Board board) {
		JSONObject result = new JSONObject();
		
		if (boardDao.deleteBoard(board.getBoardid()) > 0) {
			result.put("message", "글 삭제가 완료되었습니다.");
			result.put("status", true);
		} else {
			result.put("message", "글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
	
	// 선택 글 삭제 (관리자)
	public JSONObject deletes(String deleteBoards, String order) {
		JSONObject result = new JSONObject();
		
		if (boardDao.deleteBoards(deleteBoards) > 0) {
			result.put("message", "선택한 글 삭제가 완료되었습니다.");
			result.put("status", true);
		}
		else {
			result.put("message", "선택한 글 삭제에 실패하였습니다.");
			result.put("status", false);
		}
		
		return result;
	}
}
