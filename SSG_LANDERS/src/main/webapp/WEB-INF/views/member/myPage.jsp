<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 마이페이지</title>
</head> 
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
		<form id="form">
			<h1>MYPAGE</h1>
			<p>아이디</p>
			<input type="text" value="${loginMember.memid}" readonly="readonly"/><br/>
			<p>비밀번호</p>
			<input type="text" value="${loginMember.pwd}" readonly="readonly"/><br/>
			<p>이 름</p>
			<input type="text" value="${loginMember.mname}" readonly="readonly"/><br/>
			<p>전화번호</p>
			<input type="text" value="${loginMember.phone}" readonly="readonly"/><br/>
			<div class="links">
				<input type="button" onclick="location.href='updateForm.do'" value="정보 수정하기"/><br>
				<input id="deleteBtn" type="button" onclick="location.href='deleteForm.do'" value="회원 탈퇴하기"/><br>
				<c:if test="${loginMember.memid == 'admin' }">
					<input id="printBtn" type="button" onclick="location.href='allMemberPrint.do'" value="전체 회원 목록 출력하기"/><br>
				</c:if> 
			</div>
		</form>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer>
	</div>
</body>
</html>