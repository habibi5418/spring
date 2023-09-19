package com.kosa.ssg.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.ssg.member.domain.Member;


// 오라클 DAO
@Repository("MemberDao")
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	SqlSession sqlSession;
	
	// 1. Member 테이블 전체 조회
	@Override
	public List<Member> getAllMemberList() {
		return sqlSession.selectList("mapper.member.getAllMemberList");
	}
	
	// 2-2. 아이디 찾기 where mname = ? and phone = ?
	@Override
	public String getMemidByMnamePhone(Member member) {
		Member findMember = sqlSession.selectOne("mapper.member.getMemidByMnamePhone", member);
		
		return findMember == null ? "" : findMember.getMemid();
	}
	
	// 2-3. 비밀번호 찾기 where memid = ? and mname = ?
	@Override
	public String getPwdByMemidMname(Member member) {
		Member findMember = sqlSession.selectOne("mapper.member.getPwdByMemidMname", member);
		
		return findMember == null ? "" : findMember.getPwd();
	}
	
	// 2-4. 로그인 where memid = ? and pwd = ?
	@Override
	public Member getMemberByMemidPwd(Member member) {
		return (Member) sqlSession.selectOne("mapper.member.getMemberByMemidPwd", member);
	}

	// 아이디 중복 검사
	@Override
	public boolean existMemid(Member member) {
		return sqlSession.selectOne("mapper.member.existMemid", member) != null;
	}

	// 3. insert (memid, mname, pwd, phone)
	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("mapper.member.insertMember", member);
	}

	// 4. update (mname, pwd, phone) 조건 where memid = ?
	@Override
	public int updateMember(Member member) {
		return sqlSession.update("mapper.member.updateMember", member);
	}

	// 5. delete (memid, pwd) 조건 where memid = ? and pwd = ?
	@Override
	public int deleteMember(Member member) {
		return sqlSession.delete("mapper.member.deleteMember", member);
	}
}
