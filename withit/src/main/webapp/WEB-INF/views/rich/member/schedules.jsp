<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta id="csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <meta id="csrf" name="_csrf" content="${_csrf.token}" />
    <title>일정관리</title>
    <link rel="stylesheet" href="/resources/rich/css/mycalendar.css" />
    <link rel="stylesheet" href="/resources/rich/css/main.css" />
    <script src="/resources/rich/js/main.js"></script>
    <script src="/resources/rich/js/locales-all.js"></script>
    <script src="/resources/rich/js/mycalendar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  </head>
  <body>
  	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
    <div id="calendar"></div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
  </body>
</html>
