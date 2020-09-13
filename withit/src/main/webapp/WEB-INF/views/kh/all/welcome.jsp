<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>With IT</title>
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
							<img src="/resources/kh/image/home.jpg" alt="">
						</div>
					</div>
					<div class="banner_right">
						<h2 style="white-space: nowrap;">With it</h2>
						<p style="white-space: nowrap;">쉽고 빠른 스터디 매칭</p>
						<ul>
							<li><a href="/loginForm" class="loginIcon">Login</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- 아티클 -->
		<div id="article_wrapper">
			<div class="container">
				<div class="article_content">
					<div class="article_left">
						<article class="box">
							<img>
							<div class="inner"></div>
						</article>
					</div>
					<div class="article_center">
						<article class="box">
							<img>
						</article>
					</div>
					<div class="article_right">
						<article class="box">
							<img>
						</article>
					</div>
				</div>
			</div>
		</div>
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
	</div>
</body>
</html>