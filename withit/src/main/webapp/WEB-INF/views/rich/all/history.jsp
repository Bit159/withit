<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
	<link rel="stylesheet" href="/resources/rich/css/history.css" />
	<script defer src="/resources/rich/js/history.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.jsdelivr.net/npm/promise-polyfill@8/dist/polyfill.js"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
	<div id="historyWrapper">
		<h1 id="historyTitle">withIT Development Timeline</h1>
		<div style="display: flex; justify-content: center">
			<button id="historyButton" type="button">등록</button>
		</div>
		<div class="timeline">
			<ul>
				<li>
					<div class="content">
						<h3>Lorem ipsum1111</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4 data-time="">2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsu2222m</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsum3333</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsum4444</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsum5555</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsum6666</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<li>
					<div class="content">
						<h3>Lorem ipsu7777m</h3>
						<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
							Aliquid fugiat consequatur quia, quam est laboriosam ab, ipsum
							molestiae esse, voluptatibus dolore fuga asperiores? Inventore
							voluptas debitis, voluptatibus rerum consequatur libero!</p>
					</div>
					<div class="time">
						<h4>2020. 09. 30 (월)</h4>
					</div>
					<button class="deleteHistory" type="button">삭제</button>
				</li>
				<div style="clear: both"></div>
			</ul>
		</div>
	</div>

	<div id="info">
		이 페이지는<a href="https://www.youtube.com/watch?v=X6aMWDDJlJg">강의</a>를
		참고하였습니다<br />
	</div>
	<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
</body>

</html>