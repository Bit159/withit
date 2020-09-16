<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<title>withIT</title>
	<link rel="stylesheet" href="/resources/rich/css/insertMatch.css" />
	<script src="/resources/rich/js/insertMatch.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e&libraries=services,clusterer,drawing"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
	<div id="wrap">
	<h1>나의 매칭 관리</h1>
		<div id="msg"></div>
		<div id="option_boss">
			<button id="key" onclick="insertMatch(), drawMap(), addDrawFunction(), searchFunction(), getLocation()">등록</button>
			<button type="button" id="insert_match_button">추가하기</button>
		</div>
		<!-- End of option_boss-->
		<!-- Wish List Div-->
		
		<div id="wishList">
			<ul id="wishul">
				<c:forEach var="dto" items="${list}" >
					<li class="wishes">
						<input class="wishlist_area" type="text" value="${dto.x}" readonly /> 
						<input type="hidden" value="${dto.y}" readonly /> 
						<input type="hidden" value="${dto.range}" readonly /> 
						<input class="wishlist_time" type="text" value="${dto.time}" readonly /> 
						<input class="wishlist_topic" type="text" value="${dto.topic}" readonly /> 
						<input class="wishlist_career" type="text"	value="<c:choose><c:when test="${dto.career eq 2 }">0~2년</c:when><c:when test="${dto.career eq 5 }">3~5년</c:when><c:when test="${dto.career eq 6 }">5년 이상</c:when><c:when test="${dto.career eq 10 }">10년  이상</c:when></c:choose>" readonly />
						<input class="wishlist_people" type="text" value="<c:choose><c:when test="${dto.people eq 3 }">3명</c:when><c:when test="${dto.people eq 4 }">4~6명</c:when><c:when test="${dto.people eq 7 }">7~9명</c:when><c:when test="${dto.people eq 10 }">10명  이상</c:when></c:choose>" readonly />
						<button type="button" class="wishdelete">삭제</button>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!--End of Body Wrapper-->
	<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
</body>
</html>
