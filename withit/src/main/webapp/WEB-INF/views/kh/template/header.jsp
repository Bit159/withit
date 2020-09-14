<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/kh/css/header.css">
<div id="loginBar_wrapper">

	<div id="loginBar" class="container">
		<c:if test="${nickname eq null }">
			<a href="/joinForm">회원가입</a> <a href="/loginForm">로그인</a>
		</c:if>
		<c:if test="${nickname ne null }">
			<c:if test="${admin eq null }"><a href="/myPage">마이페이지</a></c:if>
			<c:if test="${admin ne null }"><a href="/admin">관리자페이지</a></c:if>
			<a href="/logout">로그아웃</a>
		</c:if>
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