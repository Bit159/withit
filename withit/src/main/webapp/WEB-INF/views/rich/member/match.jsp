<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/rich/css/match.css" />
	<script defer src="/resources/rich/js/match.js"></script>
	<script src="/resources/rich/js/rich.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
	<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e&libraries=services,clusterer,drawing"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/rich/template/header.jsp" flush="true" />
	<div class="matchDiv">
    <h2 id="matchTitle">
		<button id="key" onclick="insertMatch(), drawMap(), addDrawFunction(), searchFunction(), getLocation()">추가하기</button>
    </h2>
    <c:if test="${list ne null}">
    	<section id="cardWrapper">
		<c:forEach var="dto" items="${list}">
	      <div class="card">
	        <div class="cardHeader">
	          <span class="cardTitle">매칭중인 위시리스트</span>&emsp;&emsp;&emsp;
	          <button class="cardDeleteButton" data-mno="${dto.mno }">&nbsp;X&nbsp;</button>
	        </div>
	        <div class="mapdiv" data-lat="${dto.x }" data-lng="${dto.y }" data-range="${dto.range }" data-level="${dto.level }"></div>
	        <div class="cardInfo">
	          <div>시간 : <span>${dto.time }</span></div>
	          <div>주제 : <span>${dto.topic }</span></div>
	          <div>인원 : ${dto.stringPeople }</div>
	          <div>경력 : ${dto.stringCareer }</div>
	          <div>생성 : ${dto.stringCreated }</div>
	        </div>
	      </div>
		</c:forEach>
	    </section>
	</c:if>
	<c:if test="${list.size() eq 0}">
		<h3 id="emptyAlert">추가하기를 눌러 지금 매칭을 시작해보세요!</h3>
	</c:if>
	</div>
	<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
</body>
</html>
