<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	    <div id="listContainer">
 			<a href="<c:url value='/board/listBoardByViewCount.do'/>" id="listByViewCountButton" class="detailBtns">조회순</a>
			<button type="button" id="listWriteButton">글작성</button>
	    	
			<table class="table">
				<caption>ALL BOARD - 최신순</caption>
					<tr id="boardTemp" style="display: none;">
						<td id="boardidTemp"></td>
						<td>
							<a onclick="detailBoard(this.getAttribute('data-boardid'))" href="#" id="title" data-boardid="{boardid}"></a>
						</td>
						<td id="writer_uid"></td>
						<td id="reg_date"></td>
						<td id="view_count"></td>
					</tr> 
					<tr>
						<th width="8%">글번호</th>
	  			   		<th width="50%">글제목</th>
						<th width="20%">작성자</th>
						<th width="15%">작성일자</th>
						<th width="7%">조회</th>
					</tr>
					<tbody id="boardTbody">
						<c:forEach var="board" items="${result.boardList }">
							<tr>
								<td id="boardid">${board.getBoardid() }</td>
								<td id="boardTbodyTitle">
									<span style="padding-left: ${(board.level - 1) * 20}px"></span>
									${board.level != 1 ? "ㄴ " : ""}
									<a onclick="detailBoard(this.getAttribute('data-boardid'))" href="#" data-boardid="${board.boardid}">
										${board.title }
									</a>
								</td>
								<td>${board.getWriter_uid() }</td>
								<td>${board.getReg_date() }</td>
								<td>${board.getView_count() }</td>
							</tr>
						</c:forEach>
					</tbody>
			</table>
			
			<div id="naviDiv">
				<c:if test="${result.board.navStart != 1 }">
					<a href="javascript:goPage(${result.board.navStart - 1 })" class="changePageA">&lt;이전</a> | 
				</c:if>
				<c:forEach var="navNo" begin="${result.board.navStart }" end="${result.board.navEnd }">
					<c:choose>
						<c:when test="${result.board.pageNo == navNo }">
							<a href="javascript:goPage(${navNo })" id="selectedPageNo">${navNo }</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:goPage(${navNo })" id="NoSelectedPageNo">${navNo }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${result.board.navEnd != result.board.totalPageSize }">
					 | <a href="javascript:goPage(${result.board.navEnd + 1 })" class="changePageA">다음&gt;</a>
				</c:if>
				<select id="selectPageLength">
					<option value="10" ${result.board.pageLength == 10 ? 'selected="selected"' : '' }>10개씩</option>
					<option value="20" ${result.board.pageLength == 20 ? 'selected="selected"' : '' }>20개씩</option>
					<option value="50" ${result.board.pageLength == 50 ? 'selected="selected"' : '' }>50개씩</option>
					<option value="100" ${result.board.pageLength == 100 ? 'selected="selected"' : '' }>100개씩</option>
				</select>
				<form id="searchForm" name="searchForm" method="post">
					<div>
						<select id="selectSearchType">
							<option value="title" ${result.board.searchType == 'title' ? 'selected="selected"' : '' }>제목</option>
							<option value="contents" ${result.board.searchType == 'contents' ? 'selected="selected"' : '' }>내용</option>
							<option value="writer_uid" ${result.board.searchType == 'writer_uid' ? 'selected="selected"' : '' }>작성자</option>
						</select>
						<input id="inputSearchText" type="text" value="${result.board.searchText }">
						<input id="searchBtn" type="submit" value="검색">
					</div>
				</form>
			</div>
			
			<form id="pageForm" name="pageForm" action="<c:url value='/board/listBoard.do'/>" method="post">
				<input type="hidden" id="pageNo" name="pageNo" value="${result.board.pageNo }"/>
				<input type="hidden" id="searchType" name="searchType" value="${result.board.searchType }"/>
				<input type="hidden" id="searchText" name="searchText" value="${result.board.searchText }"/>
				<input type="hidden" id="pageLength" name="pageLength" value="${result.board.pageLength }"/>
			</form>
			
			<div id="detail-form" class="dialog-form" title="공지사항 상세보기">
				<div id="detailContainer">
					<div id="detailBoard">
						<input type="hidden" id="detailBoardid" value="">
						<div id="detailTitle">
						    <h1 id="detailTitleText"></h1>
						    <p id="detailWriterText" class="writer"></p>
						    <p id="detailDateText" class="date"></p>
					    </div>
					    <p id="detailContentsText" class="contents"></p>
				  	</div>
		    		<a href="#" onclick="detailBoard(this.getAttribute('data-boardid'))" data-boardid="{boardid}" id="prevlistButton" class="detailBtns">이전글</a>
		    		<a href="#" onclick="detailBoard(this.getAttribute('data-boardid'))" data-boardid="{boardid}" id="nextlistButton" class="detailBtns">다음글</a>
		    		<div id="btnForWriter">
				    	<a id="updateButton" class="detailBtns">수정</a>
				    	<a id="deleteButton" class="detailBtns">삭제</a>
		    		</div>
			  	</div>
			</div>
			
			<div id="write-form" class="dialog-form" title="글 작성 폼">
				<form method="post" autocomplete="off">
					<fieldset>
						<label for="writeTitle">글 제목</label>
						<input type="text" name="writeTitle" id="writeTitle" class="text ui-widget-content ui-corner-all" placeholder="제목을 입력하세요." required>
						<label for="writeContents">글 내용</label>
						<textarea name="writeContents" id="writeContents" class="writeContents" rows="8" placeholder="내용을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
					</fieldset>
				</form>
			</div>
			
			<div id="update-form" class="dialog-form" title="글 수정 폼">
				<form method="post" autocomplete="off">
					<fieldset>
						<label for="updateTitle">글 제목</label>
						<input type="text" name="updateTitle" id="updateTitle" class="text ui-widget-content ui-corner-all" placeholder="제목을 입력하세요." required>
						<label for="updateContents">글 내용</label>
						<textarea name="updateContents" id="updateContents" class="writeContents" rows="8" placeholder="내용을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
					</fieldset>
				</form>
			</div>
			
		</div>
    
    <script>
	    $(document).ready(function() {
	    	$("#write-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 1200,
	            modal: true,
	            buttons: {
	                "작성": writeBoard,
	                "취소": function() {
	                	$("#write-form").dialog("close");
	                }
	            },
	            close: function() {
	            	writeTitle.val("");
	            	writeContents.val("");
	            }
	        });
	    	
	    	$("#detail-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 1200,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	detailTitleText.text("");
	            	detailWriterText.text("");
	            	detailDateText.text("");
	            	detailContentsText.text("");
	            	prevlistButton.css("display", "block");
					nextlistButton.css("display", "block");
	            }
	        });
	    	
	    	$("#update-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 1200,
	            modal: true,
	            buttons: {
	            	"수정": updateBoard,
	                "취소": function() {
	                	$("#update-form").dialog("close");
	                }
	            },
	            close: function() {
	            }
	        });
	    });
	    
        var writeTitle = $("#writeTitle"),
			writeContents = $("#writeContents"),
			detailBoardid = $("#detailBoardid"),
			detailTitleText = $("#detailTitleText"),
			detailWriterText = $("#detailWriterText"),
			detailDateText = $("#detailDateText"),
			detailContentsText = $("#detailContentsText"),
        	prevlistButton = $("#prevlistButton"),
        	nextlistButton = $("#nextlistButton"),
        	btnForWriter = $("#btnForWriter");
	    	updateButton = $("#updateButton"),
	    	deleteButton = $("#deleteButton"),
	    	updateTitle = $("#updateTitle"),
	    	updateContents = $("#updateContents");
		
     	// 다이얼로그 오픈
        $("#listWriteButton").button().on("click", function() {
        	$("#write-form").dialog("open");
        });
        
        updateButton.on("click", function() {
        	const param = {
					boardid: detailBoardid.val(),
					order: "recent"
			}
			
			fetch("<c:url value='/board/getBeforeBoard.do'/>", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param),
			})
			.then((response) => response.json())
			.then((json) => {
				updateTitle.val(json.title);
				updateContents.val(json.contents);
			});
        	
        	$("#update-form").dialog("open");
        });
        
     	// 글 작성
		function writeBoard() {
			const param = {
					title: writeTitle.val(),
					contents: writeContents.val(),
					writer_uid: '${loginMember.memid}'
			}
			
			fetch("<c:url value='/board/writeBoard.do'/>", {
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
					$("#pageNo").val("1");
					$("#pageForm").submit();
				}
			});
		}    
     	
        // 상세보기
	    function detailBoard(boardid) {
			const param = {
					boardid: boardid,
					order: "recent"
			}
			
			fetch("<c:url value='/board/detailBoard.do'/>", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param),
			})
			.then((response) => response.json())
			.then((json) => {
				if (!json.status) {
					alert(json.message);
				} else {
					detailBoardid.val(json.boardid);
					
					detailTitleText.text(json.title);
					
					detailWriterText.text(json.writer_uid);
					detailDateText.text(json.reg_date);
					if (json.reg_date != json.mod_date) detailDateText.append(" (수정시각 : " + json.mod_date + ") ");
					detailDateText.append(" 조회 " + json.view_count);
					detailContentsText.text(json.contents);

		        	prevlistButton.css("display", "block");
					nextlistButton.css("display", "block");
					prevlistButton.attr("data-boardid", json.prevBoardid);
					nextlistButton.attr("data-boardid", json.nextBoardid);
					if (json.first) prevlistButton.css("display", "none");
					if (json.last) nextlistButton.css("display", "none");
					
					btnForWriter.css("display", "block");
					if ("${loginMember.memid}" !=  json.writer_uid) btnForWriter.css("display", "none");
					
					$("#detail-form").dialog("open");
				}
			});
		}
        
        // 수정
        function updateBoard() {
        	const param = {
					boardid: detailBoardid.val(),
					title: updateTitle.val(),
					contents: updateContents.val()
			}
			
			fetch("<c:url value='/board/updateBoard.do'/>", {
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
		        	$("#update-form").dialog("close");
		        	$("#detail-form").dialog("close");
		        	detailBoard(detailBoardid.val());
				}
			});
        }
        
        // 삭제
        deleteButton.on("click", function() {
      		if (confirm("게시물을 삭제하시겠습니까 ?")) {
      			const param = {
    					boardid: detailBoardid.val()
    			}
    			
    			fetch("<c:url value='/board/deleteBoard.do'/>", {
    				method: "POST",
    				headers: {
    				    "Content-Type": "application/json; charset=UTF-8",
    				},
    				body: JSON.stringify(param),
    			})
    			.then((response) => response.json())
    			.then((json) => {
    				alert(json.message);
    				if (json.status) location.href = "<c:url value='/board/listBoard.do'/>";
    			});
      		}
      	});
		
    	// 검색
	    document.querySelector("#searchForm").addEventListener("submit", e => {
	    	e.preventDefault();

			document.querySelector("#searchType").value = document.querySelector("#selectSearchType").value;
	    	document.querySelector("#searchText").value = document.querySelector("#inputSearchText").value;
	    	
    		document.querySelector("#pageNo").value = 1;

    		document.querySelector("#pageForm").submit();
		});
    	
    	// 게시물 건수 변경
    	var selectPageLength = document.querySelector("#selectPageLength");
    	selectPageLength.addEventListener("change", e => {
    		document.querySelector("#pageLength").value = selectPageLength.value;
    		document.querySelector("#pageForm").submit();
    	});
    
    	// 페이지 이동
    	function goPage(pageNo) {
    		document.querySelector("#pageForm > #pageNo").value = pageNo;
    		document.querySelector("#pageForm").submit();
    	}
    	
    </script>
