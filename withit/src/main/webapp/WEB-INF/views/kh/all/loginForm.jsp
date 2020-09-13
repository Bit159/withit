<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="../resources/js/login.js" defer></script>
<link rel="stylesheet" href="../resources/css/login.css" />
</head>
<body>
	<jsp:include page="../template/header.jsp" />
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
	<section class="login-form">
		<label for="sideicon" id="back"> <span></span>
		</label>
		<h1>Let's Synergy</h1>
		<form id="loginForm" method="post" action="/synergy-kh/all/login">
			<div id="loginFormDiv">
			<div class="info-area">
				<input type="text" name="login_id" id="login_id" autocomplete="off"
					required> <label for="login_id">EMAIL</label>
			</div>
			<div class="info-area">
				<input type="password" name="login_pw" id="login_pw"
					autocomplete="off" required> <label for="login_pw">PASSWORD</label>
			</div>
			<div id="autoLogin">
			<input type="checkbox" name="remember-me" id="remember-me">
			<label for="remember-me">자동로그인</label>
			</div>
			<div class="btn-area">
				<button type="submit" id="loginBtn">LOGIN</button>
				<button onclick="location='index.html'">BACK</button>
			</div>
			<input name="${_csrf.parameterName}" type="hidden"
				value="${_csrf.token}">
		</div>
		</form>
		<div class="thirdParty" align="center" style="margin-top: 30px;">
			<img src="../resources/image/google.png"><br> <img
				src="../resources/image/kakao_login_medium_narrow.png"><br>
		</div>

		<div class="caption">
			<a href="/synergy-kh/all/joinForm">회원가입</a>&emsp; <a href="">아이디/비밀번호
				찾기</a>
		</div>
	</section>
	<jsp:include page="../template/footer.jsp"></jsp:include>
	</body>
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
	</script>
</body>
</html>