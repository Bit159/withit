<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
	<link rel="stylesheet" href="/resources/rich/css/myGroupMap.css" />
    <script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
   	<script defer src="/resources/rich/js/myGroupMap.js" ></script>
    <script src="/resources/rich/js/rich.js"></script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
	<jsp:include page="/WEB-INF/views/rich/member/sidebar.jsp" flush="true" />
	 	<div id="testdiv" style="width:930px; height:969px; border:5px solid black;display:flex;flex-direction: column;">
	 		<div style="margin-top:20px;text-align:center;"><h3>매칭 결과 보기</h3></div>
	 		<hr>
	 		<div id="mapWrapper" style="margin:0 auto; float:left; width:80%;">
            	<div id="map" style="width: 100%; height: 600px; margin: 0 auto; border: 3px solid #32be78;"></div>
			</div>
		</div>    
	</div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
</body>

</html>