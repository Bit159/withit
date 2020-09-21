<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
<link rel="stylesheet" href="/resources/kh/css/welcome.css">
<script src="http://code.jquery.com/jquery-latest.min.js" defer></script>
<script src="/resources/kh/js/welcome.js" defer></script>
</head>
<body>
	<div id=body_wrapper>
		<!--header  -->
		<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
		<!-- 배너 -->
		<div id="banner_wrapper">
			<div id="banner" class="box container">
				<div class=banner_content>
					<div class="banner_left">
						<div class="homeImg">
							<img src="/resources/kh/image/home.jpg" width=600px alt="">
						</div>
					</div>
					<div class="banner_right">
						<div class="withIt"><h2 id="with" style="white-space: nowrap;">with</h2><h2 id="IT">IT</h2></div>
						<p style="white-space: nowrap;">쉽고 빠른 스터디 매칭</p>
						<p style="white-space: nowrap;">지금 바로 시작하세요</p>
						<sec:authorize access="isAnonymous()">
							<button onclick="location='/loginForm'" class="loginIcon">시작하기</button>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<button onclick="location='/match'" class="loginIcon">매칭하기</button>
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
		<!-- 아티클 -->
<!-- 		<div id="article_wrapper"> -->
<!-- 			<div class="container"> -->
<!-- 				<div class="article_content"> -->
<!-- 					<div class="article_left"> -->
<!-- 						<article class="box"> -->
<!-- 							<img> -->
<!-- 							<div class="inner"></div> -->
<!-- 						</article> -->
<!-- 					</div> -->
<!-- 					<div class="article_center"> -->
<!-- 						<article class="box"> -->
<!-- 							<img> -->
<!-- 						</article> -->
<!-- 					</div> -->
<!-- 					<div class="article_right"> -->
<!-- 						<article class="box"> -->
<!-- 							<img> -->
<!-- 						</article> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<!-- 푸터 -->
	</div>
	<script>
	document.addEventListener('DOMContentLoaded', ()=>{
		var body = document.body, html = document.documentElement;
 			var height = Math.max( body.scrollHeight, body.offsetHeight, 
	                       html.clientHeight, html.scrollHeight, html.offsetHeight );
		document.querySelector('div[id="footer_wrapper"]').style.position="absolute";
		document.querySelector('div[id="footer_wrapper"]').style.top=(height-345)+"px";
	});
</script>
</body>
</html>