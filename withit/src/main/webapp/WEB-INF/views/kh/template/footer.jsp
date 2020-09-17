<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/kh/css/footer.css">
<div id="footer_wrapper">
<sec:authorize access="isAuthenticated()">
    <jsp:include page="/WEB-INF/views/bj/member/chattingList.jsp"/>
</sec:authorize>
	<footer id="footer" class="container">
		<div class="footer">
			<h1>서비스</h1>
			<p>공지사항</p>
			<p>자주 묻는 질문</p>
		</div>
		<div class="footer">
			<h1>프로젝트</h1>
			<p>프로젝트 소개</p>
			<p>개발진</p>
		</div>
		<div class="footer">
			<h1>고객문의</h1>
			<p>Tel: 1234-5678 (24시간 연중무휴)</p>
			<p>Email: bit159.richard@gmail.com</p>
			<p>kakaoID: 020478</p>
		</div>
	</footer>
</div>