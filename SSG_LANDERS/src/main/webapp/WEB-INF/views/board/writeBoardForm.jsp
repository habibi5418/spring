<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 작성 페이지</title>
</head>
<body>
  <div id="container">
    <header>
    	<%@ include file="../main/header.jsp" %>
    </header>
    <div id="writeContainer">
    	<a href="listBoard.do" id="listButton" class="detailBtns">취소</a>
		<div id="detailBoard">
			<h1>글 작성</h1>
		    <form method="post" autocomplete="off">
		        <input type="text" id="title" name="title" placeholder="제목을 입력하세요." required>
		        <textarea id="contents" name="contents" rows="8" placeholder="내용을 입력하세요." required></textarea>
		        <input type="button" value="작성" onclick="writeBoard()">
		    </form>
		</div>
  	</div>
    <footer>
    	<%@ include file="../main/footer.jsp" %>
    </footer>
  </div>
	<script type="text/javascript">
		function writeBoard() {
			const param = {
					title: title.value,
					contents: contents.value,
					writer_uid: '${loginMember.memid}'
			}
			
			fetch("writeBoard.do", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param),
			})
			.then((response) => response.json())
			.then((json) => {
				alert(json.message);
				if (json.status) location.href = "listBoard.do";
			});
		}
	</script>
</body>
</html>