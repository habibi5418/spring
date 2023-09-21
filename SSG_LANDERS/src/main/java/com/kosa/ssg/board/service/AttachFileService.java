package com.kosa.ssg.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.ssg.board.dao.AttachFileDAO;
import com.kosa.ssg.board.domain.AttachFile;


@Service
public class AttachFileService {
	
	@Autowired
	private AttachFileDAO attachFileDAO;

	public AttachFile getAttachFile(String fileNo) throws Exception {
		System.out.println("AttachFileService.getAttachFile() 함수 호출됨");
		
		return attachFileDAO.getAttachFile(fileNo);
	} 

} 
