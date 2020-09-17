<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
<link rel="stylesheet" href="/resources/kh/css/header.css">
<link rel="shortcut icon" href="/resources/rich/image/favicon.png" />
<div id="loginBar_wrapper">
	<div id="loginBar" class="container">
		<sec:authorize access="isAnonymous()">
			<a href="/joinForm">회원가입</a> <a href="/loginForm">로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<form action="/logout" method="post" name="logout">
   				<a href="javascript:document.logout.submit();">로그아웃</a>
   				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
   			</form>
			<sec:authorize access="hasRole('ROLE_MEMBER')"><a href="/myPage">마이페이지</a></sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')"><a href="/admin">관리자페이지</a></sec:authorize>
		</sec:authorize>
	</div>
</div>
<div id=header_wrapper>
	<header id="header" class="container">
		<!-- 로고 -->
		<div id="logo">
			<a href="/"><img alt="홈으로" style="width: 170px; height: 55px;" src="/resources/kh/image/logo.png" /></a>
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