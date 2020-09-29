<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
	<script defer src="/resources/rich/js/rich.js"></script>
</head>

<body>
	<form method="post" enctype="multipart/form-data" action="/uploadFile?${_csrf.parameterName}=${_csrf.token}">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input id="myFiles" name="myFiles" type="file" multiple />
		<input id="myPath" name="myPath" type="hidden" value="C://Users//ztzy1//OneDrive - SangMyung University//upload//" />
		<button type="button" onclick="upload()"></button>
	</form>
	
	<script>
		function upload(){
			let form = new FormData(document.forms[0]);
			let url = "/uploadFile";
			let options = myOptionsNotJSON(form);
			console.log(options);
			fetch(url, options)
				.then(res=>res.text())
				.then(text=>console.log(text));			
		}
	</script>
</body>

</html>