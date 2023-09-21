package com.kosa.ssg.board.dao;

import java.util.List;

import com.kosa.ssg.board.domain.AttachFile;
import com.kosa.ssg.board.domain.Board;


public interface AttachFileDAO {
	
	public List<AttachFile> getList(Board board) throws Exception;
	public AttachFile getAttachFile(String fileNo);
	public void insert(AttachFile attachFile);
	
}
