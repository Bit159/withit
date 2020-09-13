<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

로그인 성공

<sec:authentication property="principal.username" var="username"/>
${username}

<form name="welcomeForm" id="welcomeForm" method="post" action="/synergy2/member/myPage">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" id="username" name="username" value="${username }">
</form>
<input type="button" value="myPage" id="myPageBtn" onclick="document.forms[0].submit()">
<input type="button" value="logout" onclick="location.href='/synergy2/member/logout'">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>