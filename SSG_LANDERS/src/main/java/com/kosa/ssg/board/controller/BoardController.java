package com.kosa.ssg.board.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.ssg.board.domain.Board;
import com.kosa.ssg.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	@ResponseBody
	@RequestMapping(value = "/board/detailBoard.do", produces = "application/text; charset=UTF-8")
	public String detailBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("detailBoard()");
		
		boardService.increaseViews(board.getBoardid());
		
		return boardService.getBoardByBoardid(board.getBoardid(), board.getOrder()).toString();
	}

	@RequestMapping(value = "/board/listBoard.do")
	public String listBoard(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoard()");
		
		request.setAttribute("result", boardService.getAllBoardPageList(board));
		
		return "board/listBoard";
	}
	
	// 해야 됨
	@RequestMapping(value = "/board/listBoardForAdmin.do")
	public String listBoardForAdmin(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoardForAdmin()");
		
		request.setAttribute("result", boardService.getAllBoardPageList(board));
		
		return "board/listBoardForAdmin";
	}

	@ResponseBody
	@RequestMapping(value = "/board/moreListBoard.do", produces = "application/text; charset=UTF-8")
	public String moreListBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("moreListBoard()");
		
		return boardService.getMoreBoardPageList(board).toString();
	}
	
	@RequestMapping(value = "/board/listBoardByViewCount.do")
	public String listBoardByViewCount(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoardByViewCount()");
		
		request.setAttribute("result", boardService.getAllBoardPageListByViewCount(board));
		
		return "board/listBoardByViewCount";
	}

	// 해
	@RequestMapping(value = "/board/listBoardByViewCountForAdmin.do")
	public String listBoardByViewCountForAdmin(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoardByViewCountForAdmin()");
		
		request.setAttribute("result", boardService.getAllBoardPageListByViewCount(board));
		
		return "board/listBoardByViewCountForAdmin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/writeBoard.do", produces = "application/text; charset=UTF-8")
	public String writeBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("writeBoard() : " + board);
		
		return boardService.write(board).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/board/getBeforeBoard.do", produces = "application/text; charset=UTF-8")
	public String getBeforeBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getBeforeBoard()");

		return boardService.getBeforeBoard(board).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/board/updateBoard.do", produces = "application/text; charset=UTF-8")
	public String updateBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateBoard()");

		return boardService.update(board).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/board/deleteBoard.do", produces = "application/text; charset=UTF-8")
	public String deleteBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deleteBoard()");

		return boardService.delete(board).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/board/deleteBoards.do", produces = "application/text; charset=UTF-8")
	public String deleteBoards(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deletesBoard()" );

		return boardService.deletes(board).toString();
	}
	
}
