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
			      <a href="#">${loginMember.mname }님<br>반갑습니다.</a>
			      <ul>
			        <li><a href="#" id="logoutBtn">LOGOUT</a></li>
			      	<li><a href="#" id="openMyPageForm">MYPAGE</a></li>
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
		<form class="form" autocomplete="off">
			<h1>LOGIN</h1>
			<input id="loginMemid" type="text" name="loginMemid" maxlength="20" placeholder="아이디" required/><br/>
			<input id="loginPwd" type="password" name="loginPwd" maxlength="20" placeholder="비밀번호" required/><br/>
			<input id="submit" type="submit" value="로그인"/><br/>
			<div class="links">
				<a href="#" id="loginToRegister">회원가입</a><span>|</span>
				<a href="#" id="loginToFindId">아이디 찾기</a><span>|</span>
				<a href="#" id="loginToFindPwd">비밀번호 찾기</a>
			</div>
		</form>
	</div>
	
	<div id="register-form" class="dialog-form" title="회원 가입 폼">
		<form class="form" method="post" autocomplete="off">
			<h1>JOIN</h1>
			<input id="registerMemid" type="text" name="memid" maxlength="20" placeholder="아이디 (영문과 숫자의 조합, 최대 20글자 제한)" required="required"/>
			<input id="idDuplication" type="button" value="중복 체크"/><br/>
			<input id="registerPwd" class="pwd" type="password" name="pwd" maxlength="20" placeholder="비밀번호(8~20자리 영문, 숫자, 특수문자의 조합)" required="required"/><br/>
			<input id="registerPwd2" type="password" name="pwd2" maxlength="20" placeholder="비밀번호 확인" required="required"/><br/>
			<input id="registerMname" class="mname" type="text" name="mname" maxlength="20" placeholder="이름(한글이나 영문)" required="required"/><br/>
			<input id="registerPhone" class="phone" type="text" name="phone" maxlength="13" placeholder="전화번호(숫자만 입력 가능. '-' 자동 작성)" required="required"/><br/>
			<input id="registerEmail" class="email" type="text" name="email" maxlength="50" placeholder="이메일(example@example.com)" required="required"/><br/>
			<input id="idcheck" type="hidden" name="idcheck" value="iduncheck"/>
			<input id="register" type="button" value="회원가입"/>
		</form>
	</div>
	
	<div id="findId-form" class="dialog-form" title="아이디 찾기 폼">
		<form class="form" method="post" autocomplete="off">
			<h1>FIND UID</h1>
			<input id="findIdMname" type="text" name="mname" maxlength="20" placeholder="이름" required/><br/>
			<input id="findIdPhone" class="phone" type="text" name="phone" maxlength="13" placeholder="전화번호(숫자만 입력 가능. '-' 자동 작성)" required/><br/>
			<input type="button" value="아이디 찾기" onclick="findMemid()"/><br/>
			<div class="links">
				<a href="#" id="findIdToRegister">회원가입</a><span>|</span>
				<a href="#" id="findIdToFindPwd">비밀번호 찾기</a>
			</div>
		</form>
	</div>
	
	<div id="findPwd-form" class="dialog-form" title="비밀번호 찾기 폼">
		<form class="form" method="post" autocomplete="off">
			<h1>FIND PASSWORD</h1>
			<input id="findPwdMemid" type="text" name="memid" maxlength="20" placeholder="아이디" required="required"/><br/>
			<input id="findPwdMname" type="text" name="mname" maxlength="20" placeholder="이름" required="required"/><br/>
			<input type="button" value="비밀번호 찾기" onclick="findPwd()"/><br/>
			<div class="links">
				<a href="#" id="findPwdToRegister">회원가입</a><span>|</span>
				<a href="#" id="findPwdToFindId">아이디 찾기</a>
			</div>
		</form>
	</div>
	
	<div id="myPage-form" class="dialog-form" title="마이페이지 폼">
		<form class="form">
			<h1>MYPAGE</h1>
			<p>아이디</p>
			<input id="myPageMemid" type="text" value="${loginMember.memid}" readonly="readonly"/><br/>
			<p>비밀번호</p>
			<input id="myPagePwd" type="text" value="${loginMember.pwd}" readonly="readonly"/><br/>
			<p>이 름</p>
			<input id="myPageMname" type="text" value="${loginMember.mname}" readonly="readonly"/><br/>
			<p>전화번호</p>
			<input id="myPagePhone" type="text" value="${loginMember.phone}" readonly="readonly"/><br/>
			<p>이메일</p>
			<input id="myPageEmail" type="text" value="${loginMember.email}" readonly="readonly"/><br/>
			<div class="links">
				<input id="openUpdateForm" type="button" value="정보 수정하기"/><br>
				<input id="openDeleteForm" type="button" value="회원 탈퇴하기"/><br>
			</div>
		</form>
	</div>
	
	<div id="updateMember-form" class="dialog-form" title="회원 정보 수정 폼">
		<form class="form" autocomplete="off">
			<h1>UPDATE</h1>
			<input id="updateMemid" type="hidden" name="memid" value="${loginMember.memid}"/> 
			<input id="updatePwd" class="pwd" type="password" name="pwd" maxlength="20" placeholder="새로운 비밀번호 (기존 : ${loginMember.pwd})"/><br/>
			<input id="updateMname" class="mname" type="text" name="mname" maxlength="20" placeholder="새로운 이름 (기존 : ${loginMember.mname})"/><br/>
			<input id="updatePhone" class="phone" type="tel" name="phone" maxlength="13" placeholder="새로운 전화번호 (기존 : ${loginMember.phone})"/><br/>
			<input id="updateEmail" class="email" type="text" name="email" maxlength="50" placeholder="새로운 이메일 (기존 : ${loginMember.email})"/><br/>
			<input type="button" value="수정하기" onclick="updateMember()"/>
		</form>
	</div>
	
	<div id="deleteMember-form" class="dialog-form" title="회원 탈퇴 폼">
		<form class="form" autocomplete="off">
			<h1>LEAVE</h1>
			<input id="deleteMemid" type="hidden" name="memid" value="${loginMember.memid}"/> 
			<input id="deletePwd" type="password" name="pwd" maxlength="20" placeholder="비밀번호 확인"/><br/>
			<input id="deleteBtn" type="button" value="탈퇴" onclick="deleteMember()"/><br/>
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
	            	loginMemid.val("");
	            	loginPwd.val("");
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
	    			registerMemid.val("");
	    			registerPwd.val("");
	    			registerPwd2.val("");
	    			registerMname.val("");
	    			registerPhone.val("");
	    			registerEmail.val("");
	            }
	        });
	    	
	    	$("#findId-form").dialog({
	            autoOpen: false,
	            height: 650,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	findIdMname.val("");
	            	findIdPhone.val("");
	            }
	        });
	    	
	    	$("#findPwd-form").dialog({
	            autoOpen: false,
	            height: 650,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	findPwdMemid.val("");
	            	findPwdMname.val("");
	            }
	        });
	    	
	    	$("#myPage-form").dialog({
	            autoOpen: false,
	            height: 850,
	            width: 900,
	            modal: true,
	            buttons: {
	            }
	        });
	    	
	    	$("#updateMember-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	updateMemid.val("");
	            	updatePwd.val("");
	            	updateMname.val("");
	            	updatePhone.val("");
	            	updateEmail.val("");
	            }
	        });
	    	
	    	$("#deleteMember-form").dialog({
	            autoOpen: false,
	            height: 450,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	deletePwd.val("");
	            }
	        });
	    });
	    
		$("#openLoginForm").on("click", function() {
			$("#login-form").dialog("open");
		});
		$("#openRegisterForm").on("click", function() {
			$("#register-form").dialog("open");
		});
		$("#loginToRegister").on("click", function() {
			$("#login-form").dialog("close");
			$("#register-form").dialog("open");
		});
		$("#loginToFindId").on("click", function() {
			$("#findId-form").dialog("open");
			$("#login-form").dialog("close");
		});
		$("#loginToFindPwd").on("click", function() {
			$("#findPwd-form").dialog("open");
			$("#login-form").dialog("close");
		});
		$("#findIdToRegister").on("click", function() {
			$("#findId-form").dialog("close");
			$("#register-form").dialog("open");
		});
		$("#findIdToFindPwd").on("click", function() {
			$("#findPwd-form").dialog("open");
			$("#findId-form").dialog("close");
		});
		$("#findPwdToRegister").on("click", function() {
			$("#findPwd-form").dialog("close");
			$("#register-form").dialog("open");
		});
		$("#findPwdToFindId").on("click", function() {
			$("#findId-form").dialog("open");
			$("#findPwd-form").dialog("close");
		});
		$("#openMyPageForm").on("click", function() {
			$("#myPage-form").dialog("open");
		});
		$("#openUpdateForm").on("click", function() {
			$("#myPage-form").dialog("close");
			$("#updateMember-form").dialog("open");
		});
		$("#openDeleteForm").on("click", function() {
			$("#myPage-form").dialog("close");
			$("#deleteMember-form").dialog("open");
		});
		
		var loginMemid = $("#loginMemid"),
			loginPwd = $("#loginPwd"),
			registerMemid = $("#registerMemid"),
			registerPwd = $("#registerPwd"),
			registerPwd2 = $("#registerPwd2"),
			registerMname = $("#registerMname"),
			registerPhone = $("#registerPhone"),
			registerEmail = $("#registerEmail"),
			findIdMname = $("#findIdMname"),
			findIdPhone = $("#findIdPhone"),
			findPwdMemid = $("#findPwdMemid"),
			findPwdMname = $("#findPwdMname"),
			myPageMemid = $("myPageMemid"),
			myPagePwd = $("myPagePwd"),
			myPageMname = $("myPageMname"),
			myPagePhone = $("myPagePhone"),
			myPageEmail = $("myPageEmail"), 
			updateMemid = $("#updateMemid"),
			updatePwd = $("#updatePwd"),
			updateMname = $("#updateMname"),
			updatePhone = $("#updatePhone"),
			updateEmail = $("#updateEmail"),
			deleteMemid = $("#deleteMemid"),
			deletePwd = $("#deletePwd");
		
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
		
		// 중복 아이디 체크
		let existUidChecked = false;
		
		document.querySelector("#idDuplication").addEventListener("click", function() {
			const param = {memid: registerMemid.val()};
			
			if (registerMemid.val() == "" || !memidCheck(registerMemid.val())) {
				alert("아이디는 영문과 숫자의 조합으로 작성해주세요.");
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
		
		// 회원가입
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
		
		// 유효성 검사
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
		function emailCheck(email) {
			var emailForm = /^[a-zA-Z0-9]+@+[a-zA-Z0-9.]+$/;
			return emailForm.test(email);
		}
		
		document.querySelector("#registerMemid").addEventListener("focusout", function() {
			var memidResult = memidCheck(this.value);
			if (!memidResult) {
				this.setCustomValidity("아이디는 영문과 숫자가 각각 최소 1글자씩 포함된 조합만 가능합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelectorAll(".pwd").forEach((target) => target.addEventListener("focusout", function() {
			var pwdResult = pwdCheck(this.value);
			if (!pwdResult) {
				this.setCustomValidity("비밀번호는 영문과 숫자, 특수문자 조합의 최소 8글자여야 합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		}));
		document.querySelector("#registerPwd2").addEventListener("focusout", function() {
			var pwd2Result = pwd2Check(this.value);
			if (!pwd2Result) {
				this.setCustomValidity("입력한 비밀번호와 다릅니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelectorAll(".mname").forEach((target) => target.addEventListener("focusout", function() {
			var mnameResult = mnameCheck(this.value);
			if (!mnameResult) {
				this.setCustomValidity("이름은 한글과 영문만 사용이 가능합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		}));
		document.querySelectorAll(".phone").forEach((target) => target.addEventListener("input", function() {
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
		}));
		document.querySelectorAll(".email").forEach((target) => target.addEventListener("focusout", function() {
			var emailResult = emailCheck(this.value);
			if (!emailResult) {
				this.setCustomValidity("이메일은 영문과 숫자만 사용이 가능합니다. ex) example@example.com");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		}));
		
		// 아이디 찾기
		function findMemid() {
			const param = {
					mname: findIdMname.val(),
					phone: findIdPhone.val()
			}
			
			fetch("<c:url value='/member/findMemid.do'/>", {
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
					findIdMname.focus();
				} else {
					$("#findId-form").dialog("close");
					$("#login-form").dialog("open");	
				}
			});
		}
		
		// 비밀번호 찾기
		function findPwd() {
			const param = {
					memid: findPwdMemid.val(),
					mname: findPwdMname.val()
			}
			
			fetch("<c:url value='/member/findPwd.do'/>", {
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
					findPwdMemid.focus();
				} else {
					$("#findPwd-form").dialog("close");
					$("#login-form").dialog("open");	
				}
			});
		}
		
		// 정보 수정
		function updateMember() {
			const param = {
					memid: updateMemid.val(),
					pwd: updatePwd.val(),
					mname: updateMname.val(),
					phone: updatePhone.val(),
					email: updateEmail.val()
			}
			
			fetch("<c:url value='/member/update.do'/>", {
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
					updatePwd.focus();
				} else {
					$("#updateMember-form").dialog("close");
					
					document.querySelector("#myPageMemid").value = json.memid;
					document.querySelector("#myPagePwd").value = json.pwd;
					document.querySelector("#myPageMname").value = json.mname;
					document.querySelector("#myPagePhone").value = json.phone;
					document.querySelector("#myPageEmail").value = json.email;
					
					$("#myPage-form").dialog("open");	
				}
			});
		}
		
		// 회원탈퇴
		function deleteMember() {
			if (confirm("정말로 탈퇴하시겠습니까 ?")) {
				const param = {
						memid: deleteMemid.val(),
						pwd: deletePwd.val()
				}
				
				fetch("<c:url value='/member/delete.do'/>", {
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
						deletePwd.focus();
					} else {
						location.href="<c:url value='main.do'/>";
					}
				});
			}	
		}
	</script>