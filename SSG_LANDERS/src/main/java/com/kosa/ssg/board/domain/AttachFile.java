package com.kosa.ssg.board.domain;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AttachFile {

	private int fileNo; 			// 첨부파일 아이디
	private int boardid; 			// 게시글번호
	private String fileNameOrg;		// 사용자가 올린 원본 파일명 
	private String fileNameReal;	// 서버에 저장된 파일명 
	private int    length;			// 파일의 길이
	private String contentType;		// 컨텐츠 타입
	private Date   reg_date;		// 등록일시
	
}
