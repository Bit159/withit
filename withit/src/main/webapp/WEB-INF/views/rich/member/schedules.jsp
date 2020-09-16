<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
    <title>일정관리</title>
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
    <div id="calendar"></div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
  </body>
</html>
