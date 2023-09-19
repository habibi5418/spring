package com.kosa.ssg.member.domain;
import java.io.Serializable;
import java.util.Objects;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Member implements Serializable {
	private static final long serialVersionUID = -1036524153261734687L;
	
	private String memid;
	private String mname;
	private String pwd;
	private String phone;
	private String email;
	
	public Member(String memid, String mname, String pwd, String phone, String email) {
		this.memid = memid;
		this.mname = mname;
		this.pwd = pwd;
		this.phone = phone;
		this.email = email;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(memid, other.memid);
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(memid);
	}

	public boolean isAdmin(String memid) {
		return this.memid.equals(memid);
	}
}
