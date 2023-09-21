package com.kosa.ssg.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kosa.ssg.board.domain.AttachFile;
import com.kosa.ssg.board.service.AttachFileService;

@Controller
public class FileDownloadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	@Autowired
	AttachFileService attachFileService;

	@RequestMapping("/attachFile/download.do")
	protected void download(@RequestParam("fileNo") String fileNo,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		AttachFile attachFile = attachFileService.getAttachFile(fileNo); 
		if (attachFile != null) {
			String filePath = CURR_IMAGE_REPO_PATH + attachFile.getFileNameReal();  
			File image = new File(filePath);
			FileInputStream in = new FileInputStream(image);
			
			byte[] buffer = new byte[1024 * 8];
			while (true) {
				int count = in.read(buffer); 
				if (count == -1) 
					break;
				out.write(buffer, 0, count);
			}
			in.close();
			
		}
		out.close();
	}
	
}
