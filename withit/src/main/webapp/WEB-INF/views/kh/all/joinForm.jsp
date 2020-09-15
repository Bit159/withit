<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/join.css">
<script defer type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script defer type="text/javascript" src="/resources/bj/js/join.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/kh/template/header.jsp"/>

<section class="join-form">
	<h1>With IT</h1>
	<form action="/join" method="post">
		<div class="join-area">
			<input type="text" name="username" id="username" autocomplete="off" required>
			<label for="username">E-MAIL</label>
		</div>
		
		<div class="join-area">
			<input type="text" name="nickname" id="nickname" autocomplete="off" required onblur="checkUsername()">
			<label for="nickname">NICKNAME</label>
		</div>
		
		<div class="join-area">
			<input type="password" name="password" id="password" autocomplete="off" required>
			<label for="password">PASSWORD</label>
		</div>
		
		<div class="join-area">
			<input type="password" name="repwd" id="repwd" autocomplete="off" required>
			<label for="repwd">RE-PASSWORD</label>
		</div>
		
		<div class="btn-area">
			<button>JOIN!</button>
			<button type="button" name="back" id="back" onclick="javascript='history.go(-1)'">BACK</button>
		</div>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</section>
<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"/>
</body>
</html>