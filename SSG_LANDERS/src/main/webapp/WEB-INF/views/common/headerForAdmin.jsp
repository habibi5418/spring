<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div id="logo">
	  <a href="<c:url value='/mainForAdmin.do'/>">
	    <h1>SSG LANDERS</h1>
	  </a>
	</div>
	<nav>
	  <ul id="topMenu">
	    <li>
	      <a href="#">LANDERS</a>
	      <ul>
	        <li><a href="#">연혁</a></li>
	        <li><a href="#">엠블럼</a></li>
	        <li><a href="#">후원사</a></li>
	        <li><a href="#">구단정보</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="#">PLAYERS</a>
	      <ul>
	        <li><a href="#">코칭 스태프</a></li>
	        <li><a href="#">투수</a></li>
	        <li><a href="#">야수</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="<c:url value='/notice/listNoticeForAdmin.do'/>">MEDIA</a>
	      <ul>
	        <li><a href="<c:url value='/notice/listNoticeForAdmin.do'/>">공지사항</a></li>
	        <li><a href="#">랜더스 포토</a></li>
	        <li><a href="<c:url value='/board/listBoardForAdmin.do'/>">자유게시판</a></li>
	      </ul>
	    </li>
	    <li>
	      <a href="#">STADIUM</a>
	      <ul>
	        <li><a href="#">구장소개</a></li>
	        <li><a href="#">찾아오시는 길</a></li>
	      </ul>
	    </li>
	    <c:choose>
		    <c:when test="${loginMember != null }">
			    <li id="header3">
			      <a href="<c:url value='/member/myPage.do'/>">${loginMember.mname }님<br>반갑습니다.</a>
			      <ul>
			        <li><a href="#" id="logoutBtn">LOGOUT</a></li>
			      	<li><a href="<c:url value='/member/myPage.do'/>">MYPAGE</a></li>
			      	<li><a href="#">MANAGEMENT</a></li>
			      </ul>
			    </li>
		    </c:when>
		    <c:when test="${loginMember == null }">
			    <li id="header1">
			      <a href="#" id="openLoginForm">LOGIN</a>
			    </li>
			    <li id="header2">
			      <a href="<c:url value='/member/registerForm.do'/>">JOIN</a>
			    </li>
		    </c:when>
		</c:choose>
	  </ul>
	</nav>
	
	<div id="login-form" class="dialog-form" title="로그인폼">
		<form id="form" autocomplete="off">
			<h1>LOGIN</h1>
			<input id="loginMemid" type="text" name="loginMemid" maxlength="20" placeholder="아이디" required/><br/>
			<input id="loginPwd" type="password" name="loginPwd" maxlength="20" placeholder="비밀번호" required/><br/>
			<input id="submit" type="submit" value="로그인"/><br/>
			<div class="links">
				<a href="registerForm.do">회원가입</a><span>|</span>
				<a href="findMemidForm.do">아이디 찾기</a><span>|</span>
				<a href="findPwdForm.do">비밀번호 찾기</a>
			</div>
		</form>
	</div>
	
	<script>
		$(document).ready(function() {
	    	$("#login-form").dialog({
	            autoOpen: false,
	            height: 650,
	            width: 900,
	            modal: true,
	            buttons: {
	            },
	            close: function() {
	            	loginMemid.text("");
	            	loginPwd.text("");
	            }
	        });
	    });
	    
		$("#openLoginForm").on("click", function() {
			$("#login-form").dialog("open");
		});

	    var loginMemid = document.querySelector("#loginMemid"),
	    	loginPwd = document.querySelector("#loginPwd");
		
		// 로그인
		document.querySelector("#login-form").addEventListener("submit", e => {
			e.preventDefault();
			
			const param = {
					memid: loginMemid.value,
					pwd: loginPwd.value
			}
			
			fetch("<c:url value='/member/login.do'/>", {
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
					location.href = "<c:url value='/mainForAdmin.do'/>";
				} 
			});
		});
		
		// 로그아웃
		document.querySelector("#logoutBtn").addEventListener("click", () => {
			if (confirm("로그아웃하시겠습니까 ?")) {			
				fetch("<c:url value='/member/logout.do'/>", {
					method: "POST",
					headers: {
					    "Content-Type": "application/json; charset=UTF-8",
					},
				})
				.then((response) => response.json())
				.then((json) => {
					alert(json.message);
					if (json.status) {
						location.href = "<c:url value='/main.do'/>";
					} 
				});
			}
		});
		
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
	</script>