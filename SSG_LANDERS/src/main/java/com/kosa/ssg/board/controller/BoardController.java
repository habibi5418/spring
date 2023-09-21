package com.kosa.ssg.board.controller;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kosa.ssg.board.domain.AttachFile;
import com.kosa.ssg.board.domain.Board;
import com.kosa.ssg.board.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	private static final String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
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

	@RequestMapping(value = "/board/listBoardByViewCountForAdmin.do")
	public String listBoardByViewCountForAdmin(Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("listBoardByViewCountForAdmin()");
		
		request.setAttribute("result", boardService.getAllBoardPageListByViewCount(board));
		
		return "board/listBoardByViewCountForAdmin";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/writeBoard.do", produces = "application/text; charset=UTF-8")
	public String writeBoard(@RequestBody Board board, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("writeBoard() : " + board);

		multipartRequest.setCharacterEncoding("UTF-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> enu = multipartRequest.getParameterNames();
		
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			map.put(name, value);
		}
		
		board.setAttacheFileList(fileProcess(multipartRequest));
		
		return boardService.write(board).toString();
	}
	
	private List<AttachFile> fileProcess(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<AttachFile> fileList = new ArrayList<>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		Calendar now = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("\\yyyy\\MM\\dd");
		
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String fileNameOrg = mFile.getOriginalFilename();
			String realFolder = sdf.format(now.getTime());
			
			File file = new File(CURR_IMAGE_REPO_PATH + realFolder);
			if (file.exists() == false) {
				file.mkdirs();
			}

			String fileNameReal = UUID.randomUUID().toString();
			
			//파일 저장 
			mFile.transferTo(new File(file, fileNameReal)); //임시로 저장된 multipartFile을 실제 파일로 전송

			fileList.add(
					AttachFile.builder()
					.fileNameOrg(fileNameOrg)
					.fileNameReal(realFolder + "\\" + fileNameReal)
					.length((int) mFile.getSize())
					.contentType(mFile.getContentType())
					.build()
					);
		}
		return fileList;
	}	

	@ResponseBody
	@RequestMapping(value = "/board/getBeforeBoard.do", produces = "application/text; charset=UTF-8")
	public String getBeforeBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getBeforeBoard()");

		return boardService.getBeforeBoard(board).toString();
	}

	@ResponseBody
	@RequestMapping(value = "/board/updateBoard.do", produces = "application/text; charset=UTF-8")
	public String updateBoard(@RequestBody Board board, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateBoard()");

		multipartRequest.setCharacterEncoding("UTF-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> enu = multipartRequest.getParameterNames();
		
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			map.put(name, value);
		}
		
		board.setAttacheFileList(fileProcess(multipartRequest));

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
	
	@ResponseBody
	@RequestMapping(value = "/board/replyBoard.do", produces = "application/text; charset=UTF-8")
	public String replyBoard(@RequestBody Board board, MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("replyBoard() : " + board);

		multipartRequest.setCharacterEncoding("UTF-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Enumeration<String> enu = multipartRequest.getParameterNames();
		
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			map.put(name, value);
		}
		
		board.setAttacheFileList(fileProcess(multipartRequest));
		
		return boardService.reply(board).toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/commentBoard.do", produces = "application/text; charset=UTF-8")
	public String commentBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("commentBoard() : " + board);
		
		return boardService.comment(board).toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/getCommentBoard.do", produces = "application/text; charset=UTF-8")
	public String getCommentBoard(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getCommentBoard() : " + board);
		
		return boardService.getComment(board).toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/getWriteComment.do", produces = "application/text; charset=UTF-8")
	public String getWriteComment(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getWriteComment() : " + board);
		
		return boardService.getWriteComment(board).toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/updateComment.do", produces = "application/text; charset=UTF-8")
	public String updateComment(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("updateComment() : " + board);
		
		return boardService.updateComment(board).toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/deleteComment.do", produces = "application/text; charset=UTF-8")
	public String deleteComment(@RequestBody Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("deleteComment() : " + board);
		
		return boardService.deleteComment(board).toString();
	}
	
}
