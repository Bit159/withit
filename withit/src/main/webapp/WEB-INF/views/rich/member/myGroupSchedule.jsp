<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
    <link rel="stylesheet" href="/resources/rich/css/schedules.css" />
    <link rel="stylesheet" href="/resources/rich/css/main.css" />
    <script src="/resources/rich/js/main.js"></script>
    <script src="/resources/rich/js/locales-all.js"></script>
    <script src="/resources/rich/js/schedules.js"></script>
    <script src="/resources/rich/js/rich.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
	<jsp:include page="/WEB-INF/views/rich/member/sidebar.jsp" flush="true" />
	 	<div class="testdiv" style="width:930px; height:969px; border:5px solid black;display:flex;text-align:center;flex-direction: column;">
	 		<div style="margin-top:20px;"><h3>그룹 일정 관리</h3></div>
	 		<hr>
	 		<div id="calendarWrapper" style="margin:0 auto; float:left; width:80%;">
				<div id="calendar" style="position:relative;margin:0 auto; width:100%; height:500px;border:5px solid black;"></div>
			</div>
		</div>    
	</div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
</body>

</html>