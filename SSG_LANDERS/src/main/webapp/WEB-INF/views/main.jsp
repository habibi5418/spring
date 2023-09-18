<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    <main>
      <div id="slideShow">
        <div id="slides">
          <img src="<c:url value='/resources/images/slide-photo1.png'/>" alt="">
          <img src="<c:url value='/resources/images/slide-photo2.jpg'/>" alt="">
          <img src="<c:url value='/resources/images/slide-photo3.png'/>" alt="">
          <button id="prev">&lang;</button>
          <button id="next">&rang;</button>
        </div>
      </div>
      <div id="contents">
        <div id="tabMenu">
          <input type="radio" id="tab1" name="tabs" checked>
          <label for="tab1">공지사항</label>
          <input type="radio" id="tab2" name="tabs">
          <label for="tab2">랜더스 포토</label>
          <input type="radio" id="tab3" name="tabs">
          <label for="tab3">자유게시판</label>
          <a id="more">전체 보기</a>
          <div id="notice" class="tabContent">
            <ul>
           		<c:forEach var="notice" items="${recentNoticeList }">
           			<li>
						<a onclick="detailNotice(this.getAttribute('data-noticeid'))" href="#" data-noticeid="${notice.noticeid}">
           					<c:if test="${notice.getFixed_yn() == 'Y'}">
           						<img id="fixedImg" src="<c:url value='/resources/images/fixed.png'/>">
           					</c:if> 
           					${notice.getTitle() }
           				</a>
           				<span>${notice.getReg_date() }</span>
           			</li>
           		</c:forEach>
           		<c:if test="${fn:length(recentNoticeList) == 0 }">
           			<li><h3>게시물이 존재하지 않습니다.</h3></li>
           		</c:if>
            </ul>
          </div>
          <div id="gallery" class="tabContent">
          	<span id="photo1" data-src="<c:url value='/resources/images/photo1.jpg'/>" class="pic"></span>
          	<span id="photo2" data-src="<c:url value='/resources/images/photo2.jpg'/>" class="pic"></span>
          	<span id="photo3" data-src="<c:url value='/resources/images/photo3.jpg'/>" class="pic"></span>
          	<span id="photo4" data-src="<c:url value='/resources/images/photo4.jpg'/>" class="pic"></span>
          	<span id="photo5" data-src="<c:url value='/resources/images/photo5.jpg'/>" class="pic"></span>
          	<span id="photo6" data-src="<c:url value='/resources/images/photo6.jpg'/>" class="pic"></span>
          </div>
          <div id="board" class="tabContent">
            <ul>
           		<c:forEach var="board" items="${recentBoardList }">
           			<li><a href="detailBoard?boardid=${board.getBoardid() }&order=recent">${board.getTitle() }</a><span>${board.getReg_date() }</span></li>
           		</c:forEach>
           		<c:if test="${fn:length(recentBoardList) == 0 }">
           			<li><h3>게시물이 존재하지 않습니다.</h3></li>
           		</c:if>
            </ul>
          </div>
        </div>
        <div id="links">
          <ul>
            <li>
              <a href="https://www.ticketlink.co.kr/sports/baseball/476#reservation" target="_blank">
                <span id="quick-icon1"></span>
                <p>티켓 예매</p>
              </a>
            </li>
            <li>
              <a href="https://ssglanderseshop.co.kr/" target="_blank">
                <span id="quick-icon2"></span>
                <p>온라인샵 by emart</p>
              </a>
            </li>
            <li>
              <a href="https://www.ssglandersstore.co.kr/" target="_blank">
                <span id="quick-icon3"></span>
                <p>온라인샵 by hyungji</p>
              </a>
            </li>
          </ul>
        </div>
      </div>
	<div id="lightbox">
		<img src="<c:url value='/resources/images/photo1.jpg'/>" alt="" id="lightboxImage">
	</div>
	
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
    		<a href="#" onclick="moveDetailNotice(this.getAttribute('data-noticeid'))" data-noticeid="{noticeid}" id="prevlistButton" class="detailBtns">이전글</a>
    		<a href="#" onclick="moveDetailNotice(this.getAttribute('data-noticeid'))" data-noticeid="{noticeid}" id="nextlistButton" class="detailBtns">다음글</a>
	  	</div>
	</div>
	
</main>
  <script src="<c:url value='/resources/js/lightbox.js'/>"></script>
  <script src="<c:url value='/resources/js/slideshow.js'/>"></script>
  <script type="text/javascript">
	document.querySelector("#more").addEventListener("click", function() {
  		var tabs = document.getElementsByName("tabs");
  		var checked;
  		
  		tabs.forEach(tab => {
  			if (tab.checked) checked = tab.getAttribute('id');
  		})

  		if (checked == "tab1") {
  			location.href = "<c:url value='/notice/listNotice.do'/>";
  		} else if (checked == "tab3") {
  			location.href = "<c:url value='/board/listBoard.do'/>";
  		}
  	});
	
	$(document).ready(function() {
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
    });
    
    var detailNoticeid = $("#detailNoticeid"),
		detailTitleText = $("#detailTitleText"),
		detailWriterText = $("#detailWriterText"),
		detailDateText = $("#detailDateText"),
		detailContentsText = $("#detailContentsText"),
    	prevlistButton = $("#prevlistButton"),
    	nextlistButton = $("#nextlistButton");

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

				prevlistButton.attr("data-noticeid", json.prevNoticeid);
				nextlistButton.attr("data-noticeid", json.nextNoticeid);
				if (json.first) prevlistButton.css("display", "none");
				if (json.last) nextlistButton.css("display", "none");
				
				$("#detail-form").dialog("open");
			}
		});
	}
    
    // 이전글, 다음글
    function moveDetailNotice(move) {
    	prevlistButton.css("display", "block");
		nextlistButton.css("display", "block");
		
		detailNotice(move);
    }
  </script>
