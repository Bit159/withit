<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>

	<!-- map -->
    <script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<link rel="stylesheet" href="/resources/rich/css/myGroupMap.css" />
   	<script defer src="/resources/rich/js/myGroupMap.js" ></script>
    <script src="/resources/rich/js/rich.js"></script>
	
	<!-- schedule -->
    <link rel="stylesheet" href="/resources/rich/css/schedules.css" />
    <link rel="stylesheet" href="/resources/rich/css/main.css" />
    <script src="/resources/rich/js/main.js"></script>
    <script src="/resources/rich/js/locales-all.js"></script>
    <script src="/resources/rich/js/schedules.js"></script>
    
    <style>
    	div[class="mapdiv"], div[class="schedulediv"]{
    		width:930px;
    		height:1000px; 
    		border:5px solid black;
    		float:left;
    		position:absolute;
    		margin:0 auto;
    		left:30%;
    		opacity: 0;
    	}
    </style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
	<jsp:include page="/WEB-INF/views/rich/member/sidebar.jsp" flush="true" />
		
		<!-- 매칭 그룹이 존재하지 않을 경우 -->
		<c:if test="${list.size() eq 0 }">
			<div style="margin:0 auto;margin-top:80px;">
				<div style="margin: 0 auto;width:400px;"><img src="/resources/kh/image/nodatacut.jpg" style="width:400px;height:300px;background-size: conatin;display:block !important;"/></div>
				<div style="text-align:center;margin:0 auto;margin-top:50px;height:150px;">
					<span style="font-size:25px;text-align:center;font-weight:550;">
						아직 매칭된 그룹이 존재하지 않습니다
					</span>
					<br>
				</div>
			</div>				
		</c:if>
		
		<!-- 매칭 그룹이 존재할 경우 -->
		<c:if test="${list.size() ne 0 }">
			<div id="startDiv" style="margin:0 auto;margin-top:80px;">
				<div style="margin: 0 auto;width:344px;"><img src="/resources/kh/image/logo.png" style="width:344px;height:114px;background-size: conatin;display:block !important;"/></div>
				<div style="text-align:center;margin:0 auto;margin-top:50px;height:150px;">
					<span style="font-size:25px;text-align:center;font-weight:550;">
						왼쪽 메뉴에서 매칭된 그룹을 확인하세요!
					</span>
					<br>
				</div>
			</div>	
			<c:forEach var="group" items="${groups }" varStatus="status">
				<!-- group map -->
				<script>
					console.log('${status.index}');
					console.log('${group[0].gno}');
					let mapOb = new Object();
					
				
				</script>
				
				<div id="mapdiv${group[0].gno }" class="mapdiv" style="position:absolute;">
			 		<div style="margin-top:20px;text-align:center;"><h3>매칭 결과 보기</h3></div>
			 		<hr>
			 		<div id="mapWrapper" style="margin:0 auto; float:left; width:50%;left:20%;">
		            	<div id="map" style="width: 100%; height: 600px; margin: 0 auto; border: 3px solid #32be78;"></div>
					</div>
				</div>    
				
				<!-- group schedules -->
			 	<div id="schedulediv${group[0].gno }" class="schedulediv" style="position:absolute !important;" >
			 		<div style="margin-top:20px;"><h3>그룹 일정 관리</h3></div>
			 		<hr>
			 		<div id="calendarWrapper" style="margin:0 auto; float:left; width:80%;">
						<div id="calendar" style="position:relative;margin:0 auto; width:100%; height:500px;border:5px solid black;"></div>
					</div>
				</div>    
			</c:forEach>
		</c:if>
		<!-- 아래에 혼자 있는 </div>는 위에 인클루드 한 녀석 닫는거니까 냅둬야함 -->
	</div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
	<script>
	
	//윈도우 사이즈 변경시 content 영역을 sidebar의 x좌표에 따라 옮겨주기 
	
	let mapdivs = document.getElementsByClassName('mapdiv');
	let scheduledivs = document.getElementsByClassName('schedulediv');
	
	document.addEventListener('DOMContentLoaded', function(){		console.log('loading');
	let sideX = document.querySelector('nav[id="sidebar"]').getBoundingClientRect().x+200;
	document.getElementById('startDiv').style.left=sideX+"px";
	for(let i = 0; i<mapdivs.length; i++) {
		mapdivs[i].style.left=sideX+"px";
		scheduledivs[i].style.left=sideX+"px";
	}});

	window.addEventListener('resize',()=>{
		let sideX = document.querySelector('nav[id="sidebar"]').getBoundingClientRect().x+200;
		console.log(sideX);
		for(let i = 0; i<mapdivs.length; i++) {
			mapdivs[i].style.left=sideX+"px";
			scheduledivs[i].style.left=sideX+"px";
		}
	})
	
	
	let show = undefined;
		function myGroupNav(menu, gno) {
			let sideX = document.querySelector('nav[id="sidebar"]').getBoundingClientRect().x+200;
			
			let target = undefined;
			switch(menu) {
				case 'Info': target = 'mapdiv'+gno; break;
				case 'Schedule': target = 'schedulediv'+gno; break;
				default : target = 'Chat'+gno; break;
			}
			show = document.getElementById(target);
			
			console.log(menu, gno);
			console.log(target);
			console.log(show);
			
			document.getElementById('startDiv').setAttribute('style', 'display:none !important');
			
			for(let i = 0; i<mapdivs.length; i++) {
				mapdivs[i].setAttribute('style', 'opacity:0;');
				scheduledivs[i].setAttribute('style', 'opacity:0;');
			}
			
			show.setAttribute('style', 'opacity:1;');
			
			for(let i = 0; i<mapdivs.length; i++) {
				mapdivs[i].style.left=sideX+"px";
				scheduledivs[i].style.left=sideX+"px";
			}
			
		}
	</script>
</body>

</html>