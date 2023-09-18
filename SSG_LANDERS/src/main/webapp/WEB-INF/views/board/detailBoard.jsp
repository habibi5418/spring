<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">	
<title>자유게시판 상세페이지 - ${board.title }</title>
<script type="text/javascript">
	if (${!status}) {
		alert('${message}');
		if (${order == "recent"}) location.href="listBoard.do";
		else if (${order == "view"}) location.href="listBoardByViewCount.do";
	}
</script>
</head>
<body>
  <div id="container">
    <header>
    	<%@ include file="../main/header.jsp" %>
    </header>
    <div id="detailContainer">
    	<c:if test="${order == 'recent' }">
    		<a href="listBoard.do" id="listButton" class="detailBtns">목록</a>
    	</c:if>
    	<c:if test="${order == 'view' }">
    		<a href="listBoardByViewCount.do" id="listButton" class="detailBtns">목록</a>
    	</c:if>
		<div id="detailBoard">
			<div id="detailTitle">
			    <h1>
			    	${board.title }
			    </h1>
			    <p class="writer">${board.writer_uid }</p>
			    <p class="date">${board.reg_date } 
			    <c:if test="${board.doMod() }">
			    	(수정시각 : ${board.mod_date }) 
			    </c:if>
			    	조회 ${board.view_count }
			    </p>
		    </div>
		    <p class="contents">${board.contents }</p>
	  	</div>
	  	<c:if test="${!first }">
    		<a href="detailBoard.do?boardid=${prevBoardid }&order=${order }" id="prevlistButton" class="detailBtns">이전글</a>
	  	</c:if>
	  	<c:if test="${!last }">
    		<a href="detailBoard.do?boardid=${nextBoardid }&order=${order }" id="nextlistButton" class="detailBtns">다음글</a>
	  	</c:if>
	  	<c:if test="${loginMember != null && loginMember.memid == 'admin' }">
	    	<a href="updateBoardForm.do?boardid=${board.boardid }&order=${order }" id="updateButton" class="detailBtns">수정</a>
	    	<a id="deleteButton" class="detailBtns">삭제</a>
	    </c:if>
  	</div>
    <footer>
    	<%@ include file="../main/footer.jsp" %>
    </footer>
  </div>
  <script type="text/javascript">
  	document.querySelector("#deleteButton").addEventListener("click", function() {
  		if (confirm("게시물을 삭제하시겠습니까 ?")) {
  			const param = {
					boardid: '${board.boardid}'
			}
			
			fetch("deleteBoard.do?order=${order}", {
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
					if (json.order == "recent") location.href="listBoard.do";
					else if (json.order = "view") location.href="listBoardByViewCount.do";
				}
			});
  		}
  	});
  </script>
</body>
</html>