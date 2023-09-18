package com.kosa.ssg.member.service;


import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kosa.ssg.member.dao.MemberDao;
import com.kosa.ssg.member.domain.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	// 아이디 중복 검사
	public JSONObject existMemid(Member member) throws Exception {
		JSONObject jsonResult = new JSONObject();
		
		if (!memberDao.existMemid(member)) {
			jsonResult.put("message", "사용 가능한 아이디입니다.");
			jsonResult.put("status", true);
		} else {
			jsonResult.put("message", "이미 존재하는 아이디입니다.");
			jsonResult.put("status", false);
		}
	        
		return jsonResult;
	}
	
	// 회원가입
	public JSONObject insert(Member member) {
		JSONObject jsonResult = new JSONObject();
		
		if (memberDao.insertMember(member) == 1) {
			jsonResult.put("message", "회원가입이 완료되었습니다. 환영합니다. " + member.getMemid() + "님!");
			jsonResult.put("status", true);
		} else {
			jsonResult.put("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
			jsonResult.put("status", false);
		}
	        
		return jsonResult;
	}
	
	// 로그인
	public JSONObject login(Member member) {
		JSONObject jsonResult = new JSONObject();
	    Member loginMember = memberDao.getMemberByMemidPwd(member);
	    
        if (loginMember != null) {
        	jsonResult.put("loginMember", loginMember);
        	jsonResult.put("message", member.getMemid() + " 계정의 로그인에 성공하였습니다.");
        	jsonResult.put("status", true);
        } else {
        	jsonResult.put("message", "아이디 또는 비밀번호가 잘못되었습니다");
        	jsonResult.put("status", false);
        }
	        
		return jsonResult;
	}
	
	// 아이디 찾기
	public JSONObject findMemid(Member member) {
		JSONObject jsonResult = new JSONObject();
	    String memid = memberDao.getMemidByMnamePhone(member);
		
		if (!memid.equals("")) {
			jsonResult.put("message", member.getMname() + "님의 아이디는 " + memid + "입니다.");
        	jsonResult.put("status", true);
    	} else {
    		jsonResult.put("message", "이름 또는 전화번호가 잘못되었습니다.");
        	jsonResult.put("status", false);
    	}
		
		return jsonResult;
	}
	
	// 비밀번호 찾기
	public JSONObject findPwd(Member member) {
		JSONObject jsonResult = new JSONObject();
	    String pwd = memberDao.getPwdByMemidMname(member);
		
		if (!pwd.equals("")) {
			jsonResult.put("message", member.getMemid() + "님의 비밀번호는 " + pwd + "입니다.");
        	jsonResult.put("status", true);
    	} else {
    		jsonResult.put("message", "아이디 또는 이름이 잘못되었습니다.");
        	jsonResult.put("status", false);
    	}
		
		return jsonResult;
	}
	
	// 정보 수정
	public JSONObject update(Member newMember, Member oldMember) {
		JSONObject jsonResult = new JSONObject();
		
		if (memberDao.updateMember(newMember) > 0) {
			jsonResult.put("message", newMember.getMemid() + "님의 정보가 성공적으로 수정되었습니다."
					+ "\n비밀번호 : " + oldMember.getPwd() + " -> " + newMember.getPwd()
					+ "\n이름 : " + oldMember.getMname() + " -> " + newMember.getMname()
					+ "\n전화번호 : " + oldMember.getPhone() + " -> " + newMember.getPhone());
			jsonResult.put("status", true);
    	} else {
    		jsonResult.put("message", "정보 수정에 실패했습니다.");
    		jsonResult.put("status", false);
    	}

		return jsonResult;
	}

	// 회원탈퇴
	public JSONObject delete(Member member) {
		JSONObject jsonResult = new JSONObject();
		
		if (memberDao.getMemberByMemidPwd(member).getMemid() != null) {
			if (memberDao.deleteMember(member) > 0) {
				jsonResult.put("message", member.getMemid() + "님의 회원탈퇴가 완료되었습니다.");
				jsonResult.put("status", true);
	    	} else {
	    		jsonResult.put("message", "회원탈퇴에 실패했습니다.");
	    		jsonResult.put("status", false);
	    	}
		} else {
    		jsonResult.put("message", "비밀번호를 다시 확인해주세요.");
    		jsonResult.put("status", false);
		}

		return jsonResult;
	}
	
	// 전체 회원 출력
	public List<Member> allMemberPrint() {
		return memberDao.getAllMemberList();
	}
}
