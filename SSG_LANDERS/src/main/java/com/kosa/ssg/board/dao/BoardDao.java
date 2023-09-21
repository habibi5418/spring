package com.kosa.ssg.board.dao;

import java.util.List;

import com.kosa.ssg.board.domain.Board;

public interface BoardDao {
	List<Board> getAllBoardList();
	List<Board> getAllBoardListByViewCount();
	Board getBoardByBoardid(int boardid);
	int writeBoard(Board board);
	int updateBoard(Board board);
	int deleteBoard(Board board);
	int deleteBoards(Board board);
	List<Board> findRecent5();
	int getTotalCount(Board board);
	List<Board> getAllBoardPageList(Board board);
	List<Board> getMoreBoardPageList(Board board);
	List<Board> getMoreBoardPageListByViewCount(Board board);
	List<Board> getAllBoardPageListByViewCount(Board board);
	void increaseViews(int boardid);
	int replyBoard(Board board);
	int commentBoard(Board board);
	List<Board> getCommentBoard(Board board);
	List<Board> getWriteComment(Board board);
	int updateComment(Board board);
	int deleteComment(Board board);
}
