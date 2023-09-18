<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div id="logo">
	  <a href="<c:url value='/main.do'/>">
	    <h1>SSG LANDERS</h1>
	  </a>
	</div>
	<nav>
	  <ul id="topMenu">
	    <li>
	      <a href="#">LANDERS</a>
	      <ul>
	        <li><a href="#">연혁</a></li>
	        <li><a href="#">엠블럼</a></li>
	        <li><a href="#">후원사</a></li>
	        <li><a href="#">구단정보</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="#">PLAYERS</a>
	      <ul>
	        <li><a href="#">코칭 스태프</a></li>
	        <li><a href="#">투수</a></li>
	        <li><a href="#">야수</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="<c:url value='/notice/listNotice.do'/>">MEDIA</a>
	      <ul>
	        <li><a href="<c:url value='/notice/listNotice.do'/>">공지사항</a></li>
	        <li><a href="#">랜더스 포토</a></li>
	        <li><a href="<c:url value='/board/listBoard.do'/>">자유게시판</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="#">STADIUM</a>
	      <ul>
	        <li><a href="#">구장소개</a></li>
	        <li><a href="#">찾아오시는 길</a></li>
	      </ul>
	    </li>
	    <c:choose>
		    <c:when test="${loginMember != null }">
			    <li id="header3">
			      <a href="<c:url value='/member/myPage.do'/>">${loginMember.mname }님<br>반갑습니다.</a>
			      <ul>
			        <li><a href="#" id="logoutBtn">LOGOUT</a></li>
			      	<li><a href="<c:url value='/member/myPage.do'/>">MYPAGE</a></li>
			      </ul>
			    </li>
		    </c:when>
		    <c:when test="${loginMember == null }">
			    <li id="header1">
			      <a href="#" id="openLoginForm">LOGIN</a>
			    </li>
			    <li id="header2">
			      <a href="#" id="openRegisterForm">JOIN</a>
			    </li>
		    </c:when>
		</c:choose>
	  </ul>
	</nav>
	
	<div id="login-form" class="dialog-form" title="로그인 폼">
		<form id="form" autocomplete="off">
			<h1>LOGIN</h1>
			<input id="loginMemid" type="text" name="loginMemid" maxlength="20" placeholder="아이디" required/><br/>
			<input id="loginPwd" type="password" name="loginPwd" maxlength="20" placeholder="비밀번호" required/><br/>
			<input id="submit" type="submit" value="로그인"/><br/>
			<div class="links">
				<a href="registerForm.do">회원가입</a><span>|</span>
				<a href="findMemidForm.do">아이디 찾기</a><span>|</span>
				<a href="findPwdForm.do">비밀번호 찾기</a>
			</div>
		</form>
	</div>
	
	<div id="register-form" class="dialog-form" title="회원가입 폼">
		<form id="form" method="post" autocomplete="off">
			<h1>JOIN</h1>
			<input id="registerMemid" type="text" name="memid" maxlength="20" placeholder="아이디 (영문과 숫자의 조합, 최대 20글자 제한)" required="required"/>
			<input id="idDuplication" type="button" value="중복 체크"/><br/>
			<input id="registerPwd" type="password" name="pwd" maxlength="20" placeholder="비밀번호(8~20자리 영문, 숫자, 특수문자의 조합)" required="required"/><br/>
			<input id="registerPwd2" type="password" name="pwd2" maxlength="20" placeholder="비밀번호 확인" required="required"/><br/>
			<input id="registerMname" type="text" name="mname" maxlength="20" placeholder="이름(한글이나 영문)" required="required"/><br/>
			<input id="registerPhone" type="text" name="phone" maxlength="13" placeholder="전화번호(숫자만 입력 가능. '-' 자동 작성)" required="required"/><br/>
			<input id="registerEmail" type="text" name="email" maxlength="50" placeholder="이메일(example@example.com)" required="required"/><br/>
			<input id="idcheck" type="hidden" name="idcheck" value="iduncheck"/>
			<input id="register" type="button" value="회원가입"/>
		</form>
	</div>
	
	<script>
		$(document).ready(function() {
	    	$("#login-form").dialog({
	            autoOpen: false,
	            height: 650,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	loginMemid.text("");
	            	loginPwd.text("");
	            }
	        });
	    	
	    	$("#register-form").dialog({
	            autoOpen: false,
	            height: 800,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	    			registerMemid.text("");
	    			registerPwd.text("");
	    			registerPwd2.text("");
	    			registerMname.text("");
	    			registerPhone.text("");
	    			registerEmail.text("");
	            }
	        });
	    });
	    
		$("#openLoginForm").on("click", function() {
			$("#login-form").dialog("open");
		});
		$("#openRegisterForm").on("click", function() {
			$("#register-form").dialog("open");
		});
		
		var loginMemid = $("#loginMemid"),
			loginPwd = $("#loginPwd"),
			registerMemid = $("#registerMemid"),
			registerPwd = $("#registerPwd"),
			registerPwd2 = $("#registerPwd2"),
			registerMname = $("#registerMname"),
			registerPhone = $("#registerPhone"),
			registerEmail = $("#registerEmail");
			
		
		// 로그인
		document.querySelector("#login-form").addEventListener("submit", e => {
			e.preventDefault();
			
			const param = {
					memid: loginMemid.val(),
					pwd: loginPwd.val()
			}
			
			fetch("<c:url value='/member/login.do'/>", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param),
			})
			.then((response) => response.json())
			.then((json) => {
				alert(json.message);
				if (json.status) {
					if (loginMemid.val() != "admin") location.href = "<c:url value='/main.do'/>";
					else location.href = "<c:url value='/mainForAdmin.do'/>";
				} 
			});
		});
		
		// 로그아웃
		if (document.querySelector("#logoutBtn") != null) {
			document.querySelector("#logoutBtn").addEventListener("click", () => {
				if (confirm("로그아웃하시겠습니까 ?")) {			
					fetch("<c:url value='/member/logout.do'/>", {
						method: "POST",
						headers: {
						    "Content-Type": "application/json; charset=UTF-8",
						},
					})
					.then((response) => response.json())
					.then((json) => {
						alert(json.message);
						if (json.status) {
							location.href = "<c:url value='/main.do'/>";
						} 
					});
				}
			});	
		}
		
		// 유효성 검사
		let existUidChecked = false;
		
		document.querySelector("#idDuplication").addEventListener("click", function() {
			const param = {memid: registerMemid.val()};
			
			if (registerMemid.val() == "" || !memidCheck(registerMemid.val())) {
				alert("아이디는 영문과 숫자의 조합으로 작성해주세요." + registerMemid.val());
				registerMemid.val() = "";
				registerMemid.focus();
				existUidChecked = false;
			}
			else {
				fetch("<c:url value='/member/existUid.do'/>", {
					method: "POST",
					headers: {
					    "Content-Type": "application/json; charset=UTF-8",
					},
					body: JSON.stringify(param),
				})
				.then((response) => response.json())
				.then((json) => {
					alert(json.message);
					if (!json.status) {
						registerMemid.val() = "";
						registerMemid.focus();
						existUidChecked = false;
					} else {
						existUidChecked = true;
					}
				});
			}
		});
		
		document.querySelector("#register").addEventListener("click", function fetchTest1() {
			if (!existUidChecked) {
				alert("아이디 중복 체크를 먼저 해주세요.");
				idDuplication.focus();
			} else {
				const param = {
						memid: registerMemid.val(),
						pwd: registerPwd.val(),
						mname: registerMname.val(),
						phone: registerPhone.val(),
						email: registerEmail.val()
				};
				
				fetch("<c:url value='/member/register.do'/>", {
					method: "POST",
					headers: {
					    "Content-Type": "application/json; charset=UTF-8",
					},
					body: JSON.stringify(param),
				})
				.then((response) => response.json())
				.then(json => {
					alert(json.message);
					if (json.status) {
						$("#register-form").dialog("close");
						$("#login-form").dialog("open");
					}
				});
			}
		});
	
		function memidCheck(memid) {
			var memidForm = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{2,20}$/;
			return memidForm.test(memid);
		}
		function pwdCheck(pwd) {
			var pwdForm = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,20}$/;
			return pwdForm.test(pwd);
		}
		function pwd2Check(pwd2) {
			if (registerPwd.val() == pwd2) return true;
			return false;
		}
		function mnameCheck(mname) {
			var mnameForm = /^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+$/;
			return mnameForm.test(mname);
		}
		
		document.querySelector("#registerMemid").addEventListener("input", function() {
			var memidResult = memidCheck(this.value);
			if (!memidResult) {
				this.setCustomValidity("아이디는 영문과 숫자가 각각 최소 1글자씩 포함된 조합만 가능합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#registerPwd").addEventListener("input", function() {
			var pwdResult = pwdCheck(this.value);
			if (!pwdResult) {
				this.setCustomValidity("비밀번호는 영문과 숫자, 특수문자 조합의 최소 8글자여야 합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#registerPwd2").addEventListener("input", function() {
			var pwd2Result = pwd2Check(this.value);
			if (!pwd2Result) {
				this.setCustomValidity("입력한 비밀번호와 다릅니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#registerMname").addEventListener("input", function() {
			var mnameResult = mnameCheck(this.value);
			if (!mnameResult) {
				this.setCustomValidity("이름은 한글과 영문만 사용이 가능합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#registerPhone").addEventListener("input", function() {
			var val = this.value.replace(/[^0-9]/g, "");
			var leng = val.length;
			var result = "";
			
			if (leng < 4) result = val;
			else if (leng < 8) {
				result += val.substring(0, 3);
				result += "-";
				result += val.substring(3);
			} else if (leng > 7) {
				result += val.substring(0, 3);
				result += "-";
				result += val.substring(3, 7);
				result += "-";
				result += val.substring(7);
			}
			
			this.value = result;
		});
	</script>