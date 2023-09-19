package com.kosa.ssg.member.dao;

import java.util.List;

import com.kosa.ssg.member.domain.Member;


public interface MemberDao {
	List<Member> getAllMemberList();
	String getMemidByMnamePhone(Member member);
	String getPwdByMemidMname(Member member);
	Member getMemberByMemidPwd(Member member);
	boolean existMemid(Member member);
	int insertMember(Member member);
	int updateMember(Member member);
	int deleteMember(Member member);
}
