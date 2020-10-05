<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
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

				
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<!-- 관리자일 경우에만 등록 버튼 노출 -->
			<div style="display: flex; justify-content: center">
				<button id="historyButton" type="button">등록</button>
			</div>
		</sec:authorize>
		
		<div class="timeline">
			<ul>
				<c:if test="${list ne null}">
					<c:forEach var="dto" items="${list}">
						<li>
							<div class="content">
								<h3 data-no="${dto.no }">${dto.title }</h3>
								<p data-no="${dto.no }"> ${dto.content }</p>
							</div>
							<div class="time">
								<h4 data-no="${dto.no }" data-time="${dto.time }">${dto.stringTime }</h4>
							</div>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<!-- 관리자일 경우에만 삭제 버튼 노출 -->
								<button data-no="${dto.no }" class="updateHistory" type="button">수정</button>
								<button data-no="${dto.no }" class="deleteHistory" type="button">삭제</button>
							</sec:authorize>
						</li>
					</c:forEach>
				</c:if>
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