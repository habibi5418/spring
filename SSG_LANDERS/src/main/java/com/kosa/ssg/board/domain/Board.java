package com.kosa.ssg.board.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	private int boardid;
	private String title;
	private String contents;
	private String writer_uid;
	private String reg_date;
	private String mod_date;
	private int view_count;
	private String delete_yn;
	private int pid;
	
	private String order;
	private String[] deleteBoards;
	private String doYN;
	private String[] currentBoards;

	private String searchType = "";
	private String searchText = "";
	
	private int pageNo = 1; // 현재 페이지
	private int totalCount; // 총 게시물 수
	private int totalPageSize; // 총 페이지 수
	private int pageLength = 10; // 한 페이지당 게시물 수 
	private int navSize = 10; // 네비게이터의 페이지 수
	private int navStart = 0; // 현재 네비게이터의 첫 번째 페이지 번호
	private int navEnd = 0; // 현재 네비게이터의 마지막 페이지 번호

	public Board(int boardid, String title, String contents, String writer_uid, String reg_date, String mod_date,
			int view_count, String delete_yn, String fixed_yn) {
		super();
		this.boardid = boardid;
		this.title = title;
		this.contents = contents;
		this.writer_uid = writer_uid;
		this.reg_date = reg_date.substring(0, reg_date.length() - 2);
		this.mod_date = mod_date.substring(0, mod_date.length() - 2);
		this.view_count = view_count;
		this.delete_yn = delete_yn;
	}
	
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date.substring(0, reg_date.length() - 2);
	}
	
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date.substring(0, mod_date.length() - 2);
	}
	
	public boolean doMod() {
		return !reg_date.equals(mod_date);
	}
	
	public void setPageInfo(int totalCount) {
		this.totalCount = totalCount;
		totalPageSize = (int) Math.ceil((double) totalCount / pageLength);
		navStart = ((pageNo - 1) / navSize) * navSize + 1;
		navEnd = ((pageNo - 1) / navSize + 1) * navSize;
		if (navEnd >= totalPageSize) navEnd = totalPageSize;
	}
	
	public int getStartNo() {
		return (pageNo - 1) * pageLength + 1; 
	}
	
	public int getEndNo() {
		return pageNo * pageLength; 
	}
}
