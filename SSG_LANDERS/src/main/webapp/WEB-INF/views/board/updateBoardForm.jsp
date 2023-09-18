<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 수정 페이지</title>
</head>
<body>
  <div id="container">
    <header>
    	<%@ include file="../main/header.jsp" %>
    </header>
    <div id="writeContainer">
    	<a href="detailBoard.do?boardid=${board.getBoardid() }&order=${order }" id="listButton" class="detailBtns">취소</a>
		<div id="detailBoard">
			<h1>글 수정</h1>
		    <form method="post" autocomplete="off">
		    	<input id="boardid" type="hidden" name="boardid" value="${board.getBoardid() }">
		        <input type="text" id="title" name="title" value="${board.getTitle() }" placeholder="제목을 입력하세요." required>
		        <textarea id="contents" name="contents" rows="8" placeholder="내용을 입력하세요." required>${board.getContents() }</textarea>
		        <input type="button" value="수정" onclick="updateBoard()">
		    </form>
		</div>
  	</div>
    <footer>
    	<%@ include file="../main/footer.jsp" %>
    </footer>
  </div>
	<script type="text/javascript">
		function updateBoard() {
			const param = {
					boardid: boardid.value,
					title: title.value,
					contents: contents.value
			}
			
			fetch("updateBoard.do?order=${order}", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param),
			})
			.then((response) => response.json())
			.then((json) => {
				alert(json.message);
				if (json.status) location.href = json.location;
			});
		}
	</script>
</body>
</html>