package com.kosa.ssg.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.ssg.board.domain.Board;

// 오라클 DAO
@Repository("BoardDao")
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Board> getAllBoardList() {
		return sqlSession.selectList("mapper.board.getAllBoardList");
	}
	
	@Override
	public List<Board> getAllBoardListByViewCount() {
		return sqlSession.selectList("mapper.board.getAllBoardListByViewCount");
	}
	
	// 2. Board 조건 조회 where boardid = ?
	@Override
	public Board getBoardByBoardid(int boardid) {
		return sqlSession.selectOne("mapper.board.getBoardByBoardid", boardid);
	}
		
	// 3. insert (boardid, title, contents, writer_uid)
	@Override
	public int writeBoard(Board board) {
		return sqlSession.insert("mapper.board.writeBoard", board);
	}
	
	// 4. update (title, contents, mod_date) 조건 where boardid = ?
	@Override
	public int updateBoard(Board board) {
		return sqlSession.update("mapper.board.updateBoard", board);
	}

	// 5. update set delete_yn = ? (실질적 삭제 X)
	@Override
	public int deleteBoard(Board board) {
		return sqlSession.update("mapper.board.deleteBoard", board);
	}

	// 5-2. 선택 글 삭제 update set delete_yn = ? (실질적 삭제 X)
	@Override
	public int deleteBoards(Board board) {
		System.out.println(board);
		return sqlSession.update("mapper.board.deleteBoards", board);
	}
	
	// 최근 글 5개 조회
	@Override
	public List<Board> findRecent5() {
		return sqlSession.selectList("mapper.board.findRecent5");
	}
	
	// 전체 게시물 수 구하기
	@Override
	public int getTotalCount(Board board) {
		Board getBoard = sqlSession.selectOne("mapper.board.getTotalCount");
		return getBoard != null ? getBoard.getTotalCount() : 0;
	}
	
	// 페이지용 게시물 가져오기
	@Override
	public List<Board> getAllBoardPageList(Board board) {
		return sqlSession.selectList("mapper.board.getAllBoardPageList", board);
	}
	
	// 페이지용 게시물 더보기 (최신순)
	@Override
	public List<Board> getMoreBoardPageList(Board board) {
		return sqlSession.selectList("mapper.board.getMoreBoardPageList", board);
	}

	// 페이지용 게시물 더보기 (조회순)
	@Override
	public List<Board> getMoreBoardPageListByViewCount(Board board) {
		return sqlSession.selectList("mapper.board.getMoreBoardPageListByViewCount", board);
	}
	
	// 페이지용 게시물 가져오기 (조회순)
	@Override
	public List<Board> getAllBoardPageListByViewCount(Board board) {
		return sqlSession.selectList("mapper.board.getAllBoardPageListByViewCount", board);
	}
	
	// 조회수 증가
	@Override
	public void increaseViews(int boardid) {
		sqlSession.update("mapper.board.increaseViews", boardid);
	}
	
	// 답글 작성
	@Override
	public int replyBoard(Board board) {
		return sqlSession.insert("mapper.board.replyBoard", board);
	}
	
	// 댓글 작성
	@Override
	public int commentBoard(Board board) {
		return sqlSession.insert("mapper.board.commentBoard", board);
	}
	
	// 댓글 가져오기
	@Override
	public List<Board> getCommentBoard(Board board) {
		return sqlSession.selectList("mapper.board.getCommentBoard", board);
	}
	
	// 작성한 댓글 가져오기
	@Override
	public List<Board> getWriteComment(Board board) {
		return sqlSession.selectList("mapper.board.getWriteComment", board);
	}
	
	// 댓글 수정
	@Override
	public int updateComment(Board board) {
		return sqlSession.update("mapper.board.updateComment", board);
	}
	
	// 댓글 삭제
	@Override
	public int deleteComment(Board board) {
		return sqlSession.delete("mapper.board.deleteComment", board);
	}
}
