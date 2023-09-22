package com.kosa.ssg.board.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.ssg.board.domain.AttachFile;
import com.kosa.ssg.board.domain.Board;


@Repository("attachFileDAO")
public class AttachFileDAOImpl implements AttachFileDAO {
	
	@Autowired
	private  SqlSession sqlSession;
	
	@Override
	public List<AttachFile> getList(Board board) throws Exception {
		return sqlSession.selectList("mapper.attach_file.getList", board);
	}

	@Override
	public AttachFile getAttachFile(String fileNo) {
		return sqlSession.selectOne("mapper.attach_file.getAttachFile", fileNo);
	}

	@Override
	public void insert(AttachFile attachFile) {
		sqlSession.insert("mapper.attach_file.insert", attachFile);
	}

	@Override
	public void update(AttachFile attachFile) {
		sqlSession.insert("mapper.attach_file.insert", attachFile);
	}

	@Override
	public void delete(int boardid) {
		sqlSession.delete("mapper.attach_file.delete", boardid);
	}

} // end class