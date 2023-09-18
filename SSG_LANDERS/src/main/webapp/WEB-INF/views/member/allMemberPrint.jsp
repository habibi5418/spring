<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
<title>SSG LANDERS : 전체 회원 목록 출력</title>
</head> 
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
		<table class="table">
			<caption>ALL MEMBER</caption>
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>전화번호</th>
			</tr>
			<c:forEach var="member" items="${memberList }">
				<tr><td>${member.memid }</td><td>${member.pwd }</td><td>${member.mname }</td><td>${member.phone }</td></tr>
			</c:forEach>
		</table>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer> 
    </div>
</body>
</html>