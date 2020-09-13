<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>ADMIN PAGE</h3>
<form id="adminPage" action="">
운영자만 들어올 수 있음
<br><br>
<input type="button" value="로그인 페이지" onclick="location.href='/synergy/all/loginForm'">
<input type="button" value="회원가입 페이지" onclick="location.href='/synergy/all/joinForm'">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>