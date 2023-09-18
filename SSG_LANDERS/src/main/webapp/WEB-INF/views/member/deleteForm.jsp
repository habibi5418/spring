<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 회원 탈퇴</title>
</head>
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
		<form id="form" method="post" autocomplete="off">
			<h1>LEAVE</h1>
			<input id="memid" type="hidden" name="memid" value="${loginMember.memid}"/> 
			<input id="pwd" type="password" name="pwd" maxlength="20" placeholder="비밀번호 확인"/><br/>
			<input id="deleteBtn" type="button" value="탈퇴"/><br/>
			<input type="button" onclick="location.href='myPage.do'" value="취소"/><br>
		</form>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer> 
	</div>
	<script type="text/javascript">
		document.querySelector("#deleteBtn").addEventListener("click", function() {
			var yesNo = confirm("정말로 탈퇴하시겠습니까 ?");
			
			if (yesNo) {
				const param = {
						memid: memid.value,
						pwd: pwd.value
				};
				
				fetch("delete.do", {
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
						location.href = "<c:url value='/index.html'/>";			
					}
				});
			} 
		});
	</script>
</body>
</html>