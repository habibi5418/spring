<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 정보 수정하기</title>
</head>
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
		<form id="form" method="post" autocomplete="off">
			<h1>UPDATE</h1>
			<input id="memid" type="hidden" name="memid" value="${loginMember.memid}"/> 
			<input id="pwd" type="password" name="pwd" maxlength="20" placeholder="새로운 비밀번호 (기존 : ${loginMember.pwd})"/><br/>
			<input id="mname" type="text" name="mname" maxlength="20" placeholder="새로운 이름 (기존 : ${loginMember.mname})"/><br/>
			<input id="phone" type="tel" name="phone" maxlength="13" placeholder="새로운 전화번호 (기존 : ${loginMember.phone})"/><br/>
			<input type="button" value="수정하기" onclick="update()"/>
		</form>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer>
	</div>
	<script type="text/javascript">
		function update() {
			const param = {
					memid: memid.value,
					pwd: pwd.value,
					mname: mname.value,
					phone: phone.value
			};
			
			fetch("update.do", {
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
					location.href = "myPage.do";			
				}
			});
		}
	
		function pwdCheck(pwd) {
			var pwdForm = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~!@#$%^&*])[a-zA-Z\d~!@#$%^&*]{8,20}$/;
			return pwdForm.test(pwd);
		}
		function mnameCheck(mname) {
			var mnameForm = /^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+$/;
			return mnameForm.test(mname);
		}
		
		document.querySelector("#pwd").addEventListener("input", function() {
			var pwdResult = pwdCheck(this.value);
			if (!pwdResult) {
				this.setCustomValidity("비밀번호는 영문과 숫자, 특수문자 조합의 최소 8글자여야 합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#mname").addEventListener("input", function() {
			var mnameResult = mnameCheck(this.value);
			if (!mnameResult) {
				this.setCustomValidity("이름은 한글과 영문만 사용이 가능합니다.");
				this.reportValidity();
			} else {
				this.setCustomValidity("");
				this.reportValidity();
			}
		});
		document.querySelector("#phone").addEventListener("input", function() {
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
</body>
</html>