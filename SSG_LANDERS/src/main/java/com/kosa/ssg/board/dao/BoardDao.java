package com.kosa.ssg.board.dao;

import java.util.List;

import com.kosa.ssg.board.domain.Board;

public interface BoardDao {
	List<Board> getAllBoardList();
	List<Board> getAllBoardListByViewCount();
	Board getBoardByBoardid(int boardid);
	int writeBoard(String title, String contents, String writer_uid);
	int updateBoard(int boardid, String title, String contents);
	int deleteBoard(int boardid);
	int deleteBoards(String deleteBoards);
	List<Board> findRecent5();
	void increaseViews(int boardid);
}
