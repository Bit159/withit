<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
	<link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@600;900&display=swap" rel="stylesheet" />
	<script src="https://kit.fontawesome.com/4b9ba14b0f.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/resources/rich/css/error.css" />
</head>

<body>
	<div class="error">
		${codeFront }&nbsp;<i class="far fa-question-circle fa-spin"></i>&nbsp;${codeEnd }
	</div>
	<div id="nodataImage"></div>
	<div class="msg">
		${msg }
		<p>
			<button onclick="location.href='/'">Home</button>
			<button id="back" onclick="javascript:history.back()">Back</button>
		</p>
	</div>
</body>
</html>