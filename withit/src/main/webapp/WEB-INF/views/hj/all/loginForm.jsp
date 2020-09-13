<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<script src="../resources/js/login.js" defer></script>
	<link rel="stylesheet" href="../resources/css/login.css"/>
</head>
<body>
	<nav class="navbar">
		<div class="logoDiv">
			<a href="index.html"><img id="logoImg" src="../resources/image/logo.png" /></a>
		</div>
		<div class="menuButtons">
			<span><a href="#">프로젝트소개</a></span>
			<span><a href="#">이용 방법</a></span>
			<span><a href="#">자주 묻는 질문</a></span>
			<span><a href="#">로그인</a></span>
			<span><a href="#">회원가입</a></span>
		</div>
			<input type="checkbox" id="sideicon">
			<label for="sideicon" id="ham">
				<span></span>
				<span></span>
				<span></span>
				<span></span>
			</label>
			<div class="sidebar">
					<ul>
						<li><a>프로젝트소개</a></li>
						<li><a>이용방법</a></li>
						<li><a>자주 묻는 질문</a></li>
						<li><a>로그인</a></li>
						<li><a>회원가입</a></li>
					</ul>
					<label for="sideicon"></label>
			</div>
	</nav>
	<section class="login-form">
			<label for="sideicon" id="back">
				<span></span>
			</label>
		<h1>Let's Synergy</h1>
		<form id="loginForm" name="loginForm" method="post" action="/synergy2/login">
			<div class="info-area">
				<input type="text" name="username" id="username" autocomplete="off" required>
				<label for="id">EMAIL</label>
			</div>

			<div class="info-area">
				<input type="password" name="password" autocomplete="off" id="password" required>
				<label for="pwd">PASSWORD</label>
			</div>
			<input type="checkbox" name="remember-me">자동로그인
			<div class="btn-area">
				<button id="loginBtn" onclick="checkLogin()">LOGIN</button>
				<button onclick="location='index.html'">BACK</button>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
		<div class="thirdParty" align="center" style="margin-top:30px;">
			<img src="../resources/image/google.png"><br>
			<img src="../resources/image/kakao_login_medium_narrow.png"><br>
		</div>

		<div class="caption">
			<a href="joinForm.html">회원가입</a>&emsp;
			<a href="">아이디/비밀번호 찾기</a>
		</div>
	</section>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="../resources/js/login.js"></script>
</body>
</html>