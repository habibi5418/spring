<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	    <div id="listContainer">
 			<a href="<c:url value='/notice/listNoticeByViewCountForAdmin.do'/>" id="listByViewCountButton" class="detailBtns">조회순</a>
			<button type="button" id="listWriteButton">글작성</button>
			<a id="listDeleteButton" class="detailBtns">삭제</a>
	    	
			<table class="table">
				<caption>ALL NOTICE - 최신순</caption>
					<tr id="noticeTemp" style="display: none;">
						<td><input type='checkbox' id="checkNoticeidTemp" class="checkNotice" value=""></td>
						<td id="noticeidTemp"></td>
						<td>
							<a onclick="detailNotice(this.getAttribute('data-noticeid'))" href="#" id="title" data-noticeid="{noticeid}"></a>
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
					<tbody id="fixNoticeTbody">
					<c:forEach var="fixedNotice" items="${result.fixedNoticeList }">
						<tr class='fixed'>
							<td><input type='checkbox' class="checkNotice" value='${fixedNotice.getNoticeid() }'></td>
							<td id="noticeid">${fixedNotice.getNoticeid() }</td>
							<td><a onclick="detailNotice(this.getAttribute('data-noticeid'))" href="#" data-noticeid="${fixedNotice.noticeid}">${fixedNotice.title }</a></td>
							<td>${fixedNotice.getWriter_uid() }</td>
							<td>${fixedNotice.getReg_date() }</td>
							<td>${fixedNotice.getView_count() }</td>
						</tr>
					</c:forEach>
					</tbody>
					<tbody id="noticeTbody">
						<c:forEach var="notice" items="${result.noticeList }">
							<tr>
								<td><input type='checkbox' class="checkNotice" value='${notice.getNoticeid() }'></td>
								<td id="noticeid">${notice.getNoticeid() }</td>
								<td>
									<a onclick="detailNotice(this.getAttribute('data-noticeid'))" href="#" data-noticeid="${notice.noticeid}">
										<c:if test="${notice.getFixed_yn() == 'Y' }">
											<img id="fixedImg" src="<c:url value='/resources/images/fixed.png'/>">
										</c:if>
										${notice.title }
									</a>
								</td>
								<td>${notice.getWriter_uid() }</td>
								<td>${notice.getReg_date() }</td>
								<td>${notice.getView_count() }</td>
							</tr>
						</c:forEach>
					</tbody>
			</table>
			
			<c:if test="${result.notice.pageNo != result.notice.totalPageSize }">
				<div id="moreDiv">
					<a href="#" id="moreList">더보기</a>
				</div>
			</c:if>
			
			<div id="naviDiv">
				<c:if test="${result.notice.navStart != 1 }">
					<a href="javascript:goPage(${result.notice.navStart - 1 })" class="changePageA">&lt;이전</a> | 
				</c:if>
				<c:forEach var="navNo" begin="${result.notice.navStart }" end="${result.notice.navEnd }">
					<c:choose>
						<c:when test="${result.notice.pageNo == navNo }">
							<a href="javascript:goPage(${navNo })" id="selectedPageNo">${navNo }</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:goPage(${navNo })" id="NoSelectedPageNo">${navNo }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${result.notice.navEnd != result.notice.totalPageSize }">
					 | <a href="javascript:goPage(${result.notice.navEnd + 1 })" class="changePageA">다음&gt;</a>
				</c:if>
				<select id="selectPageLength">
					<option value="10" ${result.notice.pageLength == 10 ? 'selected="selected"' : '' }>10개씩</option>
					<option value="20" ${result.notice.pageLength == 20 ? 'selected="selected"' : '' }>20개씩</option>
					<option value="50" ${result.notice.pageLength == 50 ? 'selected="selected"' : '' }>50개씩</option>
					<option value="100" ${result.notice.pageLength == 100 ? 'selected="selected"' : '' }>100개씩</option>
				</select>
				<form id="searchForm" name="searchForm" method="post">
					<div>
						<select id="selectSearchType">
							<option value="title" ${result.notice.searchType == 'title' ? 'selected="selected"' : '' }>제목</option>
							<option value="contents" ${result.notice.searchType == 'contents' ? 'selected="selected"' : '' }>내용</option>
							<option value="writer_uid" ${result.notice.searchType == 'writer_uid' ? 'selected="selected"' : '' }>작성자</option>
						</select>
						<input id="inputSearchText" type="text" value="${result.notice.searchText }">
						<input id="searchBtn" type="submit" value="검색">
					</div>
				</form>
			</div>
			
			<form id="pageForm" name="pageForm" action="<c:url value='/notice/listNoticeForAdmin.do'/>" method="post">
				<input type="hidden" id="pageNo" name="pageNo" value="${result.notice.pageNo }"/>
				<input type="hidden" id="searchType" name="searchType" value="${result.notice.searchType }"/>
				<input type="hidden" id="searchText" name="searchText" value="${result.notice.searchText }"/>
				<input type="hidden" id="pageLength" name="pageLength" value="${result.notice.pageLength }"/>
			</form>
			
			<div id="detail-form" class="dialog-form" title="공지사항 상세보기">
				<div id="detailContainer">
					<div id="detailBoard">
						<input type="hidden" id="detailNoticeid" value="">
						<div id="detailTitle">
						    <h1 id="detailTitleText"></h1>
						    <p id="detailWriterText" class="writer"></p>
						    <p id="detailDateText" class="date"></p>
					    </div>
					    <p id="detailContentsText" class="contents"></p>
				  	</div>
		    		<a href="#" onclick="detailNotice(this.getAttribute('data-noticeid'))" data-noticeid="{noticeid}" id="prevlistButton" class="detailBtns">이전글</a>
		    		<a href="#" onclick="detailNotice(this.getAttribute('data-noticeid'))" data-noticeid="{noticeid}" id="nextlistButton" class="detailBtns">다음글</a>
	  				<a id="fixButton" class="detailBtns" data-fixed_yn="#">고정</a>
			    	<a id="updateButton" class="detailBtns">수정</a>
			    	<a id="deleteButton" class="detailBtns">삭제</a>
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
	                "작성": writeNotice,
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
					fixButton.text("고정");
	            }
	        });
	    	
	    	$("#update-form").dialog({
	            autoOpen: false,
	            height: 700,
	            width: 1200,
	            modal: true,
	            buttons: {
	            	"수정": updateNotice,
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
    		detailNoticeid = $("#detailNoticeid"),
			detailTitleText = $("#detailTitleText"),
			detailWriterText = $("#detailWriterText"),
			detailDateText = $("#detailDateText"),
			detailContentsText = $("#detailContentsText"),
        	prevlistButton = $("#prevlistButton"),
        	nextlistButton = $("#nextlistButton"),
        	fixButton = $("#fixButton"),
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
					noticeid: detailNoticeid.val(),
					order: "recent"
			}
			
			fetch("<c:url value='/notice/getBeforeNotice.do'/>", {
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
		function writeNotice() {
			const param = {
					title: writeTitle.val(),
					contents: writeContents.val(),
					writer_uid: '${loginMember.memid}'
			}
			
			fetch("<c:url value='/notice/writeNotice.do'/>", {
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
	    function detailNotice(noticeid) {
			const param = {
					noticeid: noticeid,
					order: "recent"
			}
			
			fetch("<c:url value='/notice/detailNotice.do'/>", {
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
					detailNoticeid.val(json.noticeid);
					
					if (json.fixed_yn == "Y") {
						detailTitleText.text("");
						const fixImg = new Image();
						fixImg.id = "fixedImg";
						fixImg.src = "<c:url value='/resources/images/fixed.png'/>";
						detailTitleText.append(fixImg);
						detailTitleText.append(document.createTextNode(" " + json.title));
					} else {
						detailTitleText.text(json.title);
					}
					
					detailWriterText.text(json.writer_uid);
					detailDateText.text(json.reg_date);
					if (json.reg_date != json.mod_date) detailDateText.append(" (수정시각 : " + json.mod_date + ") ");
					detailDateText.append(" 조회 " + json.view_count);
					detailContentsText.text(json.contents);

		        	prevlistButton.css("display", "block");
					nextlistButton.css("display", "block");
					prevlistButton.attr("data-noticeid", json.prevNoticeid);
					nextlistButton.attr("data-noticeid", json.nextNoticeid);
					if (json.first) prevlistButton.css("display", "none");
					if (json.last) nextlistButton.css("display", "none");

					fixButton.text("고정");
					if (json.fixed_yn == "Y") fixButton.text("고정해제");
					fixButton.attr("data-fixed_yn", json.fixed_yn);
					
					$("#detail-form").dialog("open");
				}
			});
		}
        
        // 고정
        fixButton.on("click", function() {
        	if ($(this).data("fixed_yn") == "N") {
      			if (confirm("게시물을 고정하시겠습니까 ?")) fix("fixNotice.do", "Y");
      		} else if ($(this).data("fixed_yn") == "Y" ) {
      			if (confirm("게시물을 고정 해제하시겠습니까 ?")) fix("fixNotice.do", "N");
      		}
        });
        
        function fix(location, doYN) {
      		const param = {
    				noticeid: detailNoticeid.val(),
    				doYN: doYN,
    		}
    		
    		fetch(location, {
    			method: "POST",
    			headers: {
    			    "Content-Type": "application/json; charset=UTF-8",
    			},
    			body: JSON.stringify(param),
    		})
    		.then((response) => response.json())
    		.then((json) => {
    			alert(json.message);
    			if (json.status) document.querySelector("#pageForm").submit();
    		});
      	}
        
        // 수정
        function updateNotice() {
        	const param = {
					noticeid: detailNoticeid.val(),
					title: updateTitle.val(),
					contents: updateContents.val()
			}
			
			fetch("<c:url value='/notice/updateNotice.do'/>", {
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
		        	detailNotice(detailNoticeid.val());
				}
			});
        }
        
        // 삭제
        deleteButton.on("click", function() {
      		if (confirm("게시물을 삭제하시겠습니까 ?")) {
      			const param = {
    					noticeid: detailNoticeid.val()
    			}
    			
    			fetch("<c:url value='/notice/deleteNotice.do'/>", {
    				method: "POST",
    				headers: {
    				    "Content-Type": "application/json; charset=UTF-8",
    				},
    				body: JSON.stringify(param),
    			})
    			.then((response) => response.json())
    			.then((json) => {
    				alert(json.message);
    				if (json.status) location.href = "<c:url value='/notice/listNoticeForAdmin.do'/>";
    			});
      		}
      	});
		
    	// 더보기
    	if (document.querySelector("#moreList") != null) {
	    	document.querySelector("#moreList").addEventListener("click", e => {
	    		e.preventDefault();
	    		var noticeid = 0;
	
	    		noticeid = document.querySelector("#noticeTbody > tr:last-child > td:nth-child(2)").innerText;
				
	    		const param = {
	    			noticeid: noticeid,
	    			searchType: document.querySelector("#pageForm > #searchType").value,
		    		searchText: document.querySelector("#pageForm > #searchText").value,
		    		pageLength: document.querySelector("#pageForm > #pageLength").value,
		    		order: "recent"
	    		};
	    		
	    		fetch("<c:url value='/notice/moreListNotice.do'/>", {
					method: "POST",
					headers: {
					    "Content-Type": "application/json; charset=UTF-8",
					},
					body: JSON.stringify(param),
				})
				.then((response) => response.json())
				.then((json) => {
					const noticeList = json.noticeList;
					const noticeTemp = document.querySelector("#noticeTemp");
					const noticeListHTML = document.querySelector("#noticeTbody");
					
					for (let i = 0; i < noticeList.length; i++) {
						const notice = noticeList[i];
						const newNoticeItem = noticeTemp.cloneNode(true);
						const title = newNoticeItem.querySelector("#title");
						
						newNoticeItem.querySelector("#checkNoticeidTemp").value = notice.noticeid;
						newNoticeItem.querySelector("#noticeidTemp").innerText = notice.noticeid;
						
						if (notice.fixed_yn == "Y") {
							const fixImg = new Image();
							fixImg.id = "fixedImg";
							fixImg.src = "<c:url value='/resources/images/fixed.png'/>";
							title.appendChild(fixImg);
							const titleText = document.createTextNode(" " + notice.title);
							title.appendChild(titleText);
						} else {
							title.innerText = notice.title;
						}
						title.setAttribute("data-noticeid", notice.noticeid);
						
						newNoticeItem.querySelector("#writer_uid").innerText = notice.writer_uid;
						newNoticeItem.querySelector("#reg_date").innerText = notice.reg_date;
						newNoticeItem.querySelector("#view_count").innerText = notice.view_count;
						
						newNoticeItem.style.display = "";
						noticeListHTML.appendChild(newNoticeItem);
					}
				});
	    		
	    		return false;
	    	});
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
    		$("#checkNoticeidTemp").prop("checked", false);
    	});
    	
    	// 체크 삭제
    	document.querySelector("#listDeleteButton").addEventListener("click", function() {
      		if (confirm("선택한 게시물들을 삭제하시겠습니까 ?")) {
        		var deleteNotices = [];
        		var checks2 = document.querySelectorAll(".checkNotice:checked");
        		var cnt = checks2.length;
        		
        		checks2.forEach(checkbox => {
        			deleteNotices.push(checkbox.value);
    			});
        		
        		if (deleteNotices == "") {
        			alert("삭제할 게시물을 체크해주세요.");
        		} else {
            		const param = {
            				deleteNotices: deleteNotices
        			}
            		
            		fetch("<c:url value='/notice/deleteNotices.do'/>", {
            			
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
        					noticeid = document.querySelector("#noticeTbody > tr:last-child > td:nth-child(2)").innerText;
        					
	        				$("#allCheck").prop("checked", false);
	                		checks2.forEach(checkbox => {
	            				checkbox.parentElement.parentElement.remove();
	            			});	
	        				
	        	    		const param2 = {
	        	    			noticeid: noticeid,
	        	    			searchType: document.querySelector("#pageForm > #searchType").value,
	        		    		searchText: document.querySelector("#pageForm > #searchText").value,
	        		    		pageLength: cnt,
	        		    		order: "recent"
	        	    		}
	        	    		
	        	    		fetch("<c:url value='/notice/moreListNotice.do'/>", {
	        					method: "POST",
	        					headers: {
	        					    "Content-Type": "application/json; charset=UTF-8",
	        					},
	        					body: JSON.stringify(param2),
	        				})
	        				.then((response) => response.json())
	        				.then((json) => {
	        					const noticeList = json.noticeList;
	        					const noticeTemp = document.querySelector("#noticeTemp");
	        					const noticeListHTML = document.querySelector("#noticeTbody");
	        					
	        					for (let i = 0; i < noticeList.length; i++) {
	        						const notice = noticeList[i];
	        						const newNoticeItem = noticeTemp.cloneNode(true);
	        						const title = newNoticeItem.querySelector("#title");
	        						
	        						newNoticeItem.querySelector("#checkNoticeidTemp").value = notice.noticeid;
	        						newNoticeItem.querySelector("#noticeidTemp").innerText = notice.noticeid;
	        						
	        						if (notice.fixed_yn == "Y") {
	        							const fixImg = new Image();
	        							fixImg.id = "fixedImg";
	        							fixImg.src = "<c:url value='/resources/images/fixed.png'/>";
	        							title.appendChild(fixImg);
	        							const titleText = document.createTextNode(" " + notice.title);
	        							title.appendChild(titleText);
	        						} else {
	        							title.innerText = notice.title;
	        						}
	        						title.setAttribute("data-noticeid", notice.noticeid);
	        						
	        						newNoticeItem.querySelector("#writer_uid").innerText = notice.writer_uid;
	        						newNoticeItem.querySelector("#reg_date").innerText = notice.reg_date;
	        						newNoticeItem.querySelector("#view_count").innerText = notice.view_count;
	        						
	        						newNoticeItem.style.display = "";
	        						noticeListHTML.appendChild(newNoticeItem);
	        					}
	        				});
        				}
        			});
        		}
      		} 
      	});
    </script>
