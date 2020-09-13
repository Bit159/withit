<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/kh/css/header.css">

<div id="loginBar_wrapper">
	<div id="loginBar" class="container">
		<a href="/joinForm">회원가입</a> <a href="/loginForm">로그인</a>
	</div>
</div>
<div id=header_wrapper>
	<header id="header" class="container">
		<!-- 로고 -->
		<div id="logo">
			<a href="/"><img alt="홈으로" style="width: 155px; height: 55px;" src="/resources/kh/image/logo.png" /></a>
		</div>
		<!-- nav -->
		<nav id="nav">
			<ul>
				<li class="welcome" style="white-space: nowrap;"><a	href="/">Welcome</a></li>
				<li class="matching" style="white-space: nowrap;"><a href="/match">스터디 매칭</a></li>
				<li class="createGroup" style="white-space: nowrap;"><a href="/cardBoard">스터디 모집</a></li>
				<li class="groupManage" style="white-space: nowrap;"><a href="/mygroup">그룹관리</a></li>
				<li class="freeBoard" style="white-space: nowrap;"><a href="/freeBoard">자유게시판</a></li>
				<li class="menu3" style="white-space: nowrap;"><a href="/crawlBoard">크롤게시판</a></li>
			</ul>
		</nav>
	</header>
</div>