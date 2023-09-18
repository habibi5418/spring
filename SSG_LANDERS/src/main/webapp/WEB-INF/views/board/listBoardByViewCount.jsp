<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 목록 - 조회순</title>
</head>
<body>
	<div id="container">
	    <header>
	    	<%@ include file="../main/header.jsp" %>
	    </header>
	    <div id="listContainer">
 			<a href="listBoard.do" id="listByRecentButton" class="detailBtns">최신순</a>
	    	<c:if test="${loginMember != null && loginMember.isAdmin('admin') }">
   				<a href="writeBoardForm.do" id="listWriteButton" class="detailBtns">글작성</a>
   				<a id="listDeleteButton" class="detailBtns">삭제</a>
	    	</c:if>
			<table class="table">
				<caption>ALL BOARD - 조회순</caption>
				<c:choose>
					<c:when test="${loginMember != null && loginMember.isAdmin('admin') }">
						<tr>
							<th width="5%"><input id="allCheck" type="checkbox"></th>
							<th width="8%">글번호</th>
							<th width="45%">글제목</th>
							<th width="20%">작성자</th>
							<th width="15%">작성일자</th>
							<th width="7%">조회</th>
						</tr>
						<c:forEach var="board" items="${boardList }">
							<tr>
								<td><input type='checkbox' name='checkBoard' value='${board.getBoardid() }'></td>
								<td>${board.getBoardid() }</td>
								<td><a href='detailBoard.do?boardid=${board.getBoardid() }&order=view'>${board.title }</a></td>
								<td>${board.getWriter_uid() }</td>
								<td>${board.getReg_date() }</td>
								<td>${board.getView_count() }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th width="8%">글번호</th>
		  			   		<th width="50%">글제목</th>
							<th width="20%">작성자</th>
							<th width="15%">작성일자</th>
							<th width="7%">조회</th>
						</tr>
						<c:forEach var="board" items="${boardList }">
							<tr>
								<td>${board.getBoardid() }</td>
								<td><a href='detailBoard.do?boardid=${board.getBoardid() }&order=view'>${board.title }</a></td>
								<td>${board.getWriter_uid() }</td>
								<td>${board.getReg_date() }</td>
								<td>${board.getView_count() }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	    <footer>
	    	<%@ include file="../main/footer.jsp" %>
	    </footer>
    </div>
    <script type="text/javascript">
    	document.querySelector("#allCheck").addEventListener("click", function() {
    		var checks = document.querySelectorAll("input[type='checkbox']");
    		checks.forEach(checkbox => {
    			checkbox.checked = this.checked;
    		});
    	});
    	
    	document.querySelector("#listDeleteButton").addEventListener("click", function() {
      		if (confirm("선택한 게시물들을 삭제하시겠습니까 ?")) {
        		var deleteBoards = "";
        		var checks2 = document.getElementsByName("checkBoard");
        		
        		checks2.forEach(checkbox => {
        			if (checkbox.checked) deleteBoards += checkbox.value + ",";
        		});
        		
        		if (deleteBoards == "") {
        			alert("삭제할 게시물을 체크해주세요.");
        		} else {
            		deleteBoards = deleteBoards.substr(0, deleteBoards.length - 1);
            		
            		const param = {
            				deleteBoards: deleteBoards
        			}
            		
            		fetch("deleteBoards.do?deleteBoards=" + deleteBoards + "&order=recent", {
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
        					location.href="listBoardByViewCount.do";
        				}
        			});
        		}
      		} 
      	});
    </script>
</body>
</html>