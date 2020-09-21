<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/kh/css/footer.css">
<div id="footer_wrapper">
<sec:authorize access="isAuthenticated()">
    <jsp:include page="/WEB-INF/views/bj/member/chattingList.jsp"/>
</sec:authorize>
	<footer id="footer" class="container">
		<div class="footerDiv">
			<h1>서비스</h1>
			<p onclick="location='/notice'" style="cursor:pointer;">공지사항</p>
			<p onclick="location='/qna'" style="cursor:pointer;">Q n A</p>
		</div>
		<div class="footerDiv">
			<h1>프로젝트</h1>
			<p>프로젝트 소개</p>
			<p>개발진</p>
		</div>
		<div class="footerDiv">
			<h1>고객문의</h1>
			<p>Tel: 1234-5678 (24시간 연중무휴)</p>
			<p>Email: synergy.bit159@gmail.com</p>
			<p>kakaoID: 020478</p>
		</div>
	</footer>
</div>

<script>
	document.addEventListener('DOMContentLoaded', ()=>{
		var body = document.body, html = document.documentElement;
 			var height = Math.max( body.scrollHeight, body.offsetHeight, 
	                       html.clientHeight, html.scrollHeight, html.offsetHeight );
		document.querySelector('div[id="footer_wrapper"]').style.position="absolute";
		document.querySelector('div[id="footer_wrapper"]').style.top=(height-260)+"px";
		document.querySelector('div[id="footer_wrapper"]').style.opacity="1";
	});
</script>