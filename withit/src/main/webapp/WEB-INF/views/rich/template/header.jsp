<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

button[id="mobileOpener"] {
	width: 50px;
	height: 50px;
	display: none;
}

div[id="mobile_header_logo_wrapper"] {
	height: 30px;
	box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 4px 0
		rgba(0, 0, 0, 0.19);
	display: none;
}

img[id="mobile_header_logo"] {
	width: 90px;
	height: 30px;
	cursor: pointer;
}

svg[id="mobile_hamburger"] {
	display: none;
}

div[id="mobile_menu"] {
	position: absolute;
	right: 0;
	width: 230px;
	height: 100vh;
	transition: all 0.3s;
	z-index: 999;
	display: none;
}

li[class="mobile_li"] {
	height: 70px;
	line-height: 75px;
	font-size: 1.35rem;
	list-style: none;
	font-weight: bold;
	color: gray;
	background-color: white;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, 0.2);
}

li[class="mobile_li"]>div {
	margin-left: 12%;
}

img[id="mobile_logo"] {
	width: 207px;
}

path {
	color: #a2c7b4;
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
	div[id="mobile_header_logo_wrapper"] {
		display: initial;
		margin-top: 5px;
	}
	div[id="loginBar_wrapper"] {
		height: 40px;
		display: flex;
		justify-content: center;
	}
	div[id="header_wrapper"] {
		display: none;
	}
	div[id="loginBar"] {
		display: none;
	}
	svg[id="mobile_hamburger"] {
		position: absolute;
		font-size: 40px;
		color: white;
		right: 10px;
		display: initial;
		cursor: pointer;
	}
	svg[id="mobile_hamburger"]>path {
		color: white;
	}
}
</style>
<!-- 최상단 로그인바 -->
<div id="loginBar_wrapper">
	<div id="mobile_header_logo_wrapper">
		<a href="/"><img id="mobile_header_logo"
			src="/resources/kh/image/logo.png" /></a>
	</div>
	<div>
		<a onclick="mobile_menu()"><i id="mobile_hamburger"
			class="fas fa-bars fa-3x"></i></a>
	</div>
	<div id="loginBar">

		<sec:authorize access="isAnonymous()">
			<a class="loginBarLink" href="/loginForm">로그인</a>
			&emsp;
			<a class="loginBarLink" href="/joinForm">회원가입</a>
			&emsp;
		</sec:authorize>

		<sec:authorize access="isAuthenticated()">
			<sec:authorize access="hasRole('ROLE_MEMBER')">
				<a class="loginBarLink" href="/myPage">마이페이지</a>
			</sec:authorize>

			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a class="loginBarLink" href="/admin">관리자페이지</a>
			</sec:authorize>

			<form action="/logout" method="post" name="logout">
				&emsp;<a class="loginBarLink"
					href="javascript:document.logout.submit();">로그아웃</a>&emsp; <input
					type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token }">
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
		<button id="mobileOpener" onclick="mobile_menu()">X</button>
	</div>


	<!-- 모바일 메뉴 -->

	<div id="mobile_menu">
		<ul id="mobile_ul">
			<li class="mobile_li">
				<div>
					<i class="fas fa-home"></i>&nbsp;&nbsp;Welcome
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="fas fa-people-arrows"></i>&nbsp;&nbsp;스터디 매칭
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="far fa-id-card"></i>&nbsp;&nbsp;스터디 모집
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="fas fa-users"></i>&nbsp;&nbsp;그룹관리
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="fas fa-keyboard"></i>&nbsp;&nbsp;자유게시판
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="fas fa-wifi"></i>&nbsp;&nbsp;크롤게시판
				</div>
			</li>
			<li class="mobile_li">
				<div>
					<i class="fas fa-info-circle"></i>&nbsp;&nbsp;프로젝트 소개
				</div>
			</li>

			<sec:authorize access="isAnonymous()">
				<li class="mobile_li">
					<div>
						<i class="fas fa-sign-in-alt"></i>&nbsp;&nbsp;로그인
					</div>
				</li>
				<li class="mobile_li">
					<div>
						<i class="fas fa-user-plus"></i>&nbsp;&nbsp;회원가입
					</div>
				</li>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<sec:authorize access="hasRole('ROLE_MEMBER')">
					<li class="mobile_li">
						<div>
							<i class="fas fa-user"></i>&nbsp;&nbsp;마이페이지
						</div>
					</li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="mobile_li">
						<div>
							<i class="fas fa-user-cog"></i>&nbsp;&nbsp;관리자 메뉴
						</div>
					</li>
				</sec:authorize>
			</sec:authorize>

			<li class="mobile_li">
				<div>
					<i class="fas fa-sign-out-alt"></i>&nbsp;&nbsp;로그아웃
				</div>
			</li>
		</ul>
	</div>

	<script>
		let closed = false;
		
		function mobile_menu() {
		 console.log("호출");
		  if (closed) openMobileMenu();
		  else closeMobileMenu();
		}
		
		function closeMobileMenu() {
		  let target = document.getElementById("mobile_menu");
		  target.style.right = "-300px";
		  setTimeout(function () {
		    target.style.display = "none";
		  }, 150);
		  closed = true;
		}
		function openMobileMenu() {
		  let target = document.getElementById("mobile_menu");
		  target.style.display = "initial";
		  target.style.transition = "all 0.3s";
		  setTimeout(() => {
		    target.style.right = "0px";
		  }, 1);
		  closed = false;
		}
	</script>

</div>