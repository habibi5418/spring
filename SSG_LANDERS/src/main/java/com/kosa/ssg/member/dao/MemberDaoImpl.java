package com.kosa.ssg.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.ssg.ConnectionHelper;
import com.kosa.ssg.member.domain.Member;


// 오라클 DAO
@Repository("MemberDao")
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	SqlSession sqlsession;
	
	// 1. Member 테이블 전체 조회
	@Override
	public List<Member> getAllMemberList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<Member> memberList = new ArrayList<>();
				
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "select * from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				do {
					Member member = new Member();
					member.setMemid(rs.getString(1));
					member.setMname(rs.getString(2));
					member.setPwd(rs.getString(3));
					member.setPhone(rs.getString(4));
					memberList.add(member);
				} while (rs.next());
			}
			System.out.println("전체 멤버 : " + memberList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return memberList;
	}
	
	// 2-1. Member 조건 조회 where memid = ?
	@Override
	public Member getMemberByMemid(String memid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		Member member = new Member();
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "select * from member where memid = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memid);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				member.setMemid(rs.getString(1));
				member.setMname(rs.getString(2));
				member.setPwd(rs.getString(3));
				member.setPhone(rs.getString(4));
			}
			System.out.println("조회한 멤버 : " + member);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return member;
	}
	
	// 2-2. 아이디 찾기 where mname = ? and phone = ?
	@Override
	public String getMemidByMnamePhone(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String memid = "";
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "select * from member where mname = ? and phone = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMname());
			pstmt.setString(2, member.getPhone());
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) memid = rs.getString(1);
			
			System.out.println("찾은 아이디 : " + memid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return memid;
	}
	
	// 2-3. 비밀번호 찾기 where memid = ? and mname = ?
	@Override
	public String getPwdByMemidMname(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String pwd = "";
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "select * from member where memid = ? and mname = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMemid());
			pstmt.setString(2, member.getMname());
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) pwd = rs.getString(3);
			
			System.out.println("찾은 비밀번호 : " + pwd);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return pwd;
	}
	
	// 2-4. 로그인 where memid = ? and pwd = ?
	@Override
	public Member getMemberByMemidPwd(Member member) {
		return (Member) sqlsession.selectOne("mapper.member.getMemberByMemidPwd", member);
	}

	// 아이디 중복 검사
	@Override
	public boolean existMemid(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int cnt = 0;
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "select count(*) from member where memid = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getMemid());
			
			rs = pstmt.executeQuery();
			if (rs.next()) cnt = rs.getInt(1);
			
			return cnt == 1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
	}

	// 3. insert (memid, mname, pwd, phone)
	@Override
	public int insertMember(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int row = 0;
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "insert into member(memid, mname, pwd, phone) values(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getMemid());
			pstmt.setString(2, member.getMname());
			pstmt.setString(3, member.getPwd());
			pstmt.setString(4, member.getPhone());
			
			row = pstmt.executeUpdate();
			
			if (row > 0) System.out.println(member.getMemid() + "회원님 회원가입 완료");
			else System.out.println("회원가입 실패");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return row;
	}

	// 4. update (mname, pwd, phone) 조건 where memid = ?
	@Override
	public int updateMember(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int row = 0;
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "update member set mname = ?, pwd = ?, phone = ? where memid = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMname());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getMemid());
			
			row = pstmt.executeUpdate();
			
			if (row > 0) {
				System.out.println(member + " 정보 수정 완료");
			}
			else System.out.println("정보 수정 실패");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return row;
	}

	// 5. delete (memid, pwd) 조건 where memid = ? and pwd = ?
	@Override
	public int deleteMember(Member member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int row = 0;
		
		try {
			conn = ConnectionHelper.getConnection("oracle");
			sql = "delete from member where memid = ? and pwd = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMemid());
			pstmt.setString(2, member.getPwd());
			
			row = pstmt.executeUpdate();
			
			if (row > 0) {
				System.out.println(member.getMemid() + "님 회원탈퇴 완료");
			}
			else System.out.println("회원탈퇴 실패");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return row;
	}
}
