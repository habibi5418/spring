<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 로그인</title>
</head>
<body>
	<div id="container">
 	    <header>
	    	<c:import url="../main/header.jsp"/>
	    </header>
		<form id="form" method="post" autocomplete="off">
			<h1>LOGIN</h1>
			<input id="memid" type="text" name="memid" maxlength="20" placeholder="아이디" required/><br/>
			<input id="pwd" type="password" name="pwd" maxlength="20" placeholder="비밀번호" required/><br/>
			<input id="submit" type="submit" value="로그인"/><br/>
			<div class="links">
				<a href="registerForm.do">회원가입</a><span>|</span>
				<a href="findMemidForm.do">아이디 찾기</a><span>|</span>
				<a href="findPwdForm.do">비밀번호 찾기</a>
			</div>
		</form>
	    <footer>
	    	<c:import url="../main/footer.jsp"/>
	    </footer>
	</div>
	<script type="text/javascript">
		document.querySelector("#form").addEventListener("submit", e => {
			e.preventDefault();
			const param = {
					memid: memid.value,
					pwd: pwd.value
			}
			
			fetch("login.do", {
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
					memid.focus();
				} else {
					location.href = "<c:url value='/index.html'/>";		
				}
			});
		});
	</script>
</body>
</html>