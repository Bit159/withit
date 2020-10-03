<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<script defer src="/resources/rich/js/fontawesome.js"></script>
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

/* 모바일 */

/* 모바일 최상단 중앙 로고 래퍼 */
div[id="mobile_header_logo_wrapper"] {
	height: 30px;
	margin-top: 5px;
	box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 4px 0 rgba(0, 0, 0, 0.19);
	display: none;
}

/* 모바일 최상단 중앙 로고 */
img[id="mobile_header_logo"] {
	width: 90px;
	height: 30px;
	cursor: pointer;
}

/* 햄버거 버튼 */
svg[id="mobile_hamburger"] {
	display: none;
}

/* 모바일 메뉴 래퍼*/
div[id="mobile_menu"] {
	position: fixed;
	left: -255px;
	width: 250px;
	transition: all 0.1s;
	display:none;
}
div[id="mobile_menu"]  a {
	text-decoration: none;
}

/* 모바일 메뉴 */
li[class="mobile_li"] {
	height: 70px;
	line-height: 75px;
	font-size: 1.35rem;
	list-style: none;
	font-weight: bold;
	color: black;
	background-color: whitesmoke;
	z-index: 999;
	box-shadow: 2px 2px 2px 2px rgba(0.5, 0.5, 0.5, 0.5);
}

li[class="mobile_li"]>div {
	margin-left: 12%;
}

img[id="mobile_logo"] {
	width: 207px;
}

/* 모바일 메뉴 좌측 아이콘 색상 */
path {
	/*color: #a2c7b4;*/
	color: #32be78;
}

/* 햄버거 버튼 아이콘 색상 */
svg[id="mobile_hamburger"]>path {
	color: white;
	z-index : -999;
}


/* 1000px 이상은 PC 기본형 */
@media ( max-width : 1280px) {
	div[id="loginBar"], div[id="header"] {
		width: 100%;
	}
}

/* 1000px 이하는 navbar 메뉴 사이즈, 간격 줄이기 */
@media ( max-width : 1000px) {
	li[class="nav_menu"] {
		font-size: 0.93rem;
		margin-right: 0.5%;
	}
}

/* 768px 이하는 모바일 대응 */
@media ( max-width : 767px) {
	
	/* PC용 navbar 안 보이게 처리 */
	div[id="header_wrapper"], div[id="loginBar"] {
		display: none;
	}
	
	/* 최상단 로그인 바 height 10px 늘리고 내부 요소 중앙정렬 */
	div[id="loginBar_wrapper"] {
		position:sticky;
		top:0;
		z-index:998;
		height: 40px;
		display: flex;
		justify-content: center;
	}
	
	/* 모바일 로고 래퍼 나타내기 */
	div[id="mobile_header_logo_wrapper"] {
		display: initial;
	}
	
	/* 햄버거 버튼 나타내기 */
	svg[id="mobile_hamburger"] {
		display: initial;
		position: absolute;
		font-size: 40px;
		color: white;
		left: 10px;
		cursor: pointer;
	}
	
	div[id="mobile_menu"]{
		display:initial;
	}
}
</style>
<!-- 최상단 로그인바 -->
<div id="loginBar_wrapper">
	<div id="mobile_header_logo_wrapper">
		<a href="/"><img id="mobile_header_logo" src="/resources/kh/image/logo.png" /></a>
	</div>
	<i data-menu="0" id="mobile_hamburger" class="fas fa-bars fa-3x" onclick="open_close()"></i>
	
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

			<form action="/logout" method="post" name="logout">&emsp;
				<a class="loginBarLink" href="javascript:document.logout.submit();">로그아웃</a>&emsp; 
				<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
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

<!-- 모바일 메뉴 -->

<div id="mobile_menu">
	<ul id="mobile_ul">
		<a href="/"><li class="mobile_li"><div><i class="fas fa-home"></i>&nbsp;&nbsp;Welcome</div></li></a>
		<a href="/match"><li class="mobile_li"><div><i class="fas fa-people-arrows"></i>&nbsp;&nbsp;스터디 매칭</div></li></a>
		<a href="/cardBoard"><li class="mobile_li"><div><i class="far fa-id-card"></i>&nbsp;&nbsp;스터디 모집</div></li></a>
		<a href="/myGroup"><li class="mobile_li"><div><i class="fas fa-users"></i>&nbsp;&nbsp;그룹관리</div></li></a>
		<a href="/freeBoard"><li class="mobile_li"><div><i class="fas fa-keyboard"></i>&nbsp;&nbsp;자유게시판</div></li></a>
		<a href="/crawlBoard"><li class="mobile_li"><div><i class="fas fa-wifi"></i>&nbsp;&nbsp;크롤게시판</div></li></a>
		<a href="/history"><li class="mobile_li"><div><i class="fas fa-info-circle"></i>&nbsp;&nbsp;프로젝트 소개</div></li></a>

		<sec:authorize access="isAnonymous()">
			<a href="/loginForm"><li class="mobile_li"><div><i class="fas fa-sign-in-alt"></i>&nbsp;&nbsp;로그인</div></li></a>
			<a href="/joinForm"><li class="mobile_li"><div><i class="fas fa-user-plus"></i>&nbsp;&nbsp;회원가입</div></li></a>
		</sec:authorize>

		<sec:authorize access="isAuthenticated()">
			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<a href="/myPage"><li class="mobile_li"><div><i class="fas fa-user"></i>&nbsp;&nbsp;마이페이지</div></li></a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a href="/admin"><li class="mobile_li"><div><i class="fas fa-user-cog"></i>&nbsp;&nbsp;관리자 메뉴</div></li></a>
			</sec:authorize>
		</sec:authorize>

		<a href="javascript:document.logout.submit()"><li class="mobile_li"><div><i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;로그아웃</div></li></a>
	</ul>
</div>

<script>
	let sw = "0";

	function open_close() {
		if(sw === "0") open();
		else close();
	}
	
	function open() {
		document.querySelector('div#mobile_menu').style.left="0px";
		sw = "1";
	}
	
	function close() {
		document.querySelector('div#mobile_menu').style.left="-255px";
		sw = "0";
	}
	
</script>