<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
/* 최상단 로그인 바*/
div[id="loginBar_wrapper"] {
	width: 100%;
	background-color: #32be78;
}

div[id="loginBar"] {
	width: 1280px;
	height: 30px;
	margin: 0 auto;
	display: flex;
	justify-content: flex-end;
}

a[class="loginBarLink"] {
	line-height: 28px;
	font-size: 10pt;
	color: white;
	text-decoration: none;
}

/* 네브바 : div#header_wrapper [ div#header { div#logo_wrapper, ul#menu_wrapper } ] */
div[id="header_wrapper"] {
	width: 100%;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, 0.2);
}

div[id="header"] {
	width: 1280px;
	height: 70px;
	margin: 0 auto;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
}

/* 네브바 안의 로고 */
div[id="logo_wrapper"] {
	height: 70px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

img[id="logo_img"] {
	width: 170px;
}

/* 네브바 안의 메뉴 */
ul[id="menu_wrapper"] {
	width: 100%;
	list-style: none;
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	line-height: 70px;
}

li[class="nav_menu"] {
	margin-right: 40px;
	font-size: 1.05rem;
	transition: all 0.5s;
}

li[class="nav_menu"]:last-child {
	margin-right: 5px;
}

li[class="nav_menu"]>a {
	padding: 10px;
	color: black;
	font-weight: bold;
	text-decoration: none;
}

li[class="nav_menu"]>a:hover {
	border-bottom: solid 2px #32be78;
}

/* 반응형 대응 1000px 이하 메뉴 간격줄이기, 768px 이하 햄버거처리 */
@media ( max-width : 1280px) {
	div[id="loginBar"], div[id="header"] {
		width: 100%;
	}
}

@media ( max-width : 1000px) {
	li[class="nav_menu"] {
		font-size: 0.93rem;
		margin-right: 0.5%;
	}
}

@media ( max-width : 767px) {
	li[class="nav_menu"] {
		display: none;
	}
}
</style>
<!-- 최상단 로그인바 -->
<div id="loginBar_wrapper">
	<div id="loginBar">
	
		<sec:authorize access="isAnonymous()">
			<a class="loginBarLink" href="/loginForm">로그인</a>&emsp;
			<a class="loginBarLink" href="/joinForm">회원가입</a>&emsp;
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<a class="loginBarLink" href="/myPage">마이페이지</a>
			</sec:authorize>
			
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a class="loginBarLink" href="/admin">관리자페이지</a>
			</sec:authorize>
			
			<form action="/logout" method="post" name="logout">
				&emsp;<a class="loginBarLink" href="javascript:document.logout.submit();">로그아웃</a>&emsp;
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
		</sec:authorize>
		
	</div>
</div>

<!-- 네브바 wrapper-->
<div id="header_wrapper">
	<!-- 네브바-->
	<div id="header">
		<!-- 네브바 안의 로고 -->
		<div id="logo_wrapper">
			<a href="/"><img id="logo_img" src="/resources/kh/image/logo.png" /></a>
		</div>

		<!-- 네브바 안의 메뉴 -->
		<ul id="menu_wrapper">
			<li class="nav_menu"><a href="/">Welcome</a></li>
			<li class="nav_menu"><a href="/match">스터디 매칭</a></li>
			<li class="nav_menu"><a href="/cardBoard">스터디 모집</a></li>
			<li class="nav_menu"><a href="/myGroup">그룹관리</a></li>
			<li class="nav_menu"><a href="/freeBoard">자유게시판</a></li>
			<li class="nav_menu"><a href="/crawlBoard">크롤게시판</a></li>
		</ul>
	</div>
</div>