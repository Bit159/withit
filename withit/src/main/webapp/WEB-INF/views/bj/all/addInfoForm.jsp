<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가 정보 입력</title>
<link rel="stylesheet" href="/resources/bj/css/addInfoForm.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/kh/template/header.jsp"/>
<section id="addInfoForm" class="addInfoForm">
	<form action="/all/addInfo" method="post" class="join-form">
		<div class="join-area">
			<input type="text" name="username" id="username" autocomplete="off" value="${username}" required readonly >
			<label for="username" style="top: -2px;font-size: 13px;color: rgb(50, 190, 120);">E-MAIL</label>
		</div>
		<br>
		<div class="join-area">
			<input type="text" name="nickname" id="nickname" autocomplete="off" required>
			<label for="nickname">NICKNAME</label>
		</div>
		<br>
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