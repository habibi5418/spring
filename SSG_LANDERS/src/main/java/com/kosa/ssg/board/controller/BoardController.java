package com.kosa.ssg.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.ssg.board.domain.Board;
import com.kosa.ssg.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@ResponseBody
	@RequestMapping(value = "/board/detailBoard.do", method = RequestMethod.GET)
	public String detailBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("detailBoard()");
		
		String order = request.getParameter("order");
		
		boardService.increaseViews(board.getBoardid());
		Map<String, Object> result = boardService.getBoardByBoardid(board.getBoardid(), order);
		boolean status = (boolean) result.get("status");
		request.setAttribute("status", status);
		request.setAttribute("order", order);
		
		if (status) {
			request.setAttribute("board", result.get("board"));
			request.setAttribute("first", (boolean) result.get("first"));
			request.setAttribute("last", (boolean) result.get("last"));
			request.setAttribute("prevBoardid", result.get("prevBoardid"));
			request.setAttribute("nextBoardid", result.get("nextBoardid"));
		} else request.setAttribute("message", result.get("message"));
		
		return (String) result.get("location");
	}

	@RequestMapping(value = "/board/listBoard.do")
	public String listBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoard()");
		
		request.setAttribute("boardList", boardService.getAllBoardList());
		
		return "board/listBoard";
	}

	public String listBoardByViewCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoardByViewCount()");
		
		request.setAttribute("boardList", boardService.getAllBoardListByViewCount());
		
		return "board/listBoardByViewCount.jsp";
	}

	public String writeBoardForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("writeBoardForm()");
		
		return "board/writeBoardForm.jsp";
	}

	public String writeBoard(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("writeBoard()");

		JSONObject jsonResult = boardService.write(board);
		
		return jsonResult.toString();
	}

	public String updateBoardForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateBoardForm()");
		
		request.setAttribute("order", request.getParameter("order"));
		request.setAttribute("board", boardService.getBoardByBoardid(Integer.parseInt(request.getParameter("boardid")), request.getParameter("order")).get("board"));
		
		return "board/updateBoardForm.jsp";
	}

	public String updateBoard(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateBoard()");

		String order = request.getParameter("order");
		JSONObject jsonResult = boardService.update(board);
		jsonResult.put("location", jsonResult.getString("location") + "&order=" + order);
		
		return jsonResult.toString();
	}

	public String deleteBoard(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deleteBoard()");

		String order = request.getParameter("order");
		JSONObject jsonResult = boardService.delete(board);
		jsonResult.put("order", order);
		
		return jsonResult.toString();
	}

	public String deleteBoards(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deletesBoard()");

		String deleteBoards = request.getParameter("deleteBoards");
		String order = request.getParameter("order");
		
		JSONObject jsonResult = boardService.deletes(deleteBoards, order);
		jsonResult.put("order", order);
		
		return jsonResult.toString();
	}
}
