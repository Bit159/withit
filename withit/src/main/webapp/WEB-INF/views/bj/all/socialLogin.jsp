<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<form id="socialForm" action="/login" method="post">
	<input type="hidden" id="username" name="username" value="${username }">
	<input type="hidden" id="password" name="password" value="${password }">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="submit" value="로그인">
</form>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	
}
</script>
</html>