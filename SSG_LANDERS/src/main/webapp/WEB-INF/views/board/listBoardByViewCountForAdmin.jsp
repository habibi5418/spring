<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	    <div id="listContainer">
 			<a href="<c:url value='/board/listBoardForAdmin.do'/>" id="listByRecentButton" class="detailBtns">최신순</a>
	    	<c:if test="${loginMember != null}">
				<button type="button" id="listWriteButton">글작성</button>
 			</c:if>
			<a id="listDeleteButton" class="detailBtns">삭제</a>
	    	
			<table class="table">
				<caption>ALL NOTICE - 조회순</caption>
					<tr id="boardTemp" style="display: none;">
						<td><input type='checkbox' id="checkBoardidTemp" class="checkBoard" value=""></td>
						<td id="boardidTemp"></td>
						<td id="titleTd">
							<a onclick="detailBoard(this.getAttribute('data-boardid'))" href="#" id="title" data-boardid="{boardid}"></a>
						</td>
						<td id="writer_uid"></td>
						<td id="reg_date"></td>
						<td id="view_count"></td>
					</tr> 
					<tr>
						<th width="5%"><input id="allCheck" type="checkbox"></th>
						<th width="8%">글번호</th>
	  			   		<th width="45%">글제목</th>
						<th width="20%">작성자</th>
						<th width="15%">작성일자</th>
						<th width="7%">조회</th>
					</tr>
					<tbody id="boardTbody">
						<c:forEach var="board" items="${result.boardList }">
							<tr>
							<td><input type='checkbox' class="checkBoard" value='${board.getBoardid() }'></td>
								<td id="boardid">${board.getBoardid() }</td>
								<td id="boardTbodyTitle">
									<span style="padding-left: ${(board.level - 1) * 20}px"></span>
									${board.level != 1 ? "ㄴ " : ""}
									<a onclick="detailBoard(this.getAttribute('data-boardid'))" href="#" data-boardid="${board.boardid}">
										${board.title }
									</a>
									<c:if test="${board.existFile == 'Y'}">
										<img src="<c:url value='/resources/images/clip.png'/>" style="width: 15px; height: 15px; padding-top: 2px;">
									</c:if>
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
			
			<form id="pageForm" name="pageForm" action="<c:url value='/board/listBoardByViewCountForAdmin.do'/>" method="post">
				<input type="hidden" id="pageNo" name="pageNo" value="${result.board.pageNo }"/>
				<input type="hidden" id="searchType" name="searchType" value="${result.board.searchType }"/>
				<input type="hidden" id="searchText" name="searchText" value="${result.board.searchText }"/>
				<input type="hidden" id="pageLength" name="pageLength" value="${result.board.pageLength }"/>
			</form>
			
			<div id="detail-form" class="dialog-form" title="게시물 상세보기">
				<div id="detailContainer">
					<div id="detailBoard">
						<input type="hidden" id="detailBoardid" value="">
						<div id="detailTitle">
						    <h1 id="detailTitleText"></h1>
						    <p id="detailWriterText" class="writer"></p>
						    <p id="detailDateText" class="date"></p>
					    </div>
					    <p id="detailContentsText" class="contents"></p>
				        <div id="detailFiles" style="margin:30px auto; text-align: center;">
				        </div>
			    		<div id="commentForm">
					    	<hr>
			    			<label id="commentLabel" for="commentContents">댓글</label>
			    			<div id="commentList"></div>
							<div id="moreCommentDiv">
								<a href="#" id="moreCommentList">더보기</a>
							</div>
							<textarea name="commentContents" id="commentContents" class="commentContents" rows="8" placeholder="댓글을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
							<input id="writeComment" type="button" onclick="writeComment()" value="댓글 등록" />
						</div>
				  	</div>
				  	<c:if test="${loginMember != null}">
			    		<a id="replyButton" class="detailBtns">답글</a>
			    	</c:if>
		    		<a href="#" onclick="detailBoard(this.getAttribute('data-boardid'))" data-boardid="{boardid}" id="prevlistButton" class="detailBtns">이전글</a>
		    		<a href="#" onclick="detailBoard(this.getAttribute('data-boardid'))" data-boardid="{boardid}" id="nextlistButton" class="detailBtns">다음글</a>
		    		<div id="btnForWriter">
				    	<a id="updateButton" class="detailBtns">수정</a>
				    	<a id="deleteButton" class="detailBtns">삭제</a>
		    		</div>
			  	</div>
			</div>
			
			<div id="write-form" class="dialog-form" title="글 작성 폼">
				<form id="wForm" autocomplete="off" enctype="multipart/form-data">
					<fieldset>
						<input type="hidden" name="writer_uid" value="${loginMember.memid }" />
						<label for="writeTitle">글 제목</label>
						<input type="text" name="title" id="writeTitle" class="text ui-widget-content ui-corner-all" placeholder="제목을 입력하세요." required>
						<label for="writeContents">글 내용</label>
						<textarea name="contents" id="writeContents" class="writeContents" rows="8" placeholder="내용을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
					</fieldset>
					<input type="button" value="파일 추가" class="detailBtns" onClick="w_addFile()"/><br>
					<div id="w_file"></div>
				</form>
			</div>
			
			<div id="update-form" class="dialog-form" title="글 수정 폼">
				<form id="uForm" method="post" autocomplete="off">
					<fieldset>
						<input type="hidden" id="updateBoardid" name="boardid" value="" />
						<input type="hidden" name="writer_uid" value="${loginMember.memid }" />
						<label for="updateTitle">글 제목</label>
						<input type="text" name="title" id="updateTitle" class="text ui-widget-content ui-corner-all" placeholder="제목을 입력하세요." required>
						<label for="updateContents">글 내용</label>
						<textarea name="contents" id="updateContents" class="writeContents" rows="8" placeholder="내용을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
					</fieldset>
					<input type="button" value="파일 추가" onClick="u_addFile()"/><br>
					<div id="u_file"></div>
				</form>
			</div>
			
			<div id="reply-form" class="dialog-form" title="답글 작성 폼">
				<form id="rForm" method="post" autocomplete="off">
					<fieldset>
						<input type="hidden" id="replyPid" name="pid" value="" />
						<input type="hidden" name="writer_uid" value="${loginMember.memid }" />
						<label for="replyTitle">글 제목</label>
						<input type="text" name="title" id="replyTitle" class="text ui-widget-content ui-corner-all" placeholder="제목을 입력하세요." required>
						<label for="replyContents">글 내용</label>
						<textarea name="contents" id="replyContents" class="writeContents" rows="8" placeholder="내용을 입력하세요." required class="text ui-widget-content ui-corner-all"></textarea>
					</fieldset>
					<input type="button" value="파일 추가" onClick="r_addFile()"/><br>
					<div id="r_file"></div>
				</form>
			</div>
			
			<div id="lightbox">
				<img src="" alt="" id="lightboxImage">
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
	            	w_cnt = 1;
	            }
	        });
	    	
	    	$("#detail-form").dialog({
	            autoOpen: false,
	            height: 900,
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
					commentList.text("");
					commentContents.val("");
					cnt = 1;
					isOpenCommentUpdate = false;
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
	            	u_cnt = 1;
	            }
	        });
	    	
	    	$("#reply-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 1200,
	            modal: true,
	            buttons: {
	                "작성": replyBoard,
	                "취소": function() {
		            	replyTitle.val("");
		            	replyContents.val("");
	                	$("#reply-form").dialog("close");
	                }
	            },
	            close: function() {
	            	replyTitle.val("");
	            	replyContents.val("");
	            	r_cnt = 1;
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
	    	updateBoardid = $("#updateBoardid"),
	    	updateTitle = $("#updateTitle"),
	    	updateContents = $("#updateContents"),
	    	replyTitle = $("#replyTitle"),
			replyContents = $("#replyContents"),
			commentContents = $("#commentContents"),
			commentList = $("#commentList");
		
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
				updateBoardid.val(detailBoardid.val());
				updateTitle.val(json.title);
				updateContents.val(json.contents);
			});
	    	
	    	$("#update-form").dialog("open");
	    });
	    
	    $("#replyButton").on("click", function() {
	    	$("#replyPid").val(detailBoardid.val());
	    	$("#reply-form").dialog("open");
	    });
	    
		// 글 작성 첨부파일 추가
	    var w_cnt = 1;
	    function w_addFile(){
	    	$("#w_file").append("<input type='file' name='file" + w_cnt + "' />");
	    	w_cnt++;
	    }
	    
		// 글 수정 첨부파일 추가
	    var u_cnt = 1;
	    function u_addFile(){
	    	$("#u_file").append("<input type='file' name='file" + u_cnt + "' />");
	    	u_cnt++;
	    }
	    
		// 답글 첨부파일 추가
	    var r_cnt = 1;
	    function r_addFile(){
	    	$("#r_file").append("<input type='file' name='file" + r_cnt + "' />");
	    	r_cnt++;
	    }
	    
	 	// 글 작성
		function writeBoard() {
			const form = $("#wForm")[0];
			const formData = new FormData(form);
			
			fetch("<c:url value='/board/writeBoard.do'/>", {
				method: "POST",
				headers: {},
				body: formData,
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
					
					// 첨부파일 
	   				const attachFileList = json.attachFileList;
	   				const detailFiles = $("#detailFiles");
	   				detailFiles.empty();
	   				
	   				for (let i = 0; i < attachFileList.length; i++) {
							const file = attachFileList[i];
							const path = "<c:url value='/attachFile/download.do?fileNo='/>" + file.fileNo;
							const fileImgPath = "<c:url value='/resources/images/file.png'/>";
						const fileType = file.contentType.split("/")[0];
							var existImg = false;
							
							if (fileType == "image") {
	   						detailFiles.append(
	   								"<img src='" + path + "' style='width: 800px; height: auto; margin: 30px auto;'"
	   									+ " class='pic'><br/>"
	//	   								"<a href='" + path + "' download><img src='" + path 
	//	   									+ "' style='width: 800px; height: auto; margin: 30px auto;'"
	//	   									+ "></a><br/>"
							);
	   						
							existImg = true;
							} else {
	   						detailFiles.append(
	   								"<a href='" + path + "' download>"
	   									+ "<img src='" + fileImgPath + "' style='width: 30px; height: 30px;'><h3>" 
	   									+ file.fileNameOrg + "</h3></a><br/>"
							);
							}
	   				}
	
	   				// 라이트박스
						var lightbox = document.getElementById("lightbox");  
						var lightboxImage = document.getElementById("lightboxImage");  
						var closeBeforeBoardid;
						
					if (existImg) {
						var pics = document.getElementsByClassName("pic");
	
	  					for (var j = 0; j < pics.length; j++) {
	  						pics[j].addEventListener("click", function() {
	  							var bigLocation = this.getAttribute("src"); 
	      						lightboxImage.setAttribute("src", bigLocation); 
	      						lightbox.style.display = "block"; 
	      						if (lightboxImage.width < lightboxImage.height) {
	      							lightboxImage.style.height = 100 + "%";
	      						} else {
	      							lightboxImage.style.height = 75 + "%";
	      						}
	      						closeBeforeBoardid = detailBoardid.val();
	      						$("#detail-form").dialog("close");
	  						});
	  					}
					}
					
						lightbox.onclick = function() {  //click 이벤트가 발생했을 때 실행할 함수 선언
							lightbox.style.display = "none";  // lightbox 요소를 화면에서 감춤
							detailBoard(closeBeforeBoardid);
						}
	  					
					// 댓글 불러오기 
					const param2 = {
						replyid: 0,
	   	    			boardid: detailBoardid.val()
	   	    		}
	   	    		
	   	    		fetch("<c:url value='/board/getCommentBoard.do'/>", {
	   					method: "POST",
	   					headers: {
	   					    "Content-Type": "application/json; charset=UTF-8",
	   					},
	   					body: JSON.stringify(param2),
	   				})
	   				.then((response) => response.json())
	   				.then((json) => {
	   					const commentList = json.commentList;
	   					const commentListHTML = document.querySelector("#commentList");
	   					const moreCommentDiv = $("#moreCommentDiv");
	   					
	   					commentListHTML.innerHTML = "";
	   					
	   					for (let i = 0; i < commentList.length; i++) {
	   						const comment = commentList[i];
	   						
	   						let createDivTag = document.createElement('div');
	   						let createCommentReplyid = document.createElement('input');
	   						let createCommentWriter = document.createElement('h3');
	   						let createCommentContents = document.createElement('p');
	   						let createCommentRegDate = document.createElement('p');
	   						
	   						createDivTag.setAttribute("id", "commentDiv");
	
	   						createCommentReplyid.setAttribute("id", "commentReplyid");
	   						createCommentReplyid.setAttribute("type", "hidden");
	   						createCommentReplyid.setAttribute("value", comment.replyid);
	   						
	   						createCommentWriter.setAttribute("id", "commentWriter");
	   						createCommentWriter.innerHTML = comment.writer_uid;
	   						
	   						createCommentContents.setAttribute("id", "commentContents");
	   						createCommentContents.innerHTML = comment.contents;
	   						
	   						createCommentRegDate.setAttribute("id", "commentRegDate");
	  						createCommentRegDate.innerHTML = comment.reg_date;
	   						
	   						createDivTag.appendChild(createCommentReplyid);
	   						createDivTag.appendChild(createCommentWriter);
	   						createDivTag.appendChild(createCommentContents);
	   						createDivTag.appendChild(createCommentRegDate);
	
	   						if ("${loginMember.memid}" == comment.writer_uid) {
	   	   						let createCommentUpdateBtn = document.createElement('a');
	   	   						let createCommentDeleteBtn = document.createElement('a');
	   	   						createCommentUpdateBtn.setAttribute("id", "commentUpdateBtn");
	   	   						createCommentDeleteBtn.setAttribute("id", "commentDeleteBtn");
	   	   						createCommentUpdateBtn.href = "#";
	   	   						createCommentDeleteBtn.href = "#";
	   	   						createCommentUpdateBtn.setAttribute("onclick", "commentUpdate(this)");
	   	   						createCommentDeleteBtn.setAttribute("onclick", "commentDelete(" + comment.replyid + ")");
	   	   						createCommentUpdateBtn.innerText = "댓글 수정";
	   	   						createCommentDeleteBtn.innerText = "댓글 삭제";
	   	   						createDivTag.appendChild(createCommentUpdateBtn);
	   	   						createDivTag.appendChild(createCommentDeleteBtn);
	   						}	
	   						
	   						commentListHTML.append(createDivTag);
	   					}
							
							moreCommentDiv.css("display", "none");
							if (json.cnt == 10) moreCommentDiv.css("display", "block");
							
	   				});
					
					$("#detail-form").dialog("open");
				}
			});
		}
	    
	    // 수정
	    function updateBoard() {
			const form = $("#uForm")[0];
			const formData = new FormData(form);
	
			fetch("<c:url value='/board/updateBoard.do'/>", {
				method: "POST",
				headers: {},
				body: formData,
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
					if (json.status) location.href = "<c:url value='/board/listBoardByViewCountForAdmin.do'/>";
				});
	  		}
	  	});
	    
	 	// 답글 작성
		function replyBoard() {
			const form = $("#rForm")[0];
			const formData = new FormData(form);
			
			fetch("<c:url value='/board/replyBoard.do'/>", {
				method: "POST",
				headers: {},
				body: formData,
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
		
	 	// 댓글 작성
	 	function writeComment() {
	 		const param = {
					contents: commentContents.val(),
					writer_uid: '${loginMember.memid}',
					boardid: detailBoardid.val()
			}
			
			fetch("<c:url value='/board/commentBoard.do'/>", {
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
					commentContents.val("");
					
					const param2 = {
	   	    			boardid: detailBoardid.val()
	   	    		}
	   	    		
	   	    		fetch("<c:url value='/board/getWriteComment.do'/>", {
	   					method: "POST",
	   					headers: {
	   					    "Content-Type": "application/json; charset=UTF-8",
	   					},
	   					body: JSON.stringify(param2),
	   				})
	   				.then((response) => response.json())
	   				.then((json) => {
	   					const commentList = json.commentList;
	   					const commentListHTML = document.querySelector("#commentList");
	   					const moreCommentDiv = $("#moreCommentDiv");
	   					const lastComment = document.querySelector("#commentList > div:last-child");
	   					
	   					for (let i = 0; i < commentList.length; i++) {
	   						const comment = commentList[i];
	   						
	   						let createDivTag = document.createElement('div');
	   						let createCommentReplyid = document.createElement('input');
	   						let createCommentWriter = document.createElement('h3');
	   						let createCommentContents = document.createElement('p');
	   						let createCommentRegDate = document.createElement('p');
	   						
	   						createDivTag.setAttribute("id", "commentDiv");
	
	   						createCommentReplyid.setAttribute("id", "commentReplyid");
	   						createCommentReplyid.setAttribute("type", "hidden");
	   						createCommentReplyid.setAttribute("value", comment.replyid);
	   						       						
	   						createCommentWriter.setAttribute("id", "commentWriter");
	   						createCommentWriter.innerHTML = comment.writer_uid;
	   						
	   						createCommentContents.setAttribute("id", "commentContents");
	   						createCommentContents.innerHTML = comment.contents;
	   						
	   						createCommentRegDate.setAttribute("id", "commentRegDate");
	   						createCommentRegDate.innerHTML = comment.reg_date;
	
	   						createDivTag.appendChild(createCommentReplyid);
	   						createDivTag.appendChild(createCommentWriter);
	   						createDivTag.appendChild(createCommentContents);
	   						createDivTag.appendChild(createCommentRegDate);
	
		   						let createCommentUpdateBtn = document.createElement('a');
		   						let createCommentDeleteBtn = document.createElement('a');
		   						createCommentUpdateBtn.setAttribute("id", "commentUpdateBtn");
		   						createCommentDeleteBtn.setAttribute("id", "commentDeleteBtn");
		   						createCommentUpdateBtn.href = "#";
		   						createCommentDeleteBtn.href = "#";
		   						createCommentUpdateBtn.setAttribute("onclick", "commentUpdate(this)");
		   						createCommentDeleteBtn.setAttribute("onclick", "commentDelete(" + comment.replyid + ")");
		   						createCommentUpdateBtn.innerText = "댓글 수정";
		   						createCommentDeleteBtn.innerText = "댓글 삭제";
		   						createDivTag.appendChild(createCommentUpdateBtn);
		   						createDivTag.appendChild(createCommentDeleteBtn);
	   						
	   						commentListHTML.prepend(createDivTag);
	   					}
	   				});
				}
			});
	 	}    
		
	 	// 댓글 더보기
	 	document.querySelector("#moreCommentList").addEventListener("click", function() {
			const lastReplyid = document.querySelector("#commentList > div:last-child > input:first-child").value;
			
			const param2 = {
				replyid: lastReplyid,
				boardid: detailBoardid.val()
			}
	   	    		
	   		fetch("<c:url value='/board/getCommentBoard.do'/>", {
				method: "POST",
				headers: {
				    "Content-Type": "application/json; charset=UTF-8",
				},
				body: JSON.stringify(param2),
			})
			.then((response) => response.json())
			.then((json) => {
				const commentList = json.commentList;
				const commentListHTML = document.querySelector("#commentList");
				const moreCommentDiv = $("#moreCommentDiv");
				
				for (let i = 0; i < commentList.length; i++) {
					const comment = commentList[i];
					
					let createDivTag = document.createElement('div');
					let createCommentReplyid = document.createElement('input');
					let createCommentWriter = document.createElement('h3');
					let createCommentContents = document.createElement('p');
					let createCommentRegDate = document.createElement('p');
					
					createDivTag.setAttribute("id", "commentDiv");
	
					createCommentReplyid.setAttribute("id", "commentReplyid");
					createCommentReplyid.setAttribute("type", "hidden");
					createCommentReplyid.setAttribute("value", comment.replyid);
					
					createCommentWriter.setAttribute("id", "commentWriter");
					createCommentWriter.innerHTML = comment.writer_uid;
					
					createCommentContents.setAttribute("id", "commentContents");
					createCommentContents.innerHTML = comment.contents;
					
					createCommentRegDate.setAttribute("id", "commentRegDate");
					createCommentRegDate.innerHTML = comment.reg_date;
					
					createDivTag.appendChild(createCommentReplyid);
					createDivTag.appendChild(createCommentWriter);
					createDivTag.appendChild(createCommentContents);
					createDivTag.appendChild(createCommentRegDate);
					
					if ("${loginMember.memid}" == comment.writer_uid) {
							let createCommentUpdateBtn = document.createElement('a');
							let createCommentDeleteBtn = document.createElement('a');
							createCommentUpdateBtn.setAttribute("id", "commentUpdateBtn");
							createCommentDeleteBtn.setAttribute("id", "commentDeleteBtn");
							createCommentUpdateBtn.href = "#";
							createCommentDeleteBtn.href = "#";
							createCommentUpdateBtn.setAttribute("onclick", "commentUpdate(this)");
							createCommentDeleteBtn.setAttribute("onclick", "commentDelete(" + comment.replyid + ")");
							createCommentUpdateBtn.innerText = "댓글 수정";
							createCommentDeleteBtn.innerText = "댓글 삭제";
							createDivTag.appendChild(createCommentUpdateBtn);
							createDivTag.appendChild(createCommentDeleteBtn);
					}	
						
					commentListHTML.append(createDivTag);
					
					moreCommentDiv.css("display", "block");
					if (json.cnt != 10) moreCommentDiv.css("display", "none");
				}
				
				if (!json.check) moreCommentDiv.css("display", "none");
				
			});
	 	});
	 	
	 	// 댓글 수정창 오픈
	 	function commentUpdate(updateBtn) {
	     		let commentDiv = updateBtn.parentNode;
	     		console.log(commentDiv);
	     		if (commentDiv.getAttribute("data-isOpen") == null || commentDiv.getAttribute("data-isOpen") == "no") {
	     			commentDiv.setAttribute("data-isOpen", true);
	     			
					let createCommentUpdateArea = document.createElement("textarea");
					let createCommentUpdateInput = document.createElement("input");
					
					createCommentUpdateArea.setAttribute("id", "updateCommentContents");
					createCommentUpdateArea.setAttribute("placeholder", "수정할 댓글 내용으로 적어주세요.");
					
					createCommentUpdateInput.setAttribute("id", "updateComment");
					createCommentUpdateInput.setAttribute("class", "detailBtns");
					createCommentUpdateInput.setAttribute("type", "button");
					createCommentUpdateInput.setAttribute("onclick", "updateComment(" + commentDiv.firstChild.value + ",this)");
					createCommentUpdateInput.setAttribute("value", "댓글 수정");
					
					commentDiv.append(createCommentUpdateArea);
					commentDiv.append(createCommentUpdateInput);
				} else {
					commentDiv.setAttribute("data-isOpen", "no");
		     		commentDiv.childNodes[6].remove();
		     		commentDiv.childNodes[6].remove();
				}
	 	}
	 	
	 	// 댓글 수정
	 	function updateComment(replyid, updateComment) {
	 		const param = {
	 				replyid: replyid,
					contents: $("#updateCommentContents").val()
			}
	 		
			fetch("<c:url value='/board/updateComment.do'/>", {
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
					detailBoard(detailBoardid.val());
				}
			});
	 	}
	 	
	 	// 댓글 삭제
	 	function commentDelete(replyid) {
	 		if (confirm("댓글을 삭제하시겠습니까 ?")){
	 			const param = {
	     				replyid: replyid
				}
	     		
				fetch("<c:url value='/board/deleteComment.do'/>", {
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
						detailBoard(detailBoardid.val());
					}
				});
	 		}
	 	}
		
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
    	
    	// 전체 체크
    	document.querySelector("#allCheck").addEventListener("click", function() {
    		var checks = document.querySelectorAll("input[type='checkbox']");
    		checks.forEach(checkbox => {
    			checkbox.checked = this.checked;
    		});
    		$("#checkBoardidTemp").prop("checked", false);
    	});
    	
    	// 체크 삭제
    	document.querySelector("#listDeleteButton").addEventListener("click", function() {
      		if (confirm("선택한 게시물들을 삭제하시겠습니까 ?")) {
        		var deleteBoards = [];
        		var checks2 = document.querySelectorAll(".checkBoard:checked");
        		var cnt = checks2.length;
        		
        		checks2.forEach(checkbox => {
        				deleteBoards.push(checkbox.value);
        		});
        		
        		if (deleteBoards.length == 0) {
        			alert("삭제할 게시물을 체크해주세요.");
        		} else {
            		const param = {
            				deleteBoards: deleteBoards
        			}
            		
            		fetch("<c:url value='/board/deleteBoards.do'/>", {
            			
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
        					boardid = document.querySelector("#boardTbody > tr:last-child > td:nth-child(2)").innerText;
        					view_count = document.querySelector("#boardTbody > tr:last-child > td:nth-child(6)").innerText;
        					
	        				$("#allCheck").prop("checked", false);
	                		checks2.forEach(checkbox => {
	            				checkbox.parentElement.parentElement.remove();
	            			});	
	        				
	        	    		const param2 = {
	        	    			boardid: boardid,
	        	    			view_count: view_count,
	        	    			searchType: document.querySelector("#pageForm > #searchType").value,
	        		    		searchText: document.querySelector("#pageForm > #searchText").value,
	        		    		pageLength: cnt,
	        		    		order: "recent"
	        	    		}
	        	    		
	        	    		fetch("<c:url value='/board/moreListBoard.do'/>", {
	        					method: "POST",
	        					headers: {
	        					    "Content-Type": "application/json; charset=UTF-8",
	        					},
	        					body: JSON.stringify(param2),
	        				})
	        				.then((response) => response.json())
	        				.then((json) => {
	        					const boardList = json.boardList;
	        					const boardTemp = document.querySelector("#boardTemp");
	        					const boardListHTML = document.querySelector("#boardTbody");
	        					
	        					for (let i = 0; i < boardList.length; i++) {
	        						const board = boardList[i];
	        						const newBoardItem = boardTemp.cloneNode(true);
// 		        					const boardTitleTd = newBoardItem.querySelector("#titleTd");
	        						const title = newBoardItem.querySelector("#title");
	        						
	        						newBoardItem.querySelector("#checkBoardidTemp").value = board.boardid;
	        						newBoardItem.querySelector("#boardidTemp").innerText = board.boardid;
	        						
// 									let createSpan = document.createElement("span");
// 									createSpan.setAttribute("style", "padding-left: " + (board.level - 1) * 20 + "px");
// 									boardTitleTd.prepend(board.level != 1 ? "ㄴ " : "");
// 									boardTitleTd.prepend(createSpan);
	        						
        							title.innerText = board.title;
	        						title.setAttribute("data-boardid", board.boardid);
	        						
	        						newBoardItem.querySelector("#writer_uid").innerText = board.writer_uid;
	        						newBoardItem.querySelector("#reg_date").innerText = board.reg_date;
	        						newBoardItem.querySelector("#view_count").innerText = board.view_count;
	        						
	        						newBoardItem.style.display = "";
	        						boardListHTML.appendChild(newBoardItem);
	        					}
	        				});
        				}
        			});
        		}
      		} 
      	});
    	
    </script>
