<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="../resources/css/join.css">
<script defer src="../resources/js/join.js"></script>
</head>
<body>
<div class="nav">
	<nav>
		<div id="logoDiv">
		<a href="gogogo.html"><img src="../resources/image/testLogo.png" /></a>
		</div>
		<div id="menuButtons">
			<span></span>
			<span></span>
			<span></span>
			<span></span>
			<span></span>
			<span></span>
			<span></span>
			<span></span>
			<span>프로젝트소개</span>
			<span>이용 방법</span>
			<span>자주 묻는 질문</span>
			<span>로그인</span>
			<span>회원가입</span>
		</div>
		<div id="menuButtonsM">
		<a href="javascript:mobileMenu()">
			<span></span>
		</a>
		</div>
	</nav>
</div>
<section class="join-form">
	<h1>Let's Synergy</h1>
	<form action="" method="post">
		<div class="join-area">
			<input type="text" name="name" id="name" autocomplete="off" required>
			<label for="name">NAME</label>
		</div>
	
		<div class="join-area">
			<input type="text" name="id" id="id" autocomplete="off" required>
			<label for="id">USER NAME</label>
		</div>
		
		<div class="join-area">
			<input type="password" name="pwd" id="pwd" autocomplete="off" required>
			<label for="pwd">PASSWORD</label>
		</div>
		
		<div class="join-area">
			<input type="radio" name="gender" id="gender" value="남성" checked><span style="color:aliceblue">남 성</span>&emsp;
			<input type="radio" name="gender" id="gender" value="여성"><span style="color:aliceblue">여 성</span>
		</div>
		
		<div class="join-area">
			<input type="text" name="email" id="email" autocomplete="off" required>
			<label for="email">E-MAIL</label>
		</div>
		
		<div class="join-area">
			<input type="text" name="phone" id="phone" autocomplete="off" placeholder="                                              - 를 입력해주세요." required>
			<label for="phone">PHONE</label>
		</div>

		<div class="join-area">
			<input type="date" id="birth" style="width: 45%;">
			<label for="birth">BIRTH</label>
		</div>
		<div class="btn-area">
			<button type="submit">JOIN!</button>
			<button name="back" id="back" onclick="location='login.html'">BACK</button>
		</div>
	</form>
</section>
</body>
</html>