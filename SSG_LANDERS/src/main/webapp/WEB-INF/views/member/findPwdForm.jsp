<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 비밀번호 찾기</title>
  <link rel="stylesheet" href="css/style-index.css?ver=4131121">
</head>
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
		<form id="form" method="post" autocomplete="off">
			<h1>FIND PASSWORD</h1>
			<input id="memid" type="text" name="memid" maxlength="20" placeholder="아이디" required="required"/><br/>
			<input id="mname" type="text" name="mname" maxlength="20" placeholder="이름" required="required"/><br/>
			<input type="button" value="비밀번호 찾기" onclick="findPwd()"/><br/>
			<div class="links">
				<a href="registerForm.do">회원가입</a><span>|</span>
				<a href="findMemidForm.do">아이디 찾기</a>
			</div>
		</form>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer> 
	</div>
	<script type="text/javascript">
		function findPwd() {
			const param = {
					memid: memid.value,
					mname: mname.value
			}
			
			fetch("findPwd.do", {
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
					location.href = "loginForm.do";		
				}
			});
		}
	</script>
</body>
</html>